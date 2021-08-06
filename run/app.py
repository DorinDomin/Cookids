from flask import Blueprint
from flask_restful import Api
# from resources.users import User
from resources.Register import Register
from resources.Login import Login
from resources.Questions import Questions
# from resources.DoneRecipe import DoneRecipe
from resources.checkSentDelete import CheckSentDelete
from resources.RecommendRecipe import RecommendRecipe
from resources.SelectRecipe import SelectRecipe
from resources.UpdateRecipeData import UpdateRecipeData

# here we need to import our new api
api_bp = Blueprint('api', __name__)
api = Api(api_bp)

# Route
# api.add_resource(User, '/User')

api.add_resource(Register, '/Register')
api.add_resource(Login, '/Login')
api.add_resource(Questions, '/Questions')
# api.add_resource(DoneRecipe, '/DoneRecipe')
api.add_resource(CheckSentDelete, '/CheckSentDelete')
api.add_resource(RecommendRecipe, '/RecommendRecipe')
api.add_resource(SelectRecipe, '/SelectRecipe')
api.add_resource(UpdateRecipeData, '/UpdateRecipeData')

# here we add to resurces and check
