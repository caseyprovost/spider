# frozen_string_literal: true

class ApiClient
  include HTTParty

  BOOK_SERVICE_URL = ENV.fetch("BOOKSHELF_API_URL")
  PUBLISHER_SERVICE_URL = ENV.fetch("PUBLISHER_API_URL")
  AUTHOR_SERVICE_URL = ENV.fetch("AUTHOR_API_URL")
  BOOKSTORE_SERVICE_URL = ENV.fetch("BOOKSTORE_API_URL")

  attr_reader :jwt_token

  debug_output

  def initialize(jwt_token)
    @jwt_token = jwt_token
  end

  def product(id)
    fetch("#{BOOKSTORE_SERVICE_URL}/api/v1/products/#{id}")
  end

  def property(uuid)
    fetch("#{BOOKSTORE_SERVICE_URL}/api/v1/properties/#{id}")
  end

  def properties(filters: {})
    fetch_collection(
      method: :get,
      url: "#{BOOK_SERVICE_URL}/v1/properties",
      filters: filters
    )
  end

  def product_properties(filters: {})
    fetch_collection(
      method: :get,
      url: "#{BOOK_SERVICE_URL}/api/v1/product_properties",
      filters: filters
    )
  end

  def option_types(filters: {})
    fetch_collection(
      method: :get,
      url: "#{BOOK_SERVICE_URL}/api/v1/option_types",
      filters: filters
    )
  end

  def books(filters: {})
    fetch_collection(
      method: :get,
      url: "#{BOOK_SERVICE_URL}/v1/books",
      filters: filters
    )
  end

  def publishers(filters: {})
    fetch_collection(
      method: :get,
      url: "#{PUBLISHER_SERVICE_URL}/v1/publishers",
      filters: filters
    )
  end

  def authors(filters: {})
    fetch_collection(
      method: :get,
      url: "#{AUTHOR_SERVICE_URL}/v1/authors",
      filters: filters
    )
  end

  def author(uuid)
    fetch("#{AUTHOR_SERVICE_URL}/v1/authors/#{uuid}")
  end

  def products(filters: {})
    fetch_collection(
      method: :get,
      url: "#{BOOKSTORE_SERVICE_URL}/api/v1/products",
      filters: filters
    )
  end

  def product(uuid)
    fetch("#{BOOKSTORE_SERVICE_URL}/api/v1/products/#{uuid}")
  end

  def categories(filters: {})
    fetch_collection(
      method: :get,
      url: "#{BOOKSTORE_SERVICE_URL}/api/v1/categories",
      filters: filters
    )
  end

  def variants(filters: {})
    fetch_collection(
      method: :get,
      url: "#{BOOKSTORE_SERVICE_URL}/api/v1/variants",
      filters: filters
    )
  end

  private

  def fetch(url)
    response = self.class.get(url, headers: headers)

    parsed_response = JSON.parse(response.body)
    normalize_json_api_object(parsed_response["data"])
  end

  def fetch_collection(method:, url:, filters: {})
    query = {filter: filters.keep_if { |_, value| value.present? }}
    query.delete(:filter) if query[:filter].empty?
    options = { query: query, headers: headers }
    response = HTTParty.send(:perform_request, method, url, options)

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response["data"])
  end

  def headers
    @headers ||= {
      "Accept" => "application/vnd.api+json",
      "Content-Type" => "application/vnd.api+json",
      "Authorization" => jwt_token,
    }
  end

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
