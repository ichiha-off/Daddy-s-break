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
//= require jquery 
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

// ヘッダー部分のアニメーション
$(document).on('turbolinks:load', function() {
  var _window = $(window),
    _header = $('.scroll_header');
    _header.hide();
  _window.on('scroll',function(){
    if (_window.scrollTop() > 300) {
      _header.addClass('fixed');
      _header.slideDown();
      }
    else {
      _header.slideUp();
      }
  });
});

// login画面
$(document).on('turbolinks:load',function () {
  $("#devise-images").skippr({
    transition : 'slide',
    speed : 1000,
    easing : 'easeOutQuart',
    navType : "block",
    childrenElementType : 'div',
    arrows : true,
    autoPlay : true,
    autoPlayDuration : 3000,
    keyboardOnAlways : false,
    hidePrevious : false
  });
});
 
// 画像プレビュー機能
$(document).on('turbolinks:load',function(){
  $('#comment_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(".image_preview").attr('src', e.target.result);
      $(".image_preview").attr('style', 'width: 100px; height: 100px; margin: 15px;');
    }
    reader.readAsDataURL(e.target.files[0]);
  });
  $('#user_profile_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(".image_preview").attr('src', e.target.result);
      $(".image_preview").attr('style', 'width: 200px; height: 200px;');
    }
    reader.readAsDataURL(e.target.files[0]);
  });
  $('#reply_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(".image_preview").attr('src', e.target.result);
      $(".image_preview").attr('style', 'width: 100px; height: 100px; margin: 15px;');
    }
    reader.readAsDataURL(e.target.files[0]);
  });
  $('#topic_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(".image").attr('src', e.target.result);
      $(".image").attr('style');
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});

// TOP画面へボタン
$(document).on('turbolinks:load', function() {
  var pagetop = $('#page_top');
  pagetop.hide();
  $(window).scroll(function () {
      if ($(this).scrollTop() > 200) {  //200pxスクロールしたら表示
          pagetop.fadeIn();
      } else {
          pagetop.fadeOut();
      }
  });
  pagetop.click(function () {
      $('body,html').animate({
          scrollTop: 0
      }, 500); //0.5秒かけてトップへ移動
      return false;
  });
});

$(document).on('turbolinks:load', function () {
  var navpagetop = $('.nav_page_top');
  navpagetop.click(function () {
    $('body,html').animate({
      scrollTop: 0
    }, 500); //0.5秒かけてトップへ移動
    return false;
  });
});

// 検索バーのアニメーション
$('.search-input').focus(function(){
  $(this).parent().addClass('focus');
}).blur(function(){
  $(this).parent().removeClass('focus');
})

// aboutページのアニメーション
$(window).scroll(function() {
  var windowH = $(window).height(),
  scrollY = $(window).scrollTop();
  
  $('.about-section-image').each(function() {
    var elPosition = $(this).offset().top;
    if (scrollY > elPosition - windowH) {
      $(this).addClass("scroll-fade-image");
    }
  });

  $('.about-section-text').each(function () {
    var elPosition = $(this).offset().top;
    if (scrollY > elPosition - windowH) {
      $(this).addClass("scroll-fade-text");
    }
  });

});