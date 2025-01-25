class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def question
    @book = Book.find(params[:id])
    question_text = params[:question]

    # Check if the user has already asked 10 questions today
    if Question.asked_today(current_user).count >= 1000
      flash[:alert] = "You have reached the daily limit of 10 questions. Please try again tomorrow."
      redirect_to book_path(@book) and return
    end

    # Create a question record with a placeholder answer
    @question = @book.questions.create!(
      question: question_text,
      answer: "Processing...",
      user: current_user
    )

    # Enqueue the Sidekiq job to process the question asynchronously
    QuestionProcessorJob.perform_later(@question.id)

    respond_to do |format|
      format.turbo_stream # Turbo updates to handle real-time UI updates
      format.html do
        flash[:notice] = "Your question has been submitted and is being processed. Check back shortly for the answer."
        redirect_to book_path(@book)
      end
    end
  end
end


