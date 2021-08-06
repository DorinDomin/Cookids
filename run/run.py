from flask import Flask
import flask.scaffold
from werkzeug.serving import WSGIRequestHandler
flask.helpers._endpoint_from_view_func = flask.scaffold._endpoint_from_view_func
from models import mongo
def create_app(config_filename):
    app = Flask(__name__)
    app.config.from_object(config_filename)
    # mongo.init_app(app)
    from app import api_bp
    app.register_blueprint(api_bp, url_prefix='/api')

    # from models import db
    # db.init_app(app)

    return app


if __name__ == "__main__":
    app = create_app("config")
    WSGIRequestHandler.protocol_version = "HTTP/1.1"
    app.run(debug=True)