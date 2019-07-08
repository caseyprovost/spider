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

    field :products, [Types::ProductType], null: false,
                                           description: "Returns a list of products"

    field :variants, [Types::VariantType], null: false,
                                           description: "Returns a list of variants"

    def books
      api_client.books(context[:jwt_token])
    end

    def authors
      api_client.authors(context[:jwt_token])
    end

    def publishers
      api_client.publishers(context[:jwt_token])
    end

    def products
      api_client.products(context[:jwt_token])
    end

    def variants
      api_client.variants(context[:jwt_token])
    end

    private

    def api_client
      @api_client ||= ApiClient.new
    end
  end
end
