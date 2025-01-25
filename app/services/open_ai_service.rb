# app/services/openai_service.rb
class OpenAIService
    def self.ask_question(prompt)
      client = OpenAI::Client.new
      response = OpenAI_CLIENT.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: "You are a helpful assistant." },
            { role: "user", content: "Write a short poem about Ruby on Rails." }
          ],
          max_tokens: 50
        }
      )
      puts response.dig("choices", 0, "message", "content")
      
    end
  end
  