# Convert all keys to symbols
module Enumerable
  def recursive_symbolize_keys
    symbolize = lambda { |v| v.respond_to?(:map) ? v.recursive_symbolize_keys : v }
    if self.kind_of? Hash
      Hash[ self.map { |k, v| [k.to_sym, symbolize.call(v)] } ]
    else
      self.map { |v| symbolize.call(v) }
    end
  end
end

