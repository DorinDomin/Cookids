# from db.index import newConnection
from resources.moduls.personalityQuestionnaire import check_age, check_know_read, check_need_sound, check_adult_help, save_data


def get_details(dbConnection,email, age, know_read, need_sound, adult_help):
    """ This function receives input that the user entered in the personality questionnaire at the user's initial login,
    checks whether the input is correct and saves the data in the database.

   :param email: We use email as a unique identifier for the user
   :param age: User age
   :param know_read: 1 - if the user can read, 0 - otherwise
   :param need_sound:  0/1/2
   :param adult_help: 0/1/2/3/4
   :return: void
   """
    # Start db connection
    # dbConnection = newConnection()
    if check_age(age) and check_know_read(know_read) and check_need_sound(need_sound) and check_adult_help(adult_help):
        # Save these answers
        result = save_data(dbConnection, email, age, know_read, need_sound, adult_help)
        return result
    else:
        print("Problem with the data")
        return "Problem with the data"


def main():
    # email = "shira@gmail.com"       #delete
    email = "turg4@gmail.com"  # delete

    age = 10
    know_read = 1  # 0-no, 1-yes
    need_sound = 2  # 0,1,2
    adult_help = 2  # 0,1,2,3,4

    get_details(email, age, know_read, need_sound, adult_help)


if __name__ == '__main__':
    main()
