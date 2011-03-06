# LittleSMS
This gem provides access to LittleSMS.ru API from ruby.

# Installation
    gem install little_sms

# Usage
    require "little_sms"
    api = LittleSMS.new(:apiuser, :apikey)
    api.message.send(:recipients => "112", :message => "Sos!")
Also you can pass a block to LittleSMS object:
    LittleSMS.new(:apiuser, :apikey) do
      msg =  message.send(:recipients => "112", :message => "Sos!")
      if msg[:status] == :success
        messages_id = msg[:messages_id].join
        status = message.status(:messages_id => messages_id)
        puts "Message #{status[:messages][messages_id]}" if status[:status] == :success
      end
    end

# Copyright
Copyright © 2011 Artyom Bolshakov. See LICENSE.txt for details.

