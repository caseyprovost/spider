# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Types::QueryType do
  include ApiMocking

  let(:auth_token) { 'Bearer SomeToken' }

  describe 'books' do
    before { mock_books(auth_token) }

    let(:query) do
      %(query {
        books {
          title
        }
      })
    end

    subject(:result) do
      SpiderSchema.execute(query).as_json
    end

    it 'returns all books' do
      books = result.dig('data', 'books')
      expect(books.count).to eq(3)
    end
  end
end
