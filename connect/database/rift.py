
name = input("Enter your name ")
age = input("how old are you? ")
city = input("what city do you live in? ")
occupation = input("what is your occupation? ")
gender = input("what is your gender? ")
hobbies = input("what are your hobbies? ")
degree = input("what is your degree? ")
field_of_study = input("what is your field of study? ")
salary = input("what is your salary? ")
marital_status = input("what is your marital status? ")
religion = input("what is your religion? ")

 print("my name is " + name + ", I am " + age + " years old, I live in " + city + ", I work as a " + occupation + ", I am " + gender + ", My hobbies include " + hobbies + ", I have a degree in " + degree + ", My field of study is " + field_of_study + ", I earn a salary of " + salary + ", I am " + marital_status + ", My religion is " + religion)


annual_income = int(salary) * 12
print (annual_income)

age_difference = max(age) - min(age)
print (27 - 24)

average_age = (27 + 24) / 2
print (average_age)



couple1 = {
    "name": "oscar david",
    "age": 27,
    "city": "kubuwa",
    "occupation": "civil servant",
    "gender": "Male",
    "religion": "Christian",
    "salary": 300000,
    "institution": "university of abuja",
    "marital_status": "married",
}

print("Couple 1: ", couple1)


couple2 = {
    "name": "helen david",
    "age": 24,
    "city": "kubuwa",
    "occupation": "customer and admin rep",
    "gender": "Female",
    "religion": "christian",
    "salary": 150000,
    "institution": "nnamdi azikiwe university",
    "marital_status": "married"

}
print("Couple 2: ", couple2)

print ("Couple 1's annual income: ", couple1["salary"] * 12)
print ("Couple 2's institution: ", couple2["institution"] )
print ("Couple 1's marital status: ", couple1["marital_status"])


oscar_salary = couple1["salary"]
if oscar_salary > 275000:
    print("Oscar is a higher earner")

    if couple1["religion"] == couple2["religion"]:
        print("They share the same religion")


couple = [
    {
        "name": "oscar david",
        "occupation": "civil servant",
        "salary": 300000,
        "institution": "university of abuja",
    },
    {
        "name": "helen david",
        "occupation": "customer and admin rep",
        "salary": 150000,
        "institution": "nnamdi azikiwe university",
    }
]
for person in couple:
    print("name:", person["name"])
    print("occupation:", person["occupation"])
    print("salary:", person["salary"])
    print("institution:", person["institution"])