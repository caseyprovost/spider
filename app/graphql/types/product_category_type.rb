module Types
  class ProductCategoryType < Types::BaseObject
    field :id, ID, null: false
    field :product_id, Integer, null: false
    field :category_id, Integer, null: false
    field :category, Types::CategoryType, null: false
    field :product, Types::ProductType, null: false

    def category
      api_client.categories.fetch(object["category_id"])
    end

    def product
      api_client.products.fetch(object["product_id"])
    end

    private

    def api_client
      @api_client ||= ApiClient::Client.new(context[:jwt_token])
    end
  end
end
