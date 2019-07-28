# frozen_string_literal: true

module Types
  class VariantType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :price, String, null: true
    field :sku, String, null: true
    field :product_id, Integer, null: true
    field :position, String, null: true
    field :description, String, null: true
    field :created_at, String, null: true
    field :updated_at, String, null: true

    field :product, Types::ProductType, null: true
    field :line_items, [Types::LineItemType], null: true
    field :orders, [Types::OrderType], null: true
    field :option_types, [Types::OptionType], null: true
    field :option_values, [Types::OptionValueType], null: true
    field :option_value_variants, [Types::OptionValueVariantType], null: true

    def product
      raise "no product id" if object["product_id"].blank?
      api_client.product(object["product_id"])
    end

    def line_items
      filters = {variant_id: object["id"]}
      api_client.line_items(filters: filters)
    end

    def option_value_variants
      filters = {variant_id: object["id"]}
      api_client.option_value_variants(filters: filters)
    end

    def option_values
      filters = {variant_id: object["id"]}
      api_client.option_values(filters: filters)
    end

    def orders
      filters = {variant_id: object["id"]}
      api_client.orders(filters: filters)
    end

    def option_types
      filters = {variant_id: object["id"]}
      api_client.option_types(filters: filters)
    end

    private

    def api_client
      @api_client ||= ApiClient.new(context[:jwt_token])
    end
  end
end
