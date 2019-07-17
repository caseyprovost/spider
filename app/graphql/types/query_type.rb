# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :books, [Types::BookType], null: false,
                                     description: "Returns a list of books"

    field :authors, [Types::AuthorType], null: false,
                                         description: "Returns a list of authors"

    field :publishers, [Types::PublisherType], null: false,
                                               description: "Returns a list of publishers"

    field :products, [Types::ProductType], null: false do
      argument :category_id, ID, required: false
      description "Returns a list of products"
    end

    field :variants, [Types::VariantType], null: false,
                                           description: "Returns a list of variants"

    field :categories, [Types::CategoryType], null: false,
                                              description: "Returns a list of categories"

    field :author, Types::AuthorType, null: true do
      argument :id, ID, required: true
    end

    def author(id:)
      api_client.author(id)
    end

    def books
      api_client.books
    end

    def authors
      api_client.authors
    end

    def publishers
      api_client.publishers
    end

    def products(category_id: nil)
      api_client.products(filters: {
        category_id: category_id
      })
    end

    def variants
      api_client.variants
    end

    def categories
      api_client.categories
    end

    private

    def api_client
      @api_client ||= ApiClient.new(context[:jwt_token])
    end
  end
end
