(function($) { // Hide scope, no $ conflict

var PROP_NAME = 'referencePopup';
function ReferencePopup() {}

$.extend(ReferencePopup.prototype, {

    /* Class name added to elements to indicate already configured with max length. */
    markerClassName: 'hasReferencePopup',

    /* Attach the max length functionality to a text field.
       @param  target    (element) the control to affect 
    */
    _attachReferencePopup: function( target, parent_window ) {

		// Set 'target' to the actual object in the DOM
		//  which is attached a reference browser
        target = $(target);
        if( target.hasClass(this.markerClassName) ) {
            return;
        }

		// Add this class to the object which is also now a reference browser
        target.addClass(this.markerClassName).bind('click', function(event) {

			/*  START reference pop up click event handler code  */
			var html = "<div id='reference_browser' name='reference_browser' style='background:#ffffff;height:794px;margin:3px 3px 3px 3px;'> \
						<iframe  width='100%' height='100%' src='/reference'></iframe> \
						</div>";

			Shadowbox.open({
				player:     'html',
				title:      'Reference Browser',
				content:    html,
				height:     800,
				width:      1000
			});

			// Call the "we have opened Shadowbox" callback
			popupTrackerCallback( target );

			/*  END reference pop up click event handler code  */
		});
    }
});

var popupTrackerCallback = function(){ }

	/*	Attach the reference popup functionality to a jQuery selection.
   		@return  (jQuery) for chaining further calls */
	$.fn.referencePopup = function( popup_tracker, parent_window ) {

	////////////////////////////////////////////////
	// popup_tracker is a function that is called
	// when the item which is now also reference popup
	// is triggered
    if( null != popup_tracker && $.isFunction(popup_tracker) ){
        popupTrackerCallback = popup_tracker;
    }

	/////////////////////////////////////////////////
	// Do the attaching through _attachReferencePopup()
    var otherArgs = Array.prototype.slice.call(arguments, 1);
    return this.each(function() {
        $.referencePopup._attachReferencePopup( this, parent_window );
    });
};

/* Initialise the reference popup functionality. */
$.referencePopup = new ReferencePopup(); // singleton instance

})(jQuery);
