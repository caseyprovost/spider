class ApiClient
  BOOK_SERVICE_URL = ENV.fetch('BOOKSHELF_API_URL')
  PUBLISHER_SERVICE_URL = ENV.fetch('PUBLISHER_API_URL')
  AUTHOR_SERVICE_URL = ENV.fetch('AUTHOR_API_URL')

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


  private

  def normalize_json_api_collection(collection)
    collection.map do |item|
      data = { 'id' => item['id'] }

      item['attributes'].each_pair do |key, value|
        if value.respond_to?(:has_key?)
          data[key] = item['attributes'].delete(key)['attributes']
        else
          data[key] = value
        end
      end

      data
    end
  end
end
