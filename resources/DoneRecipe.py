from flask_restful import Resource
from flask import request
from models import mongo
from resources.moduls import login # change to Shira'a code
import re
import json

class Questions(Resource):
    def get(self):
        return {"message": "get from DoneRecipe!"}

    def post(self):
        # check by error func!
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        #password, username validation checks
        qDetails = {"email": json_data['email'],"recipe_id": json_data['recipe_id'],"time": json_data['time'],
                    "hear_clicking": json_data['hear_clicking']}
        # check extra merror- if json has no such vals at all!!!!!!
        # checks those vals and save in db
        user = login.existUser(mongo.db.users,email=userDetails['email'],password=userDetails['password'])
        # check for exeptions errors!!!!!!!!!!!
        if not user:
            return {'message': 'please try again'}, 404
        # in case everything is ok and data was saved in db
        return {"message": 'yay'},200