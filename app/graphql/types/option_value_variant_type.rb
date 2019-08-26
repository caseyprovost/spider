# frozen_string_literal: true

module Types
  class OptionValueVariantType < Types::BaseObject
    field :id, ID, null: false
    field :option_type_id, Integer, null: false
    field :variant_id, Integer, null: false
    field :id, ID, null: false
    field :created_at, String, null: true
    field :updated_at, String, null: true

    field :option_value, Types::OptionValueType, null: false
    field :variant, Types::VariantType, null: false

    def option_value
      api_client.option_values.fetch(object["option_value_id"])
    end

    def variant
      api_client.variants.fetch(object["variant_id"])
    end

    private

    def api_client
      @api_client ||= ApiClient::Client.new(context[:jwt_token])
    end
  end
end
