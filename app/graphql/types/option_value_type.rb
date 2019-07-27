# frozen_string_literal: true

module Types
  class OptionValueType < Types::BaseObject
    field :id, ID, null: false
    field :position, String, null: false
    field :name, String, null: true
    field :created_at, String, null: true
    field :updated_at, String, null: true

    field :option_type, Types::OptionType, null: false
    field :option_value_variants, [Types::OptionValueVariantType], null: false
    field :variants, [Types::VariantType], null: false

    def option_type
      api_client.option_type(object["option_type_id"])
    end

    def order_value_variants
      filters = {order_value_id: object["id"]}
      api_client.order_value_variants(filters: filters)
    end

    def variants
      filters = {order_value_id: object["id"]}
      api_client.variants(filters: filters)
    end

    def product_option_types
      filters = {order_value_id: object["id"]}
      api_client.product_option_types(filters: filters)
    end

    private

    def api_client
      @api_client ||= ApiClient.new(context[:jwt_token])
    end
  end
end
