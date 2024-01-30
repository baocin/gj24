import {Peer} from "https://esm.sh/peerjs@1.5.2?bundle-deps"

const peer = new Peer(undefined, {
    host: '0.peerjs.com',
    port: 443,
    secure: true
});
const peers = {};
const gameContainer = document.getElementById('gameContainer');
let myPlayerDiv;
let playerPositions = {};

peer.on('open', (id) => {
    console.log('My peer ID is: ' + id);
    myPlayerDiv = createPlayer(id);
    playerPositions[id] = { x: 0, y: 0 };
});

peer.on('connection', (conn) => {
    setupConnection(conn);
});

function setupConnection(conn) {
    conn.on('data', (data) => {
        updatePlayers(data);
    });

    conn.on('open', () => {
        peers[conn.peer] = conn;
        broadcastInitialState(conn);
    });
}

function broadcastInitialState(conn) {
    const initialState = {
        type: 'initial',
        players: playerPositions
    };
    conn.send(initialState);
}

function updatePlayers(data) {
    if (data.type === 'initial') {
        Object.entries(data.players).forEach(([peerId, position]) => {
            if (!document.getElementById(peerId)) {
                createPlayer(peerId);
            }
            movePlayer(document.getElementById(peerId), position.x, position.y);
        });
    } else {
        movePlayer(document.getElementById(data.id), data.x, data.y);
    }
}

document.addEventListener('keydown', (event) => {
    const keyName = event.key;
    const playerDiv = myPlayerDiv;
    if (!playerDiv) return;

    let { x, y } = playerPositions[peer.id] || { x: Math.floor(Math.random() * 500), y: Math.floor(Math.random() * 500) };

    if (keyName === 'w') y -= 10;
    else if (keyName === 's') y += 10;
    else if (keyName === 'a') x -= 10;
    else if (keyName === 'd') x += 10;

    playerPositions[peer.id] = { x, y };
    movePlayer(playerDiv, x, y);
    broadcastGameState();
});

function movePlayer(playerDiv, x, y) {
    playerDiv.style.transform = `translate(${x}px, ${y}px)`;
}

function broadcastGameState() {
    const state = {
        type: 'update',
        id: peer.id,
        x: playerPositions[peer.id].x,
        y: playerPositions[peer.id].y
    };
    Object.values(peers).forEach(conn => conn.send(state));
}

function createPlayer(peerId) {
    const playerDiv = document.createElement('div');
    playerDiv.className = 'player';
    playerDiv.id = peerId;
    gameContainer.appendChild(playerDiv);
    return playerDiv;
}
