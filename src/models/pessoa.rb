# frozen_string_literal: true

require 'mongoid'

Mongoid.load! 'mongoid.yaml'

class PessoaModel
  include Mongoid::Document
  store_in collection: 'pessoas'
  field :name, type: String
  field :age, type: Numeric

  validates_presence_of :name, message: 'Name is required.'
  validates_presence_of :age, message: 'Age is no integer.'

  index({ name: 'text' }, name: 'name_index')
end
