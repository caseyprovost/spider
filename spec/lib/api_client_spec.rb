require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ApiClient do
  include ApiMocking

  let(:auth_token) { 'Bearer SomeToken' }
  let(:client) { described_class.new }
  let(:json_response) { JSON.parse(response.parsed_response) }

  describe '#books' do
    let(:response) { client.books(auth_token) }

    context 'when the client is already authorized' do
      before { mock_books(auth_token) }

      it 'returns the available books' do
        expect(response).to be_an_instance_of(Array)
        response.each do |book_json|
          expect(book_json['id']).to be_present
          expect(book_json).to have_key('title')
          expect(book_json).to have_key('publication_date')
          expect(book_json).to have_key('page_count')
          expect(book_json).to have_key('created_at')
          expect(book_json).to have_key('updated_at')
        end
      end
    end
  end
end
