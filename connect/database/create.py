from fidesagro import connect


#class EmployeeCreator:
    #def __init__(self, db: Database):
        #self.db = db

    #def add_employee(self, emp_no, birth_date, first_name, last_name, gender, hire_date):
        #sql = """
           # INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
           # VALUES (%s, %s, %s, %s, %s, %s)
        #"""
     #self.db.cursor.execute(sql, (emp_no, birth_date, first_name, last_name, gender, hire_date))
        #self.db.connection.commit()
        #print(f"Employee {first_name} {last_name} added (emp_no: {emp_no})")

    #def add_many(self, employees: list[tuple]):
        #sql = """
            #INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
           # VALUES (%s, %s, %s, %s, %s, %s)
       # """
       # self.db.cursor.executemany(sql, employees)
       # self.db.connection.commit()
       # print(f"{self.db.cursor.rowcount} employees added")


#if __name__ == "__main__":
    #with Database() as db:
        #creator = EmployeeCreator(db)

        # single insert
        #creator.add_employee(
         #   999001, "1990-05-15", "Ada", "Lovelace", "F", "2020-01-10"
        #)

        # bulk insert
        #creator.add_many([
            #(999002, "1985-03-22", "Alan", "Turing", "M", "2019-06-01"),
            #(999003, "1992-11-08", "Grace", "Hopper", "F", "2021-03-15"),
        #])

