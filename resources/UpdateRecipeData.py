from flask_restful import Resource
from models import mongo
from resources.controllers import updateRecipeData
from flask import request,Response


class UpdateRecipeData(Resource):
    def get(self):
        print("in UpdateRecipeData get recipe by id")

    def post(self):
        # check by error func!
        print("in UpdateRecipeData post request")
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        qDetails = {"email": json_data['email'],"recipe_id": int(json_data['recipe_id']),"time": json_data['time'],
                    "hear_clicking": json_data['hear_clicking']}
        # checks those vals and save in db
        # update_end_recipe(email, num_clicks, time, recipe_id)

        updateRecipeData.update_end_recipe(mongo,email=qDetails['email'],
                                                    num_clicks = qDetails['hear_clicking'],
                                                    time = qDetails['time'],
                                                    recipe_id = qDetails['recipe_id'])
        return {'message': "updated"}, 200
        # print("got respond")
        # # check for exeptions errors!!!!!!!!!!!
        # if not result:
        #     return {'message': "db problem,please try again later"}, 400
        # else:
        #     return {'message': "db problem,please try again later"}, 400

