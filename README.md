# Descrição do Projeto:

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

Até então, esse é o modelo esquematizado que realizei:


![Untitled](https://github.com/LuccaCasalecchi/Segments-API/assets/72542388/da5337a9-1228-423f-a1a8-08ba718403d3)
