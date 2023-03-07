# coding: utf-8
require "httparty"
require "active_support/core_ext/hash/conversions"
require "dewu/result"

module Dewu
  #https://open.dewu.com/#/index
  module Service
    extend self

    # 获取商家已授权的品牌和类目
    def auth_brand_list(params = {})
      get("v1/spu/auth_brand_list", params)
    end

    # 根据品牌和类目ID拉取平台商品升级版【跨境】
    def brand_category_spus_oversea_sync(brand_id, params = {})
      get("v1/spu/oversea/brand_category_spus_oversea_sync", { brand_id: brand_id }.merge(params))
    end

    # 根据品牌和类目ID拉取平台商品升级版【国内】
    def brand_category_spus_domestic_sync(brand_id, params = {})
      get("v1/spu/domestic/brand_category_spus_domestic_sync", { brand_id: brand_id }.merge(params))
    end

    # 通过货号批量获取商品spu信息
    def batch_article_number(article_numbers)
      post("v1/spu/batch_article_number", { article_numbers: article_numbers.split(",") })
    end

    # 商家出价列表信息（支持按出价类型查询）
    def bidding_generic_list(bidding_type, params = {})
      post("v1/bidding/generic_list", { bidding_type: bidding_type }.merge { params })
    end

    # 获取商家出价列表信息【普通现货】
    def bidding_normal_list(bidding_type, sku_id, spu_id, merchant_sku_code, params = {})
      post("v1/bidding/normal/normal_list", { sku_id: sku_id, spu_id: spu_id, merchant_sku_code: merchant_sku_code }.merge { params })
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
