# frozen_string_literal: true

require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/reloader' if development?

require_relative 'controller/pessoa'

get '/' do
  @env = ENV['RACK_ENV'].to_s.upcase
  "Bem vinda a minha primeira API | ENVIRONMENT."
end
