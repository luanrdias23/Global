from faker import Faker

fake = Faker('pt_BR')

# Lista para armazenar instruções SQL INSERT
sql_statements_usuarios = []

# Gerar instruções SQL INSERT para 100 usuários
for id_usuario in range(1, 101):
    nm_usuario = fake.name()
    nr_cpf = fake.random_number(digits=11)
    nm_rg = fake.random_number(digits=9)
    dt_nascimento = fake.date_of_birth(minimum_age=18, maximum_age=80)
    fl_genero = fake.random_element(elements=('M', 'F'))
    dt_cadastro = fake.date_this_decade()
    nm_email = fake.email()
    nm_senha = fake.password()

    # Cria a instrução SQL para o usuário
    sql_statement_usuario = f'''
    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES ({id_usuario}, '{nm_usuario}', {nr_cpf}, '{nm_rg}', TO_DATE('{dt_nascimento}', 'YYYY-MM-DD'), '{fl_genero}',
            TO_DATE('{dt_cadastro}', 'YYYY-MM-DD'), '{nm_email}', '{nm_senha}');
    '''
    sql_statements_usuarios.append(sql_statement_usuario)

# Imprimir as instruções SQL para usuários
for statement in sql_statements_usuarios:
    print(statement)
''