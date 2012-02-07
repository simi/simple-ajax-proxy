require 'sinatra'
require 'open-uri'
require 'net/http'

class SimpleAjaxProxy < Sinatra::Base
  post '/' do
    url = URI.parse(params[:url])

    req = Net::HTTP::Post.new(url.path, initheader = {'Content-Type' =>'application/json'})
    req.body = params[:request]

    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    response['Access-Control-Allow-Origin'] = url
    response.body
  end

  run! if app_file == $0
end

run SimpleAjaxProxy
