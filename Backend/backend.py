from flask import Flask, send_from_directory
from flask_restful import Api
from NetworkApi import NetworkApi

app = Flask(__name__)


@app.route("/")
def getMainPage():
    return getStaticFile("index.html")


@app.route("/<path:path>")
def getStaticFile(path):
    return send_from_directory("../Frontend-Build", path)


api = Api(app)
api.add_resource(NetworkApi, '/api')

if __name__ == '__main__':
    app.run(debug=False)
