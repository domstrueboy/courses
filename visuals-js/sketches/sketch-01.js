const canvasSketch = require('canvas-sketch');
const { degToRad } = require('canvas-sketch-util/math');
const { range } = require('canvas-sketch-util/random');

const settings = {
  dimensions: [ 1080, 1080 ]
};

const sketch = () => {
  return ({ context, width, height }) => {
    context.fillStyle = 'white';
    context.fillRect(0, 0, width, height);

    context.fillStyle = 'black';

    const cx = width * 0.5,
          cy = height * 0.5,
          w = width * 0.01,
          h = height * 0.1;

    const num = 40;
    const slice = degToRad(360 / num);

    const radius = width * 0.36;

    for (let i = 0; i < num; i++) {
      const angle = slice * i;
      const x = radius * Math.sin(angle);
      const y = radius * Math.cos(angle);

      context.save();
      context.translate(cx, cy);
      context.translate(x, y);
      context.rotate(-angle);
      context.scale(range(0.1, 2), range(0.2, 0.5));

      context.beginPath();
      context.rect(-w * 0.5, range(0, -h * 0.5), w, h);
      context.fill();
      context.restore();

      context.save();
      context.translate(cx, cy);
      context.rotate(-angle);

      context.lineWidth = range(1, 15);
      context.beginPath();
      context.arc(0, 0, radius * range(0.7, 1.3), slice * range(1, -8), slice * range(1, 5));
      context.stroke();
      context.restore();
    }

    
  };
};

canvasSketch(sketch, settings);
