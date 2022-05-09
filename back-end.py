import os
from flask import Flask, redirect, url_for, request, render_template, send_from_directory
from werkzeug.utils import secure_filename

filename = ""

def main_page():
    return render_template("template.html")

def index():
    if request.method == "GET":
        return main_page()
    else:
        if 'file' not in request.files:
            return redirect(url_for("result"))
        file = request.files['file']
        if file.filename == "":
            return send_from_directory(app.config["folder"], "Black Square.jpg")
        if file:
            global filename
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['folder'], filename))
            return redirect(url_for("result"))
        return render_template("template.html")

def result():
    return send_from_directory(app.config["folder"], filename)

folder = os.getcwd()
app = Flask(__name__, template_folder=folder, static_folder=folder)
app.add_url_rule('/', 'index', index, methods=['post', 'get'])
app.add_url_rule('/index', 'index', index, methods=['post', 'get'])
app.add_url_rule('/result', 'result', result)
app.config["SECRET_KEY"] = "SuperSecretKey"
app.config["folder"] = folder

app.run(host= "0.0.0.0")
