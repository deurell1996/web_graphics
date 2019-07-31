Bouncer[] bouncer = new Bouncer[3];

void setup() {
    size(500, 500);
    frameRate(24);
    stroke(#0000FF);
    fill(#FFFFFF);
    bouncer[0] = new Box(30, width / 2, 20, 80);
    bouncer[1] = new Ball(width / 2, height / 2, 20);
    bouncer[2] = new Box(width - 50, width / 2, 20, 80);
}

void draw() {
    for (int b = 1, end = bouncer.length; b < end; b++)
        bouncer[b].computeNextStep(width, height, frameRate);

    background(#000000);

    for (int b = 0, end = bouncer.length; b < end; b++)
        bouncer[b].draw();
}

// Keyboard Input
void keyPressed() {
    if (key == CODED) {
        if ( keyCode == 38) {
            bouncer[0].y -= 14;
        }
        else if (keyCode == 40) {
            bouncer[0].y += 14;
        }
    }
}

// bouncer[0] is the left paddle
// bouncer[1] is the ball
// bouncer[2] is the right paddle
bool paddleCollide() {
    if (bouncer[1].x <= bouncer[0].x + bouncer[0].w + bouncer[1].radius - 3 &&
        bouncer[1].y >= bouncer[0].y - bouncer[0].h / 2 &&
        bouncer[1].y <= bouncer[0].y + bouncer[0].h / 2)
        return true
    if (bouncer[1].x >= bouncer[2].x - bouncer[2].w &&
        bouncer[1].y >= bouncer[2].y - bouncer[2].h / 2 &&
        bouncer[1].y <= bouncer[2].y + bouncer[2].h / 2)
        return true;
    return false;
}

abstract class Bouncer
{
    int x, y;
    boolean canmove = true;
    int step = 0;
    int xoffset = 0;
    int yoffset = 0;

    void computeNextStep(int width, int height, float framerate) {
        if (canmove)
            reallyComputeNextStep(width, height, framerate);
    }

    abstract void reallyComputeNextStep(int width, int height, float framerate);

    abstract void draw();

    abstract boolean mouseOver(int mx, int my);
}

class Ball extends Bouncer
{
    int radius;

    // Determine the initial direction the ball is moving
    int dirX = (int) random(1, 3);
    int dirY = (int) random(1, 3);

    // The movement speed of the ball for X,Y
    int xSpeed;
    int ySpeed;

    Ball(int x, int y, int r) {
        this.x = x;
        this.y = y;
        this.radius = r;

        // Get a random speed for X
        if (dirX == 1)
            xSpeed = random(-8, -4);
        else
            xSpeed = random(5, 9);

        // Get a random speed for Y
        if (dirY == 1)
            ySpeed = random(-8, -4);
        else
            ySpeed = random(5, 9);
    }

    void reallyComputeNextStep(int sketch_width, int sketch_height, float frame_rate) {
        // If the ball hits a paddle, deflect it
        // Doesn't work vertically
        if (paddleCollide()) xSpeed = -xSpeed;

        // If the ball hits a wall, reset
        if (x >= sketch_width - radius / 2 || x <= 0 + radius / 2) {
            bouncer[1].x = sketch_width / 2;
            bouncer[1].y = sketch_height / 2;

            // Send the ball in a new direction
            dirX = (int) random(1, 3);
            if (dirX == 1)
                xSpeed = random(-8, -4);
            else
                xSpeed = random(5, 9)
        }

        // Apply the horizontal speed
        x += xSpeed;

        // If the ball hits the ceiling or floor, let it bounce off
        if (y >= sketch_height - radius / 2 || y <= 0 + radius / 2)
            ySpeed = -ySpeed;
        // Apply the vertical speed
        y += ySpeed;
    }

    void draw() {
        ellipse(x + xoffset, y + yoffset, radius, radius);
    }

    boolean mouseOver(int mx, int my) {
        return sqrt((x - mx) * (x - mx) + (y - my) * (y - my)) <= radius;
    }
}

class Box extends Bouncer
{
    int w, h;
    int step = 15;
    String dir = "up";

    Box(int x, int y, int w, int h) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }

    void reallyComputeNextStep(int sketch_width, int sketch_height, float frame_rate) {
        // Move the opponent's paddle up or down
        if (dir == "up") {
            y = y - step;
            if (y <= 0 + (h / 2))
                dir = "down";
        }
        else if (dir == "down") {
            y = y + step;
            if (y >= 500 - (h / 2))
                dir = "up";
        }
    }

    void draw() {
        rect(x + xoffset, (y - h / 2) + yoffset, w, h);
    }
}
