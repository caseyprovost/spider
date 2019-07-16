# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :variants, [Types::VariantType], null: false

    def variants
      filters = { product_id: object["id"] }
      ApiClient.new(context[:jwt_token]).variants(filters: filters)
    end
  end
end
