# from db.index import newConnection
from resources.moduls.recipeInfo import get_recipe_json_by_id


def get_recipe(dbConnection,id_num):
    """ This function returns 2 Jason files. The first contains all the ingredients of the recipe and their photos and
     the second contains all the steps of preparing the recipe and their photos

    :param id_num: ID of the recipe
    :return: json_ingredients, json_recipe
    """
    # Start db connection
    dbConnection = dbConnection.recipes
    # Check if this username already exists in the system
    id_num = int(id_num)
    json_ingredients = get_recipe_json_by_id(dbConnection, id_num, "json_ingredients")
    json_recipe = get_recipe_json_by_id(dbConnection, id_num, "json_recipe")
    return json_ingredients, json_recipe


def main():
    id_num = "0"  ###
    res = get_recipe(id_num)
    json_ingredients = res[0]
    json_recipe = res[1]


if __name__ == '__main__':
    main()
