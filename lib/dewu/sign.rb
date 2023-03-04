require 'digest/md5'

module Dewu
  module Sign
    def self.generate(params) #https://open.dewu.com/#/doc?id=1010000028&pid=1010515087&type=article
      query = params.sort.map do |key, value|
        "#{key}=#{value}" if value != "" && !value.nil?
      end.compact.join('&')

      Digest::MD5.hexdigest("#{query}#{Dewu.app_secret}").upcase
    end

    def self.generate!(params)
      sign = self.generate(params)
      params[:sign] = sign
      params
    end

    def self.verify?(params)
      params = params.dup
      sign = params.delete('sign') || params.delete(:sign)

      generate(params) == sign
    end
  end
end