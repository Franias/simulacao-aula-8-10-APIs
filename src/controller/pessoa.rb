# frozen_string_literal: true
require_relative '../helpers'
namespace '/api' do
  helpers do
    def find_pessoa
      PessoaModel.where(id: params[:id]).first
    end
    def pessoa_not_found!
      halt(404, { message: 'Pessoa not found.' }.to_json) unless find_pessoa
    end

    def serializer_pessoa(pessoa)
      PessoaSerializer.new(pessoa).to_json
    end
  end

  post '/pessoa' do
    
    request= json_params

    found = PessoaModel.where(name: request[:name])
    halt(409,{message: 'Duplicated pessoa.'}.to_json ) if found.count > 0

    pessoa = PessoaModel.new(request)
    halt 400, serializer_pessoa(pessoa) unless pessoa.save
    res ={
      id: pessoa.id.to_s
    }
    halt 201, res.to_json
  end

  put 'pessoa/:id' do
    pessoa_not_found!
    halt 422, serializer_pessoa(find_pessoa) unless find_pessoa.update_attributes(json_params)
    serializer_pessoa(find_pessoa)
  end

  get 'pessoa/:id' do
    pessoa_not_found!
    serializer_pessoa(find_pessoa)
  end

  get '/pessoa' do
    pessoas = PessoaModel.all    
    pessoas.map {|p| PessoaSerializer.new(p).to_json}
  end

  delete '/pessoa/:id' do
    pessoa_not_found!
    find_pessoa.destroy if find_pessoa
    status 200
  end
end
