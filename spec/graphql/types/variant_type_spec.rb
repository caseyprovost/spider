# # frozen_string_literal: true

# require "rails_helper"
# require "webmock/rspec"

# RSpec.describe Types::VariantType do
#   include ApiMocking

#   let(:auth_token) { "Bearer SomeToken" }

#   describe "variant" do
#     before do
#       mock_products(auth_token)
#       mock_variants(auth_token, 1)
#     end

#     let(:query) do
#       <<~GQL
#         query {
#           variant(id: 1) {
#             id
#             name

#             product {
#               id
#               name
#             }
#           }
#         }
#       GQL
#     end

#     subject(:result) do
#       SpiderSchema.execute(query, context: {jwt_token: auth_token}).as_json
#     end

#     it "returns all categories" do
#       items = result.dig("data", "categories")
#       expect(items.count).to be > 1

#       items.each do |item|
#         expect(item["name"]).to be_present
#       end
#     end
#   end
# end
