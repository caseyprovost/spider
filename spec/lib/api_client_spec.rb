# frozen_string_literal: true

require "rails_helper"
require "webmock/rspec"

RSpec.describe ApiClient::Client do
  include ApiMocking

  let(:auth_token) { "Bearer SomeToken" }
  let(:client) { described_class.new(auth_token) }
  let(:json_response) { JSON.parse(response.parsed_response) }

  describe "#books" do
    let(:resource) { client.books }

    it "returns the proper resource" do
      expect(resource).to be_an_instance_of(ApiClient::Resource)
      expect(resource.url).to eq(ENV["BOOKSHELF_API_URL"])
      expect(resource.path).to eq("v1/books")
      expect(resource.jwt_token).to be_present
    end
  end

  describe "#authors" do
    let(:resource) { client.authors }

    it "returns the proper resource" do
      expect(resource).to be_an_instance_of(ApiClient::Resource)
      expect(resource.url).to eq(ENV["AUTHOR_API_URL"])
      expect(resource.path).to eq("v1/authors")
      expect(resource.jwt_token).to be_present
    end
  end

  describe "#publishers" do
    let(:resource) { client.publishers }

    it "returns the proper resource" do
      expect(resource).to be_an_instance_of(ApiClient::Resource)
      expect(resource.url).to eq(ENV["PUBLISHER_API_URL"])
      expect(resource.path).to eq("v1/publishers")
      expect(resource.jwt_token).to be_present
    end
  end
end
