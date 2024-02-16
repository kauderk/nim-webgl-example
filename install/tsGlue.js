function testAssert(condition, message) {
    if (!condition)
        throw new Error("Assert failed: " + message);
}
function consoleLog(message) {
    console.log(message);
}
function consoleError(message) {
    console.error(message);
}
function float32Set(a, k, v) {
    a[k] = v;
}
function checkShader(shader) {
    var compiled = gl.getShaderParameter(shader, gl.COMPILE_STATUS);
    if (!compiled)
        console.error(gl.getShaderInfoLog(shader));
}
function checkProgram(program) {
    var linked = gl.getProgramParameter(program, gl.LINK_STATUS);
    if (!linked)
        console.error(gl.getProgramInfoLog(program));
}
// WebGL
var canvas = document.getElementById('canvas');
function initWebGL(canvas) {
    var gl = null;
    try {
        // Try to grab the standard context. If it fails, fallback to experimental.
        gl = (canvas.getContext("webgl") || canvas.getContext("experimental-webgl"));
    }
    catch (e) { }
    // If we don't have a GL context, give up now
    if (!gl) {
        alert("WebGL is not working. Your browser may not support it.");
        gl = null;
    }
    return gl;
}
var gl = initWebGL(canvas);
var drawCanvasCallback;
function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    // Changing size will clear canvas
    drawCanvasCallback();
}
function animationLoop() {
    drawCanvasCallback();
    requestAnimationFrame(animationLoop);
}
function startup() {
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas, false);
    requestAnimationFrame(animationLoop);
}
