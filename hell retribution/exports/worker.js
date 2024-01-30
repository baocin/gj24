self.addEventListener('message', async (event) => {
  if (event.data.type === 'DETECT_FACES') {
    const base64ImageData = event.data.frame;
    // const faceapi = faceapi;
    const image = await faceapi.fetchImage(base64ImageData);
    const detectionsWithExpressions = await faceapi.detectAllFaces(image).withFaceExpressions();
    self.postMessage({
      type: 'DETECTION_RESULTS',
      detections: detectionsWithExpressions
    });
  }
});


// const video = document.getElementById('video-face')
// // const canvas = document.getElementById('canvas-face')
// // const context = canvas.getContext('2d')
// // request frame
// // const requestAnimationFrame = window.requestAnimationFrame ||
// // 	window.mozRequestAnimationFrame ||
// // 	window.webkitRequestAnimationFrame ||
// // 	window.msRequestAnimationFrame;
// // navigator.getUserMedia = navigator.getUserMedia ||
// // 	navigator.webkitGetUserMedia ||
// // 	navigator.mozGetUserMedia ||
// // 	navigator.msGetUserMedia;
// // video constraints
// const constraints = {
// 	video: true,
// };
// // turn on webcam
// navigator.mediaDevices.getUserMedia(constraints).then((stream) => {
// 	video.srcObject = stream;
// 	video.play();
// });
// // load models
// Promise.all([
// 	faceapi.nets.tinyFaceDetector.loadFromUri('/gj24/models'),
// 	faceapi.nets.faceLandmark68Net.loadFromUri('/gj24/models'),
// 	faceapi.nets.faceRecognitionNet.loadFromUri('/gj24/models'),
// 	faceapi.nets.faceExpressionNet.loadFromUri('/gj24/models'),
// 	faceapi.nets.ssdMobilenetv1.loadFromUri('/gj24/models')
// ]).then(startVideo);

// // setTimeout(startVideo, 5000);

// console.log(faceapi.nets)

// function startVideo() {
// 	console.log('start video')
// 	// detect face every 100ms
// 	// setInterval(async () => {
// 	// 	const detectionsWithExpressions = await faceapi.detectAllFaces(video).withFaceExpressions()
// 	// 	console.log(detectionsWithExpressions)

// 	// 	if (detectionsWithExpressions.length > 0) {
// 	// 		console.log(`Happy: ${detectionsWithExpressions[0].expressions.happy}`)
// 	// 	}
// 	// }, 100);


// 	setInterval(async () => {
// 		const detectionsWithExpressions = await faceapi.detectAllFaces(video).withFaceExpressions()
// 		console.log(detectionsWithExpressions)

// 		if (detectionsWithExpressions.length > 0) {
// 			console.log(`Happy: ${detectionsWithExpressions[0].expressions.happy}`)
// 		}
// 	}, 100);
// }