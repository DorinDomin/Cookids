# from db.index import newConnection
from resources.moduls.recipesMenu import get_id_by_difficulty, list_image_name, details_recommand


def get_menu(dbConnection,diff):
    """ This function gets a difficulty rating and holds a dictionary that contains all the recipes in this difficulty
     sense and their pictures

    :param diff: difficulty level
    :return: image to recipe
    """
    # Start db connection
    # dbConnection = newConnection().recipes
    # Get a list of all the recipes at this difficulty level
    id_list = get_id_by_difficulty(dbConnection.recipes, diff)
    # Match image to any recipe
    res = list_image_name(dbConnection, id_list)
    return res


def get_recipe_recommand(dbConnection,email):
    """ This function returns the recommended recipe for the user

    :param email: email
    :return: recommand recipe
    """
    # Start db connection
    # dbConnection = newConnection()
    res = details_recommand(dbConnection, email)
    return res


def main():
    diff = "Hard"
    res = get_menu(diff)

    email = "shira@gmail.com"
    get_recipe_recommand(email)


if __name__ == '__main__':
    main()
