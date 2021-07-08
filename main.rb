require 'json'
require 'sinatra'

set :protection, :except => :frame_options
set :bind, '0.0.0.0'
set :port, 8080

get '/' do
  erb :index
end

post '/convert-form' do
  json = {'cert' => convert_pem(params[:pem]) }
  body JSON.pretty_generate(json)
end

post '/convert' do
  pem = request.body.read
  json = { 'cert' => convert_pem(pem) }
  body JSON.pretty_generate(json)
end

def convert_pem(pem_content)
  converted_pem = pem_content
  converted_pem.gsub(/\r/," ").split("\n").map do |line|
    line.strip
  end.join("\n") + "\n"
end
