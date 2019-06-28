float framerate = 24;
int ball_x;
int ball_y;
int ball_radius = 20;

void setup() {
    size(200, 200);
    frameRate(framerate);
    ball_x = width / 2;
    ball_y = ball_radius;
    stroke(#333333);
    fill(#330066);
}

void draw() {
    float bounce_height = height / 2 * abs(sin(PI * frameCount / framerate));
    float ball_height = height - (bounce_height + ball_radius);
    background(#FFFFEE);
    ball_y = (int) ball_height;
    ellipse(ball_x, ball_y, ball_radius, ball_radius);
}
