module ApiClient
  class Resource
    include HTTParty

    attr_reader :url
    attr_reader :path
    attr_reader :jwt_token

    def initialize(url:, path:, jwt_token: nil)
      @url = url
      @path = path
      @jwt_token = jwt_token
    end

    def fetch(id)
      response = self.class.get("#{@url}/#{path}/#{id}", headers: headers)
      parsed_response = JSON.parse(response.body)

      result = if parsed_response["data"].is_a?(Array)
        parsed_response["data"].first
      else
        parsed_response["data"]
      end

      normalize_json_api_object(result)
    end

    def list(filters: {})
      query = {filter: filters.keep_if { |_, value| value.present? }}
      query.delete(:filter) if query[:filter].empty?
      options = {query: query, headers: headers}
      response = self.class.get("#{url}/#{path}", options)

      parsed_response = JSON.parse(response.body)
      normalize_json_api_collection(parsed_response["data"])
    end

    private

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
end
