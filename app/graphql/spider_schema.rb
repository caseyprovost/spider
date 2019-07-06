# frozen_string_literal: true

class SpiderSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
