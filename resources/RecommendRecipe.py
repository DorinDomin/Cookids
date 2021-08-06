from flask_restful import Resource
from flask import request
from models import mongo
from resources.controllers import recipesMenu
from flask import request,Response
import jsonpickle


class RecommendRecipe(Resource):
    def get(self):
        print("in get recipes by id")
        arg = request.args.get("level")
        print(arg)
        result = recipesMenu.get_menu(mongo,arg)
        response = {'list': result,
                    }
        response_pickled = jsonpickle.encode(response)
        print(response_pickled)
        return Response(response=response_pickled, status=200, mimetype="application/json")


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
            response = {'id': result['id'],'name': result['name'], 'image': result['image'],
                        }
            # encode response using jsonpickle
            # print(result['image'])
            # response_pickled = jsonpickle.encode(response.encode('utf-8'))
            response_pickled = jsonpickle.encode(response)
            # print(response_pickled)
            return Response(response=response_pickled, status=200, mimetype="application/json")
