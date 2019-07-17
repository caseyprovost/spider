# frozen_string_literal: true

class ApiClient
  BOOK_SERVICE_URL = ENV.fetch("BOOKSHELF_API_URL")
  PUBLISHER_SERVICE_URL = ENV.fetch("PUBLISHER_API_URL")
  AUTHOR_SERVICE_URL = ENV.fetch("AUTHOR_API_URL")
  BOOKSTORE_SERVICE_URL = ENV.fetch("BOOKSTORE_API_URL")

  attr_reader :jwt_token

  def initialize(jwt_token)
    @jwt_token = jwt_token
  end

  def books
    response = HTTParty.get("#{BOOK_SERVICE_URL}/v1/books", headers: {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => "application/vnd.api+json",
      "Authorization" => jwt_token,
    })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response["data"])
  end

  def publishers
    response = HTTParty.get("#{PUBLISHER_SERVICE_URL}/v1/publishers", headers: {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => "application/vnd.api+json",
      "Authorization" => jwt_token,
    })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response["data"])
  end

  def authors
    response = HTTParty.get("#{AUTHOR_SERVICE_URL}/v1/authors", headers: {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => "application/vnd.api+json",
      "Authorization" => jwt_token,
    })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response["data"])
  end

  def author(uuid)
    response = HTTParty.get("#{AUTHOR_SERVICE_URL}/v1/authors/#{uuid}", headers: {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => "application/vnd.api+json",
      "Authorization" => jwt_token,
    })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_object(parsed_response["data"])
  end

  def products(filters: {})
    base_url = "#{BOOKSTORE_SERVICE_URL}/api/v1/products"
    query = {filters: filters.keep_if { |_, value| value.present? }}
    query.delete(:filters) if query[:filters].empty?

    response = HTTParty.get(base_url,
      query: query,
      headers: {
        "Accept" => "application/vnd.api+json",
        "Content-Type" => "application/vnd.api+json",
        "Authorization" => jwt_token,
      })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response["data"])
  end

  def categories
    response = HTTParty.get("#{BOOKSTORE_SERVICE_URL}/api/v1/categories", headers: {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => "application/vnd.api+json",
      "Authorization" => jwt_token,
    })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response["data"])
  end

  def variants(filters: {})
    base_url = "#{BOOKSTORE_SERVICE_URL}/api/v1/variants"
    filter_parts = []

    filters.each_pair do |filter, criteria|
      filter_parts << "filter[#{filter}]=#{criteria}"
    end

    base_url += "?#{filter_parts.join("&")}"

    response = HTTParty.get(base_url, headers: {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => "application/vnd.api+json",
      "Authorization" => jwt_token,
    })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response["data"])
  end

  private

  def normalize_json_api_object(object)
    data = {"id" => object["id"]}

    object["attributes"].each_pair do |key, value|
      data[key] = if value.respond_to?(:has_key?)
        object["attributes"].delete(key)["attributes"]
      else
        value
      end
    end

    data
  end

  def normalize_json_api_collection(collection)
    collection.map { |item| normalize_json_api_object(item) }
  end
end
