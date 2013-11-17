file = File.read( File.expand_path "~/.textmagic_sms" ).strip
textmagic_secret, recipient = file.split "|"
TEXTMAGIC_SECRET = textmagic_secret
RECIPIENT = recipient

def log(data)
  gateway = TextMagic::API.new 'makevoid', TEXTMAGIC_SECRET
  recipient = RECIPIENT
  message = "logged: #{data}"
  gateway.send message, recipient.gsub(/\s+/, '')
end

require 'bundler'
Bundler.require :default

class RediLogger < Sinatra::Application
  get "/trovit/cuoco" do
    log "#{request.ip} #{request.user_agent[0..120]}"
    redirect "http://lavoro.trovit.it/index.php/cod.search_jobs/what_d.cuoco/"
  end

  get "/ebay/cuoco" do
    log "#{request.ip} #{request.user_agent[0..120]}"
    redirect "http://annunci.ebay.it/offerte-di-lavoro/offerta/cuochi-e-baristi-offerte/cuoco/"
  end

  get "/*" do
    log "#{request.ip} #{request.user_agent[0..120]}"
    redirect "http://annunci.ebay.it/offerte-di-lavoro/offerta/cuochi-e-baristi-offerte/cuoco/"
  end
end