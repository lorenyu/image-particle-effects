(function( window, undefined ) {

var _imageParticleEffects = window.imageParticleEffects;

var DrawUtil = {
  ellipse: function(ctx, x, y, width, height) {
    ctx.save();

    ctx.translate(x, y);
    ctx.scale(width, height);
    ctx.beginPath();
    ctx.arc(0, 0, 1, 0, 2 * Math.PI);
    ctx.fill();

    ctx.restore();
  }
};
var MathUtil = {
  lerp: function(start, stop, amt) {
    return start + (stop - start) * amt;
  }
};
var Random = {
  random: function() {
    if (arguments.length === 0) {
      return Math.random();
    } else if (arguments.length === 1) {
      return Math.random() * arguments[0];
    } else {
      return Math.random() * (arguments[1] - arguments[0]) + arguments[0];
    }
  },
  randomNormal: (function() {
    var next
      , hasNext = false;
    return function(mean, stddev) {
      if (typeof(mean) === 'undefined') {
        mean = 0.0;
      }
      if (typeof(stddev) === 'undefined' || stddev <= 0) {
        stddev = 1.0;
      }
      if (hasNext) {
        hasNext = false;
        return next;
      }
      
      var u = Math.random()
        , v = Math.random()
        , x = Math.sqrt(-2 * Math.log(u)) * Math.cos(2 * Math.PI * v);
      next = Math.sqrt(-2 * Math.log(u)) * Math.sin(2 * Math.PI * v);
      next = mean + next * stddev;
      hasNext = true;
      
      return mean + x * stddev;
    };
  })()
};
var Particle = function(drawingContext, xMax, yMin, yMax) {
  this.ctx = drawingContext;

  this.x = 0;
  this.y = 0;
  this.z = 0;
  this.size = 0;
  this.yMin = yMin;
  this.yMax = yMax;
  this.xMax = xMax;

  this.init();
  this.timeElapsed = parseInt(Random.random(Particle.ANIMATION_TIME));
};
Particle.ANIMATION_TIME = 11;
Particle.prototype.init = function() {
  this.y = Random.random(this.yMin,this.yMax);
  this.z = (this.yMax - this.yMin + 1)/(this.y - this.yMin + 1)/(360 - this.yMin);
  // z is in range (0,1]
  this.z = MathUtil.lerp(1, 30, this.z);
  // z goes from 1 to 50
  this.size = 1.0 / this.z;
  
  if (Random.random(6) < 4) {
    this.x = 344 + Random.randomNormal(0, this.xMax / 24) / this.z;
  } else {
    this.x = 344 + Random.randomNormal(0, this.xMax / 4) / this.z;
  }
  this.timeElapsed = 0;
};
Particle.prototype.tick = function() {
  this.timeElapsed++;

  if (this.timeElapsed >= Particle.ANIMATION_TIME) {
    this.init();
  }
};
Particle.prototype.draw = function() {
  var ctx = this.ctx
    , x = this.x
    , y = this.y
    , size = this.size
    , timeElapsed = this.timeElapsed
    , ANIMATION_TIME = Particle.ANIMATION_TIME
    , lerp = MathUtil.lerp;

  if (timeElapsed < ANIMATION_TIME / 2) {
    DrawUtil.ellipse(ctx, x, y, lerp(0, 14 * size, timeElapsed / (ANIMATION_TIME / 2)), lerp(0, 2 * size, timeElapsed / (ANIMATION_TIME / 2)));
  } else {
    DrawUtil.ellipse(ctx, x, y, lerp(14 * size, 0, (timeElapsed - ANIMATION_TIME / 2) / (ANIMATION_TIME / 2)), lerp(2 * size, 0, (timeElapsed - ANIMATION_TIME / 2) / (ANIMATION_TIME / 2)));
  }
};

var SparklingWaterEffect = function(img) {
  var width = img.offsetWidth
    , height = img.offsetHeight
    , particles = []
    , canvas = document.createElement('canvas')
    , ctx = canvas.getContext('2d')
    , numParticles = 200
    , frameRate = 12;

  canvas.setAttribute('width', width);
  canvas.setAttribute('height', height);

  for (var i = 0; i < numParticles; i++) {
    particles.push(new Particle(ctx, width, 223, height));
  }

  var next = img.nextSibling
    , parent = img.parentNode;
  parent.removeChild(img);
  parent.insertBefore(canvas, next);

  this.img = img;
  this.width = width;
  this.height = height;
  this.particles = particles;
  this.canvas = canvas;
  this.ctx = ctx;
  this.frameRate = frameRate;
};

SparklingWaterEffect.prototype.startDrawing = function() {
  var self = this;
  var scheduleDraw = function() {
    requestAnimationFrame(draw);
  };
  var draw = function() {
    self.draw();
    setTimeout(scheduleDraw, 1000 / self.frameRate);
  };
  scheduleDraw();
};

SparklingWaterEffect.prototype.draw = function() {
  var img = this.img
    , width = this.width
    , height = this.height
    , particles = this.particles
    , ctx = this.ctx;

  ctx.lineWidth = 0;
  ctx.fillStyle = 'rgb(255,255,255)';

  ctx.drawImage(img, 0, 0, width, height);
  // ctx.fillRect(Math.random() * 300, Math.random() * 300, 10, 10);
  for (var i = 0, n = particles.length; i < n; i++) {
    var particle = particles[i];
    particle.tick();
    particle.draw();
  }
};

var imageParticleEffects = {

  SparklingWaterEffect: SparklingWaterEffect,

  noConflict: function() {
    if ( window.imageParticleEffects === imageParticleEffects ) {
      window.imageParticleEffects = _imageParticleEffects;
    }

    return imageParticleEffects;
  }
};

if ( typeof module === "object" && module && typeof module.exports === "object" ) {
  // Expose imageParticleEffects as module.exports in loaders that implement the Node
  // module pattern (including browserify). Do not create the global, since
  // the user will be storing it themselves locally, and globals are frowned
  // upon in the Node module world.
  module.exports = imageParticleEffects;
} else {
  // Register as a named AMD module, since imageParticleEffects can be concatenated with other
  // files that may use define, but not via a proper concatenation script that
  // understands anonymous AMD modules. A named AMD is safest and most robust
  // way to register. Lowercase imageParticleEffects is used because AMD module names are
  // derived from file names, and imageParticleEffects is normally delivered in a lowercase
  // file name. Do this after creating the global so that if an AMD module wants
  // to call noConflict to hide this version of imageParticleEffects, it will work.
  if ( typeof define === "function" && define.amd ) {
    define( "image-particle-effects", [], function () { return imageParticleEffects; } );
  }
}

if ( typeof window === "object" ) {
  window.imageParticleEffects = imageParticleEffects;
}

})( window );
