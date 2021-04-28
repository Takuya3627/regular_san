$(function() {
    var topBtn = $('#top-btn a');
    topBtn.hide();
    $(window).scroll(function(){
         if ($(this).scrollTop() > 100) {
             topBtn.fadeIn(1000);
         } else {
             topBtn.fadeOut();
         }
    });
    topBtn.click(function () {
        $('body, html').animate({
      scrollTop:0
    }, 1000);
    event.preventDefault();
  });
});