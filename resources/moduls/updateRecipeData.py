def set_time(dbConnection, email, recipe_id, time):
    """ This function saves the time it takes the user to execute a particular recipe.

    :param dbConnection: Connection to the app's database
    :param email: We use the user's email as a unique identifier
    :param recipe_id: The ID of the recipe
    :param time: How long it took the user to complete the recipe
    :return: void
    """
    try:
        recipes_time = dbConnection.users.find({"email": email})[0].get("recipes_time")
        recipes_time[recipe_id] = time
        dbConnection.users.update_one({"email": email},
                                      {"$set": {"recipes_time": recipes_time}})
    except():
        raise Exception("error with db")


def set_clicks(dbConnection, email, recipe_id, clicks_num):
    """ This function saves the number of times the user presses the sound button during each preparation of a
     particular recipe

    :param dbConnection: Connection to the app's database
    :param email: We use the user's email as a unique identifier
    :param recipe_id: The ID of the recipe
    :param clicks_num: The number of times the user clicks the play button during the recipe preparation
    :return: void
    """
    try:
        recipes_clicks = dbConnection.users.find({"email": email})[0].get("recipes_clicks")
        recipes_clicks[recipe_id] = clicks_num
        dbConnection.users.update_one({"email": email},
                                      {"$set": {"recipes_clicks": recipes_clicks}})
    except():
        raise Exception("error with db")


def do_recipe(dbConnection, email, recipe_id):
    """ Each user has a 0/1 array in the database based on the amount of recipes available. Once a user has finished
     performing a particular recipe we will mark 1 in the appropriate place in the array.

    :param dbConnection: Connection to the app's database
    :param email: We use the user's email as a unique identifier
    :param recipe_id: The ID of the recipe
    :return: void
    """
    try:
        do_recipe = dbConnection.users.find({"email": email})[0].get("do_recipe")
        do_recipe[recipe_id] = 1
        dbConnection.users.update_one({"email": email},
                                      {"$set": {"do_recipe": do_recipe}})
    except():
        raise Exception("error with db")
