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

    def error
      if error? then @json[:error] else nil end
    end

    def message
      if error? then @json[:message] else nil end
    end

    def method_missing(name, *args)
      unless args.empty?
        super
      else
        @json[name] || super
      end
    end

    def respond_to?(method)
      @json.has_key?(method) || super
    end
  end
end
