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

    field :option_types, [Types::OptionType], null: false,
                                              description: "Returns a list of option types"

    field :product_option_types, [Types::ProductOptionType], null: false do
      description "Returns a list of product option types"
    end

    field :option_values, [Types::OptionValueType], null: false do
      description "Returns a list of option values"
    end

    field :option_value_variants, [Types::OptionValueVariantType], null: false do
      description "Returns a list of option value variants"
    end

    field :properties, [Types::PropertyType], null: false,
                                              description: "Returns a list of properties"

    field :product_properties, [Types::ProductPropertyType], null: false,
                                                             description: "Returns a list of product properties"

    field :author, Types::AuthorType, null: true do
      argument :id, ID, required: true
    end

    field :publisher, Types::PublisherType, null: true do
      argument :id, ID, required: true
    end

    field :book, Types::PublisherType, null: true do
      argument :id, ID, required: true
    end

    field :product, Types::ProductType, null: true do
      argument :id, ID, required: true
    end

    field :option_type, Types::OptionType, null: true do
      argument :id, ID, required: true
    end

    field :option_value, Types::OptionType, null: true do
      argument :id, ID, required: true
    end

    field :option_value_variant, Types::OptionValueVariantType, null: true do
      argument :id, ID, required: true
    end

    field :variant, Types::VariantType, null: true do
      argument :id, ID, required: true
    end

    def author(id:)
      api_client.authors.fetch(id)
    end

    def product(id:)
      api_client.products.fetch(id)
    end

    def books
      api_client.books.list
    end

    def authors
      api_client.authors.list
    end

    def publishers
      api_client.publishers.list
    end

    def products(category_id: nil)
      api_client.products.list(filters: {
        category_id: category_id,
      })
    end

    def variant(id:)
      api_client.variants.fetch(id)
    end

    def variants
      api_client.variants.list
    end

    def category(id:)
      api_client.categories.fetch(id)
    end

    def categories
      api_client.categories.list
    end

    def property(id:)
      api_client.properties.fetch(id)
    end

    def properties
      api_client.properties.list
    end

    def product_properties
      api_client.product_properties.list
    end

    def option_types
      api_client.option_types.list
    end

    def product_option_types
      api_client.product_option_types.list
    end

    private

    def api_client
      @api_client ||= ApiClient::Client.new(context[:jwt_token])
    end
  end
end
