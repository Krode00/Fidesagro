from db import Database


class EmployeeReader:
    def __init__(self, db: Database):
        self.db = db

    def get_by_firstname(self, first_name):
        self.db.cursor.execute("SELECT * FROM employees WHERE first_name = %s", (first_name,))
        return self.db.cursor.fetchone()


if __name__ == "__main__":
    with Database() as db:
        reader = EmployeeReader(db)
        
        print ("=== Employee with Serial No (first_name)")
        for number in reader.get_by_firstname("Nigeria"):
            print(number)

        # print("=== Total employees ===")
        # print(reader.count())

        # print("\n=== First 5 employees ===")
        # for emp in reader.get_all(limit=5):
        #     print(emp)

        # print("\n=== Search 'Ada' ===")
        # for emp in reader.search_by_name("Ada"):
        #     print(emp)

        # print("\n=== Sales department ===")
        # for emp in reader.get_by_department("Sales", limit=5):
        #     print(emp)



