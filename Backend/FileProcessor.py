import os
import secrets
from flask import request
from werkzeug.utils import secure_filename
from neural_network.face_detection import FaceDetector

upload_folder = "/tmp/nn-anonymizer"
allowed_extensions = {"png", "jpg", "jpeg", "bmp"}


def getFileExtension(path):
    return path.rsplit(".", 1)[1].lower()


def isFileAllowed(path):
    return ("." in path) and (getFileExtension(path) in allowed_extensions)


def processSavedFile(path):
    detector = FaceDetector(path)
    detector.draw_faces()


def postImage():
    if not os.path.exists("/tmp/nn-anonymizer"):
        os.mkdir("/tmp/nn-anonymizer")

    if "file" not in request.files:
        return {
            "result": None,
            "error": {
                "errorCode": 1,
                "description": "No file section in request"
            }
        }, 400

    file = request.files["file"]
    if file.filename == "":
        return {
            "result": None,
            "error": {
                "errorCode": 2,
                "description": "No file sent"
            }
        }, 400

    if (not isFileAllowed(file.filename)) or (not file):
        return {
           "result": None,
           "error": {
               "errorCode": 3,
               "description": "File extension not allowed or file not found"
           }
        }, 400

    uploaded_file_name = secure_filename(file.filename)
    saved_file_name = secrets.token_urlsafe(42) + "." + getFileExtension(uploaded_file_name)
    saved_file_path = os.path.join(upload_folder, saved_file_name)
    file.save(saved_file_path)

    processSavedFile(saved_file_path)

    return {
        "result": {
            "fileName": saved_file_name
        },
        "error": None
    }, 200
