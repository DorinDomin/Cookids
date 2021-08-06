import os
from pymongo import MongoClient


basedir = os.path.abspath(os.path.dirname(__file__))
# MONGO_URI = "mongodb://localhost:27017/cookids_db"
user = "test_user"
password = "cookids123"
db_name = "cookids"
MONGO_URI = "mongodb+srv://"+user+":"+password+"@cookids.au8m2.mongodb.net/"+db_name+"?retryWrites=true&w=majority"
