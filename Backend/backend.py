from flask import Flask
from FileProcessor import *
from PageServer import *

app = Flask(__name__)


@app.route("/", methods=["GET"])
def _getMainPage():
    return getMainPage()


@app.route("/<path:path>", methods=["GET"])
def _getStaticFile(path):
    return getStaticFile(path)


@app.route("/content/<path:path>", methods=["GET"])
def _getContent(path):
    return getContent(path)


@app.route("/api/process", methods=["POST"])
def _postImage():
    return postImage()


if __name__ == '__main__':
    app.run(debug=False, port=config.getPort(), host="0.0.0.0")
