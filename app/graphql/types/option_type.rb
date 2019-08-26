module Types
  class OptionType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true

    def option_type_values
      filters = {option_type_id: object["id"]}
      api_client.option_type_values.list(filters: filters)
    end

    def product
      api_client.products.fetch(object["product_id"])
    end

    private

    def api_client
      @api_client ||= ApiClient::Client.new(context[:jwt_token])
    end
  end
end
