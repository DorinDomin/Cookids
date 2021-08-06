import json

from resources.moduls.textKeywords import line_to_keywords


def get_name_by_id(dbConnection, id_num):
    """ This function get a recipe ID number and returns its name.

    :param dbConnection: Connection to the app's database
    :param id_num: The ID of the recipe
    :return: The name of the recipe
    """
    try:
        name = dbConnection.find({"id": id_num}).distinct("name")
        if len(name) == 0:
            name = ""
        else:
            name = name[0]
        # print("name: ", name)
        return name
    except():
        print("We did not find the name of the recipe in the database")
        return None


def get_difficulty_by_id(dbConnection, id_num):
    """ This function get a recipe ID number and returns difficulty level of the recipe.

    :param dbConnection: Connection to the app's database
    :param id_num: The ID of the recipe
    :return: Difficulty level of the recipe
    """
    try:
        difficulty = dbConnection.find({"id": id_num}).distinct("Difficulty")
        if len(difficulty) == 0:
            difficulty = ""
        else:
            difficulty = difficulty[0]
        # print("difficulty: ", difficulty)
        return difficulty
    except():
        print("We did not find the difficulty level of the recipe in the database")
        return None


def get_recipe_by_id(dbConnection, id_num):
    """ This function get a recipe ID number and returns the recipe.

    :param dbConnection: Connection to the app's database
    :param id_num: The ID of the recipe
    :return: The recipe
    """
    try:
        recipe = dbConnection.find({"id": id_num}).distinct("recipe")
        if len(recipe) == 0:
            recipe = ""
        else:
            recipe = recipe[0]
        # print("recipe: ", recipe)
        return recipe
    except():
        print("We did not find the recipe in the database")
        return None


def get_ingredients_by_id(dbConnection, id_num):
    """ This function get a recipe ID number and returns the ingredients of the recipe.

    :param dbConnection: Connection to the app's database
    :param id_num: The ID of the recipe
    :return: The ingredients of the recipe
    """
    try:
        ingredients = dbConnection.find({"id": id_num}).distinct("Ingredients")
        if len(ingredients) == 0:
            return ""
        else:
            ingredients = ingredients[0]
        # print("ingredients: ", ingredients)
        return ingredients
    except():
        print("We did not find the ingredients of the recipe in the database")
        return None


def get_recipe_stages(recipe):
    """ This function accepts the recipe, divides it into steps (by ',') and then returns an array of key words of each
     step in the recipe.

    :param recipe: String of recipe
    :return: array of key words of each step in the recipe.
    """
    # Split recipe to sentences
    recipe_stages = recipe.split(',')
    # Separate each step into tokens by keywords
    for i, line in enumerate(recipe_stages):
        recipe_stages[i] = line_to_keywords(line)
    # print(recipe_stages)
    return recipe_stages


def save_recipe_stages_list(dbConnection, name, ingredients_tokens, ingredients_images, recipe_stages_tokens,
                            recipe_images_by_steps, json_recipe, json_ingredients):
    """ This function gets the recipe name and other details like difficulty level, required ingredients and preparation
     steps and saves all this data in database

    :param dbConnection: Connection to the app's database
    :param name: The name of the recipe
    :param ingredients_tokens: An array of ingredients needed for the recipe
    :param ingredients_images: An array of images matching the ingredients needed for the recipe
    :param recipe_stages_tokens: An array of recipe preparation steps
    :param recipe_images_by_steps: An array of images suitable for each step in the recipe
    :return: Error message if any
    """
    try:
        dbConnection.update_one({"name": name},
                                {"$set": {"json_recipe": json_recipe,
                                          "json_ingredients": json_ingredients}})

        '''
        dbConnection.update_one({"name": name},
                                {"$set": {"ingredients_tokens": ingredients_tokens,
                                          "ingredients_images": ingredients_images,
                                          "recipe_stages_tokens": recipe_stages_tokens,
                                          "recipe_images_by_steps": recipe_images_by_steps,
                                          "json_recipe":jsonData}})
                                          '''
    except():
        print("error with db")


def create_json(steps, images_by_steps):
    """ This function gets a list of sentences and a list of pictures and creates a Jason that links a sentence to a
     suitable list of pictures

    :param dbConnection: Connection to the app's database
    :param steps: A list with the stages of the recipe or a list of ingredients for the recipe
    :param images_by_steps: A list with pictures for each step in the recipe or for the ingredients for the recipe
    :return: Json
    """
    data = {}
    for i in range(len(steps)):
        step_images = [None] * len(images_by_steps[i])
        idx = 0
        for j in images_by_steps[i]:
            if type(j) == bytes:
                step_images[idx] = j.decode("utf-8")
                idx += 1
        data["step " + str(i)] = {"line": steps[i], "images": step_images[:idx]}
    jsonData = json.dumps(data)
    jsonData = json.loads(jsonData)
    return jsonData


def get_recipe_json_by_id(dbConnection, id_num, json_name):
    """ This function get a recipe ID number and returns the ingredients of the recipe.

    :param dbConnection: Connection to the app's database
    :param id_num: The ID of the recipe
    :param json_name: The name of the Jason we want to get
    :return: Json
    """
    try:
        json = dbConnection.find({"id": id_num})
        # print("look ###########")
        # print(json)
        json = json.distinct(json_name)
        # print("inside #########")
        # print(json)
        # json = dbConnection.find({"id": id_num}).distinct(json_name)
        # print('checking json of recipe: ')
        # print(json)
        if len(json) == 0:
            json = ""
        else:
            json = json[0]
        return json
    except():
        print("We did not find the Json of the recipe in the database")
        return None
