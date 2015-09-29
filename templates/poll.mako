<!DOCTYPE html>
<html>
<head lang="en">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <link rel="shortcut icon" type="image/png" href="/favicon.png"/>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:300,500,700' rel='stylesheet' type='text/css'>
    <meta charset="UTF-8">
    <title>${poll['name'].title()} - Handrewbrozel</title>
    <link rel="stylesheet" href="/css/style.css">
    <script src="http://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="/js/master.js" type="text/javascript"></script>
    <script type="text/javascript">
        max_poll_opts = ${poll['max_opts']}
        try {
            max_vote = ${max([opt['votes'] for opt in poll['options']])} } catch (e) {
        }
    </script>
</head>
<body>
<nav>
    <img src="/assets/gswlogo.svg" class="logo"/>
    %for link in config:
        %if link['name'] != "error":
            <a class="${"active" if link['uri']==active_page else ""}" href="${link['uri']}">${link['name']}</a>
        %endif
    %endfor
    %if len([poll_ for poll_ in polls if poll_.get('uri', '') is not '' and not poll_.get('vip_only', True)]) > 0:
        <a href="/polls">POLLS
            <ul class="polls">
                %for poll_ in polls:
                    %if poll_.get('uri', '') is not '' and not poll_.get('vip_only', True):
                        <li data-href="/polls${poll_['uri']}">${poll_['name']}</li>
                    %endif
                %endfor
            </ul>
        </a>
    %endif
</nav>
<div class="container pw_form">
    <%doc>%if page_config.get('password', UNDEFINED) is UNDEFINED or (page_config.get('password', UNDEFINED) is UNDEFINED and password is UNDEFINED) or password==page_config['password']:
        <div style="max-width: ${page_config.get('max_stream_width', 99999)}px;" class="video-container">
            ${page_config.get('text','')}
            %if active_page == "/":
                <div class="below" style="max-width: ${page_config.get('max_stream_width', 99999)}px;">
                    <ul class="tab-control">
                        <li id="livescores" class="active-tab">Live Scores</li>
                        <li id="teamstats">Team Stats</li>
                    </ul>
                    <div style="padding:5px; height: auto" data-tab="livescores">
                        GSW 100 - LAC 0
                    </div>
                    <div data-tab="teamstats" style="display:none">
                    <script type="text/javascript"
                            src="http://widgets.sports-reference.com/wg.fcgi?css=1&site=bbr&url=%2Fteams%2FGSW%2F2015.html&div=div_totals"></script>
                    </div>
                </div>
            %endif
        </div>
        <div class="chat-container">
            <script id="cid0020000090554645135" data-cfasync="false" async src="//st.chatango.com/js/gz/emb.js" style="width: 350px;height: 700px;">{"handle":"andthefoot","arch":"js","styles":{"a":"1A64B7","b":100,"c":"FBBF16","d":"FBBF16","e":"ffffff","h":"ffffff","l":"cccccc","m":"dadada","p":"9","q":"FBBF16","r":100,"t":0,"usricon":0.61,"sbc":"FBBF16","surl":0}}</script>
        </div>
        <div class="clear"></div>
    %else:
        <form style="padding: 0 20px;" class="pw_form" action="" method="post">
        Enter password: <input type="password" name="pw_input" id="pw_input"/> <input type="submit" value="GO"/><br/>
        %if active_page == "/vip":
            <br/>
                <span style="font-weight: 500">
            VIPs can vote on the music and games they want to see, and have access to a top secret VIP lounge. Join the elite club by <a
                href="https://www.twitchalerts.com/donate/handrewbrozel" target="_blank">making a donation</a>.
            </span>
        %endif
        </form>
    %endif</%doc>
    <h1>${poll['name'].title()}</h1>

    %if poll['vip_only'] and (password is UNDEFINED or username is UNDEFINED or vips.get(username, None) != password):
        <span style="font-weight: 500;">This poll is VIP only. Please log in to access it.</span>
        <br><br>

        <form action="" method="post">
            Username: <br> <input type="text" name="pw_user" id="pw_user"/><br/><br>
            Password: <br> <input type="password" name="pw_input" id="pw_input"/><br/><br>
            <input type="submit" style="font-size: 1.5em;" value="GO"/><br/>
        </form>
    %else:
        %if not voted:
            <ul class="poll-list">
                %for opt in poll['options']:
                    <li>${opt['name']}</li>
                %endfor
            </ul>
            <br/>

            <div id="make-vote" class="admin-action" style="font-size: 1.5em;">VOTE</div>
        %else:
            <div class="vote-results">
                %for opt in sorted(poll['options'], key=lambda k: (-k['votes'], k['name'])):
                    <div data-votes="${opt['votes']}" title="${opt['name']}">${opt['name']}</div>
                    <div class="opt-votes">${opt['votes']}</div>
                    <br>
                %endfor
            </div>
        %endif
    %endif

</div>
<footer>
    enjoy our streams? <a href="https://www.twitchalerts.com/donate/handrewbrozel" target="_blank">donate</a> to help us
    out and become a <a href="/vip">vip</a>!
</footer>
</body>
</html>