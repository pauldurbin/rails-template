// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap
//= require jquery.ihavecookies.min
//= require jquery-ui
//= require owl.carousel

$(function() {
  $('body').ihavecookies({
    title: "Cookies & Privacy",
    message: "This website uses cookies to ensure you get the best experience on our website.",
    link: "/privacy-policy",
    delay: 600,
    cookieTypes: [
      {
        type: 'Analytics',
        value: 'analytics',
        description: 'Cookies related to site visits, browser types, etc.'
      }
    ]
  });

  // $('.navbar .dropdown > a').click(function() {
  //   location.href = this.href;
  // });

  $('[data-url]').addClass('clickable').on('click', function() {
    window.location = $(this).data('url');
  })

  $('[data-modal-url]').on('click', function() {
    $('.modal .modal-header .modal-title').hide();
    $('.modal .modal-body').load($(this).data('modal-url') + ' #content').addClass('text-center');
    $('.modal-placeholder').modal({ backdrop: 'static' });
  });

  $('*[data-modal="true"]').on('click', function(e) {
    e.preventDefault();
    var img = new Image;
    img.src = $(this).attr('data-image');
    img.className = 'img-fluid';

    $('.modal .modal-header .modal-title').html($(this).attr('data-title'));
    $('.modal .modal-body').html(img);
    $('.modal-placeholder').modal({ backdrop: 'static', keyboard: true });
  });

  $('[data-toggle="tooltip"]').tooltip();

  $('.btn-choose').bind('ajax:beforeSend', function() {
    $(this).closest('.content').addClass('loading');
  });

  $('.owl-carousel').owlCarousel({
    loop: true,
    margin: 15,
    nav: false,
    dots: false,
    autoplay: true,
    autoplayHoverPause: true,
    responsiveClass:true,
    responsive:{
      0:{
        items:3,
        nav: false
      },
      720:{
        items:4,
        nav: false
      },
      992:{
        items:6,
        nav: true,
        loop: false
      }
    }
  });
});