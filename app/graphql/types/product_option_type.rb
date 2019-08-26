module Types
  class ProductOptionType < Types::BaseObject
    field :id, ID, null: false
    field :option_type_id, Integer, null: false
    field :product_id, Integer, null: false
    field :option_type, Types::OptionType, null: false
    field :product, Types::ProductType, null: false

    def option_type
      api_client.option_types.fetch(object["option_type_id"])
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
