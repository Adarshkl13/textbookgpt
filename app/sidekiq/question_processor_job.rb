class QuestionProcessorJob < ApplicationJob
  queue_as :default

  def perform(question_id)
    question = Question.find(question_id)

    # Call OpenAI API and generate the answer
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          {
            role: "system",
            content: "You are a helpful assistant. Always explain answers in simple English using short sentences and easy-to-understand words."
          },
          {
            role: "user",
            content: "Book content: #{question.book.content.truncate(3000)}\n\nQuestion: #{question.question}"
          }
        ],
        max_tokens: 2000
      }
    )

    answer_text = response.dig("choices", 0, "message", "content")

    # Update the question with the final answer
    question.update!(answer: answer_text)

    # Broadcast Turbo Stream update
    Turbo::StreamsChannel.broadcast_replace_to(
      "book_#{question.book.id}",
      target: "last-question",
      partial: "books/last_question",
      locals: { question: question }
    )
  rescue => e
    Rails.logger.error("OpenAI Error: #{e.message}")
    question.update!(answer: "Sorry, there was an error processing your request. Please try again later.")
  end
end
