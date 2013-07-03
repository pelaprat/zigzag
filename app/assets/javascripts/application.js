// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {

	// Functions
	function submit_item_search_form() {
		$.get( $('#item-search-form').attr('action'), $('#item-search-form').serialize(), null, 'script');
	}

	// To be called on startup
	var delay = (function(){
	  var timer = 0;
	  return function(callback, ms){
	    clearTimeout (timer);
	    timer = setTimeout(callback, ms);
	  };
	})();

	$("#items-list .item-table .header a").on('click', function () {
		$.getScript(this.href);
		return false;
	});

	$('#item-search-form input').keyup(function() {
		delay( function() {
			submit_item_search_form();
			return false;
		}, 250 );
	});

	$("#f_books").click( function(){
		submit_item_search_form();
	});

	$("#f_articles").click( function(){
		submit_item_search_form();
	});

});