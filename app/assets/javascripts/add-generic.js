function register_add_link( singular, plural, ajaxify ) {

	// By default, åjaxify is true
	ajaxify = (typeof ajaxify === "undefined") ? true : ajaxify;

	// Hide the template we just used
	template = $( '#' + singular + '-template' );
	template.hide();

	// Get the add new upload link.
	var jAddNewGeneric = $( "#add-" + singular );

	// Hook up the click event.
	jAddNewGeneric
	.attr( "href", "javascript:void( 0 )" )
	.click(
		function( objEvent ){
			var clone = AddNewGeneric( '', singular, plural );

			// Only if ajaxify is true do we
			//  submit the form.
			if ( ajaxify == 'true' ) {
				clone.change(function() {
					$.post( $('#' + singular + '-form').attr('action'),
				 			$('#' + singular + '-form').serialize());

					$(this).remove();
				});
			}

			// Prevent the default action.
			objEvent.preventDefault();
			return( false );
		}
	)
	;
}

function AddNewGeneric( selected, singular, plural ) {

	// Get a reference to the upload container.
	var container = $( "#" + plural );


	// Get the file upload template.
	var template = $( "#" + singular + "-template" );

	// Duplicate the upload template. This will give us a copy
	// of the templated element, not attached to any DOM.
	var clone = template.clone();

	// At this point, we have an exact copy. This gives us two
	// problems; on one hand, the values are not correct. On
	// the other hand, some browsers cannot dynamically rename
	// form inputs. To get around the FORM input name issue, we
	// have to strip out the inner HTML and dynamically generate
	// it with the new values.
	var clone_html = clone.html();

	// Now, we have the HTML as a string. Let's replace the
	// template values with the correct ones. To do this, we need
	// to see how many upload elements we have so far.
	//	var intNewXgroupCount = (container.find( "div.xgroup-item" ).length + 1);

	var last_item  = container.children().last().attr('id');
	var exp        = /(\d+)$/i;
	var next_id    = 1;

	if( ! last_item ) {
		next_id = 1;
	} else {
		var last_id = last_item.match( exp );
		next_id = ( parseInt(last_id) + 1 );
	}

	if( ! next_id || next_id <= 0 ) {
		next_id = 1;
	}

	// Set the proper ID.
	clone.attr( "id", ( singular + "_" + next_id ) );

	// Replace the values.
	clone_html = clone_html
	.replace(
		new RegExp( "::FIELD1::", "ig" ),
		( singular + "_" + next_id)
	)
	.replace(
		new RegExp( "::FIELD2::", "ig" ),
		( singular + "_" + next_id)
	)
	;

	// Now that we have the new HTML, we can replace the
	// HTML of our new upload element.
	clone.html( clone_html );

	// Make a default if necessary.
	clone.find( 'select' ).val( selected );

	// Let's attach it to the DOM.
	container.append( clone );

	// Adjust the remove link for this clone
	// Hook up the click event.

	delete_link = $( "#delete-" + singular + "_" + next_id );

	// Hook up the click event.
	delete_link
	.attr( "href", "javascript:void( 0 )" )
	.click(
		function( objEvent ){
			DeleteGeneric( '#' + singular + '_' + next_id );

			// Prevent the default action.
			objEvent.preventDefault();
			return( false );
		}
	);

	// Show the item
	clone.show();

	return clone;
}

function DeleteGeneric( object ) {
    obj = $( object );
    obj.remove();
}

