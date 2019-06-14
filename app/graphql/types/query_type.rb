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

    def books
      ApiClient.new.books(context[:jwt_token])
    end

    def authors
      ApiClient.new.authors(context[:jwt_token])
    end

    def publishers
      ApiClient.new.publishers(context[:jwt_token])
    end
  end
end
