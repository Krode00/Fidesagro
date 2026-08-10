from db import Database

class InsertRecord:
    def __init__(self, db: Database):
        self.db = db

    def add_employee(self, emp_no, birth_date, first_name, last_name, gender, hire_date):
        sql = """
            INSERT INTO employees
            (emp_no, birth_date, first_name, last_name, gender, hire_date)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        newEmployee = (emp_no, birth_date, first_name, last_name, gender, hire_date)

        self.db.cursor.execute(sql, newEmployee)
        self.db.connection.commit()

        print(f"{self.db.cursor.rowcount} employee(s) added.")

    def add_department(self, dept_no, dept_name):
        sql = """
            INSERT INTO departments
            (dept_no, dept_name)
            VALUES (%s, %s)
        """
        newDept = (dept_no, dept_name)

        self.db.cursor.execute(sql, newDept)
        self.db.connection.commit()

        print(f"{self.db.cursor.rowcount} department(s) added.")
        
        def add_dept_emp(self, emp_no, dept_no, from_date, to_date):
            sql = """
                INSERT INTO dept_emp
                (emp_no, dept_no, from_date, to_date)
                VALUES (%s, %s, %s, %s)
            """
            newDeptEmp = (emp_no, dept_no, from_date, to_date)

            self.db.cursor.execute(sql, newDeptEmp)
            self.db.connection.commit()

            print(f"{self.db.cursor.rowcount} department employee(s) added.")


if __name__ == "__main__":
    with Database() as db:
        add_record = InsertRecord(db)

        add_record.add_employee(
            999008,
            "1999-06-23",
            "Alen",
            "Wang",
            "M",
            "2022-01-10"
        )

        add_record.add_department(
            "d012",
            "Optics"
        )
        
        add_record.add_dept_emp(
            999010,
            "d013",
            "2022-05-17",
            "2024-08-11"
        )