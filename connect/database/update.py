from db import Database


class EmployeeUpdater:
    def __init__(self, db: Database):
        self.db = db

    def update_name(self, emp_no, first_name=None, last_name=None):
        fields = []
        values = []

        if first_name:
            fields.append("first_name = %s")
            values.append(first_name)
        if last_name:
            fields.append("last_name = %s")
            values.append(last_name)

        if not fields:
            print("Nothing to update")
            return 0

        values.append(emp_no)
        sql = f"UPDATE employees SET {', '.join(fields)} WHERE emp_no = %s"
        self.db.cursor.execute(sql, tuple(values))
        self.db.connection.commit()
        print(f"Updated {self.db.cursor.rowcount} row(s)")
        return self.db.cursor.rowcount

    def update_hire_date(self, emp_no, hire_date):
        sql = "UPDATE employees SET hire_date = %s WHERE emp_no = %s"
        self.db.cursor.execute(sql, (hire_date, emp_no))
        self.db.connection.commit()
        print(f"Updated {self.db.cursor.rowcount} row(s)")
        return self.db.cursor.rowcount


if __name__ == "__main__":
    with Database() as db:
        updater = EmployeeUpdater(db)

        updater.update_name(999001, first_name="Augusta Ada")
        updater.update_hire_date(999001, "2020-06-01")