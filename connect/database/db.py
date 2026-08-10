import mysql.connector

# import mysql.connector

# db = mysql.connector.connect(
#     host="localhost",
#     user="root",
#     password="",
#     database="connect"
# )

# print("Connected to MySQL successfully!")

class Database:
    def __init__(self, host="localhost", user="root", password="", database="connect"):
        self.config = {
            "host": host,
            "user": user,
            "password": password,
            "database": database,
        }
        self.connection = None
        self.cursor = None

    def connect(self):
        self.connection = mysql.connector.connect(**self.config)
        self.cursor = self.connection.cursor(dictionary=True)
        return self

    def close(self):
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()

    # context manager so you can use: with Database() as db:
    def __enter__(self):
        self.connect()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_type:
            self.connection.rollback()
        self.close()
        
        
        


class Connectcreator:
    def __init__(self, db):
        self.db = db

    def add_delivery(self, delivery_id, contact_id, scheduled_for, quality_tonnes, pickup_location, status, delivered_at, created_at):
        sql = """
            INSERT INTO connect.deliveries (delivery_id, contact_id, scheduled_for, quality_tonnes, pickup_location, status, delivered_at, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """
        self.db.cursor.execute(sql, (delivery_id, contact_id, scheduled_for, quality_tonnes, pickup_location, status, delivered_at, created_at))
        self.db.connection.commit()
        print(f"Delivery {delivery_id} added")
        


