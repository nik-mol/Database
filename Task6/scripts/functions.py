import configparser
import json
import sqlalchemy
from sqlalchemy.orm import sessionmaker

from .models_db import create_tables, Publisher, Shop, Book, Stock, Sale

def connect_to_db():
    config = configparser.ConfigParser()
    config.read('settings.ini')
    user = config['DB']['user']
    password = config['DB']['password']
    DSN = f'postgresql://{user}:{password}@localhost:5432/homework_orm_db'
    engine = sqlalchemy.create_engine(DSN)
    create_tables(engine)
    return engine

engine = connect_to_db()
Session = sessionmaker(bind=engine)

def add_to_db(data_db):
    session = Session()
    with open(data_db, 'r') as fd:
        data = json.load(fd)
    for record in data:
        model = {
            'publisher': Publisher,
            'shop': Shop,
            'book': Book,
            'stock': Stock,
            'sale': Sale,
        }[record.get('model')]        
        session.add(model(id=record.get('pk'), **record.get('fields')))
    session.commit() 
    session.close()

def get_publisher(input_id):
    session = Session()
    publishers = session.query(Publisher).filter(Publisher.id==input_id)
    for publisher in publishers.all(): 
        print(f'Выбранный издатель: {publisher}')
    session.close()

def get_shops(input_id):
    session = Session()   
    shops = session.query(Shop).join(Stock).join(Book).join(Publisher).filter(Publisher.id == input_id,
                                                                              Stock.count != 0
    )
    for shop in shops.all():       
        print(shop.name)    
    session.close()









