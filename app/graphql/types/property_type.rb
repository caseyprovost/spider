module Types
  class PropertyType < Types::BaseObject
    field :name, String, null: true
    field :presentation, String, null: true
  end
end
