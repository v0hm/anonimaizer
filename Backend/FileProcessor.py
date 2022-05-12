import os
import config
import secrets
from flask import request
from werkzeug.utils import secure_filename
from neural_network.face_detection import FaceDetector

upload_folder = config.upload_folder


def getFileExtension(path):
    return path.rsplit(".", 1)[1].lower()


def processSavedFile(path, result_path):
    detector = FaceDetector(path, result_path)
    detector.draw_faces(draw_keypoints=False)


def postImage():
    if not os.path.exists("/tmp/nn-anonymizer"):
        os.mkdir("/tmp/nn-anonymizer")

    if "file" not in request.files:
        return {"result": None, "error": {"errorCode": 1, "description": "No file section in request"}}, 400

    file = request.files["file"]
    if file.filename == "":
        return {"result": None, "error": {"errorCode": 2, "description": "No file sent"}}, 406

    if not file:
        return {"result": None,
                "error": {"errorCode": 3, "description": "File extension not allowed or file not found"}}, 415

    uploaded_file_name = secure_filename(file.filename)

    token = secrets.token_urlsafe(42)
    saved_file_name = token + "." + getFileExtension(uploaded_file_name)
    result_name = token + "." + "jpeg"

    saved_file_path = os.path.join(upload_folder, saved_file_name)
    result_path = os.path.join(upload_folder, result_name)

    file.save(saved_file_path)

    processSavedFile(saved_file_path, result_path)

    return {"result": {"fileName": "/" + result_name}, "error": None}, 200
