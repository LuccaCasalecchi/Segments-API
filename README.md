# 📰 Descrição do Projeto:

Sua missão é criar uma API rest json que permite a criação de gerenciamento de segmentos.
Segmentos são agrupadores persistidos em banco de dados, para segmentar usuários em um sistema por propriedades combinadas.
Para isso, você deve implementar uma API com os endpoints para gerenciar usuário e segmentos, assim como aplicar um segmento para filtrar os usuários.
Seguem os campos mínimos que cada tabela deve ter:

## User

- first_name :string
- last_name :string
- email :string
- birth_date :date
- admission_date :date
- is_active :boolean
- sex :string, options: [ 'male', 'female']
- last_sign_in_at :datetime
Usuários podem estar associados a várias tags (relação n:n)

## tag
- name :string

A(s) tabela(s) para o gerenciamento de segment deve(m) ser criada(s) por você.
Cada segmento não deve ter limites de combinações de propriedades de filtragem

***
## 💿 Como rodar o projeto localmente:
### Pré-requisitos:
1. Ruby 3.2.2,
2. Rails 7.1.2,
3. Docker e Docker Compose,

- Após clonar o repositório (`git clone [url do repositório]`) e acessá-lo, rode em seu terminal:
`bundle install`

- No seu diretório raiz, crie um arquivo `.env` neste modelo:

```
POSTGRES_DB=nome do seu bancpo
POSTGRES_USER=seu usuário
POSTGRES_PASSWORD=senha do seu postgres
```

- Inicie os serviços com docker-compose:
  `docker-compose up`

- Crie e migre seu banco de dados:
  `rails db:create db:migrate`

- Por fim ~ufa~ inicie o servidor:
  `rails server`

- Para inicializar os testes, você pode utilizar:
  `rspec`


***

## 🏗️ Estrutura do projeto

Este é o modelo de banco esquematizado para a API de Segmentação


