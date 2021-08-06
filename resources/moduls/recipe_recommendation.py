import random
# from db.index import newConnection
import numpy as np

def recipe_recommend_user(dbConnection):
    """ This function goes through all the users X who are registered for the app and for each one searches for another
     user Y so that the details of both are similar, then it looks for a recipe recommendation for X according to the
      recipes that Y has done and X has not yet done and saves the recommendation in the database.

    :param dbConnection: Connection to the app's database
    :return: void
    """
    users = get_all_user_details(dbConnection)
    for x in users:
        x_email = x.get("email")
        # Create a vector with details of the other user
        x_vector = create_user_vector(dbConnection, x_email)
        similar_user_email = KNN(dbConnection, x_vector, x)
        # Find a recommendation for a recipe
        random_idx_recipe = find_recommand(dbConnection, similar_user_email, x_email)
        # Save in the database
        save_recommand(dbConnection, random_idx_recipe, x_email)

def find_similar_user(dbConnection):
    """ This function goes through all the users X who are registered for the app and for each one searches for another
     user Y so that the details of both are similar, then it looks for a recipe recommendation for X according to the
      recipes that Y has done and X has not yet done and saves the recommendation in the database.

    :param dbConnection: Connection to the app's database
    :return: void
    """
    users = get_all_user_details(dbConnection)
    for x in users:
        x_email = x.get("email")
        print("x_email: ", x_email)
        # Create a vector with details of the other user
        x_vector = create_user_vector(dbConnection, x_email)
        similar_user_email = KNN(dbConnection, x_vector, x)
        print("x: ", x_email, "y: ", similar_user_email, "\n")
        # Find a recommendation for a recipe
        random_idx_recipe = find_recommand(dbConnection, similar_user_email, x_email)
        # Save in the database
        save_recommand(dbConnection, random_idx_recipe, x_email)


def get_all_user_details(dbConnection):
    """ This function returns all registered users to the application.

    :param dbConnection: Connection to the app's database
    :return: All registered users to the application
    """
    try:
        return dbConnection.users.find()
    except():
        raise Exception("error with db")


def KNN(dbConnection, x_vector, x):
    """ This function receives a certain user, then it goes through all the other users who are registered for the
     application and searches for a user whose details are most similar to the given user.

    :param dbConnection: Connection to the app's database
    :param x_vector: A vector with details of the my user
    :param x: My user
    :return: Return the user whose distance from my user is the smallest
    """
    min = float('inf')
    similar_user_email = None
    # Get all registered users to the application
    mydoc2 = get_all_user_details(dbConnection)
    for another_user in mydoc2:
        # If it is the same user in the 2 loops, we will skip
        if (x == another_user):
            continue
        else:
            # Get a unique ID (email) for the other user
            y_email = another_user.get("email")
            print("y_email: ", y_email)
            # Create a vector with details of the other user
            y_vector = create_user_vector(dbConnection, y_email)
            # Check how different my user is from the other user
            distance = np.linalg.norm(x_vector - y_vector)
            print("d: ", distance, "min: ", min)
            if min > distance:
                min = distance
                similar_user_email = y_email
    # Return the user whose distance from my user is the smallest
    return similar_user_email


def find_recommand(dbConnection, similar_user_email, x_email):
    """

    :param dbConnection: Connection to the app's database
    :param similar_user_email: Email of the other user
    :param x_email: My user's email
    :return: ID of the recommended recipe
    """
    try:
        similar_do_recipe = dbConnection.users.find({"email": similar_user_email})[0].get("do_recipe")
        x_user_do_recipe = dbConnection.users.find({"email": x_email})[0].get("do_recipe")
    except():
        raise Exception("Unable to get the array from the database 'do_recipe'")
    print(similar_do_recipe)
    # Create an array that holds all the indexes of the recipes that the other user performed
    idx_of_do_recipes = [i for i, j in enumerate(similar_do_recipe) if j == 1]
    print(idx_of_do_recipes)
    # Choose an index at random, but check that my user has not already performed this recipe
    random_idx_recipe = random.choice(idx_of_do_recipes)
    recipes_count = len(x_user_do_recipe)
    for i in range(recipes_count):
        if x_user_do_recipe[random_idx_recipe] == 1:
            random_idx_recipe = random.choice(idx_of_do_recipes)
        else:
            break
    print("random_idx_recipe: ", random_idx_recipe)
    # Return the ID of the recommended recipe
    return random_idx_recipe


def save_recommand(dbConnection, random_idx_recipe, x_email):
    """ This function saves in the database the recommended recipe for my user.

    :param dbConnection: Connection to the app's database
    :param random_idx_recipe: ID of the recommended recipe
    :param x_email: My user's email
    :return: void
    """
    try:
        dbConnection.users.update_one({"email": x_email},
                                      {"$set": {"recipe recommand": random_idx_recipe}})
    except():
        raise Exception("Unable to save the recommend in database")


def get_age_by_email(dbConnection, email):
    """ This function accepts a user and returns his age.

    :param dbConnection: Connection to the app's database
    :param email: We use email as a unique identifier for the user
    :return: User age
    """
    try:
        age = dbConnection.users.find({"email": email}).distinct("age")[0]
        return age
    except():
        raise Exception("Unable to find user age from database")


def get_know_read_by_email(dbConnection, email):
    """ This function receives a user and returns whether he can read (0/1).

    :param dbConnection: Connection to the app's database
    :param email: We use email as a unique identifier for the user
    :return: 1 - if the user can read, 0 - otherwise
    """
    try:
        know_read = dbConnection.users.find({"email": email}).distinct("know_read")[0]
        return know_read
    except():
        raise Exception("Unable to find 'know read' from database")


