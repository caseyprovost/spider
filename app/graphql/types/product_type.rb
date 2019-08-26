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
      api_client.variants.list(filters: filters)
    end

    def categories
      filters = {product_id: object["id"]}
      api_client.categories.list(filters: filters)
    end

    def properties
      filters = {product_id: object["id"]}
      api_client.properties.list(filters: filters)
    end

    def product_properties
      filters = {product_id: object["id"]}
      api_client.product_properties.list(filters: filters)
    end

    def option_types
      filters = {product_id: object["id"]}
      api_client.option_types.list(filters: filters)
    end

    private

    def api_client
      @api_client ||= ApiClient::Client.new(context[:jwt_token])
    end
  end
end
