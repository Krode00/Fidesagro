from db import Database


class EmployeeReader:
    def __init__(self, db: Database):
        self.db = db

    def get_by_id(self, emp_no):
        self.db.cursor.execute("SELECT * FROM employees WHERE emp_no = %s", (emp_no,))
        return self.db.cursor.fetchone()

    def get_all(self, limit=10):
        self.db.cursor.execute("SELECT * FROM employees LIMIT %s", (limit,))
        return self.db.cursor.fetchall()

    def search_by_name(self, name):
        pattern = f"%{name}%"
        self.db.cursor.execute(
            "SELECT * FROM employees WHERE first_name LIKE %s OR last_name LIKE %s",
            (pattern, pattern),
        )
        return self.db.cursor.fetchall()

    def get_by_department(self, dept_name, limit=10):
        sql = """
            SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
            FROM employees e
            JOIN dept_emp de ON e.emp_no = de.emp_no
            JOIN departments d ON de.dept_no = d.dept_no
            WHERE d.dept_name = %s
            LIMIT %s
        """
        self.db.cursor.execute(sql, (dept_name, limit))
        return self.db.cursor.fetchall()

    def count(self):
        self.db.cursor.execute("SELECT COUNT(*) AS total FROM employees")
        return self.db.cursor.fetchone()["total"]


if __name__ == "__main__":
    with Database() as db:
        reader = EmployeeReader(db)

        print("=== Total employees ===")
        print(reader.count())

        print("\n=== First 5 employees ===")
        for emp in reader.get_all(limit=5):
            print(emp)

        print("\n=== Search 'Ada' ===")
        for emp in reader.search_by_name("Ada"):
            print(emp)

        print("\n=== Sales department ===")
        for emp in reader.get_by_department("Sales", limit=5):
            print(emp)