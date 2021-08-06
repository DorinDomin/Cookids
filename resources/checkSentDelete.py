from flask_restful import Resource
from flask import request,Response
import requests
from models import mongo
import re
import json
import jsonpickle
import base64
class CheckSentDelete(Resource):
    def get(self):
        print("get from CheckSentDelete!")
        r = request
        # convert string of image data to uint8
        my_url = 'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg'
        output = base64.b64encode(requests.get(my_url).content)
        # bin = "".join(format(ord(x), "b") for x in base64.decodestring(output))
        bin=""
    # nparr = np.fromstring(r.data, np.uint8)
    # # decode image
    # img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

        # do some fancy processing here....

        # build a response dict to send back to client
        response = {'messages': ['hello thete', 'you made it!','my champ!!'], 'image': bin,
                    }
        # encode response using jsonpickle
        response_pickled = jsonpickle.encode(response)

        return Response(response=response_pickled, status=200, mimetype="application/json")


    def post(self):
        # check by error func!
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        #password, username validation checks
        qDetails = {"id": json_data['id'],"recipe_id": json_data['recipe_id'],"time": json_data['time'],
                    "hear_clicking": json_data['hear_clicking']}
        # check extra merror- if json has no such vals at all!!!!!!
        # checks those vals and save in db
        user = login.existUser(mongo.db.users,email=userDetails['email'],password=userDetails['password'])
        # check for exeptions errors!!!!!!!!!!!
        if not user:
            return {'message': 'please try again'}, 404
        # in case everything is ok and data was saved in db
        return {"message": 'yay'},200