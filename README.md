# LittleSMS
This gem provides access to LittleSMS.ru API from ruby.

# Installation
    $ gem install little_sms

# Usage
    require "little_sms"
    api = LittleSMS.new(:apiuser, :apikey)
    api.message.send(:recipients => "112", :message => "Sos!")

Also you can pass a block to LittleSMS object:

    LittleSMS.new(:apiuser, :apikey) do
      msg =  message.send(:recipients => "112", :message => "Sos!")
      if msg[:status] == "success"
        messages_id = msg[:messages_id].join
        status = message.status(:messages_id => messages_id)
        puts "Message #{status[:messages][messages_id]}" if status[:status] == "success"
      end
    end

# Supported API methods
This gem supports all LittleSMS api features.
Due to LittleSMS api’s bad design we need to specify right parameters order. These order stored at ``lib/little_sms/ordering/*.yaml`` files.

Currently there is no documentation for all methods. Fill in those files yourself if you know right parameters order
See ``lib/little_sms/ordering/message.yaml`` for details. You always should specify api user at the beginning of the list and api key at the end.

# Copyright
Copyright © 2011 Artyom Bolshakov. See LICENSE.txt for details.

