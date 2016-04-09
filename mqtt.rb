require 'rubygems'
require 'mqtt'
require 'openssl'

# Subscribe example
 client = MQTT::Client.connect(
  :host => 'www.techministry.gr',
  :port => 1883,
  :ssl => true,
  :ca_file => 'path_to_your_ca'
 )
client.subscribe('techministry/spacestatus/hackers')
client.get do |topic,message|
  # If you pass a block to the get method, then it will loop
  File.open('/usr/share/nginx/html/hackers.txt', 'w') { |file| file.truncate(0); file.write("#{message}") }
end
