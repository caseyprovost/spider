module Types
  class OptionType < Types::BaseObject
    field :name, String, null: true
    field :option_types, [Types::OptionType], null: true

    def product_option_types
      filters = {option_type_id: object["id"]}
      api_client(context[:jwt_token]).option_types(filters: filters)
    end

    private

    def api_client(jwt_token)
      ApiClient.new(jwt_token)
    end
  end
end
