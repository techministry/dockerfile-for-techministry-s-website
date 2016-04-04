require 'rubygems'
require 'mqtt'

# Subscribe example
client = MQTT::Client.connect('www.techministry.gr')
client.subscribe('techministry/spacestatus/hackers')
client.get do |topic,message|
  # If you pass a block to the get method, then it will loop
  File.open('/usr/share/nginx/html/hackers.txt', 'w') { |file| file.truncate(0); file.write("#{message}") }
end
