from db import Database

class insertRecord:
    def __init__(self, db: Database):
        self.db = db

    def add_employee(self, emp_no, birth_date, first_name, last_name, gender, hire_date):
        sql = """
            INSERT INTO employees 
            (emp_no, birth_date, first_name, last_name, gender, hire_date)
            values (%s, %s, %s, %s, %s, %s)
            """
        newEmployee = (emp_no, birth_date, first_name, last_name, gender, hire_date)
        
        self.db.cursor.execute(sql, newEmployee)
        self.db.connection.commit()
        
        print(f"{self.db.cursor.rowcount}, employees added")
        
    def add_department(self, dept_no, dept_name):
        sql = """
            INSERT INTO departments
            (dept_no, dept_name)
            values (%s, %s)
            """
        newDepartment = (dept_no, dept_name)
        
        self.db.cursor.execute(sql, newDepartment)
        self.db.connection.commit()    
        
        print(f"{self.db.cursor.rowcount}, departments added")

    def add_dept_emp(self, emp_no, dept_no, from_date, to_date):
                sql = """
                    INSERT INTO dept_emp
                    (emp_no, dept_no, from_date, to_date)
                    values (%s, %s, %s, %s)
                """
                newdept_emp = (emp_no, dept_no, from_date, to_date)
                
                self.db.cursor.execute(sql, newdept_emp)
                self.db.connection.commit()
                
                print(f"{self.db.cursor.rowcount}, dept_emp added")
                
    def add_salaries(self, emp_no, salary, from_date, to_date):
                sql = """
                    INSERT INTO salaries
                    (emp_no, salary, from_date, to_date)
                    values (%s, %s, %s, %s)
                    """
                newsalaries = (emp_no, salary, from_date, to_date)
                    
                self.db.cursor.execute(sql, newsalaries)
                self.db.connection.commit()
                    
                print(f"{self.db.cursor.rowcount}, salaries added")
                
    def add_titles(self, emp_no, title, from_date, to_date):
                sql = """
                    INSERT INTO titles
                    (emp_no, title, from_date, to_date)
                    values (%s, %s, %s, %s)
                    """
                newtitles = (emp_no, title, from_date, to_date)
                    
                self.db.cursor.execute(sql, newtitles)
                self.db.connection.commit()
                    
                print(f"{self.db.cursor.rowcount}, titles added")
                
    def add_dept_manager(self, emp_no, dept_no, from_date, to_date):
                sql = """
                        INSERT INTO dept_manager
                        (emp_no, dept_no, from_date, to_date)
                        values (%s, %s, %s, %s)
                        """
                newdept_manager = (emp_no, dept_no, from_date, to_date)
                        
                self.db.cursor.execute(sql, newdept_manager)
                self.db.connection.commit()
                        
                print(f"{self.db.cursor.rowcount}, dept_manager added")
    
    # def add_employee_and_information(self, emp_no, birth_date, first_name, last_name, gender, hire_date, dept_no, from_date_dept_emp, to_date_dept_emp, salary, from_date_salary, to_date_salary, title, from_date_title, to_date_title):
    #     self.add_employee(emp_no, birth_date, first_name, last_name, gender, hire_date)
    #     self.add_dept_emp(emp_no, dept_no, from_date_dept_emp, to_date_dept_emp)
    #     self.add_salaries(emp_no, salary, from_date_salary, to_date_salary)
    #     self.add_titles(emp_no, title, from_date_title, to_date_title)
    #     sql = """
    #         INSERT INTO employee(emp_no, birth_date, first_name, last_name, gender, hire_date)
    #         INSERT INTO dept_emp(emp_no, dept_no, from_date, to_date)
    #         INSERT INTO salaries(emp_no, salary, from_date, to_date)
    #         INSERT INTO titles(emp_no, title, from_date, to_date)
    #         VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    #     """
        
    #     newEmployeeData = (emp_no, birth_date, first_name, last_name, gender, hire_date)
    #     self.db.cursor.execute(sql, newEmployeeData)
    #     self.db.connection.commit()
        
    #     print(f"{self.db.cursor.rowcount}, employee and related information added")        
     
    def add_employee_and_information(
        self,
        emp_no,
        birth_date,
        first_name,
        last_name,
        gender,
        hire_date,
        dept_no,
        dept_from_date,
        dept_to_date,
        salary,
        salary_from_date,
        salary_to_date,
        title,
        title_from_date,
        title_to_date,
    ):

        employee_sql = """
        INSERT INTO employees
        (emp_no, birth_date, first_name, last_name, gender, hire_date)
        VALUES (%s,%s,%s,%s,%s,%s)
        """

        dept_sql = """
        INSERT INTO dept_emp
        (emp_no, dept_no, from_date, to_date)
        VALUES (%s,%s,%s,%s)
        """

        salary_sql = """
        INSERT INTO salaries
        (emp_no, salary, from_date, to_date)
        VALUES (%s,%s,%s,%s)
        """

        title_sql = """
        INSERT INTO titles
        (emp_no, title, from_date, to_date)
        VALUES (%s,%s,%s,%s)
        """

        try:

            self.db.connection.start_transaction()

            # ---------------- Employees ---------------- #

            employee_data = (
                emp_no,
                birth_date,
                first_name,
                last_name,
                gender,
                hire_date,
            )

            self.db.cursor.execute(employee_sql, employee_data)

            if self.db.cursor.rowcount != 1:
                raise Exception("Employee insertion failed.")

            # ---------------- Department ---------------- #

            dept_data = (
                emp_no,
                dept_no,
                dept_from_date,
                dept_to_date,
            )

            self.db.cursor.execute(dept_sql, dept_data)

            if self.db.cursor.rowcount != 1:
                raise Exception("Department insertion failed.")

            # ---------------- Salary ---------------- #

            salary_data = (
                emp_no,
                salary,
                salary_from_date,
                salary_to_date,
            )

            self.db.cursor.execute(salary_sql, salary_data)

            if self.db.cursor.rowcount != 1:
                raise Exception("Salary insertion failed.")

            # ---------------- Title ---------------- #

            title_data = (
                emp_no,
                title,
                title_from_date,
                title_to_date,
            )

            self.db.cursor.execute(title_sql, title_data)

            if self.db.cursor.rowcount != 1:
                raise Exception("Title insertion failed.")

            self.db.connection.commit()

            return {
                "success": True,
                "message": "Employee and related information inserted successfully."
            }

        except mysql.connector.Error as err:

            self.db.connection.rollback()

            return {
                "success": False,
                "message": str(err)
            }

        except Exception as err:

            self.db.connection.rollback()

            return {
                "success": False,
                "message": str(err)
            }               
                    

