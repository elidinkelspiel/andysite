if (!String.prototype.format) {
    String.prototype.format = function () {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function (match, number) {
            return typeof args[number] != 'undefined'
                ? args[number]
                : match
                ;
        });
    };
}
team_abbr = {
    'Atlanta': 'ATL',
    'Brooklyn': 'BKN',
    'Boston': 'BOS',
    'Charlotte': 'CHA',
    'Chicago': 'CHI',
    'Cleveland': 'CLE',
    'Dallas': 'DAL',
    'Denver': 'DEN',
    'Detroit': 'DET',
    'Golden State': 'GSW',
    'Houston': 'HOU',
    'Indiana': 'IND',
    'LA Clippers': 'LAC',
    'LA Lakers': 'LAL',
    'Memphis': 'MEM',
    'Miami': 'MIA',
    'Milwaukee': 'MIL',
    'Minnesota': 'MIN',
    'New Orleans': 'NOP',
    'New York': 'NYK',
    'Oklahoma City': 'OKC',
    'Orlando': 'ORL',
    'Philadelphia': 'PHI',
    'Phoenix': 'PHX',
    'Portland': 'POR',
    'Sacramento': 'SAC',
    'San Antonio': 'SAS',
    'Toronto': 'TOR',
    'Utah': 'UTA',
    'Washington': 'WAS',
    'Fenerbahce Ulker': 'FBU',
    'Milan': 'MLN'
};
$(document).ready(function () {
    $('body').on('click', 'div.score i.fa-ellipsis-h', function (e) {
        var html = $(this).parents('div.score').find('div[class^="score-dts"]').html();
        if ($(window).width() > 600) {
            var x = e.clientX;
            var y = e.clientY + window.scrollY;
            var i = $(this).parents('div.score').find('div[class^="score-dts"]').attr('class').split('-')[2];
            var same = i == $('div.score-deets').attr('data-score');
            if (same) {
                $('div.score-deets').attr('data-score', "").fadeOut();
            } else {
                $('div.score-deets').html(html).attr('data-score', i).css({
                    'left': x + "px",
                    'top': y + 10 + "px"
                }).fadeIn();
            }
        } else {
            var re = /<br>(.*)<br>(.*)<br>/g;
            var match = re.exec(html);
            html = match[1] + "\n" + match[2];
            swal({
                title: "Top Performers",
                text: html,
                confirmButtonText: "Close"
            });
        }
    }).on('click', 'div.score-deets i.fa-times', function (e) {
        $('div.score-deets').attr('data-score', "").fadeOut();
    });
    updateLiveStats = function () {
        $.get('/livescores', function (data) {
            var data = unescape(data).split("nba_s_left");
            data.shift();
            var html = "";
            var score = "<div class='score'>{0}<i class='fa fa-ellipsis-h'></i></div>";
            var match;
            var re;
            for (var i = 0; i < data.length; i++) {
                re = /\d*?=(?:([\^a-zA-Z\s]*)(\d*)\s*([\^a-zA-Z\s]*)(\d*)\s*\((.*)\).*?=(.*?)&.*?=(.*?)&.*)?(?:([\^a-zA-Z\s]*) at ([\^a-zA-Z\s]*).*\((.*)\))?.*url.*?=(.*)/g;
                match = re.exec(data[i]);
                match.shift();
                console.log('match {0} - {1}'.format(i, match));
                if (match[0] != "" && match[0] != null && match[0] != undefined) { //ongoing game
                    match[0] = "<b {1}>{0}</b>".format(team_abbr[match[0].trim().replace(/\^/g, '')], match[0].indexOf("^") > -1 ? "class='winner'" : ""); //team 1
                    match[1] = match[1].trim() + "<br/>"; //score 1
                    match[2] = "<b {1}>{0}</b>".format(team_abbr[match[2].trim().replace(/\^/g, '')], match[2].indexOf("^") > -1 ? "class='winner'" : ""); //team 2
                    match[3] = match[3].trim() + "<br/>"; //score 2
                    match[4] = match[4].trim() + "<br/>"; //time
                    match[5] = "<div class='score-dts-{0}'><i class='fa fa-times'></i><b>Top Performers</b><br/>".format(i) + match[5].trim() + "<br/>"; //player1
                    match[6] = match[6].trim() + "<br/>"; //player2
                    match[10] = "</div><a target='_blank' class='score-link' href='{0}'><i class='fa fa-link'></i></a>".format(match[10].replace('/preview?', '/boxscore?')); //url
                } else { //future game
                    match[7] = "<b>{0}</b>".format(team_abbr[match[7].trim().replace(/\^/g, '')]) + "<br/>"; //team1
                    match[8] = "<b>{0}</b>".format(team_abbr[match[8].trim().replace(/\^/g, '')]) + "<br/>"; //team2
                    match[9] = match[9].trim() + "<br/>"; //time
                    match[10] = "<a target='_blank' class='score-link' href='{0}'><i class='fa fa-link'></i></a>".format(match[10].replace('/preview?', '/boxscore?')); //url
                }
                html += score.format(match.join(' '));
            }
            $('div[data-tab="livescores"]').html(html);
        })
    }
    voteResults = function () {
        $('.vote-results div[data-votes]').each(function () {
            //var bw = 50;
            var v = parseInt($(this).attr('data-votes'));
            var f = v / max_vote;
            var maxw = $(this).css('max-width');
            if (maxw == "100%") {
                maxw = $('.container').width() - 40;
            } else {
                maxw = parseInt(maxw.replace(/[%a-zA-Z]/g, ''));
            }
            var minw = $(this).css('min-width');
            minw = parseInt(minw.replace(/[%a-zA-Z]/g, ''));
            var w = (maxw - minw) * f;
            /*var ow = $(this).css('width');
             ow = parseInt(ow.replace(/[%a-zA-Z]/g, ''));*/
            var nw = minw + w;
            //console.log(nw);
            $(this).css('width', nw);
        });
    }
    resizeFunc = function () {
        var h;
        if ($(window).width() > 800) {
            $('.chat-container iframe').css('height', $(window).height() - 125);
            h = $(window).height() - 125;
            $('.container').css('margin-left', Math.max(0, ($(window).width() - $('.video-container').width() - $('.chat-container').width() - 50) / 2))
            try {
                var hv = $('.video-container iframe').css('height');
                hv = parseInt(hv.substr(0, hv.length - 2));
                var hc = $('.chat-container iframe').css('height');
                hc = parseInt(hc.substr(0, hc.length - 2));
                var th = $('table.sortable').css('height');
                if (th === undefined) {
                    th =  "0px";
                }
                th = parseInt(th.substr(0, th.length - 2)) + 50;
                if (th == 50) {
                    th = 99999;
                }
                if ((hv + 150) > hc) {
                    $('.below').css({"max-height": th, height: "100%", width: "calc(100vw - 60px)"})
                    $('.chat-container iframe').css('height', hv);
                    $('.below').css({
                        width: $('.video-container iframe').css('width')
                    })
                } else {
                    $('.below').css({
                        "max-height": th,
                        height: (hc - hv - 10),
                        width: $('.video-container iframe').css('width')
                    })
                }
            } catch (e) {

            }
        } else {
            h = $(window).height() - 115;
            $('.chat-container iframe').css('height', $(window).height() - 115);
            $('.below').css('height', 'auto').css('width', '100%');
        }
        voteResults();
    };
    setTimeout(function () {
        resizeFunc()
    }, 1000);
    if (location.pathname == "/") {
        $('.below td').each(function () {
            if ($(this).html() == "") {
                $(this).html("-")
            }
        });
        updateLiveStats();
        setInterval(function () {
            updateLiveStats()
        }, 60000);
    }
    $('iframe').load(function () {
        resizeFunc();
        $('.below td').each(function () {
            if ($(this).html() == "") {
                $(this).html("-")
            }
        });
    });
    $('.logo, .hand').click(function () {
        location.href = "/"
    });
    $('.tab-control li').click(function () {
        $('.tab-control li').removeClass('active-tab');
        $(this).addClass('active-tab');
        $('div[data-tab]').fadeOut();
        $('div[data-tab="' + $(this).attr('id') + '"]').fadeIn(400, function () {
            $(window).resize();
        });
    });
    $('span.mobile-nav').click(function () {
        $('nav a').slideToggle();
    });
    $('#new-link-item').click(function () {
        var lli = $('#new-link-item').parents('.admin-tab').find('.link-item').last();
        var str = lli[0].outerHTML;
        lli.parent().append(str);
        lli = $('#new-link-item').parents('.admin-tab').find('.link-item').last();
        lli.find('input').val('');
        lli.find('textarea').val('');
    });
    $('#new-vip').click(function () {
        $('.vip-item').last().after('<div class="vip-item"><input type="text" data-key="username" placeholder="Username"> <input type="text" data-key="password" placeholder="Password"> <span class="vip-del">(DELETE)</span></div>')
    });
    $('#new-poll-item').click(function () {
        var lli = $('#new-poll-item').parents('.admin-tab').find('.link-item').last();
        var str = lli[0].outerHTML;
        lli.parent().append(str);
        var el = $('#new-poll-item').parents('.admin-tab').find('.link-item').last();
        el.find('input').val('');
        el.find('textarea').val('');
        $('[data-tab="polls"] [data-key="version"]').last().change();
    });
    $('#save-link-items').click(function () {
        var items = [];
        var flag = true;
        $('[data-tab="pages"] .link-item').each(function (i) {
            console.log(i);
            var obj = {};
            var t = $(this);
            var inputs = t.find('[data-key]');
            var name = t.find('[data-key="name"]').val().trim();
            var uri = t.find('[data-key="uri"]').val().trim();
            if (name == "" || uri == "") {
                alert('Cmon Andy. You left the name or URL blank in item #' + (i + 1));
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
    $('#save-vips').click(function () {
        var vips = {};
        var flag = true;
        $('.vip-list .vip-item').each(function (i) {
            var un = $(this).find('input[data-key="username"]').val().trim();
            var pw = $(this).find('input[data-key="password"]').val().trim();
            if (un == "" || pw == "") {
                alert('Cmon Andy. You left the username or password blank in item #' + (i + 1));
                flag = false;
                return false;
            }
            vips[un] = pw;
        });
        if (flag) {
            $.post("/admin", {"vips": JSON.stringify(vips)}, function (data) {
                if (data == "success") {
                    if (confirm("Configuration updated successfully.  Click OK to reload")) {
                        location.reload()
                    }
                }

            });
        }
    });
    $('#save-poll-items').click(function () {
        var items = [];
        var flag = true;
        $('[data-tab="polls"] .link-item').each(function (i) {
            console.log(i);
            var obj = {};
            var t = $(this);
            var inputs = t.find('[data-key]');
            var name = t.find('[data-key="name"]').val().trim();
            if (name == "") {
                alert('Cmon Andy. You left the name blank in item #' + (i + 1));
                flag = false;
                return false;
            }
            inputs.each(function () {
                if ($(this).is('input')) {
                    if ($(this).is('[type="checkbox"]')) {
                        obj[$(this).attr('data-key')] = $(this).prop('checked')
                    }
                    else if ($(this).val() != "") {
                        obj[$(this).attr('data-key')] = $(this).val().trim()
                    }
                } else { //options div
                    obj[$(this).attr('data-key')] = [];
                    var dk = $(this).attr('data-key'); // == "options"
                    $(this).find('input').each(function () {
                        if ($(this).val() != '') {
                            obj[dk].push({
                                'name': $(this).val(),
                                'votes': parseInt($(this).next().next().find('label').text())
                            });
                        }
                    });
                    if (obj[$(this).attr('data-key')].length == 0) {
                        alert('Cmon Andy. You didn\'t add any options in item #' + (i + 1));
                        flag = false;
                        return false;
                    }
                }
            });
            items.push(obj)
        });
        if (flag) {
            $.post("/admin", {"polls": JSON.stringify(items)}, function (data) {
                if (data == "success") {
                    if (confirm("Polls updated successfully.  Click OK to reload")) {
                        location.reload()
                    }
                }

            });
        }
    });
    $('ul.polls li').hover(function (e) {
        //e.preventDefault();
        //location.assign($(this).attr('data-href'));
        $('a.polls-link').attr('href', $(this).attr('data-href'));
    });
    $('a.polls-link').click(function (e) {
        if ($(e.target).is('a')) {
            e.preventDefault();
            return false;
        }
    });
    $('#make-vote').click(function () {
        var res = [];
        var flag = true;
        var active = $('.poll-list li.active');
        if (active.length > 0) {
            active.each(function () {
                res.push($(this).text())
            })
        } else {
            alert('Please select at least one option.');
            flag = false;
            return false;
        }
        if (flag) {
            $.post("", {"vote": JSON.stringify(res)}, function (data) {
                location.reload()
            });
        }
    });
    $('.poll-list li').click(function () {
        $(this).toggleClass('active');
        if ($('.poll-list li.active').length > max_poll_opts) {
            $('.poll-list li.active').not(this).first().removeClass('active')
        }
        //$('.poll-list li').removeClass('active');
    });
    $('body').on('input change propertychange', '[data-tab="polls"] [data-key="version"]', function () {
        $(this).parents('.link-item').find('label').text(0)
    });
    $('body').on('click', '.add-poll-option', function () {
        $(this).before('<input/> <b class="remove-poll-option" style="cursor: pointer;">X</b><span> - <label>0</label> votes</span><br>');
        $(this).prev().prev().prev().prev().focus();
    }).on('click', '.remove-poll-option', function () {
        $(this).prev().remove();
        $(this).next().remove();
        $(this).next().remove();
        $(this).remove();
    }).on('click', '.link-item span.delete', function () {
        if ($(this).parents('.admin-tab').children('.link-item').length == 1) {
            $(this).parents('.admin-tab').find('.admin-action[id^="new"]').click()
        }
        $(this).parents().eq(0).remove();
    }).on('click', "span.vip-del", function () {
        $(this).parent().remove();
        if ($('.vip-item').length == 0) {
            $('.vip-list').append('<div class="vip-item"><input type="text" data-key="username" placeholder="Username"> <input type="text" data-key="password" placeholder="Password"> <span class="vip-del">(DELETE)</span></div>');
        }
    });
    $('.admin-options').sortable();
    //youtube autodimension
    // Find all YouTube videos
    var $allVideos = $(".video-container iframe"),

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

        resizeFunc();

// Kick off one resize to fix all videos on page load
    }).resize();
});
