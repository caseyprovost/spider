# frozen_string_literal: true

module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, String, null: false
    field :total, String, null: true
    field :payment_state, String, null: true
    field :completed_at, String, null: true
    field :created_at, String, null: true
    field :updated_at, String, null: true

    field :line_items, [Types::LineItemType], null: false
    field :variants, [Types::VariantType], null: false

    def line_items
      filters = {order_id: object["id"]}
      api_client.line_items(filters: filters)
    end

    def variant
      filters = {order_id: object["id"]}
      api_client.variants(filters: filters)
    end

    private

    def api_client
      @api_client ||= ApiClient.new(context[:jwt_token])
    end
  end
end
