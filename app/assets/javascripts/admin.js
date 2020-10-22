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
//= require activestorage
//= require jquery3
//= require jquery-ui
//= require popper
//= require bootstrap
//= require summernote/summernote-bs4.min
//= require jquery.slugger
//= require jquery.nestedSortable.js
//= require sortable_tree.js
//= require select2.min
//= require cropper
//= require jquery.cropper
//= require cocoon
//= require arrive.min

$(function() {
  $("#page_menu_title").slugger({ slugInput: $("#page_slug") });
  $("#news_item_title").slugger({ slugInput: $("#news_item_slug") });
  $("#award_name").slugger({ slugInput: $("#award_slug") });
  $("#meeting_title").slugger({ slugInput: $("#meeting_slug") });

  $(document).arrive("[data-provider='summernote']", function() {
    $(this).summernote({
      height: 150,
      toolbar:[
        ['style',['style']],
        ['font',['bold','italic','underline','clear']],
        ['para',['ul','ol','paragraph']],
        ['height',['height']],
        ['table',['table']],
        ['insert',['media','picture','link','hr']],
        ['view',['fullscreen','codeview']],
        ['help',['help']]
      ]
    });
  });

  $('[data-provider="summernote"]').each(function() {
    $(this).summernote({
      height: 300,
      toolbar:[
        ['style',['style']],
        ['font',['bold','italic','underline','clear']],
        ['para',['ul','ol','paragraph']],
        ['height',['height']],
        ['table',['table']],
        ['insert',['media','picture','link','hr']],
        ['view',['fullscreen','codeview']],
        ['help',['help']]
      ]
    })
  });

  $('.markdown-area').each(function() {
    var simplemde = new SimpleMDE({
        element: this,
    });
    simplemde.render(); 
  });

  var hash = window.location.hash;
  hash && $('ul.nav-tabs a[href="' + hash + '"]').tab('show');

  $(".sortable").sortable({
    handle: ".handle",
    placeholder: "sortable-placeholder",
    stop: function( event, ui ) {
      var parentNode = ui.item[0].parentNode;
      var klass = $(parentNode).data('klass');
      var url = $(parentNode).data('url');
      var ids_in_order = $(parentNode).sortable('toArray');

      $.post(url, {
        klass: klass, ids: ids_in_order
      });
    }
  });

  // Acts as taggable
  $(".taggable").select2({
    tags: true
  });

  // always pass csrf tokens on ajax calls
  $.ajaxSetup({
    headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
  });

  // New product resource
  if ($('.resource-list').length > 0) {
    $('form.new_resource_product').hide();

    $('.resource-list li').each(function() {
      $(this).on('click', function() {
        var image = new Image(500);
        image.src = $(this).data('resource-url');

        $('.resource-placeholder').html(image);
        $('#resource_product_resource_id').val($(this).data('resource-id'));

        $('form.new_resource_product').show();
      });
    });
  }
});
