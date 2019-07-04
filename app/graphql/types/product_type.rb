module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :variants, [Types::VariantType], null: false

    def variants
      ApiClient.new.variants(context[:jwt_token], product_id: object['id'])
    end
  end
end
