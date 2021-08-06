from flask_restful import Resource
from flask import request
from models import mongo
from resources.moduls import login
import re
import json

class Login(Resource):
    def get(self):
        return {"message": "get from login!"}

    def post(self):
        # check by error func!
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        #password, username validation checks
        userDetails = {"email": json_data['email'],"password": json_data['password']}
        # check extra merror- if json has no such vals at all!!!!!!
        user = login.existUser(mongo.users,email=userDetails['email'],password=userDetails['password'])
        # check for exeptions errors!!!!!!!!!!!
        if not user:
            return {'message': 'please try again'}, 404

        # user = signup.checkName(name=json_data['first_name'])
        # if not user:
        #     return {'message': 'first name not valid'}, 400
        #
        # user = signup.checkName(name=json_data['last_name'])
        # if not user:
        #     return {'message': 'last name not valid'}, 400

        # user = signup.checkName(name=json_data['user_name'])
        # if not user:
        #     return {'message': 'user name not valid'}, 400

        # user = signup.checkPassword(name=json_data['password'])
        # if not user:
        #     return {'message': 'password not valid'}, 400

        # user = signup.checkEmail(email=json_data['email'])
        # if not user:
        #     return {'message': 'email not valid'}, 400

        return {"message": 'yay'},200

