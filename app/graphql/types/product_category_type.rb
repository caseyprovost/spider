module Types
  class ProductCategoryType < Types::BaseObject
    field :id, ID, null: false
    field :product_id, Integer, null: false
    field :category_id, Integer, null: false
    field :category, Types::CategoryType, null: false
    field :product, Types::ProductType, null: false

    def category
      api_client(context[:jwt_token]).category(object["category_id"])
    end

    def product
      api_client(context[:jwt_token]).product(object["product_id"])
    end

    private

    def api_client(jwt_token)
      ApiClient.new(jwt_token)
    end
  end
end
