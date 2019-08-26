# frozen_string_literal: true

require "api_client"

ApiClient.configure do |config|
  config.bookstore_service_url = ENV["BOOKSTORE_API_URL"]
  config.bookshelf_service_url = ENV["BOOKSHELF_API_URL"]
  config.author_service_url = ENV["AUTHOR_API_URL"]
  config.publisher_service_url = ENV["PUBLISHER_API_URL"]
end
