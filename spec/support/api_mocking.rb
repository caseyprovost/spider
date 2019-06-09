module ApiMocking
  def mock_successful_api_login(body)
    stub_request(:post, "https://master-auth.herokuapp.com/users/sign_in").
      with(
        body: body,
        headers: {
          'Accept'=>'application/json',
          'Content-Type'=>'application/json'
        }
    ).to_return(status: 201, body: json_fixture('tony_stark'), headers: { Authorization: 'Bearer 234234klsd' })
  end

  def mock_failed_api_login(body)
    stub_request(:post, "https://master-auth.herokuapp.com/users/sign_in").
      with(
        body: body,
        headers: {
          'Accept'=>'application/json',
          'Content-Type'=>'application/json'
        }
    ).to_return(status: 402, body: { error: 'failed attempt' }.to_json, headers: {})
  end

  def mock_books
    stub_request(:get, "https://ruby-bookshelf.herokuapp.com/v1/books").
      with(
        headers: {
          'Accept'=>'application/vnd.api+json',
          'Content-Type'=>'application/vnd.api+json'
        }
    ).to_return(status: 201, body: json_fixture('books'), headers: { Authorization: 'Bearer 234234klsd' })
  end

  def json_fixture(file_name)
    file_fixture("#{file_name}.json").read
  end
end
