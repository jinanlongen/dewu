# coding: utf-8
require "httparty"
require "active_support/core_ext/hash/conversions"
require "dewu/result"

module Dewu
  module Service
    def self.auth_brand_list(params = {})
      r = get("v1/spu/auth_brand_list", params)
      yield r if block_given?

      r
    end

    def self.brand_category_spus_oversea_sync(params = {})
      r = get("v1/spu/oversea/brand_category_spus_oversea_sync", params)
      yield r if block_given?

      r
    end

    def self.brand_category_spus_domestic_sync(params = {})
      r = get("v1/spu/domestic/brand_category_spus_domestic_sync", params)
      yield r if block_given?

      r
    end

    def self.batch_article_number(params = {})
      r = post("v1/spu/batch_article_number", params)
      yield r if block_given?

      r
    end

    class << self
      private

      def check_required_options(options, names)
        names.each do |name|
          warn("Dewu Warn: missing required option: #{name}") unless options.has_key?(name)
        end
      end

      def make_url(path)
        Dewu.base_uri + path
      end

      def merge_params(params)
        params = params.merge({
          :app_key => Dewu.app_key,
          :timestamp => (Time.now().to_f * 1000).to_i, # current timestamp in milliseconds
        })
        sign = Dewu::Sign.generate(params)

        params.merge({
          :sign => sign,
        })
      end

      def get(path, params = {})
        r = HTTParty.get(
          make_url(path),
          :headers => { "Content-type" => "application/json" },
          :query => merge_params(params),
        ).parsed_response

        if r
          Dewu::Result.new(r)
        else
          nil
        end
      end

      def post(path, params = {})
        r = HTTParty.post(
          make_url(path),
          :headers => { "Content-type" => "application/json" },
          :body => merge_params(params).to_json,
        ).parsed_response

        if r
          Dewu::Result.new(r)
        else
          nil
        end
      end
    end
  end
end
