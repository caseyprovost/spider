# frozen_string_literal: true

module Types
  class VariantType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :price, String, null: true
    field :sku, Integer, null: true
    field :position, String, null: true
    field :product, Types::ProductType, null: true

    def product
      api_client.product(object["product_id"])
    end

    private

    def api_client
      @api_client ||= ApiClient.new(context[:jwt_token])
    end
  end
end
