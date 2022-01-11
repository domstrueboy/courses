const canvasSketch = require('canvas-sketch');
const { noise2D, noise3D } = require('canvas-sketch-util/random');
const { mapRange } = require('canvas-sketch-util/math');
const tweakpane = require('tweakpane');

const settings = {
  dimensions: [ 1080, 1080 ],
  animate: true,
};

const params = {
  lineCap: 'butt',
  cols: 10,
  rows: 10,
  scaleMin: 1,
  scaleMax: 100,
  freq: 0.001,
  amp: 0.2,
  frame: 0,
  animate: true,
};

const sketch = () => {
  return ({ context, width, height, frame }) => {
    context.fillStyle = 'white';
    context.fillRect(0, 0, width, height);

    const cols = params.cols;
    const rows = params.rows;
    const numCells = cols * rows;

    const gridw = width * 0.8;
    const gridh = height* 0.8;
    const cellw = gridw / cols;
    const cellh = gridh / rows;
    const margx = (width - gridw) / 2;
    const margy = (height - gridh) / 2;

    for (let i = 0; i < numCells; i++) {
      const col = i % cols;
      const row = Math.floor(i / cols);

      const x = col * cellw;
      const y = row * cellh;
      const w = cellw * 0.8;
      const h = cellh * 0.8;

      const f = params.animate ? frame : params.frame;

      // const n = noise2D(x + f * 10, y, params.freq);
      const n = noise3D(x, y, f * 10, params.freq);
      const angle = n * Math.PI * params.amp;
      const scale = mapRange(n, -1, 1, params.scaleMin, params.scaleMax);

      context.save();
      context.translate(x, y);
      context.translate(margx, margy);
      context.translate(cellw / 2, cellh / 2);
      context.rotate(angle);

      context.lineWidth = scale;
      context.lineCap = params.lineCap;

      context.beginPath();
      context.moveTo(w * -0.5, 0);
      context.lineTo(w * 0.5, 0);
      context.stroke();

      context.restore();
    }
  };
};

const createPanel = () => {
  const panel = new tweakpane.Pane();

  let folder;
  folder = panel.addFolder({ title: 'Grid' });
  folder.addInput(params, 'lineCap', { options: { butt: 'butt', round: 'round', square: 'square' } });
  folder.addInput(params, 'cols', { min: 2, max: 50, step: 1 });
  folder.addInput(params, 'rows', { min: 2, max: 50, step: 1 });
  folder.addInput(params, 'scaleMin', { min: 1, max: 100 });
  folder.addInput(params, 'scaleMax', { min: 1, max: 100 });

  folder.addFolder({ title: 'Noise' });
  folder.addInput(params, 'freq', { min: -0.01, max: 0.01 });
  folder.addInput(params, 'amp', { min: -1, max: 1 });
  folder.addInput(params, 'frame', { min: 0, max: 999 });
  folder.addInput(params, 'animate');
}

createPanel();
canvasSketch(sketch, settings);