if __name__ == "__main__":
        with Database() as db:
            addRecord = insertRecord(db)
            
            # addRecord.add_employee_and_information(999008, "1999-06-23", "Alen", "Wang", "M", "2022-01-10", "d012", "2022-01-10", "2024-08-11", "1000000", "2024-08-11", "2026-08-11", "Chief Data Scientist", "2024-08-11", "2026-08-11")
        
            # addRecord.add_employee(
            #     999009,
            #     "1999-06-23",
            #     "Alen",
            #     "Wang",
            #     "M",
            #     "2022-01-10"
            # )

            # addRecord.add_department(
            #     "d013",
            #     "Optics and Surgery"
            # )
            
            # addRecord.add_dept_emp(
            #    987652,
                # "d013",
                # "2022-05-17",
                # "2024-08-11"
            #  )
                                
            # addRecord.add_salaries(
            #     999007,
            #     80000,
            #     "2022-12-27",
            #     "2024-08-21"
            #  )
            
            # addRecord.add_titles(
            #     999003,
            #     "Chief Engineer",
            #     "2022-05-18",
            #     "2024-03-11"
            # )
            
            # addRecord.add_dept_manager(
                # 987652,
                # "d014",
                # "2021-08-14",
                # "2025-05-10"
            # )
            
            result = addRecord.add_employee_and_information(
            999102,
            "1999-06-23",
            "Velentine",
            "Wang",
            "M",
            "2022-01-10",
            "d009",        # Make sure this department exists
            "2022-01-10",
            "2024-08-11",
            1000000,
            "2024-08-11",
            "2026-08-11",
            "Chief Data Scientist",
            "2024-08-11",
            "2026-08-11"
        )

        print(result)