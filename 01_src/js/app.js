// SCSS
require("../scss/styles.scss");

// IMPORT
import Glossarizer from './glossarizer-zexfix.js';
import 'bootstrap/js/dist/modal';

// GA
const gaKey = $('body').attr('data-gakey');
if (gaKey.length) {
	// console.log(`Use Google Analytics with key ${gaKey}`);
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', gaKey);
}

// POLLYFILLS -- forEach() on IE
if (window.NodeList && !NodeList.prototype.forEach) {
    NodeList.prototype.forEach = function (callback, thisArg) {
        thisArg = thisArg || window;
        for (var i = 0; i < this.length; i++) {
            callback.call(thisArg, this[i], i, this);
        }
    };
}

// UTILITY --> Mass execution function for iterating through Method group objects
const executeAll = function(methodObjects) { methodObjects.forEach(function(methodObject) { for (const key in methodObject) methodObject[key]() }) }

// MEDIA BREAKPOINTS
const breakPoints = {
	xs: 0,
	sm: 576,
	md: 768,
	lg: 1100,
	xl: 1400
};

// MAIN APP
const App = {

	// Object to register methods to run when DOM ready
	initMethods: {},

	// Object to register methods to run when DOM ready, and subsequently when the media breakpoint changes
	resizeMethods: {},

	// Objects to register common methods and variables used in multiple places, to reduce code duplication
	utilMethods: {},
	utilVars: {},

	// Use this for mapping
	mapData: {
		zoom: 10,
		poiData: []
	},

	// Use this if font load detection is required
	fontState: null,

	// Methods to enable responsive functionality
	breakPoint: '',
	getBreakPoint: function() {//--> Sets App.breakpoint to a string containing the identification code of each breakpoint passed
		this.breakPoint = '';
		for (const key in breakPoints) this.breakPoint = ( $(window).width() >= breakPoints[key] ? this.breakPoint + ' ' + key : this.breakPoint );
	},
	updateBreakPoint: function(e) {//--> Gets App.breakpoint and executes all resize methods
		var oldBreakPoint = App.breakPoint;
		App.getBreakPoint();
		if (App.breakPoint !== oldBreakPoint) executeAll([App.resizeMethods]);
	},
	watchBreakPoints: function() {//--> Watches breakpoints and runs updateBreakpoint when one is triggered
		for (const key in breakPoints) window.matchMedia('(min-width: ' + breakPoints[key] + 'px)').addListener(this.updateBreakPoint);
	},

	// Executes all methods registered to the initMethods and resizeMethods objects, starts listening for resize events, called when DOM ready
	init: function() {
		this.getBreakPoint();
		executeAll([this.initMethods, this.resizeMethods]);
		this.watchBreakPoints();
	}
};

// Resize method example
// App.resizeMethods.resizeTest = function () {
// 	if ( App.breakPoint.includes('lg') ) console.log('desktop code here');
// 	if ( !App.breakPoint.includes('md') ) console.log('mobile code here');
// }

App.initMethods.changeUserStatus = function () {
	let changeStatusButtons = document.querySelectorAll('[data-changestatus]');
	const clickHandler = function () {
		document.cookie = "userStatus=" + this.dataset.changestatus;
		window.location.href = "/";
	}

	changeStatusButtons.forEach(function(button) {
		button.addEventListener("click", clickHandler);
	});
}
// App.initMethods.stickyHeader = function () {
// 	$(window).scroll(function(){
// 		if ($(window).scrollTop() >= 300) {
// 			$('nav').addClass('fixed-header');
// 			$('nav div').addClass('visible-title');
// 		}
// 		else {
// 			$('nav').removeClass('fixed-header');
// 			$('nav div').removeClass('visible-title');
// 		}
// 	});

// 	$('.nm__link').click(function(e){
// 		$('.nm__link').removeClass("active");
//     		$(this).addClass("active");

// 		if( !$(this).hasClass('external') ) {
// 			e.preventDefault();

// 			var scrollId = $(this).attr('href');

// 			$('html, body').animate({
// 				scrollTop: $(scrollId).offset().top
// 			}, 1000);
			
// 		}
// 	});
	
// }

App.initMethods.hamburgerMenu = function () {
	let hamburger = $('#hamburger'),
		mainHeader_nav = $('.mh__nav-container'),
		menuOpen = $('.mh__nav_mobile'),

		backdrop = $('.backdrop');

	hamburger.click(function(){
		hamburger.toggleClass('hamburger--open');
		mainHeader_nav.toggleClass('open');
		// menuOpen.slideToggle(1000);
		backdrop.fadeToggle();
	});

	$('.backdrop').on("click", function (event){
		console.log("backdrop clicked");
		$('.backdrop').fadeOut();
		if ($('#hamburger').hasClass('hamburger--open')) {
			console.log('hamburger open');
			$('.mh__nav-container').removeClass('open');
			$('.mh__nav_mobile').fadeOut(1000);
			$('#hamburger').removeClass('hamburger--open');
		}
	});
}

