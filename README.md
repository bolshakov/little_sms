# LittleSMS
This gem provides access to LittleSMS.ru API from ruby (mri 1.8.7 and 1.9.2 supported).

# Installation
    $ gem install little_sms

# Usage
    require "little_sms"
    api = LittleSMS.new(:apiuser, :apikey)
    api.message.send(:recipients => "+79211234567", :message => "Test", :test => 1)

Also you can pass a block to LittleSMS object:

    LittleSMS.new(:apiuser, :apikey) do
      msg =  message.send(:recipients => "+79211234567", :message => "Test")
      if msg.success?
        messages_id = msg.messages_id.join
        status = message.status(:messages_id => messages_id)
        puts "Message #{status.messages[messages_id]}" unless status.error? # => Message delivered
      end
    end

In case of error:

    LittleSMS.new(:apiuser, :apikey) do
      msg = message.send(:recipients => "112", :message => "Test")
      if msg.error?
        puts msg.error   # => 4
        puts msg.message # => "incorrect or empty recipients list"
      end
    end

# Copyright
Copyright © 2011 Artyom Bolshakov. See LICENSE.txt for details.

