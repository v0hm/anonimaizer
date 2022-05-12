import os


def getPort():
    production_var = "PRODUCTION_MODE"
    debug_port = 8080
    production_port = 80

    if os.environ.keys().__contains__(production_var):
        if os.environ[production_var] == "true":
            return production_port

    return debug_port


upload_folder = "/tmp/nn-anonymizer"
