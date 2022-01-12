const canvasSketch = require('canvas-sketch');
const { pick } = require('canvas-sketch-util/random');

const settings = {
  dimensions: [ 1080, 1080 ]
};

let manager;

let text = 'G';
let fontSize = 1200;
let fontFamily = 'serif';

const typeCanvas = document.createElement('canvas');
const typeCtx = typeCanvas.getContext('2d');

const sketch = ({ width, height }) => {
  const cell = 20;
  const cols = Math.floor(width / cell);
  const rows = Math.floor(height / cell);
  const numCells = cols * rows;

  typeCanvas.width = cols;
  typeCanvas.height = rows;

  return ({ context: ctx, width, height }) => {
    typeCtx.fillStyle = 'black';
    typeCtx.fillRect(0, 0, cols, rows);

    fontSize = cols * 1.2;

    typeCtx.fillStyle = 'white';
    typeCtx.font = `${fontSize}px ${fontFamily}`;
    typeCtx.textBaseline = 'top';

    const metrics = typeCtx.measureText(text);
    const mx = metrics.actualBoundingBoxLeft * -1;
    const my = metrics.actualBoundingBoxAscent * -1;
    const mw = metrics.actualBoundingBoxLeft + metrics.actualBoundingBoxRight;
    const mh = metrics.actualBoundingBoxAscent + metrics.actualBoundingBoxDescent;
    const tx = (cols - mw) / 2 - mx;
    const ty = (rows - mh) / 2 - my;

    typeCtx.save();
    typeCtx.translate(tx, ty);

    typeCtx.beginPath();
    typeCtx.rect(mx, my, mw, mh);
    typeCtx.stroke();

    typeCtx.fillText(text, 0, 0);
    typeCtx.restore();

    const typeData = typeCtx.getImageData(0, 0, cols, rows).data;

    ctx.fillStyle = 'black';
    ctx.fillRect(0, 0, width, height);
    ctx.textBaseline = 'middle';
    ctx.textAlign = 'center';

    ctx.drawImage(typeCanvas, 0, 0);

    for (let i = 0; i < numCells; i++) {
      const col = i % cols;
      const row = Math.floor(i / cols);

      const x = col * cell;
      const y = row * cell;

      const r = typeData[i * 4 + 0];
      const g = typeData[i * 4 + 1];
      const b = typeData[i * 4 + 2];
      const a = typeData[i * 4 + 3];

      ctx.fillStyle = 'white';
      ctx.font = `${cell * 2}px ${fontFamily}`;
      if (Math.random() < 0.1) ctx.font = `${cell * 6}px ${fontFamily}`;
      const glyph = getGlyph(r);

      ctx.save();
      ctx.translate(x, y);
      ctx.translate(cell / 2, cell / 2);

      // rectangles:
      // ctx.fillRect(0, 0, cell, cell);

      // circles:
      // ctx.beginPath();
      // ctx.arc(0, 0, cell / 2, 0, Math.PI * 2);
      // ctx.fill();

      ctx.fillText(glyph, 0, 0);

      ctx.restore();
    }
  };
};

const getGlyph = (v) => {
  if (v < 50) return '';
  if (v < 100) return '.';
  if (v < 150) return '-';
  if (v < 200) return '+';
  // if (v < 200) return 'Fuck';

  const glyphs = `_=/`;
  return pick(glyphs);
}

const onKeyUp = (e) => {
  text = e.key.toUpperCase();
  manager.render();
}

document.addEventListener('keyup', onKeyUp);

const start = async () => {
  manager = await canvasSketch(sketch, settings);
}

start();
