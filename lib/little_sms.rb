libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require "#{libdir}/little_sms/component"
require "#{libdir}/little_sms/little_sms"


class LittleSMS; end

