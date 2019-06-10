module ApiMocking
  def mock_books(auth_token)
    stub_request(:get, "https://ruby-bookshelf.herokuapp.com/v1/books").
      with(
        headers: {
          'Accept'        => 'application/vnd.api+json',
          'Content-Type'  => 'application/vnd.api+json',
          'Authorization' => auth_token
        }
    ).to_return(status: 201, body: json_fixture('books'), headers: { Authorization: 'Bearer 234234klsd' })
  end

  def json_fixture(file_name)
    file_fixture("#{file_name}.json").read
  end
end
