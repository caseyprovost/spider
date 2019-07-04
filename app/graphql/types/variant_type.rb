module Types
  class VariantType < Types::BaseObject
    field :name, String, null: false
    field :price, String, null: true
    field :sku, Integer, null: true
    field :position, String, null: true
    field :product, Types::ProductType, null: true
  end
end
