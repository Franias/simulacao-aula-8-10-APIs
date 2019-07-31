class PessoaSerializer
    def initialize(pessoa)
        @pessoa = pessoa
    end

    def as_json(*)
        data = {
            id: @pessoa.id.to_s,
            name: @pessoa.name,
            age: @pessoa.age
        }
        data[:errors] = @pessoa.errors if @pessoa.errors.any?
        data
    end
end