// Expander
App.initMethods.expander = function () {
	$('[data-expander-content]').each(function () {
		if ( $(this).hasClass('open') ) {
			$(this).css('display', 'block');
		} else {
			$(this).hide();
		}
		$(this).addClass('init');
	});

	var clickHandler = function(el) {
		var expanderId = el.attr('data-expander');
		var closeOthers = el.attr('data-expander-close-others');
		var wasOpen = el.hasClass('open');

		if (closeOthers == 'true') {
			$('[data-expander]:not([data-expander="' + expanderId + '"])').removeClass('open');
			$('[data-expander-content]:not([data-expander="' + expanderId + '"])').removeClass('open').slideUp(1000);
		}

		if (!wasOpen) {
			el.addClass('open');
			$('[data-expander-content="' + expanderId + '"]').slideDown(1000, function () {
				App.utilMethods.classOnScroll.checkTargets();
			});
			setTimeout(function(){$('[data-expander-content="' + expanderId + '"]').addClass('open') }, 50);
		} else {
			el.removeClass('open');
			$('[data-expander-content="' + expanderId + '"]').removeClass('open').slideUp(1000);
			console.log($('[data-expander-content="' + expanderId + '"]').find(App.utilVars.classOnScroll.revealClass));
			$('[data-expander-content="' + expanderId + '"]').find(App.utilVars.classOnScroll.revealClass).removeClass(App.utilVars.classOnScroll.revealClass.replace('.', ''));
		}
	}

	$('[data-expander]').click( function() {
		clickHandler($(this));
	});
}

// Class on scroll
App.utilVars.classOnScroll = {
	revealClass: '.revealed',
	targetClass: '.has-scroll-reveal',
	offset: 50,
	delay: 1000,
	revealQueue: [],
	queueActive: false
}
App.initMethods.classOnScroll = function () {
	let { targetClass } = App.utilVars.classOnScroll,
		{ checkTargets } = App.utilMethods.classOnScroll;

	$(targetClass).each(function(index) {
		if ($(this).attr('data-sr-sync')) $('[data-sr-sync="' + $(this).attr('data-sr-sync') + '"]').attr('cos-queue-id', index);
		else $(this).attr('cos-queue-id', index);
	});
    checkTargets();
    $(window).on('scroll', function() { checkTargets() });
}
App.utilMethods.classOnScroll = {
	checkTargets: function() {
		let { revealClass, targetClass, offset, revealQueue } = App.utilVars.classOnScroll,
			trigger = $(window).scrollTop() + $(window).height() - offset,
			triggered = false;

		$(targetClass).each(function() {
			let parentNotClosedExpander = $(this).parents().filter( "[data-expander-content]" ).length ? $(this).parents().filter( "[data-expander-content]" ).hasClass('open') : true;
			if ( $(this).offset().top < trigger && !revealQueue.includes($(this).attr('cos-queue-id')) && !$(this).hasClass(revealClass.replace('.','')) && parentNotClosedExpander) {
				revealQueue.push($(this).attr('cos-queue-id'));
				triggered = true;
			}
		});
		if (triggered) App.utilMethods.classOnScroll.processQueue();
	},
	processQueue: function() {
		let { delay, revealQueue, queueActive } = App.utilVars.classOnScroll;

		if (!queueActive && revealQueue.length) {
			App.utilMethods.classOnScroll.processElement(revealQueue.shift());
			App.utilVars.classOnScroll.revealQueue = revealQueue;
			App.utilVars.classOnScroll.queueActive = true;

			window.setTimeout(function() {
				App.utilVars.classOnScroll.queueActive = false;
				App.utilMethods.classOnScroll.processQueue();
			}, delay);
		}
	},
	processElement: function(id) {
		let { revealClass } = App.utilVars.classOnScroll,
			element = $('[cos-queue-id="' + id + '"]');

		element.addClass( revealClass.replace('.','') );
		element.find('.jquery-show').each(function() { 
			$(this).slideDown(2000, function() { $(this).removeClass('jquery-show') });
		});
	}
}

App.initMethods.tableResponsive = function () {
	let tableAccordionTabs = document.querySelectorAll('.Rtable .Accordion');
	const clickHandler = function () {
		let nextElementSibling = this.nextElementSibling;
		let aria = this.getAttribute("aria-selected");
		if ( aria == "true" ) {
			this.setAttribute("aria-selected", "false");
		} else {
			this.setAttribute("aria-selected", "true");
		}
		do {
			if ( nextElementSibling.nextElementSibling == null ) {
				break
			}
			nextElementSibling.classList.toggle('hidden');
			nextElementSibling = nextElementSibling.nextElementSibling;
		} while ( nextElementSibling.classList.contains("Accordion") === false );
	}

	tableAccordionTabs.forEach(function(button) {
		button.addEventListener("click", clickHandler);
	});
}

// Glossary Tooltips
App.initMethods.glossaryTooltips = function () {
	var glossaryUrl = '/glossary';
	$('.content-blocks').glossarizer({
	    sourceURL: '/glossary-definitions.json',
	    lookupTagName : 'p, ul',
	    caseSensitive : false,
	    replaceOnce   : false,
	    exactMatch: true,
	    callback: function() {
			//Initialize tooltips
	    	$('.glossarizer_replaced')
		    	.tooltip({
		    		boundary: $('main')[0],
		    		trigger: 'manual'
		    	})
		    	.mouseenter( function() {
				    $(this).tooltip('show').attr('data-term-id', camelize( $(this).text() ));
				    $('#' + $(this).attr('aria-describedby'))
					    .mouseleave( function() {
							var _this = $(this);
					    	setTimeout(function () {
							    if (!$('[aria-describedby=' + _this.attr('id') +']').is(':hover') && !_this.is(':hover')) {
							    	$('[aria-describedby=' + _this.attr('id') +']').tooltip('hide');
					            }
				            }, 300)
						})
						.click( function () {
							window.location.href = glossaryUrl + '#glossary-term--' + $('[aria-describedby=' + $(this).attr('id') +']').attr('data-term-id');
						});
				})
				.mouseleave( function() {
					var _this = $(this);
					setTimeout(function () {
			            if (!$('#' + _this.attr('aria-describedby')).is(':hover')) {
				    		_this.tooltip('hide');
			            }
			        }, 300)
				})
	    }
    });
}

window.onload = function() {
	App.init();
};