import os


def getPort():
    debug_port = 8080
    production_port = 80

    if os.environ.keys().__contains__("PRODUCTION-MODE"):
        if os.environ["PRODUCTION-MODE"] == "true":
            return production_port

    return debug_port


upload_folder = "/tmp/nn-anonymizer"
