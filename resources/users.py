from flask_restful import Resource
from flask import request
import random
import string


class User(Resource):
    def get(self):
        return {"message": "Hello, World!"}