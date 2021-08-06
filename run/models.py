from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_pymongo import PyMongo
from pymongo import MongoClient
from config import MONGO_URI
import pymongo
# mongo = PyMongo()
client = MongoClient(MONGO_URI)
# mongo = pymongo.database.Database(client, 'cookids_db')
mongo = client.cookids_db

# class User(db):
#     def get(self):
#         return {"message": "Hello, World!"}
#     # __tablename__ = 'people'
#     #
#     # id = db.Column(db.Integer, primary_key=True)
#     # first_name = db.Column(db.String(250), nullable=False)
#     # last_name = db.Column(db.String())
#     # email = db.Column(db.String())
#     # gender = db.Column(db.String())
#     # ip_adress = db.Column(db.String())
#     # api_key = db.Column(db.String())
#     #
#     # def __init__(self, api_key, firstname, lastname, emailadress, gender, ipadress):
#     #     self.api_key = api_key
#     #     self.first_name = firstname
#     #     self.last_name = lastname
#     #     self.email = emailadress
#     #     self.gender = gender
#     #     self.ip_adress = ipadress
#     #
#     # def __repr__(self):
#     #     return '<id {}>'.format(self.id)
#     #
#     # def serialize(self):
#     #     return {
#     #         'api_key' : self.api_key,
#     #         'id' : self.id,
#     #         'first_name' : self.first_name,
#     #         'last_name' : self.las_tname,
#     #         'email' : self.email,
#     #         'gender' : self.gender,
#     #         'ip_adress' : self.ip_adress,
#     #     }