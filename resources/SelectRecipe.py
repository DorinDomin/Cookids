from flask_restful import Resource
from flask import request
from models import mongo
from resources.controllers import selectRecipe
from flask import request,Response
import jsonpickle


class SelectRecipe(Resource):
    def get(self):
        print("in SelectRecipe get recipe by id")
        arg = request.args.get("id")
        print(arg)
        result = selectRecipe.get_recipe(mongo,arg)
        # print((result[0]["step 1"])["images"][0])
        if len(result) ==2:
            response = {'ingredients': result[0],
                        'recipe': result[1]
                        }
            response_pickled = jsonpickle.encode(response)
            # print(response_pickled)
            return Response(response=response_pickled, status=200, mimetype="application/json")
        else:
            response = {}
            response_pickled = jsonpickle.encode(response)
            print("error, could not get the recipe and ingredients")
            return Response(response=response_pickled, status=404, mimetype="application/json")

    def post(self):
        # check by error func!
        print("in RecipeMenu post request")
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        #password, username validation checks
        # json_data = jsonpickle.decode(json_data)
        qDetails = {"email": json_data['email']}
        # check extra merror- if json has no such vals at all!!!!!!
        # checks those vals and save in db
        result = recipesMenu.get_recipe_recommand(mongo,email=qDetails['email'])
        print("got respond")
        # check for exeptions errors!!!!!!!!!!!
        if not result:
            return {'message': "db problem,please try again later"}, 404
        else:
            # response = {'name': result['name'], 'image': result['image'],
            # print("name: ")
            # print(result['name'])
            # print("img: ")
            # print(result['image'])
            response = {'name': result['name'], 'image': result['image'],
                        }
            # encode response using jsonpickle
            # print(result['image'])
            # response_pickled = jsonpickle.encode(response.encode('utf-8'))
            response_pickled = jsonpickle.encode(response)
            # print(response_pickled)
            return Response(response=response_pickled, status=200, mimetype="application/json")
