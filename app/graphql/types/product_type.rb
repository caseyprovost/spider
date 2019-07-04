module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :variants, [Types::VariantType], null: true

    def self.scope_items(items, context)
      Rails.logger.info(%Q{
        CONTEXT IS \n
        #{context.inspect} \n
      }
      items.where(product_id: 1)
    end
  end
end
