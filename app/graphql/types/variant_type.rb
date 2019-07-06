# frozen_string_literal: true

module Types
  class VariantType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :price, String, null: true
    field :sku, Integer, null: true
    field :position, String, null: true
    field :product, Types::ProductType, null: true
  end
end
