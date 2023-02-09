import os
from scripts.functions import Session, add_to_db, get_publisher, get_shops



data_db = os.path.abspath('fixtures/test_data.json')

if __name__ == '__main__':    
    add_to_db(data_db)
    get_publisher(int(input('Введите ID издателя: ')))
    get_shops(int(input('Введите ID издателя: ')))
 