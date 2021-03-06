require "json"
require "net/http"
require "net/https"
require "digest/md5"
require "digest/sha1"
require_relative "responce"

class LittleSMS
  class Component
    # Conflict with message.send
    undef :send
    attr_reader :component

    def initialize(component, api_user, api_key)
      @api_uri = URI.parse("https://littlesms.ru:443/api/")
      @api_user, @api_key = api_user, api_key
      @component = component # Component name. E.g. message or user.
    end

    def method_missing(name, *args)
      request_api_method(name, args[0])
    end

    private
    def request_api_method(method, options = {})
      options[:sign] = sign_request(options || {})
      options[:user] = @api_user

      uri = @api_uri.merge("#{@component}/#{method}")
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(options.delete_if {|k, v| k == :key})

      uri.scheme, uri.port, use_ssl = if LittleSMS.use_ssl
        ["https", 443, true]
      else
        ["http", 80, false]
      end
      res = Net::HTTP.new(uri.host, uri.port)
      res.use_ssl = use_ssl

      case res = res.start {|http| http.request(req) }
      when Net::HTTPSuccess, Net::HTTPRedirection
        return Responce.new(JSON.parse(res.body))
      else
        res.error!
      end
    end

    def sign_request(options)
      sorted_options = options.map{|k, v| [k.to_s, v]}.sort.inject(""){|str, value| str += value[1].to_s}
      Digest::MD5.hexdigest(Digest::SHA1.hexdigest("#{@api_user}#{sorted_options}#{@api_key}"))
    end
  end
end