def get_need_sound_by_email(dbConnection, email):
    """ This function receives a user and returns whether he can need sound (0/1/2).

    :param dbConnection: Connection to the app's database
    :param email: We use email as a unique identifier for the user
    :return: 0/1/2
    """
    try:
        need_sound = dbConnection.users.find({"email": email}).distinct("need_sound")[0]
        return need_sound
    except():
        raise Exception("Unable to find 'need sound' from database")


def get_adult_help_by_email(dbConnection, email):
    """ This function receives a user and returns whether he can need adult help (0/1/2/3/4).

    :param dbConnection: Connection to the app's database
    :param email: We use email as a unique identifier for the user
    :return: 0/1/2/3/4
    """
    try:
        adult_help = dbConnection.users.find({"email": email}).distinct("adult_help")[0]
        return adult_help
    except():
        raise Exception("Unable to find 'adult help' from database")


def create_user_vector(dbConnection, email):
    """ This function receives a user and returns a vector with details about the user.

    :param dbConnection: Connection to the app's database
    :param email: We use email as a unique identifier for the user
    :return: A vector with details about the user
    """
    time_user = score_time(dbConnection, email)
    clicks_user = score_clicks(dbConnection, email)
    age = get_age_by_email(dbConnection, email)
    know_read = get_know_read_by_email(dbConnection, email)
    need_sound = get_need_sound_by_email(dbConnection, email)
    adult_help = get_adult_help_by_email(dbConnection, email)
    arr = np.array([time_user, clicks_user, age, know_read, need_sound, adult_help])
    return arr


def avg_time(dbConnection):
    """ This function creates an array the size of the amount of recipes and saves for each recipe how long it takes on
     average for the user to make it.

    :param dbConnection: Connection to the app's database
    :return: average arr
    """
    try:
        # Check out how many recipes there are
        recipes_count = dbConnection.recipes.count_documents({})
        # Get all users
        users = dbConnection.users.find()
    except():
        raise Exception("Error with db")
    # Create an array the size of the amount of recipes that will hold for each recipe the average time it took for all
    # users to make it
    arr_avg_time = [0] * recipes_count
    # Create an array the size of the amount of recipes that will hold for each recipe how many users made it
    counter = [0] * recipes_count

    for x in users:
        # Get an array that holds for each recipe how long it took to my user to execute it
        x = x.get("recipes_time")
        for idx, val in enumerate(x):
            # If the user has not performed a particular recipe, skip
            if val == 0:
                continue
            arr_avg_time[idx] += val
            counter[idx] += 1
    for idx, val in enumerate(arr_avg_time):
        if counter[idx] != 0:
            arr_avg_time[idx] = arr_avg_time[idx] / counter[idx]
    return arr_avg_time


def avg_clicks(dbConnection):
    """ This function creates an array the size of the amount of recipes and saves for each recipe a few clicks on the
     audio button each user clicks on average

    :param dbConnection: Connection to the app's database
    :return: average arr
    """
    try:
        # Check out how many recipes there are
        recipes_count = dbConnection.recipes.count_documents({})
        # Get all users
        recipes_clicks = dbConnection.users.find()
    except():
        raise Exception("Error with db")
    arr_avg_clicks = [0] * recipes_count
    # Create an array the size of the amount of recipes that will hold for each recipe a few clicks on the audio button
    # each user clicks on average
    counter = [0] * recipes_count
    # Create an array the size of the amount of recipes that will hold for each recipe how many users made it
    recipes_clicks = dbConnection.users.find()

    for x in recipes_clicks:
        # Get an array that holds for each recipe a few clicks the user clicks
        x = x.get("recipes_clicks")
        for idx, val in enumerate(x):
            if val == 0:
                continue
            arr_avg_clicks[idx] += val
            counter[idx] += 1
    for idx, val in enumerate(arr_avg_clicks):
        if counter[idx] != 0:
            arr_avg_clicks[idx] = arr_avg_clicks[idx] / counter[idx]
    return arr_avg_clicks


def score_time(dbConnection, email):
    """ This function calculates the distance between the average time vector of users and the length of time my user
    takes to execute the recipes

    :param dbConnection: Connection to the app's database
    :param email: We use email as a unique identifier for the user
    :return: score
    """
    # This vector holds the length of time it took my user to execute each recipe
    try:
        user_recipes_time = np.array(dbConnection.users.find({"email": email})[0].get("recipes_time"))
    except():
        raise Exception("Can't get 'recipes_time' from the database")
    # This vector holds the average length of time it took for all app users to execute each recipe
    arr_avg_time = np.array(avg_time(dbConnection))
    # Find the distance between 2 vectors
    score = np.linalg.norm(user_recipes_time - arr_avg_time)
    return score


def score_clicks(dbConnection, email):
    """ This function calculates the distance between my users' average clicks vector and my user's clicks.

    :param dbConnection: Connection to the app's database
    :param email: We use email as a unique identifier for the user
    :return: score
    """
    # An array that holds for each average recipe the amount of my user clicks on the audio button
    try:
        user_recipes_clicks = np.array(dbConnection.users.find({"email": email})[0].get("recipes_clicks"))
    except():
        raise Exception("Can't get 'recipes_clicks' from the database")
    # An array that holds for each average recipe the amount of users pressing the audio button
    arr_avg_clicks = np.array(avg_clicks(dbConnection))
    # Find the distance between 2 vectors
    score = np.linalg.norm(user_recipes_clicks - arr_avg_clicks)
    return score


''''
def main():
    dbConnection = newConnection()
    find_similar_user(dbConnection)


if __name__ == '__main__':
    main()
'''
