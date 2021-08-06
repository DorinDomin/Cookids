from resources.moduls.wordImage import get_image


def get_id_by_difficulty(dbConnection, diff):
    """ This item returns the ID of all recipes in the requested difficulty level

    :param diff: difficult level
    :return: id list
    """
    try:
        id_list = dbConnection.find({"Difficulty": diff}).distinct("id")
        print("id_list: ", id_list)
        if len(id_list) == 0:
            return None
        else:
            return id_list
    except():
        print("We did not find the id of the recipe in the database")
        return None


def list_image_name(dbConnection, id_list):
    """ This function returns a list that contains a name and image for all recipes of a certain difficulty level

    :param id list: List of ID of all recipes with a certain degree of difficulty
    :return: image_for_id
    """
    image_for_id = {}
    if id_list == None:
        return None
    for id in id_list:
        try:
            recipe_name = dbConnection.recipes.find({"id": id}).distinct("name")
            if len(recipe_name) == 0:
                recipe_name = ""
            else:
                recipe_name = recipe_name[0]

            image_for_id[id] = {"name": recipe_name, "image": get_image(dbConnection,recipe_name)}
            # image_for_id[id] = {"name": recipe_name, "image": get_image(dbConnection,recipe_name).decode('ascii')}
        except():
            print("We did not find the id of the recipe in the database")
            return None
    print(image_for_id)
    return image_for_id


def get_recipe_recommand(dbConnection, email):
    """ This function returns an ID of the recommended recipe for the variable

    :param email: email of user
    :return: recipe id
    """
    try:
        recipe_recommand = dbConnection.users.find({"email": email})
        # check if empty
        result = list(recipe_recommand)
        print(result)
        if len(result) == 0:
            recipe_name = ""
        else:
            recipe_recommand = result[0].get("recipe recommand")
            return recipe_recommand
    except():
        print("error with db")
        return None


def details_recommand(dbConnection, email):
    """ This function returns an ID, name and image of the recommended recipe for the variable

    :param email: email of user
    :return: recipe id
    """
    recipe_id = str(get_recipe_recommand(dbConnection, email))
    print("********************")
    print(recipe_id)
    if not recipe_id or recipe_id == "None":
        print("could not find reco for current email")
        return None
    try:
        recipe_name = dbConnection.recipes.find({"id": int(recipe_id)}).distinct("name")
        if len(recipe_name) == 0:
            return None
        else:
            recipe_name = recipe_name[0]
        img = get_image(dbConnection,recipe_name)
        # img = get_image(dbConnection,recipe_name).decode('ascii')
        print("***************************")
        print(type(img))
        details = {"id":recipe_id ,"name": recipe_name, "image": img}
        return details
    except():
        # raise Exception("error with db")
        print("error with db")
        return None
