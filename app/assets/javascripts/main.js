$(document).ready(function(){
  $('.toggle-wrapper > .toggler').on('click', function(e) {
    wrp = $(e.target).closest('.toggle-wrapper');
    cnt = wrp.find('.toggle-content');
    cnt.toggleClass('opened');
  })
})
