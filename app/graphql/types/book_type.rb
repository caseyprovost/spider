# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    field :title, String, null: false
    field :summary, String, null: true
    field :page_count, Integer, null: true
    field :publication_date, String, null: true
    field :publisher, Types::PublisherType, null: true
    field :author, Types::AuthorType, null: false

    def author
      api_client.author(object["author_uuid"])
    end

    def publisher
      api_client.publisher(object["publisher_uuid"])
    end

    private

    def api_client
      @api_client ||= ApiClient.new(context[:jwt_token])
    end
  end
end
