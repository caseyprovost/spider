# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    field :name, String, null: false
    field :bio, String, null: true
    field :date_of_birth, String, null: true
    field :hometown, String, null: true
    field :uuid, String, null: true
  end
end
