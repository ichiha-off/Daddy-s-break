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
  $("#login-images").skippr({
    // スライドショーの変化 ("fade" or "slide")
    transition : 'slide',
    // 変化に係る時間(ミリ秒)
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形("block" or "bubble")
    navType : "block",
    // 子要素の種類("div" or "img")
    childrenElementType : 'div',
    // ナビゲーション矢印の表示(trueで表示)
    arrows : true,
    // スライドショーの自動再生(falseで自動再生なし)
    autoPlay : true,
    // 自動再生時のスライド切替間隔(ミリ秒)
    autoPlayDuration : 3000,
    // キーボードの矢印キーによるスライド送りの設定(trueで有効)
    keyboardOnAlways : false,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
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