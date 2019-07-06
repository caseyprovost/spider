# frozen_string_literal: true

require "rails_helper"
require "webmock/rspec"

RSpec.describe ApiClient do
  include ApiMocking

  let(:auth_token) { "Bearer SomeToken" }
  let(:client) { described_class.new }
  let(:json_response) { JSON.parse(response.parsed_response) }

  describe "#books" do
    let(:response) { client.books(auth_token) }

    context "when the client is already authorized" do
      before { mock_books(auth_token) }

      it "returns the available books" do
        expect(response).to be_an_instance_of(Array)
        response.each do |item|
          expect(item["id"]).to be_present
          expect(item).to have_key("title")
          expect(item).to have_key("publication_date")
          expect(item).to have_key("page_count")
          expect(item).to have_key("created_at")
          expect(item).to have_key("updated_at")
        end
      end
    end
  end

  describe "#authors" do
    let(:response) { client.authors(auth_token) }

    context "when the client is already authorized" do
      before { mock_authors(auth_token) }

      it "returns the available authors" do
        expect(response).to be_an_instance_of(Array)
        response.each do |item|
          expect(item["id"]).to be_present
          expect(item).to have_key("name")
          expect(item).to have_key("bio")
          expect(item).to have_key("date_of_birth")
          expect(item).to have_key("hometown")
        end
      end
    end
  end

  describe "#publishers" do
    let(:response) { client.publishers(auth_token) }

    context "when the client is already authorized" do
      before { mock_publishers(auth_token) }

      it "returns the available publishers" do
        expect(response).to be_an_instance_of(Array)
        response.each do |item|
          expect(item["id"]).to be_present
          expect(item).to have_key("name")
          expect(item).to have_key("description")
          expect(item).to have_key("uuid")
        end
      end
    end
  end
end
