require 'pdf-reader'
class Book < ApplicationRecord
  has_many :questions, dependent: :destroy

  def content
    # If content is already cached in the database, return it
    return self[:content] if self[:content].present?

    pdf_text = ''
    begin
      file_path = Rails.root.join(pdf_path)

      # Ensure the file exists
      raise "File not found: #{file_path}" unless File.exist?(file_path)

      # Extract text from the PDF
      reader = PDF::Reader.new(file_path)
      reader.pages.each do |page|
        pdf_text += page.text
      end

      # Cache the extracted content in the database
      update(content: pdf_text)
    rescue => e
      Rails.logger.error("Failed to read PDF: #{e.message}")
    end
    pdf_text
  end
end
