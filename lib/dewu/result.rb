module Dewu
  class Result < ::Hash
    CODE_SUCCESS = 200

    def initialize(result)
      super

      self.merge!(result)
    end

    def success?
      self["code"] == CODE_SUCCESS
    end
  end
end
