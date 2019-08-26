module Types
  class ProductPropertyType < Types::BaseObject
    field :id, ID, null: false
    field :value, String, null: false
    field :property_id, String, null: false
    field :product_id, String, null: false
    field :property, Types::PropertyType, null: false
    field :product, Types::ProductType, null: false

    def property
      api_client.properties.fetch(object["property_id"])
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
