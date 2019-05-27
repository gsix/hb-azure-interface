$(document).ready(function(){
  $('.toggle-wrapper > .toggler').on('click', function(e) {
    wrp = $(e.target).closest('.toggle-wrapper');
    cnt = wrp.find('.toggle-content');
    cnt.toggleClass('opened');
  });

  $('.tooltiped').mouseenter(function(e) {
    $elm = $(e.target)
    otop = $elm.offset().top - $elm.height() - 20
    oleft = $elm.offset().left
    text = $elm.data('tooltip')

    $(document.body).append('<div id="tooltip" style="top:' + otop + 'px;left:' + oleft + 'px">' + text + '</div>')
  })

  $('.tooltiped').mouseleave(function(e) {
    $('#tooltip').remove()
  })
})
