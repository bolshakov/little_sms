# Convert all keys to symbols
module Enumerable
  def symbolize_keys
    symbolize = lambda { |v| v.respond_to?(:map) ? v.symbolize_keys : v }
    case self
    when Hash
      Hash[ self.map { |key, value|
        k = key.kind_of?(String) ? key.to_sym : key
        v = symbolize.call(value)
        [k, v]
      }]
    when Array
      self.map { |value| symbolize.call(value) }
    else
      self
    end
  end
end

