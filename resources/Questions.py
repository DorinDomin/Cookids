from flask_restful import Resource
from flask import request
from models import mongo
from resources.controllers import personalityQuestionnaire  # change to Shira'a code

import re
import json

class Questions(Resource):
    def get(self):
        return {"message": "get from Questions!"}

    def post(self):
        # check by error func!
        print("in questions posr request")
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        #password, username validation checks
        qDetails = {"email": json_data['email'],"age": int(json_data['age']),"read": int(json_data['read']),
                    "hear": int(json_data['hear']), "adult_help": int(json_data['adult'])}
        # check extra merror- if json has no such vals at all!!!!!!
        # checks those vals and save in db
        user = personalityQuestionnaire.get_details(mongo,email=qDetails['email'],age=qDetails['age'],
                                                    know_read=qDetails['read'],need_sound=qDetails['hear'],
                                                    adult_help=qDetails['adult_help'])
        # check for exeptions errors!!!!!!!!!!!
        if user == "ok":
            # in case everything is ok and data was saved in db
            return {"message": 'yay'},200
        elif user == "Problem with the data":
            return {'message': user}, 400
        elif user == "Problem with the DB, please try again later":
            return {'message': user}, 401
        else:
            return {'message': user}, 404
