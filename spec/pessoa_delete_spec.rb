describe 'DELETE /pessoa/:id' do
    describe 'status 200'do
        before(:context) do
            @req = { name: Faker::Pessoa.quote, age: 30}
            post '/api/pessoa', @req.to_json
            @id_pessoa_valido = json_body[:id]
        end
        it('delete a pessoa') do
            delete '/api/pessoa' + @id_pessoa_valido
            expect_status(200)            
            found =PessoaModel.where(name: @req[:name])
            expect(found.count).to eql 0
        end

    end

    describe 'status 404' do
        it('pessoa not found') do
            delete '/api/pessoa' + Faker::Number.hexadecimal(25)
            expect_status(404)
            expect(json_body).to eql(message: 'Pessoa not found.')
        end
    end


end