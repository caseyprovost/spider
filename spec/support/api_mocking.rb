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

  def mock_books_with_authors(auth_token)
    stub_request(:get, "http://bookshelf.book-ecosystem.dev/v1/books")
      .with(
        headers: {
          "Accept" => "application/vnd.api+json",
          "Content-Type" => "application/vnd.api+json",
          "Authorization" => auth_token,
        }
      ).to_return(status: 201, body: json_fixture("books"), headers: {Authorization: "Bearer 234234klsd"})
  end

  def mock_product_search(auth_token, filters: {})
    query = {
      filters: filters.keep_if { |_, value| value.present? },
    }

    query.delete(:filters) if query[:filters].empty?

    stub_request(:get, "#{ENV["BOOKSTORE_API_URL"]}/api/v1/products")
      .with(
        query: query,
        headers: {
          "Accept" => "application/vnd.api+json",
          "Content-Type" => "application/vnd.api+json",
          "Authorization" => auth_token,
        }
      ).to_return(status: 201, body: json_fixture("products"), headers: {Authorization: "Bearer 234234klsd"})
  end

  def mock_products(auth_token)
    stub_request(:get, "https://ruby-bookstore.herokuapp.com/api/v1/products")
      .with(
        headers: {
          "Accept" => "application/vnd.api+json",
          "Content-Type" => "application/vnd.api+json",
          "Authorization" => auth_token,
        }
      ).to_return(status: 201, body: json_fixture("products"), headers: {Authorization: "Bearer 234234klsd"})
  end

  def mock_variants(auth_token, product_id)
    stub_request(:get, "https://ruby-bookstore.herokuapp.com/api/v1/variants?filter[product_id]=#{product_id}")
      .with(
        headers: {
          "Accept" => "application/vnd.api+json",
          "Content-Type" => "application/vnd.api+json",
          "Authorization" => auth_token,
        }
      ).to_return(status: 201, body: json_fixture("variants"), headers: {Authorization: "Bearer 234234klsd"})
  end

  def mock_categories(auth_token)
    stub_request(:get, "https://ruby-bookstore.herokuapp.com/api/v1/categories")
      .with(
        headers: {
          "Accept" => "application/vnd.api+json",
          "Content-Type" => "application/vnd.api+json",
          "Authorization" => auth_token,
        }
      ).to_return(status: 201, body: json_fixture("categories"), headers: {Authorization: "Bearer 234234klsd"})
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

  def mock_author(auth_token, uuid)
    stub_request(:get, "http://author-registry.book-ecosystem.dev/v1/authors/#{uuid}")
      .with(
        headers: {
          "Accept" => "application/vnd.api+json",
          "Content-Type" => "application/vnd.api+json",
          "Authorization" => auth_token,
        }
      ).to_return(status: 201, body: json_fixture("stephen_king"), headers: {Authorization: "Bearer 234234klsd"})
  end

  def json_fixture(file_name)
    file_fixture("#{file_name}.json").read
  end
end
