module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :books, [Types::BookType], null: false,
      description: "Returns a list of books"

    def books
      ApiClient.new.books(context[:jwt_token])
    end
  end
end
