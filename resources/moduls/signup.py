from hashlib import sha256
import re


def existUser(dbConnection, first_name, last_name, username, email):
    """This function accepts the information entered by the user and checks whether the information already exists in
    the system, then returns an error message.

    :param dbConnection: Connection to the app's database
    :param first_name: The first name that the user entered while signing up to app
    :param last_name: The last name that the user entered while signing up to app
    :param username: The username that the user entered while signing up to app
    :param email: The email that the user entered while signing up to app
    :return: If the user already exists - return True, else return False
    """
    if len(first_name) < 1:
        return True
    try:
        # Check if the details are in the database
        if dbConnection.users.count_documents({"first_name": first_name, "last_name": last_name, "username": username,
                                               "email": email}) == 0 and dbConnection.users.count_documents(
            {"email": email}) == 0:
            return False
        else:
            # username exists in the system
            return True
    except():
        raise TypeError("error with db")

#def saveUser(dbConnection, first_name, last_name, username, email, password):

def saveUser(dbConnection, username, email, password):
    """ This item receives information from the user and saves it as a new user.

    :param dbConnection: Connection to the app's database
    :param first_name: The first name that the user entered while signing up to app
    :param last_name: The last name that the user entered while signing up to app
    :param username: The username that the user entered while signing up to app
    :param email: The email that the user entered while signing up to app
    :param password: The password that the user entered while signing up to app
    :return: void
    """
    try:
        # Check out how many recipes there are
        recipes_count = dbConnection.recipes.count_documents({})
    except():
        raise TypeError("error with db")
    # Create an array the size of the amount of recipes for recipes_time, recipes_clicks and do_recipe
    arr = [None] * recipes_count
    for i in range(recipes_count):
        arr[i] = 0
    print(arr)
    userDetails = { "username": username, "email": email,
                   "password": hashGenerate(password), "recipes_time": arr,
                   "recipes_clicks": arr, "do_recipe": arr}
    # userDetails = {"first_name": first_name, "last_name": last_name, "username": username, "email": email,
    #                "password": hashGenerate(password), "recipes_time": arr,
    #                "recipes_clicks": arr, "do_recipe": arr}
    try:
        # Save in db
        dbConnection.users.insert_one(userDetails)
    except():
        raise TypeError("error with db")


def hashGenerate(password):
    """ This function receives input and activates a hash function on it

    :param password: The password that the user entered while signing up to app
    :return: hash of the input
    """
    h = sha256()
    h.update(password.encode())
    hash_password = h.hexdigest()
    return hash_password


def checkEmail(email):
    """ This item receives an email and checks if it is in the correct format

    :param email: The email that the user entered while signing up to app
    :return: If the email format is correct - True, else return False
    """
    # Make a regular expression for validating an Email
    regex = '^(\w|\.|\_|\-)+[@](\w|\_|\-|\.)+[.]\w{2,3}$'
    # Pass the regular expression and the string in search() method
    if (re.search(regex, email)):
        print("Valid Email")
        return True
    else:
        print("Invalid Email")
        return False


def checkPassword(password):
    """ This function receives a password and checks the correctness of the format

    :param password: The password that the user entered while signing up to app
    :return: If the format is correct - True, else return False
    """
    val = True
    if len(password) < 6:
        print('length of password should be at least 6')
        val = False
    if len(password) > 20:
        print('length of password should be not be greater than 20')
        val = False
    if not any(char.isdigit() for char in password):
        print('Password should have at least one numeral')
        val = False
    if not any(char.islower() for char in password):
        print('Password should have at least one lowercase letter')
        val = False
    return val


def checkName(name):
    """ This function receives a string and checks the correctness of the format

    :param name: The first name, last name and username that the user entered while signing up to app
    :return: If the format is correct - True, else return False
    """
    val = True
    if len(name) < 2:
        print('length should be at least 2')
        val = False
    if len(name) > 10:
        print('length should be not be greater than 10')
        val = False
    if not any(char.islower() for char in name):
        print('Username should have at least one lowercase letter')
        val = False
    return val


def error_message(email, password, username, first_name, last_name):
    """ This function returns the error message for the inputs entered by the user

    :param email: The email that the user entered while signing up to app
    :param password: The password that the user entered while signing up to app
    :param username: The username that the user entered while signing up to app
    :param first_name: The first name that the user entered while signing up to app
    :param last_name: The last name that the user entered while signing up to app
    :return: Error message, if any
    """
    email_valid = checkEmail(email)
    password_valid = checkPassword(password)
    username_valid = checkName(username)
    # firs_name_valid = checkName(first_name)
    # last_name_valid = checkName(last_name)

    if not email_valid:
        return email_valid
    elif not password_valid:
        return password_valid
    elif not username_valid:
        return username_valid
    # elif not firs_name_valid:
    #     return firs_name_valid
    # elif not last_name_valid:
    #     return last_name_valid
    else:
        return True
