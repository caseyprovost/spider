module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :book, BookType, null: false,
      description: "An example field added by the generator"

    def book
      # todo
    end
  end
end