![Untitled](https://github.com/LuccaCasalecchi/Segments-API/assets/72542388/da5337a9-1228-423f-a1a8-08ba718403d3)


O projeto segue uma estrutura semelhante ao de uma arquitetura MVC.

### Aqui está uma breve explicação sobre os Models criados:

1. **SegmentRule**:
   - Representa uma regra associada a um segmento.
   - Pertence a um `Segment`.
   - Não tem associações diretas com outros modelos além de `Segment`.

2. **Segment**:
   - Representa um segmento que pode conter várias regras (`SegmentRule`) e várias tags (`Tag`) por meio de `SegmentTagRule`.
   - Tem muitas `SegmentRule` e `SegmentTagRule`.
   - Tem muitas `Tags` através de `SegmentTagRule`.
   - Está associado a muitos `UserSegments`, que por sua vez, estão associados a `Users`.
   - Valida a presença de `name` e `description`.

3. **Tag**:
   - Representa uma etiqueta que pode ser associada a usuários e segmentos.
   - Tem muitos `UserTag` e `SegmentTagRule`.
   - Tem muitos `Users` e `Segments` através de `UserTag` e `SegmentTagRule`, respectivamente.
   - Valida a presença de `name`.

4. **UserTag**:
   - Representa a associação entre um usuário e uma tag.
   - Pertence a um `User` e a uma `Tag`.

5. **User**:
   - Representa um usuário que pode ter várias tags e estar associado a vários segmentos.
   - Tem muitos `UserTag` e `UserSegment`.
   - Tem muitas `Tags` e `Segments` através de `UserTag` e `UserSegment`, respectivamente.
   - Valida a presença de `first_name`, `last_name`, `email`, `birth_date` e `sex`, e a unicidade do `email`.


### Uma breve explicação dos controllers:
**UsersController**: 
- Gerencia as operações básicas relacionadas aos usuários. 
- Inclui listar todos os usuários, mostrar detalhes de um usuário específico, criar um novo usuário, atualizar um usuário existente e deletar um usuário.

**TagsController**: 
- Responsável pelo gerenciamento de tags. 
- Permite listar todas as tags, mostrar uma tag específica, criar uma nova tag, atualizar uma tag existente e deletar uma tag.

**SegmentsController**: 
- Lida com operações relacionadas a segmentos. 
- Inclui listar todos os segmentos, mostrar detalhes de um segmento específico, criar um novo segmento, atualizar um segmento existente e deletar um segmento.

**SegmentRulesController**: 
- Gerencia regras associadas a segmentos. 
- Permite criar uma nova regra para um segmento específico, listar todas as regras de um segmento e deletar uma regra de um segmento.

**SegmentUserController**: 
- Usado para listar todos os usuários associados a um segmento específico. 
- Aplica as regras de segmento para filtrar e exibir os usuários relevantes.

**UserSegmentsController**: 
- Lida com a associação entre usuários e segmentos. 
- Permite adicionar um segmento a um usuário, remover um segmento de um usuário e listar todos os segmentos associados a um usuário específico.

**UserTagsController**: 
- Gerencia a atribuição de tags aos usuários. 
- Permite atribuir uma tag a um usuário, remover uma tag de um usuário e listar todas as tags associadas a um usuário específico.

***

 ### 🕹️ Comandos para interagir com a API :

## UsersController
- Gerencia as operações básicas relacionadas aos usuários.
- Ações:
  - Listar todos os usuários: `curl -X GET http://localhost:3000/users`
  - Mostrar detalhes de um usuário específico: `curl -X GET http://localhost:3000/users/1`
  - Criar um novo usuário: `curl -X POST http://localhost:3000/users -H "Content-Type: application/json" -d '{"user": {...}}'`
  - Atualizar um usuário existente: `curl -X PUT http://localhost:3000/users/1 -H "Content-Type: application/json" -d '{"user": {...}}'`
  - Deletar um usuário: `curl -X DELETE http://localhost:3000/users/1`

## TagsController
- Responsável pelo gerenciamento de tags.
- Ações:
  - Listar todas as tags: `curl -X GET http://localhost:3000/tags`
  - Mostrar uma tag específica: `curl -X GET http://localhost:3000/tags/1`
  - Criar uma nova tag: `curl -X POST http://localhost:3000/tags -H "Content-Type: application/json" -d '{"tag": {...}}'`
  - Atualizar uma tag existente: `curl -X PUT http://localhost:3000/tags/1 -H "Content-Type: application/json" -d '{"tag": {...}}'`
  - Deletar uma tag: `curl -X DELETE http://localhost:3000/tags/1`

## SegmentsController
- Lida com operações relacionadas a segmentos.
- Ações:
  - Listar todos os segmentos: `curl -X GET http://localhost:3000/segments`
  - Mostrar detalhes de um segmento específico: `curl -X GET http://localhost:3000/segments/1`
  - Criar um novo segmento: `curl -X POST http://localhost:3000/segments -H "Content-Type: application/json" -d '{"segment": {...}}'`
  - Atualizar um segmento existente: `curl -X PUT http://localhost:3000/segments/1 -H "Content-Type: application/json" -d '{"segment": {...}}'`
  - Deletar um segmento: `curl -X DELETE http://localhost:3000/segments/1`

## SegmentRulesController
- Gerencia regras associadas a segmentos.
- Ações:
  - Criar uma nova regra para um segmento específico: `curl -X POST http://localhost:3000/segments/3/rules -H "Content-Type: application/json" -d '{"rule": {...}}'`
  - Listar todas as regras de um segmento: `curl -X GET http://localhost:3000/segments/3/rules`
  - Deletar uma regra de um segmento: `curl -X DELETE http://localhost:3000/segments/3/rules/9`

## SegmentUserController
- Usado para listar todos os usuários associados a um segmento específico.
- Ações:
  - Listar usuários de um segmento: `curl -X GET http://localhost:3000/segments/3/users`

## UserSegmentsController
- Lida com a associação entre usuários e segmentos.
- Ações:
  - Adicionar um segmento a um usuário: `curl -X POST http://localhost:3000/users/1/segments -H "Content-Type: application/json" -d '{"segment_id": 2}'`
  - Remover um segmento de um usuário: `curl -X DELETE http://localhost:3000/users/1/segments/2`
  - Listar todos os segmentos associados a um usuário: `curl -X GET http://localhost:3000/users/1/segments`

## UserTagsController
- Gerencia a atribuição de tags aos usuários.
- Ações:
  - Atribuir uma tag a um usuário: `curl -X POST http://localhost:3000/users/1/tags/3`
  - Remover uma tag de um usuário: `curl -X DELETE http://localhost:3000/users/1/tags/3`
  - Listar todas as tags associadas a um usuário: `curl -X GET http://localhost:3000/users/1/tags`



