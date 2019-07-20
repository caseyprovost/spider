module Types
  class ProductOptionType < Types::BaseObject
    field :id, ID, null: false
    field :option_type, Types::OptionType, null: false
    field :product, Types::ProductType, null: false

    def option_type
      api_client(context[:jwt_token]).option_type(object["option_type_id"])
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
