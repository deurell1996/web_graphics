let angle = 0

function setup() {
    createCanvas(400,400);
    angleMode(DEGREES);
}

function draw() {
    background(0);
    push();
    fill(0,255,255);
    translate(50, 50);
    rotate(angle);
    rect(0,0,100,50);
    pop();
    angle = angle + 1

    push();
    fill(255,0,255);
    translate(200,200);
    rotate(-angle * 3);
    rect(0,0,100,50);
    pop();

}