class connectInsertRecord:
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

    def add_connect_offer_messages(self, message_id, offer_id, sender_user_id, body, sent_at, read_at):
        sql = """
            INSERT INTO connect.offer_messages (message_id, offer_id, sender_user_id, body, sent_at, read_at)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        self.db.cursor.execute(sql, (message_id, offer_id, sender_user_id, body, sent_at, read_at))
        self.db.connection.commit()
        print(f"Offer message {message_id} added")


    def add_connect_delivery_confirmations(self, confirmation_id, delivery_id, confirming_side, confirmed_quantity_tonnes, confirmed_by_champion_id, quality_note, is_disputed, confirmed_at):
        sql = """
            INSERT INTO connect.delivery_confirmations (confirmation_id, delivery_id, confirming_side, confirmed_quantity_tonnes, confirmed_by_champion_id, quality_note, is_disputed, confirmed_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """
        self.db.cursor.execute(sql, (confirmation_id, delivery_id, confirming_side, confirmed_quantity_tonnes, confirmed_by_champion_id, quality_note, is_disputed, confirmed_at))
        self.db.connection.commit()
        print(f"Delivery confirmation {confirmation_id} added")

    def add_connect_produce_listings(self, listing_id, listing_reference, block_id, season_id, crop_id, crop_grade_id, estimated_quantity_tonnes, committed_quantity_tonnes, quantity_source, source_snapshot_id, harvest_window_start, harvest_window_ends, ask_price_min, ask_price_max, status, coop_confirmed_at, ops_reviewed_by, ops_reviewed_at, published_at, expires_at, created_at, updated_at ):
        sql = """
            INSERT INTO connect.produce_listings (listing_id, listing_reference, block_id, season_id, crop_id, crop_grade_id, estimated_quantity_tonnes, committed_quantity_tonnes, quantity_source, source_snapshot_id, harvest_window_start, harvest_window_ends, ask_price_min, ask_price_max, status, coop_confirmed_at, ops_reviewed_by, ops_reviewed_at, published_at, expires_at, created_at, updated_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        self.db.cursor.execute(sql, (listing_id, listing_reference, block_id, season_id, crop_id, crop_grade_id, estimated_quantity_tonnes, committed_quantity_tonnes, quantity_source, source_snapshot_id, harvest_window_start, harvest_window_ends, ask_price_min, ask_price_max, status, coop_confirmed_at, ops_reviewed_by, ops_reviewed_at, published_at, expires_at, created_at, updated_at))
        self.db.connection.commit()
        print(f"Produce listing {listing_id} added")

    def add_connect_offtaker_crop_interests(self, offtaker_id, crop_id, target_tonnes_per_season):
        sql = """
            INSERT INTO connect.offtaker_crop_interests (offtaker_id, crop_id, target_tonnes_per_season)
            VALUES (%s, %s, %s)
        """
        self.db.cursor.execute(sql, (offtaker_id, crop_id, target_tonnes_per_season))
        self.db.connection.commit()
        print(f"Offtaker crop interest {offtaker_id}-{crop_id} added")

    def add_connect_offtakers(self, offtaker_id, company_name, rc_number, businness_type, contact_person, contact_email, head_office_state_id, annual_volume_tonnes, verification_status, verified_at, verified_by, status, created_at, updated_at):
        sql = """
            INSERT INTO connect.offtakers (offtaker_id, company_name, rc_number, businness_type, contact_person, contact_email, head_office_state_id, annual_volume_tonnes, verification_status, verified_at, verified_by, status, created_at, updated_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        self.db.cursor.execute(sql, (offtaker_id, company_name, rc_number, businness_type, contact_person, contact_email, head_office_state_id, annual_volume_tonnes, verification_status, verified_at, verified_by, status, created_at, updated_at))
        self.db.connection.commit()
        print(f"Offtaker {offtaker_id} added")

        if __name__ == "__main__":
            with Database() as db:
                creator = connectInsertRecord(db)

                
                creator.add_delivery(
                    delivery_id=10032,
                    contact_id=987654,
                    scheduled_for="2026-11-01",
                    quality_tonnes=10.5,
                    pickup_location="kubuwa",
                    status="Scheduled",
                    delivered_at="Asokoro",
                    created_at="2026-08-10 "
                )

                creator.add_connect_offer_messages(
                    message_id=1234,
                    offer_id=456,
                    sender_user_id=789,
                    body="This is a test message.",
                    sent_at="2026-08-10 ",
                    read_at=None
                )

                creator.add_connect_delivery_confirmations(
                    confirmation_id=1,
                    delivery_id=10032,
                    confirming_side="Sender",
                    confirmed_quantity_tonnes=10.5,
                    confirmed_by_champion_id=101112,
                    quality_note="Good, fresh and high quality.",
                    is_disputed=False,
                    confirmed_at="2026-08-10 "
                )

                creator.add_connect_produce_listings(
                    listing_id=13579,
                    listing_reference="LIST001",
                    block_id=204,
                    season_id=1,
                    crop_id=102,
                    crop_grade_id=1,
                    estimated_quantity_tonnes=10.5,
                    committed_quantity_tonnes=10.5,
                    quantity_source="Manual",
                    source_snapshot_id=None,
                    harvest_window_start="2026-08-01",
                    harvest_window_ends="2026-08-31",
                    ask_price_min=100.0,
                    ask_price_max=200.0,
                    status="Active",
                    coop_confirmed_at="2026-08-10 ",
                    ops_reviewed_by=None,
                    ops_reviewed_at=None,
                    published_at="2026-08-10 ",
                    expires_at="2026-09-30 ",
                    created_at="2026-08-10 ",
                    updated_at="2026-08-10 "
                )

                creator.add_connect_offtaker_crop_interests(
                    offtaker_id=987654,
                    crop_id=102,
                    target_tonnes_per_season=10.5
                )

                creator.add_connect_offtakers(
                    offtaker_id=987654,
                    company_name="Fidesagro",
                    rc_number="RC123456",
                    businness_type="Agriculture",
                    contact_person="habbeb",
                    contact_email="habeeb@agrotech.com",
                    head_office_state_id=1470,
                    annual_volume_tonnes=100.0,
                    verification_status="Pending",
                    verified_at=None,
                    verified_by=None,
                    status="Active",
                    created_at="2026-08-10 ",
                    updated_at="2026-08-10 "
                )
