require "json"
require "net/http"
require "net/https"
require 'digest/md5'
require 'digest/sha1'

class LittleSMS
  class Component
    # Conflict with message.send
    undef :send
    attr_reader :component

    def initialize(component, api_user, api_key)
      @api_uri = URI.parse("https://littlesms.ru:443/api/")
      @auth = {:user => api_user, :key => api_key}
      @component = component # Component name. E.g. message or user.
    end

    def method_missing(name, *args)
      request_api_method(name, args[0])
    end

    private
    def request_api_method(method, options = {})
      options ||= {}
      options.merge!(@auth)

      options[:sign] = sign_request(options)
      uri = @api_uri.merge("#{@component}/#{method}")
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(options.delete_if {|k, v| k == :key})

      uri.scheme, uri.port, use_ssl = if LittleSMS.use_ssl
        ['https', 443, true]
      else
        ['http', 80, false]
      end
      res = Net::HTTP.new(uri.host, uri.port)
      res.use_ssl = use_ssl

      case res = res.start {|http| http.request(req) }
      when Net::HTTPSuccess, Net::HTTPRedirection
        return JSON.parse(res.body).recursive_symbolize_keys
      else
        res.error!
      end
    end

    def sign_request(options)
      Digest::MD5.hexdigest(
          Digest::SHA1.hexdigest(options.sort.map {|e| e[1]}.join)
        )
    end
  end
end

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

