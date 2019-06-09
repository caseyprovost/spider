class ApiClient
  AUTH_SERVICE_URL = 'https://master-auth.herokuapp.com'
  BOOK_SERVICE_URL = 'https://ruby-bookshelf.herokuapp.com'

  attr_accessor :auth_token
  attr_reader :email
  attr_reader :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def login
    response = HTTParty.post("#{AUTH_SERVICE_URL}/users/sign_in", {
      body: {
        user: {
          email: email,
          password: password
        }.to_json
      },
      headers: {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    })

    self.auth_token = response.headers['Authorization']
    response
  end

  def books
    with_authorization do
      HTTParty.get("#{BOOK_SERVICE_URL}/v1/books", headers: {
        'Accept' => 'application/vnd.api+json',
        'Content-Type' => 'application/vnd.api+json'
      })
    end
  end

  private

  def with_authorization
    login if auth_token.blank?
    yield
  end
end
