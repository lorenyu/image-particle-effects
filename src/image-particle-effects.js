(function( window, undefined ) {

var _imageParticleEffects = window.imageParticleEffects;

var imageParticleEffects = {
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
