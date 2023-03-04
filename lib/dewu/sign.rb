require "digest/md5"

module Dewu
  module Sign
    extend self

    def generate(params)
      query = params.sort.map { |key, value| "#{key}=#{value}" if value && !value.to_s.empty? }.compact.join("&")
      Digest::MD5.hexdigest("#{query}#{Dewu.app_secret}").upcase
    end

    def generate!(params)
      params.merge(sign: generate(params))
    end

    def verify?(params)
      sign = params.delete(:sign) || params.delete("sign")
      generate(params) == sign
    end
  end
end
