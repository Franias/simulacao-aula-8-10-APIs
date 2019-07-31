# frozen_string_literal: true



# testes unitarios

describe 'GET /pessoa/:id' do

  describe 'status 200' do

    before(:context) do

      @req = {

        name: 'Jonatha', age: 20

      }

      post 'api/pessoa', @req.to_json

      @id_pessoa_valido = json_body[:id]

    end

    it('return a unique pessoa') do

      get '/api/pessoa' + @id_pessoa_valido

      expect_status(200)

      expect_json_types('*',name: :string, age: :integer)

      expect_json(name: @req[:name], age: @req[:age])

    end

  end



  describe 'status 400' do

    it('pessoa not found') do

      get '/api/pessoa/' + Faker::Number.hexadecimal(25)

      expect_status(404)

      expect(json_body).to eql(message: 'Pessoa not found.')

    end

  end

end



describe 'GET /pessoa' do

  describe 'status 200' do

    before(:context) do

      5.times do

        req = {

          name: Faker::Pessoa,

          age: Faker::Number.between(10,50) }

        post '/api/pessoa', req.to_json

      end

    end

    it 'return a list of pessoas' do

      PessoaModel.destroy_all

      get '/api/pessoa'

      expect_status(200)

      puts json_body

    end

  end

end

