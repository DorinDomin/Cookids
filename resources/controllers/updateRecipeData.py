from resources.moduls.updateRecipeData import set_time, set_clicks, do_recipe
from resources.moduls.recipe_recommendation import recipe_recommend_user


def update_end_recipe(dbConnection,email, num_clicks, time, recipe_id):
    """ This function receives some data after the user has completed all the steps of the recipe and saves this
     information in the database. Then look for a recommended recipe for the user for next time.

    :param email: We use email as the user's unique identifier
    :param num_clicks: The number of clicks the user presses a sound play button during the recipe preparation time
    :param time: The length of time in minutes it took the user to complete all steps of the recipe
    :param recipe_id: Recipe ID
    :return:void
    """
    # dbConnection = newConnection()
    # Update data on the recipe the user has just finished
    set_time(dbConnection, email, recipe_id, time)
    set_clicks(dbConnection, email, recipe_id, num_clicks)
    do_recipe(dbConnection, email, recipe_id)
    # Find a recommended recipe for the user and save it in the db
    recipe_recommend_user(dbConnection)


def main():
    email = "shira@gmail.com"  # delete
    num_clicks = 8
    time = 45
    recipe_id = 0

    update_end_recipe(email, num_clicks, time, recipe_id)


if __name__ == '__main__':
    main()
