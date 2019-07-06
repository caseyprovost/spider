# frozen_string_literal: true

class ApiClient
  BOOK_SERVICE_URL = ENV.fetch('BOOKSHELF_API_URL')
  PUBLISHER_SERVICE_URL = ENV.fetch('PUBLISHER_API_URL')
  AUTHOR_SERVICE_URL = ENV.fetch('AUTHOR_API_URL')
  BOOKSTORE_SERVICE_URL = ENV.fetch('BOOKSTORE_API_URL')

  def books(jwt_token)
    response = HTTParty.get("#{BOOK_SERVICE_URL}/v1/books", headers: {
                              'Accept' => 'application/vnd.api+json',
                              'Content-Type' => 'application/vnd.api+json',
                              'Authorization' => jwt_token
                            })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response['data'])
  end

  def publishers(jwt_token)
    response = HTTParty.get("#{PUBLISHER_SERVICE_URL}/v1/publishers", headers: {
                              'Accept' => 'application/vnd.api+json',
                              'Content-Type' => 'application/vnd.api+json',
                              'Authorization' => jwt_token
                            })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response['data'])
  end

  def authors(jwt_token)
    response = HTTParty.get("#{AUTHOR_SERVICE_URL}/v1/authors", headers: {
                              'Accept' => 'application/vnd.api+json',
                              'Content-Type' => 'application/vnd.api+json',
                              'Authorization' => jwt_token
                            })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response['data'])
  end

  def products(jwt_token)
    response = HTTParty.get("#{BOOKSTORE_SERVICE_URL}/api/v1/products", headers: {
                              'Accept' => 'application/vnd.api+json',
                              'Content-Type' => 'application/vnd.api+json',
                              'Authorization' => jwt_token
                            })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response['data'])
  end

  def variants(jwt_token, product_id: nil)
    base_url = "#{BOOKSTORE_SERVICE_URL}/api/v1/variants"

    base_url += "?filter[product_id]=#{product_id}" if product_id.present?

    response = HTTParty.get(base_url, headers: {
                              'Accept' => 'application/vnd.api+json',
                              'Content-Type' => 'application/vnd.api+json',
                              'Authorization' => jwt_token
                            })

    parsed_response = JSON.parse(response.body)
    normalize_json_api_collection(parsed_response['data'])
  end

  private

  def normalize_json_api_collection(collection)
    collection.map do |item|
      data = { 'id' => item['id'] }

      item['attributes'].each_pair do |key, value|
        data[key] = if value.respond_to?(:has_key?)
                      item['attributes'].delete(key)['attributes']
                    else
                      value
                    end
      end

      data
    end
  end
end
