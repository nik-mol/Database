import psycopg2

# -- ----Функция, создающая структуру БД (таблицы)----------

def create_client_table(conn):
	with conn.cursor() as cur:
		cur.execute("""
		CREATE TABLE IF NOT EXISTS client(
			id SERIAL PRIMARY KEY,
			first_name VARCHAR(30) NOT NULL,
			last_name VARCHAR(30) NOT NULL,
			email VARCHAR(30) NOT NULL
		);
		""")

def create_phone_table(conn):
	with conn.cursor() as cur:
		cur.execute("""
		CREATE TABLE IF NOT EXISTS phone(
			id SERIAL PRIMARY KEY,
			number VARCHAR(20),
			client_id INTEGER NOT NULL REFERENCES client(id)
		);
		""")

# -----------Функция, позволяющая добавить нового клиента-------------------

def add_client(conn, first_name, last_name, email, phone=None):
	with conn.cursor() as cur:
		cur.execute("""
		INSERT INTO client (first_name, last_name, email) 
		VALUES(%s, %s, %s)
        RETURNING id, first_name	
		""", (first_name, last_name, email))
		print(cur.fetchone())

def add_phone(conn, client_id, number):
    with conn.cursor() as cur:
        cur.execute("""
        INSERT INTO phone (client_id, number)
        VALUES(%s, %s)
        RETURNING id, phone
        """, (client_id, number))
        print(cur.fetchone())

# ----------Функция, позволяющая изменить данные о клиенте-----------------

def change_first_name(conn, id, first_name):
    with conn.cursor() as cur:
        cur.execute("""
        UPDATE client SET first_name=%s
        WHERE id=%s
        RETURNING id;
        """, (first_name, id))
        cur.fetchone()

def change_last_name(conn, id, last_name):
    with conn.cursor() as cur:
        cur.execute("""
        UPDATE client SET last_name=%s
        WHERE id=%s
        RETURNING id;
        """, (last_name, id))
        cur.fetchone()

def change_email(conn, id, email):
    with conn.cursor() as cur:
        cur.execute("""
        UPDATE client SET email=%s
        WHERE id=%s
        RETURNING id;
        """, (email, id))
        cur.fetchone()

def change_phone(conn, client_id, new_number):
    with conn.cursor() as cur:
        cur.execute("""
        SELECT number FROM phone
        WHERE client_id = %s;        
        """, (client_id,))
        print(f"У клиента с id = {client_id} следующие номера: ", cur.fetchall())
        old_number = input('Введите номер, который необходимо заменить: ')

        cur.execute("""
        UPDATE phone 
        SET number=%s
        WHERE number=%s
        RETURNING client_id, number;
        """, (new_number, old_number))
        print(cur.fetchone())

def change_client(conn, id, first_name=None, last_name=None, email=None, new_number=None):
    if first_name:
        change_first_name(conn, id, first_name)
    if last_name:
        change_last_name(conn, id, last_name)
    if email:
        change_email(conn, id, email)
    if new_number:
        change_phone(conn, id, new_number)

# -------Функция, позволяющая удалить телефон для существующего клиента-----------

def delete_phone(conn, client_id):
    with conn.cursor() as cur:
        cur.execute("""
        SELECT number 
        FROM phone
        WHERE client_id = %s;
        """, (client_id,))
        print(f"В базе данных c id = {client_id} следующие телефоны: ", cur.fetchall())
        number_for_del = input('Введите номер телефона для удаления: ')

        cur.execute("""
        DELETE FROM phone 
        WHERE number = %s
        RETURNING id, number;        
        """, (number_for_del,))
        print(cur.fetchone())

# -------Функция, позволяющая удалить существующего клиента------------------

def delete_client(conn, id):
    with conn.cursor() as cur:
        cur.execute("""
        SELECT 
        DELETE FROM client 
        WHERE id = %s
        RETURNING id;
        """, (id,))
        cur.fetchone()

# ------Функция, позволяющая найти клиента по его данным (имени, фамилии, email-у или телефону)------

def find_client_by_first_name(conn, first_name):
    with conn.cursor() as cur:
        cur.execute("""
        SELECT * FROM client 
        WHERE first_name = %s
        """, (first_name,))
        print(f'Данные клиента {first_name}: ', cur.fetchall())

def find_client_by_last_name(conn, last_name):
    with conn.cursor() as cur:
        cur.execute("""
        SELECT * FROM client 
        WHERE last_name = %s
        """, (last_name,))
        print(f'Данные клиента {last_name}: ', cur.fetchall())

def find_client_by_email(conn, email):
    with conn.cursor() as cur:
        cur.execute("""
        SELECT * FROM client 
        WHERE email = %s
        """, (email,))
        print(f'Данные клиента {email}: ', cur.fetchall())

def find_client_by_phone(conn, number):
    with conn.cursor() as cur:
        cur.execute("""
        SELECT * FROM phone p
        JOIN client c ON c.id = p.client_id
        WHERE number = %s
        """, (number,))
        print(f'Данные клиента {number}: ', cur.fetchall())

def find_client(conn, first_name=None, last_name=None, email=None, number=None):
    if first_name:
        find_client_by_first_name(conn, first_name)
    if last_name:
        find_client_by_last_name(conn, last_name)
    if email:
        find_client_by_email(conn, email)
    if number:
        find_client_by_phone(conn, number)

with psycopg2.connect(database = "client", user = "postgres", password = "postgres") as conn:
    with conn.cursor() as cur:

        # cur.execute("""
        # DROP TABLE phone;
        # DROP TABLE client;
        # """)

        create_client_table(conn)
        create_phone_table(conn)
        conn.commit()

        add_client(conn,'Nikolay', 'Mold', 'nikolay@yandex.ru')
        add_client(conn,'Olesya', 'Mold', 'Olesya@yandex.ru')

        add_phone(conn, 4, '89043334455')
        add_phone(conn, 4, '89053330000')
        add_phone(conn, 2, '89063334455')

        change_client(conn, 1, first_name = 'fhdgjfdgf', number = '5564565465')
        change_phone(conn, 4, '89999999999')

        delete_phone(conn, 1)
        delete_phone(conn, 4)
        delete_client(conn, 1)

        find_client(conn, first_name='Nikolay')

    
conn.close()

