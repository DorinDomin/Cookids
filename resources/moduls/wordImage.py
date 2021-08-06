import base64
import os
from PIL import Image
from resources.connect_db import find_and_get, count_documents

def get_image(dbConnection,img_name):
    """ This function get a word and checks if there is a suitable image for that word. If so it returns a binary format
     of the image.

    :param dbConnection: db connection
    :param img_name: Word
    :return: A binary format of the image
    """
    if count_documents(dbConnection.images, {"name": img_name}) != 0:
        aaa = find_and_get(dbConnection.images, {"name": img_name}, "binary")
        print("picture fpund" )
        # print(aaa)
        return aaa.decode('ascii')
    else:
        print("error with find image - {}".format(img_name))
        return None


def find_recipe_images(dbConnection, recipe_stages_kywords):
    """ This function gets an array of recipe steps, with each step being an array of words. We will go through all the
     words and look for a suitable image and return an array of recipe steps when a step is an array of images.

    :param dbConnection: db connection
    :param recipe_stages_kywords:An array of recipe steps, with each step being an array of words
    :return:a An array of recipe steps when a step is an array of images
    """
    #print("recipe_stages: ", recipe_stages_kywords)
    recipe_images_by_steps = []
    for stage in recipe_stages_kywords:
        # Initialize an empty list
        stage_images = []
        for word in stage:
            binary_img = get_image(dbConnection, word)
            # Add image to the list:
            stage_images.append(binary_img)
            #print(word, binary_img)
        recipe_images_by_steps.append(stage_images)
    return recipe_images_by_steps

