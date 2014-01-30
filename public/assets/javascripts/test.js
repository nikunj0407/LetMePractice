var hours = 2, min = 30, sec = 00;
$(function () {
    $('#counter').text(leftPad(hours, 2) + ':' + leftPad(min, 2) + ':' + leftPad(sec, 2));
    $('#instruction_container').animate({"top": "44px"}, 1000);
    $("#start_test_btn").on('click', function () {
        $('#instruction_panel').fadeOut('slow', function () {
            $('#test_panel').fadeIn('slow', function () {
                setInterval(function () {
                    set_counter()
                }, 1000);
            });
        });
    });
    for (var i = 1; i < 9; i++) {
        $('#q' + i).on('click', function () {
            var div_id = $(this).attr('id')
            $('.active').fadeOut(400,function () {
                $('#' + div_id + '_div').fadeIn(400).addClass('active');
            }).removeClass('active');
        });
    }
});
function set_counter() {
    if (sec == 0) {
        sec = 59;
        min -= 1
    } else
        sec -= 1;

    if (min < 0) {
        min = 59;
        hours -= 1;
    }
    if (hours < 0)
        $(".submit_btn").click();
    else
        $('#counter').text(leftPad(hours, 2) + ':' + leftPad(min, 2) + ':' + leftPad(sec, 2));

    $('#time_taken').val($('#counter').text())

    if(min < 15 && hours < 1)
        $('#counter').css('color', 'orange');
}
function leftPad(number, targetLength) {
    var output = number + '';
    while (output.length < targetLength) {
        output = '0' + output;
    }
    return output;
}