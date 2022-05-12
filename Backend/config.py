import os


def getPort():
    debug_port = 8080
    production_port = 80

    if os.environ["PRODUCTION-MODE"] == "true":
        return production_port

    else:
        return debug_port


upload_folder = "/tmp/nn-anonymizer"
