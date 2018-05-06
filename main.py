from flask import Flask, request, send_file
import requests
app = Flask(__name__)


@app.route('/')
def index():
    return(open("/app/index.html", "r").read())


@app.route('/ip')
def ip():
    r = requests.get(r'http://jsonip.com')
    ip = r.json()['ip']
    return(ip)


@app.route('/css/style.css')
def style():
    return(open('/app/css/style.css', 'r').read())


@app.route('/images')
def image():
    return send_file('/app/images/'+request.args.get('name'),
                     mimetype='image/gif')
