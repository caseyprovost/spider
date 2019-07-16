# frozen_string_literal: true

require "rails_helper"
require "webmock/rspec"

RSpec.describe Types::QueryType do
  include ApiMocking

  let(:auth_token) { "Bearer SomeToken" }

  describe "books" do
    context "standard case" do
      before { mock_books(auth_token) }
      let(:expected_books) { JSON.parse(json_fixture("books"))["data"] }

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

    context "including authors" do
      before do
        mock_books(auth_token)
        mock_author(auth_token, author_uuid)
      end

      let(:author_uuid) { "1111-2222-3333" }

      let(:query) do
        <<~GQL
          query {
            books {
              title
              author {
                name
              }
            }
          }
        GQL
      end

      subject(:result) do
        SpiderSchema.execute(query, context: {jwt_token: auth_token}).as_json
      end

      it "returns all books with authors nested" do
        author = result.dig("data", "books")[0]["author"]
        expect(author["name"]).to eq("Stephan King")
      end
    end
  end

  describe "authors" do
    before { mock_authors(auth_token) }
    let(:expected_authors) { JSON.parse(json_fixture("authors"))["data"] }

    let(:query) do
      <<~GQL
        query {
          authors {
            name
          }
        }
      GQL
    end

    subject(:result) do
      SpiderSchema.execute(query, context: {jwt_token: auth_token}).as_json
    end

    it "returns all authors" do
      authors = result.dig("data", "authors")
      expect(authors.count).to eq(expected_authors.count)

      authors.each do |author|
        match = expected_authors.detect { |a| a["attributes"]["name"] == author["name"] }
        expect(match).to be_present
      end
    end
  end

  describe "products" do
    context "standard case" do
      before { mock_products(auth_token) }

      let(:expected_products) { JSON.parse(json_fixture("products"))["data"] }

      let(:query) do
        <<~GQL
          query {
            products {
              name
              description
            }
          }
        GQL
      end

      subject(:result) do
        SpiderSchema.execute(query, context: {jwt_token: auth_token}).as_json
      end

      it "returns all the products" do
        products = result.dig("data", "products")
        expect(products.count).to eq(expected_products.count)

        products.each do |product|
          product_match = expected_products.detect { |item| item["attributes"]["name"] == product["name"] }
          expect(product_match).to be_present
        end
      end
    end

    context "with variants" do
      before do
        mock_products(auth_token)
        mock_variants(auth_token, 1)
      end

      let(:expected_products) { JSON.parse(json_fixture("products"))["data"] }
      let(:expected_variants) { JSON.parse(json_fixture("variants"))["data"] }

      let(:query) do
        <<~GQL
          query {
            products {
              name
              description
              variants {
                name
                position
                price
              }
            }
          }
        GQL
      end

      subject(:result) do
        SpiderSchema.execute(query, context: {jwt_token: auth_token}).as_json
      end

      it "returns all the products with their variants" do
        products = result.dig("data", "products")
        expect(products.count).to eq(expected_products.count)

        products.each do |product|
          product_match = expected_products.detect { |item| item["attributes"]["name"] == product["name"] }
          expect(product_match).to be_present
        end
      end
    end
  end
end
