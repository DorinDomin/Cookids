from flask_restful import Resource
from flask import request
from models import mongo
from resources.moduls import signup
import re
import json

class Register(Resource):
    def get(self):
        return {"message": "Hello, World!"}

    def post(self):
        # check by error func!
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        #email, password, username, first_name, last_name validation checks
        userDetails = {
                       "user_name": json_data['user_name'],"email": json_data['email'],
                       "password": json_data['password']}
        # userDetails = {"first_name": json_data['first_name'], "last_name": json_data['last_name'],
        #                "user_name": json_data['user_name'],"email": json_data['email'],
        #                "password": json_data['password']}

        # check extra merror- if json has no such vals at all!!!!!!
        # also- check if user exists
        # user = signup.error_message(email=userDetails['email'],password=userDetails['password'],
        #                             username= userDetails['user_name'],first_name=userDetails['first_name'],
        #                             last_name=userDetails['last_name'])

        # if not user:
        #     return {'message': 'please try again'}, 400

        # user = signup.checkName(name=json_data['first_name'])
        # if not user:
        #     return {'message': 'first name not valid'}, 400
        #
        # user = signup.checkName(name=json_data['last_name'])
        # if not user:
        #     return {'message': 'last name not valid'}, 400

        user = signup.checkName(name=json_data['user_name'])
        if not user:
            return {'message': 'user name not valid'}, 405

        user = signup.checkPassword(password=json_data['password'])
        if not user:
            return {'message': 'password not valid'}, 406

        user = signup.checkEmail(email=json_data['email'])
        if not user:
            return {'message': 'email not valid'}, 407

        #hash password
        userDetails['password'] = signup.hashGenerate(userDetails['password'])
        try:
            # Save in db
            # use from Shira!!!!!!!!!!!!!!
            mongo.users.insert_one(userDetails)
            return {"message": 'yay'},200
        except():
            return {"message": "oh no"},410
