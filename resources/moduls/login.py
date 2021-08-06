from hashlib import sha256


def existUser(dbConnection, email, password):
    """ This function receives details from the user, if the details exist in the system then the connection to
     the application is successful, otherwise an error message will be returned

    :param dbConnection: dbConnection: Connection to the app's database
    :param username: The username that the user entered while signing up to app
    :param password: The password that the user entered while signing up to app
    :return: If the user does not exist the system - return False, otherwise True
    """
    try:
        if dbConnection.count_documents({"email": email, "password": hashGenerate(password)}) == 0:
            print("user not exists")
            return False
        else:
            # username exists in the system
            return True
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
