module Types
  class ProductPropertyType < Types::BaseObject
    field :id, ID, null: false
    field :value, String, null: false
    field :property_id, String, null: false
    field :product_id, String, null: false
    field :property, Types::PropertyType, null: false
    field :product, Types::ProductType, null: false

    def property
      api_client(context[:jwt_token]).property(object["property_id"])
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
