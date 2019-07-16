function setup() {
    createCanvas(400,400);
}

function draw() {
    background(0);
    fill(255);
    translate(mouseX, mouseY);
    rect(0,0,100,50);
}
