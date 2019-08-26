module ApiClient
  class Configuration
    cattr_accessor :bookshelf_service_url
    cattr_accessor :bookstore_service_url
    cattr_accessor :publisher_service_url
    cattr_accessor :author_service_url
  end
end
