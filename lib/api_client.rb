# frozen_string_literal: true

require_relative "./api_client/configuration"
require_relative "./api_client/resource"

module ApiClient
  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end

  class Client
    attr_reader :jwt_token

    def initialize(jwt_token)
      @jwt_token = jwt_token
    end

    def products
      @products ||= Resource.new(
        url: ApiClient.config.bookstore_service_url,
        path: "api/v1/products",
        jwt_token: jwt_token
      )
    end

    def properties
      @properties ||= Resource.new(
        url: ApiClient.config.bookstore_service_url,
        path: "api/v1/properties",
        jwt_token: jwt_token
      )
    end

    def product_properties
      @product_properties ||= Resource.new(
        url: ApiClient.config.bookstore_service_url,
        path: "api/v1/product_properties",
        jwt_token: jwt_token
      )
    end

    def option_types
      @option_types ||= Resource.new(
        url: ApiClient.config.bookstore_service_url,
        path: "api/v1/option_types",
        jwt_token: jwt_token
      )
    end

    def option_values
      @option_types ||= Resource.new(
        url: ApiClient.config.bookstore_service_url,
        path: "api/v1/option_values",
        jwt_token: jwt_token
      )
    end

    def option_value_variants
      @option_value_variants ||= Resource.new(
        url: ApiClient.config.bookstore_service_url,
        path: "api/v1/option_value_variants",
        jwt_token: jwt_token
      )
    end

    def books
      @books ||= Resource.new(
        url: ApiClient.config.bookshelf_service_url,
        path: "v1/books",
        jwt_token: jwt_token
      )
    end

    def publishers
      @publishers ||= Resource.new(
        url: ApiClient.config.publisher_service_url,
        path: "v1/publishers",
        jwt_token: jwt_token
      )
    end

    def authors
      @authors ||= Resource.new(
        url: ApiClient.config.author_service_url,
        path: "v1/authors",
        jwt_token: jwt_token
      )
    end

    def categories
      @categories ||= Resource.new(
        url: ApiClient.config.bookstore_service_url,
        path: "api/v1/categories",
        jwt_token: jwt_token
      )
    end

    def variants
      @variants ||= Resource.new(
        url: ApiClient.config.bookstore_service_url,
        path: "api/v1/variants",
        jwt_token: jwt_token
      )
    end
  end
end
