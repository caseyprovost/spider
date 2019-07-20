# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :variants, [Types::VariantType], null: false
    field :categories, [Types::CategoryType], null: false
    field :properties, [Types::PropertyType], null: false
    field :product_properties, [Types::ProductPropertyType], null: false
    field :option_types, [Types::OptionType], null: false

    def variants
      filters = {product_id: object["id"]}
      api_client(context[:jwt_token]).variants(filters: filters)
    end

    def categories
      filters = {product_id: object["id"]}
      api_client(context[:jwt_token]).categories(filters: filters)
    end

    def properties
      filters = {product_id: object["id"]}
      api_client(context[:jwt_token]).properties(filters: filters)
    end

    def product_properties
      filters = {product_id: object["id"]}
      api_client(context[:jwt_token]).product_properties(filters: filters)
    end

    def option_types
      filters = {product_id: object["id"]}
      api_client(context[:jwt_token]).option_types(filters: filters)
    end

    private

    def api_client(jwt_token)
      ApiClient.new(jwt_token)
    end
  end
end
