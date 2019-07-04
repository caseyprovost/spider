module Types
  class ProductType < Types::BaseObject
    field :name, String, null: false
    field :description, String, null: true
    field :variants, [Types::AuthorType], null: true
  end
end
