# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :variants, [Types::VariantType], null: false
    field :categories, [Types::CategoryType], null: false

    def variants
      filters = {product_id: object["id"]}
      api_client(context[:jwt_token]).variants(filters: filters)
    end

    def categories
      filters = {product_id: object["id"]}
      api_client(context[:jwt_token]).categories(filters: filters)
    end

    private

    def api_client(jwt_token)
      ApiClient.new(jwt_token)
    end
  end
end
