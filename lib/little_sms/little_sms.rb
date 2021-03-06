class LittleSMS
  class << self
    attr_accessor :use_ssl
  end
  # Use ssl by default
  self.use_ssl = true

  def initialize(api_user, api_key, &block)
    @api_user, @api_key = api_user, api_key
    @components = {}
    self.instance_eval &block if block_given?
  end

  def method_missing(name, *args)
    @components[name] ||= Component.new(name, @api_user, @api_key)
  end
end

