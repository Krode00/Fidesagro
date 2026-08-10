from db import Database


class EmployeeCreator:
    def __init__(self, db: Database):
        self.db = db

    def add_employee(self, emp_no, birth_date, first_name, last_name, gender, hire_date):
        sql = """
            INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        self.db.cursor.execute(sql, (emp_no, birth_date, first_name, last_name, gender, hire_date))
        self.db.connection.commit()
        print(f"Employee {first_name} {last_name} added (emp_no: {emp_no})")

    def add_many(self, employees: list[tuple]):
        sql = """
            INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        self.db.cursor.executemany(sql, employees)
        self.db.connection.commit()
        print(f"{self.db.cursor.rowcount} employees added")


if __name__ == "__main__":
    with Database() as db:
        creator = EmployeeCreator(db)

        # single insert
        creator.add_employee(
            999001, "1990-05-15", "Ada", "Lovelace", "F", "2020-01-10"
        )

        # bulk insert
        creator.add_many([
            (999002, "1985-03-22", "Alan", "Turing", "M", "2019-06-01"),
            (999003, "1992-11-08", "Grace", "Hopper", "F", "2021-03-15"),
        ])