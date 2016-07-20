require 'rubygems'
require 'mqtt'
require 'openssl'

# Subscribe example
 client = MQTT::Client.connect(
  :host => 'www.techministry.rocks',
  :port => 1883,
  :ssl => true,
  :ca_file => '/var/local/mosquitto/MQTT-CA-TM.crt'
 )
client.subscribe('techministry/spacestatus/hackers')
client.get do |topic,message|
  # If you pass a block to the get method, then it will loop
  File.open('/usr/share/nginx/html/hackers.txt', 'w') { |file| file.truncate(0); file.write("#{message}") }
  File.open('/usr/share/nginx/html/hackerslog.txt', 'a') { |file| file.write("#{message} #{Time.now}\n") }
end
