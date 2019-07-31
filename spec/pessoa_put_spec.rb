describe 'PUT /api/pessoa/:id' do
    describe 'status 200' do
        before(:context) do
            @req1 = { name:'Batman', age:50 }
            @req2 = { name:'Batman', age:52 }
            post '/api/pessoa', @req1.to_json
            @id_pessoa_valido= json_body[:id]
        end

        it 'update a pessoa' do
            put 'api/pessoa' + @id_pessoa_valido, @req2.to_json
            expect_status(200)
        end

        after do
            get 'api/pessoa' + @id_pessoa_valido
            expect_json(name: @req2[:name], age: @req2[:age])
        end
    end
    describe 'status 404' do
        it('pessoa not found') do
            put 'api/pessoa' + Faker::Number.hexadecimal(25),
            { name: 'xpto', age: 95 }.to_json
            expect_status(404)
            expect(json_body).to eql(message: 'Pessoa not found.')
        end
    end

end