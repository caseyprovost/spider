require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ApiClient do
  include ApiMocking

  let(:client) { described_class.new(email, password) }
  let(:email) { 'tony.stark@avengers.net' }
  let(:password) { 'iamironman' }
  let(:json_response) { JSON.parse(response.parsed_response) }

  describe '#login' do
    let(:response) { client.login }

    context 'with proper credentials' do
      before do
        mock_successful_api_login(request_body)
      end

      let(:request_body) do
        "user=%7B%22email%22%3A%22tony.stark%40avengers.net%22%2C%22password%22%3A%22iamironman%22%7D"
      end

      it 'returns the user' do
        expect(json_response.keys).to include('id')
        expect(json_response.keys).to include('email')
        expect(json_response.keys).to include('jti')
        expect(json_response.keys).to include('name')
      end

      it 'sets the auth token' do
        expect(client.auth_token).to be_blank
        expect(response.code).to eq(201)
        expect(client.auth_token).to be_present
      end
    end
  end

  describe '#books' do
    let(:response) { client.books }

    context 'when the client is already authorized' do
      before do
        client.auth_token = 'Bearer 324234'
        mock_books
      end

      it 'returns the available books' do
        expect(json_response).to be_an_instance_of(Hash)
        json_response['data'].each do |book_json|
          expect(book_json['id']).to be_present
          expect(book_json['type']).to eq('books')
          expect(book_json['attributes']).to have_key('title')
          expect(book_json['attributes']).to have_key('publication_date')
          expect(book_json['attributes']).to have_key('page_count')
          expect(book_json['attributes']).to have_key('created_at')
          expect(book_json['attributes']).to have_key('updated_at')
        end
      end
    end
  end
end
