from db import Database
from create import EmployeeCreator
from read import EmployeeReader
from update import EmployeeUpdater
from delete import EmployeeDeleter


def main():
    with Database() as db:
        creator = EmployeeCreator(db)
        reader = EmployeeReader(db)
        updater = EmployeeUpdater(db)
        deleter = EmployeeDeleter(db)

        # CREATE
        # print("=== CREATE ===")
        # creator.add_employee(987652, "1990-05-15", "Ada", "Lovelace", "F", "2020-01-10")

        # # READ
        # print("\n=== READ ===")
        # emp = reader.get_by_id(987652)
        # print(emp)

        # UPDATE
        print("\n=== UPDATE ===")
        updater.update_name(987652, first_name="Nigeria")

        # verify the update
        emp = reader.get_by_id(987652)
        print(emp)

        # # DELETE
        # print("\n=== DELETE ===")
        # deleter.delete_by_id(987651)

        # # verify deletion
        # emp = reader.get_by_id(987651)
        # print(emp)  # None

        # # show total count from original data
        # print(f"\nTotal employees in database: {reader.count()}")


if __name__ == "__main__":
    main()