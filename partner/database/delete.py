from db import Database


class EmployeeDeleter:
    def __init__(self, db: Database):
        self.db = db

    def delete_by_id(self, emp_no):
        self.db.cursor.execute("DELETE FROM employees WHERE emp_no = %s", (emp_no,))
        self.db.connection.commit()
        print(f"Deleted {self.db.cursor.rowcount} row(s)")
        return self.db.cursor.rowcount

    def delete_many(self, emp_nos: list[int]):
        placeholders = ", ".join(["%s"] * len(emp_nos))
        sql = f"DELETE FROM employees WHERE emp_no IN ({placeholders})"
        self.db.cursor.execute(sql, tuple(emp_nos))
        self.db.connection.commit()
        print(f"Deleted {self.db.cursor.rowcount} row(s)")
        return self.db.cursor.rowcount


if __name__ == "__main__":
    with Database() as db:
        deleter = EmployeeDeleter(db)

        deleter.delete_by_id(999001)
        deleter.delete_many([999002, 999003])