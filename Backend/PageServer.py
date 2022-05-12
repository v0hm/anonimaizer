from flask import send_from_directory


def getMainPage():
    return getStaticFile("index.html")


def getStaticFile(path):
    return send_from_directory("../Frontend-Build", path)


def getContent(path):
    return send_from_directory("~/.cache/nn-anonymizer", path)
