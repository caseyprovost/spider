module Resolvers
  class Base < GraphQL::Schema::Resolver
    argument_class Arguments::Base
  end
end
