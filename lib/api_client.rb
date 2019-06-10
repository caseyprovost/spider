class ApiClient
  BOOK_SERVICE_URL = ENV.fetch('BOOKSHELF_API_URL')

  def books(jwt_token)
    response = HTTParty.get("#{BOOK_SERVICE_URL}/v1/books", headers: {
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
      {
        'id' => item['id'],
      }.merge(item['attributes'])
    end
  end
end
