$(document).ready(function () {
    resizeFunc = function(){
        var h;
        if ($(window).width() > 800) {
            $('.chat-container iframe').css('height', $(window).height() - 125);
            h = $(window).height() - 125;
            $('.container').css('margin-left', Math.max(0, ($(window).width() - $('.video-container').width() - $('.chat-container').width() - 50) / 2))
        } else {
            h = $(window).height() - 115;
            $('.chat-container iframe').css('height', $(window).height() - 115)
        }
        var hv = $('.video-container iframe').css('height');
        hv = parseInt(hv.substr(0, hv.length - 2));
        var hc = $('.chat-container iframe').css('height');
        hc = parseInt(hc.substr(0, hc.length - 2));
        var th = $('table.sortable').css('height');
        th = parseInt(th.substr(0, th.length - 2)) + 50;
        if (th == 50) {
            th = 99999;
        }
        if (hv > hc) {
            $('.below').css({"max-height": th, height: "100%", width: "calc(100vw - 40px)"})
        } else {
            $('.below').css({"max-height": th, height: (hc-hv-10), width: $('.video-container iframe').css('width')})
        }
    };
    setTimeout(function(){
        resizeFunc()
    }, 1000);
    $('iframe').load(function () {
        resizeFunc()
    });
    $('.logo').click(function () {
        location.href = "/"
    });
    $('.tab-control li').click(function(){
        $('.tab-control li').removeClass('active-tab');
        $(this).addClass('active-tab');
        $('.below div[data-tab]').fadeOut();
        $('.below div[data-tab="'+$(this).attr('id')+'"]').fadeIn(400, function() {
            $(window).resize();
        });
    });
    $('#new-link-item').click(function () {
        var str = $('.link-item').last()[0].outerHTML + '<br/>';
        $('.link-item').last().next().after(str);
        var el = $('.link-item').last();
        el.find('input').val('');
        el.find('textarea').val('');
    });
    $('#save-link-items').click(function () {
        var items = [];
        var flag = true;
        $('.link-item').each(function (i) {
            console.log(i);
            var obj = {};
            var t = $(this);
            var inputs = t.find('[data-key]');
            var name = t.find('[data-key="name"]').val().trim();
            var uri = t.find('[data-key="uri"]').val().trim();
            if (name == "" || uri == "") {
                alert('Cmon Andy. You left the name or URL blank in item #' + (i + 1))
                flag = false;
                return false;
            }
            inputs.each(function () {
                if ($(this).val() != "")
                    obj[$(this).attr('data-key')] = $(this).val().trim()
            });
            items.push(obj)
        });
        if (flag) {
            $.post("/admin", {"config": JSON.stringify(items)}, function (data) {
                if (data == "success") {
                    if (confirm("Configuration updated successfully.  Click OK to reload")) {
                        location.reload()
                    }
                }

            });
        }
    });
    $('.link-item span').click(function () {
        var br = $(this).parents().eq(0).next();
        $(this).parents().eq(0).remove();
        br.remove();
    });
    //youtube autodimension
    // Find all YouTube videos
    var $allVideos = $("iframe[src*='//www.youtube.com']"),

    // The element that is fluid width
        $fluidEl = $(".video-container");

// Figure out and save aspect ratio for each video
    $allVideos.each(function () {

        $(this)
            .data('aspectRatio', this.height / this.width)

            // and remove the hard coded width/height
            .removeAttr('height')
            .removeAttr('width');

    });

// When the window is resized
    $(window).resize(function () {
        $('.container').css('margin-left', 0);

        var newWidth = $fluidEl.width();

        // Resize all videos according to their own aspect ratio
        $allVideos.each(function () {

            var $el = $(this);
            $el
                .width(newWidth)
                .height(newWidth * $el.data('aspectRatio'));

        });

        resizeFunc()

// Kick off one resize to fix all videos on page load
    }).resize();
});
