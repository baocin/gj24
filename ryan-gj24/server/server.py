from flask import Flask, render_template
from flask_socketio import SocketIO, emit
from pyautogui import press
from flask_cors import CORS, cross_origin
import json

app = Flask(__name__, static_url_path='/', static_folder='.')
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app, cors_allowed_origins='*')
cors = CORS(app, resources={r"/*": {"origins": "*"}})
app.config['CORS_HEADERS'] = 'Content-Type'

@socketio.on('control')
@cross_origin()
def handle_control(key):
    key_handler(key['data'])
    emit('response', {'status': 'Controlled'})

def key_handler(key):
    # data = json.loads(key.replace("'", '"'))
    # data = j
    expressions = key['expressions']

    if expressions['happy'] > 0.5:
        press('w')
    elif expressions['surprised'] > 0.5:
        press('s')
    elif expressions['sad'] > 0.35:
        press('t')

if __name__ == '__main__':
    socketio.run(app, port=5000, host='0.0.0.0')
