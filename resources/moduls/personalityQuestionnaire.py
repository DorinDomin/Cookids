def save_data(dbConnection, email, age, know_read, need_sound, adult_help):
    """ This function receives data for a particular user and saves them in the database

    :param dbConnection: Connection to the app's database
    :param email: We use email as a unique identifier for the user
    :param age: User age
    :param know_read: 1 - if the user can read, 0 - otherwise
    :param need_sound:  0/1/2
    :param adult_help: 0/1/2/3/4
    :return: void
    """
    try:
        # Save in db
        dbConnection.users.update_one({"email": email},
                                      {"$set": {"age": age,
                                                "know_read": know_read,
                                                "need_sound": need_sound,
                                                "adult_help": adult_help}})
        return "ok"
    except():
        return "Problem with the DB, please try again later"



def check_age(age):
    """ This function accepts the age of the user and checks if it is in the appropriate range

    :param age: User age
    :return: True/ False
    """
    if age <= 0 or age > 100:
        print("wrong age")
        return False
    else:
        return True


def check_know_read(know_read):
    """ This function checks that the input received is the number 0 or 1

    :param know_read: A parameter that says whether the user can read or not
    :return: True/ False
    """
    if know_read != 0 and know_read != 1:
        print("wrong read")
        return False
    else:
        return True


def check_need_sound(need_sound):
    """ This function receives input and checks whether it is a number between 0 and 2.

    :param need_sound: A parameter that says whether the user needs the sound of the instructions or not
    :return: True/ False
    """
    if need_sound < 0 or need_sound > 2:
        print("wrong hear")
        return False
    else:
        return True


def check_adult_help(adult_help):
    """ This function receives input and checks whether it is a number between 0 and 4

    :param adult_help: A parameter that determines how much the child needs the help of an adult from 1 to 5
    :return: True/ False
    """
    if adult_help < 0 or adult_help > 4:
        print("wrong adult")
        return False
    else:
        return True