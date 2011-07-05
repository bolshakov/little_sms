require_relative "enumerable"

class LittleSMS
  class Responce
    def initialize(json)
      @json = json.recursive_symbolize_keys
    end
  end
end

