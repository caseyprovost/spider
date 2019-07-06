# frozen_string_literal: true

module ApiMocking
  def mock_books(auth_token)
    stub_request(:get, "http://bookshelf.book-ecosystem.dev/v1/books")
      .with(
        headers: {
          "Accept" => "application/vnd.api+json",
          "Content-Type" => "application/vnd.api+json",
          "Authorization" => auth_token,
        }
      ).to_return(status: 201, body: json_fixture("books"), headers: {Authorization: "Bearer 234234klsd"})
  end

  def mock_publishers(auth_token)
    stub_request(:get, "http://publisher-registry.book-ecosystem.dev/v1/publishers")
      .with(
        headers: {
          "Accept" => "application/vnd.api+json",
          "Content-Type" => "application/vnd.api+json",
          "Authorization" => auth_token,
        }
      ).to_return(status: 201, body: json_fixture("publishers"), headers: {Authorization: "Bearer 234234klsd"})
  end

  def mock_authors(auth_token)
    stub_request(:get, "http://author-registry.book-ecosystem.dev/v1/authors")
      .with(
        headers: {
          "Accept" => "application/vnd.api+json",
          "Content-Type" => "application/vnd.api+json",
          "Authorization" => auth_token,
        }
      ).to_return(status: 201, body: json_fixture("authors"), headers: {Authorization: "Bearer 234234klsd"})
  end

  def json_fixture(file_name)
    file_fixture("#{file_name}.json").read
  end
end
