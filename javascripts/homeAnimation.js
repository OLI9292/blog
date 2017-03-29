(function() {

  var svg = document.getElementById('lines');
  var colors = ['#c7254e', '#2647A1', '#609DD3', '#e6b24f'];

  var random = {
    x: function() {
      return Math.random() * window.innerWidth;
    },
    y: function() {
      return Math.random() * window.innerHeight;
    },
    width: function() {
      var plusOrMinus = Math.random() < 0.5 ? -1 : 1;
      return plusOrMinus * Math.random() * window.innerWidth;
    },
    color: function() {
      return colors[Math.floor(Math.random() * colors.length)];
    },
    dash: function() {
      return randomIntFromInterval(window.innerWidth / 10, window.innerWidth / 2);
    }
  }

  function createLine(x, y, width, color, dashLength) {
    var line = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    line.setAttribute('d', "M" + x + " " + y + "h " + width);
    line.setAttribute('stroke', color);
    line.setAttribute('stroke-dasharray', dashLength);
    return line;
  }

  function start() {
    for (i = 1; i < 60; i += 1) {
      var line = createLine(
        random.x(),
        random.y(),
        random.width(),
        random.color(),
        random.dash()
      );
      svg.appendChild(line);
    }
  };

  start();

}());

function randomIntFromInterval(min, max) {
    return Math.floor(Math.random()*(max-min+1)+min);
};
