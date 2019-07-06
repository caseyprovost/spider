# frozen_string_literal: true

require "rails_helper"
require "webmock/rspec"

RSpec.describe Types::QueryType do
  include ApiMocking

  let(:auth_token) { "Bearer SomeToken" }
  let(:expected_books) do
    JSON.parse(json_fixture("books"))["data"]
  end

  describe "books" do
    before { mock_books(auth_token) }

    let(:query) do
      %(query {
        books {
          title
        }
      })
    end

    subject(:result) do
      SpiderSchema.execute(query, context: {jwt_token: auth_token}).as_json
    end

    it "returns all books" do
      books = result.dig("data", "books")
      expect(books.count).to eq(expected_books.count)

      books.each do |book|
        book_match = expected_books.detect { |b| b["attributes"]["title"] == book["title"] }
        expect(book_match).to be_present
      end
    end
  end
end
