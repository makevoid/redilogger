file = File.read( File.expand_path "~/.textmagic_sms" ).strip
textmagic_secret, recipient = file.split "|"
TEXTMAGIC_SECRET = textmagic_secret
RECIPIENT = recipient
TARGET_URL = "http://example.com/success"

def log(data)
  gateway = TextMagic::API.new 'makevoid', TEXTMAGIC_SECRET
  recipient = RECIPIENT
  message = "logged: #{data}"
  gateway.send message, recipient.gsub(/\s+/, '')
end

require 'bundler'
Bundler.require :default

class RediLogger < Sinatra::Application

  get "/*" do
    log "RediLogger: #{params.inspect}"
    redirect TARGET_URL
  end
end