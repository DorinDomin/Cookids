from pymongo import MongoClient


def newConnection():
    try:
        user = "test_user"
        password = "cookids123"
        db_name = "cookids"
        str = "mongodb+srv://"+user+":"+password+"@cookids.au8m2.mongodb.net/"+db_name+"?retryWrites=true&w=majority"
        str = "mongodb+srv://"+"test_user"+":"+"cookids123"+"@cookids.au8m2.mongodb.net/"+"cookids"+"?retryWrites=true&w=majority"
        #str = "mongodb+srv://test_user:cookids123@cookids.au8m2.mongodb.net/cookids?retryWrites=true&w=majority"
        client = MongoClient(str)
        db = client.cookids_db
        return db
    except():
        raise TypeError("Fail to connect to DB")


def insert_one(collection_name, data):
    try:
        collection_name.insert_one(data)
    except():
        raise TypeError("Error with insert_one function")


def insert_many(collection_name, data):
    try:
        collection_name.insert_many(data)
    except():
        raise TypeError("Error with insert_many function")


def count_documents(collection_name, data):
    try:
        return collection_name.count_documents(data)
    except():
        raise TypeError("Error with count_documents function")


def update_one(collection_name, query, new_values):
    try:
        collection_name.update_one(query, new_values)
    except():
        raise TypeError("Error with update_one function")


def find_and_distict(collection_name, data_for_find, data_for_distict):
    try:
        return collection_name.find(data_for_find).distinct(data_for_distict)
    except():
        raise TypeError("Error with find_and_distict function")


def find_and_get(collection_name, data_for_find, data_for_get):
    try:
        return collection_name.find(data_for_find)[0].get(data_for_get)
    except():
        raise TypeError("Error with find_and_get function")


def find_query(collection_name, data):
    try:
        return collection_name.find(data)
    except():
        raise TypeError("Error with find function")


def get_query(collection_name, data):
    try:
        return collection_name.get(data)
    except():
        raise TypeError("Error with get function")


def distinct_query(collection_name, data):
    try:
        return collection_name.distinct(data)
    except():
        raise TypeError("Error with distinct function")
