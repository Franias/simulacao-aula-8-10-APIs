require 'openssl'
require 'date'
require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/cross_origin'

require_relative 'models/pessoa'
require_relative 'serializers'

configure do
    enable :cross_origin
end

namespace '/api' do
    before do
      content_type 'application/json'
    end

    helpers do 
        def base_url
          @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
        end
        def json_params
            JSON.parse(request.body.read, symbolize_names: true)
        rescue
            halt 400, {message:'Invalid JSON'}.to_json
        end
    end    
  end