module Types
  class OptionType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true

    def option_type_values
      filters = {option_type_id: object["id"]}
      api_client(context[:jwt_token]).option_type_values(filters: filters)
    end

    def product
      api_client(context[:jwt_token]).product(object["product_id"])
    end

    private

    def api_client(jwt_token)
      ApiClient.new(jwt_token)
    end
  end
end
