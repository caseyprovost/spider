# frozen_string_literal: true

module Types
  class PublisherType < Types::BaseObject
    field :name, String, null: false
    field :description, String, null: true
    field :uuid, String, null: true
  end
end
