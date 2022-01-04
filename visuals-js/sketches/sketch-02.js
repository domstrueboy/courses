const canvasSketch = require('canvas-sketch');
const { range } = require('canvas-sketch-util/random');
const { mapRange } = require('canvas-sketch-util/math');

const settings = {
  dimensions: [ 1080, 1080 ],
  animate: true,
};

const sketch = ({ width, height }) => {

  const points = [];
  for (let i = 0; i < 40; i++) {
    const x = range(0, width);
    const y = range(0, height);
    const point = new Point(x, y);
    points.push(point);
  }

  return ({ context, width, height }) => {
    context.fillStyle = 'white';
    context.fillRect(0, 0, width, height);

    for (let i = 0; i < points.length; i ++) {

      const point = points[i];

      for (let j = i + 1; j < points.length; j++) {
        const otherPoint = points[j];

        const distance = point.position.getDistance(otherPoint.position);

        if (distance > 200) continue;

        context.lineWidth = mapRange(distance, 0, 200, 6, 1);

        context.beginPath();
        context.moveTo(point.position.x, point.position.y);
        context.lineTo(otherPoint.position.x, otherPoint.position.y);
        context.stroke();
      }
    }

    points.forEach(point => {
      point.update();
      point.draw(context);
      point.bounce(width, height);
    });
  };
};

canvasSketch(sketch, settings);

class Vector {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  getDistance(otherVector) {

    const dx = this.x - otherVector.x;
    const dy = this.y - otherVector.y;

    return Math.sqrt(dx*dx + dy*dy);
  }
}

class Point {
  constructor(x, y) {
    this.position = new Vector(x, y);
    this.velocity = new Vector(range(-1, 1), range(-1, 1));
    this.radius = range(4, 12);
  }

  bounce(width, height) {
    if (this.position.x <= 0 || this.position.x >= width) this.velocity.x *= -1;
    if (this.position.y <= 0 || this.position.y >= height) this.velocity.y *= -1;
  }

  update() {
    this.position.x += this.velocity.x;
    this.position.y += this.velocity.y;
  }

  draw(ctx) {
    ctx.save();
    ctx.translate(this.position.x, this.position.y);

    ctx.lineWidth = 4;
    ctx.beginPath();
    ctx.arc(0, 0, this.radius, 0, Math.PI * 2);
    ctx.fill();
    ctx.stroke();

    ctx.restore();
  }
}
