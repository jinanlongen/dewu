# coding: utf-8
require "httparty"
require "active_support/core_ext/hash/conversions"
require "dewu/result"

module Dewu
  module Service
    extend self

    # 获取商家已授权的品牌和类目
    # https://open.dewu.com/#/api/body?apiId=21&id=2&title=%E5%95%86%E5%93%81%E6%9C%8D%E5%8A%A1API
    def auth_brand_list(params = {})
      get("v1/spu/auth_brand_list", params)
    end

    # 根据品牌和类目ID拉取平台商品升级版【跨境】
    # https://open.dewu.com/#/api/body?apiId=48&id=2&title=%E5%95%86%E5%93%81%E6%9C%8D%E5%8A%A1API
    def brand_category_spus_oversea_sync(params = {})
      get("v1/spu/oversea/brand_category_spus_oversea_sync", params)
    end

    # 根据品牌和类目ID拉取平台商品升级版【国内】
    # https://open.dewu.com/#/api/body?apiId=47&id=2&title=%E5%95%86%E5%93%81%E6%9C%8D%E5%8A%A1API
    def brand_category_spus_domestic_sync(params = {})
      get("v1/spu/domestic/brand_category_spus_domestic_sync", params)
    end

    # 通过货号批量获取商品spu信息
    # https://open.dewu.com/#/api/body?apiId=156&id=2&title=%E5%95%86%E5%93%81%E6%9C%8D%E5%8A%A1API
    def batch_article_number(article_numbers)
      post("v1/spu/batch_article_number", { article_numbers: article_numbers.split(",") })
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
