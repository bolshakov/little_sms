require_relative "enumerable"

class LittleSMS
  class Responce
    def initialize(json)
      @json = json.recursive_symbolize_keys
    end

    def success?
      @json[:status] == "success"
    end

    def error?
      @json[:status] == "error"
    end
  end
end

