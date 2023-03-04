# coding: utf-8
require "httparty"
require "active_support/core_ext/hash/conversions"
require "dewu/result"

module Dewu
  module Service
    extend self

    def auth_brand_list(params = {})
      get("v1/spu/auth_brand_list", params)
    end

    def brand_category_spus_oversea_sync(params = {})
      get("v1/spu/oversea/brand_category_spus_oversea_sync", params)
    end

    def brand_category_spus_domestic_sync(params = {})
      get("v1/spu/domestic/brand_category_spus_domestic_sync", params)
    end

    def batch_article_number(params = {})
      post("v1/spu/batch_article_number", params)
    end

    private

    def make_url(path)
      "#{Dewu.base_uri}#{path}"
    end

    def merge_params(params)
      params = params.merge({
        :app_key => Dewu.app_key,
        :timestamp => (Time.now().to_f * 1000).to_i, # current timestamp in milliseconds
      })

      params.merge({
        sign: Dewu::Sign.generate(params),
      })
    end

    def get(path, params = {})
      response = HTTParty.get(
        make_url(path),
        headers: { "Content-type" => "application/json" },
        query: merge_params(params),
      )

      Dewu::Result.new(response.parsed_response)
    end

    def post(path, params = {})
      response = HTTParty.post(
        make_url(path),
        headers: { "Content-type" => "application/json" },
        body: merge_params(params).to_json,
      )

      Dewu::Result.new(response.parsed_response)
    end
  end
end
