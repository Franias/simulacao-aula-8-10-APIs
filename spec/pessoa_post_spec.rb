describe 'POST /pessoa' do
    before(:context) do
        PessoaModel.destroy_all
    end

    describe 'status 200'do
        it('create a new pessoa') do
            request ={
                name: 'João',
                age: 58
            }
            post 'api/pessoa', request.to_json
            expect_status(201)
        end
    end
    describe 'status 409' do
        before(:context) do
            @request = { name: Faker::Pessoa.quote, age:2000}
            post '/api/pessoa', @request.to_json
        end
        it 'duplicate' do
           post '/api/pessoa', @request.to_json
           expect_status(409)
           expect(json_body[:message]).to eql 'Duplicated pessoa.'
        end
    end 
    
    describe 'status 400' do
        it 'name is required' do
            request = {
                name:'',
                age:58
            }
            post 'api/pessoa', request.to_json
            expect_status(400)
            expect(json_body[:errors][:name].first).to eql 'Name is required.'
        end
        it 'age is number' do
            request = {
                name: 'Paola',
                age: 'abr'
            }
            post '/api/pessoa', request.to_json
            expect_status(400)
            expect(
                json_body[:errors][:age].first).to eql 'Age is not integer.'
        end
    end
end