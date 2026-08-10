from FIDESAGRO import connect





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
        







