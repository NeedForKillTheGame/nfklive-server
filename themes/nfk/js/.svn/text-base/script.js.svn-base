(function( $ ) {

var module = {};

function Hook_LayoutLoaded() {
    var tourLink = $("<div class='interactive' style='position: absolute; left: 4px; top: 55px; width: 119px; height: 30px'></div>")
        .click( quakelive.mod_home.ShowTour );
    
    var guideLink = $( "<div class='interactive' style='position: absolute; left: 128px; top: 55px; width: 127px; height: 30px'></div>" )
        .click( function () {
            quakelive.Goto( 'guide' );
        } );
    
    $('#valance_self_advert')
    .css('border','0')
    .css( 'position', 'relative' )
    .html( "<div style='background: url(" + quakelive.resource( "./valances/default/learn_more.png" ) + "); width: 260px; height: 94px'></div>" )
    .append( tourLink )
    .append( guideLink );
}

module.Init = function () {
    quakelive.AddHook( 'OnLayoutLoaded', Hook_LayoutLoaded );
};

quakelive.RegisterModule( 'valance', module );

})( jQuery );
