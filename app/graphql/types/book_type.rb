module Types
  class BookType < Types::BaseObject
    field :title, String, null: false
    field :summary, String, null: true
    field :page_count, Integer, null: true
    field :publication_date, String, null: true
    field :publisher, Types::PublisherType, null: true
    #field :author, Types::AuthorType, null: true
  end

  #class AuthorType < Types::BaseObject
    #field :name, String, null: false
  #end

  #class PublisherType < Types::BaseObject
    #field :name, String, null: false
  #end
end
