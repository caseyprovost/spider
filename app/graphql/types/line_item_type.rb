# frozen_string_literal: true

module Types
  class LineItemType < Types::BaseObject
    field :id, ID, null: false
    field :quantity, String, null: false
    field :price, String, null: true
    field :order_id, Integer, null: false
    field :created_at, String, null: true
    field :updated_at, String, null: true

    field :order, Types::OrderType, null: true
    field :variant, Types::VariantType, null: false

    def order
      api_client.orders.fetch(object["order_id"])
    end

    def variant
      api_client.variants.fetch(object["order_id"])
    end

    private

    def api_client
      @api_client ||= ApiClient::Client.new(context[:jwt_token])
    end
  end
end
