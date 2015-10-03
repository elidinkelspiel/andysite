<!DOCTYPE html>
<html>
<head lang="en">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <link rel="shortcut icon" type="image/png" href="/favicon.png"/>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:300,500,700' rel='stylesheet' type='text/css'>
    <meta charset="UTF-8">
    <title>${page_config.get('name','').title().replace("Vip", "VIP")} - Handrewbrozel</title>
    <link rel="stylesheet" href="/css/style.css">
    <script src="//code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js" type="text/javascript"></script>
    <script src="/js/master.js" type="text/javascript"></script>
</head>
<body>
<%doc><nav>
    <img src="/assets/gswlogo.svg" class="logo" />
    <span class="hand">geoffgeoff</span>
    <div class="desktop-nav">
    %for link in config:
        %if link['name'] != "error":
            <a class="${"active" if link['uri']==active_page else ""}" href="${link['uri']}">${link['name']}</a>
        %endif
    %endfor
    %if len([poll for poll in polls if poll.get('uri', '') is not '' and not poll.get('vip_only', True)]) > 0:
        <a href="/polls">POLLS
            <ul class="polls">
                %for poll in polls:
                %if poll.get('uri', '') is not '' and not poll.get('vip_only', True):
                    <li data-href="/polls${poll['uri']}">${poll['name']}</li>
                %endif
            %endfor
            </ul>
        </a>
    %endif
    </div>
    <span class="mobile-nav">&#9776;</span>
</nav></%doc>
<%include file="/templates/header.mako"/>
<div class="container">
    %if (active_page == "/vip" and vips is not UNDEFINED and username is not None and vips.get(username, None)==password) or ((page_config.get('password', UNDEFINED) is UNDEFINED and password is UNDEFINED) or password==page_config['password']):
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
            %elif active_page == "/vip":
                <div class="below" style="max-width: ${page_config.get('max_stream_width', 99999)}px;">
                    <ul class="tab-control">
                        <li id="polls" class="active-tab">VIP Polls</li>
                        <li id="memes">Dank Memes</li>
                    </ul>
                    <div data-tab="polls" style="padding: 3px;">
                        <%
                        vip_polls = [poll for poll in polls if poll.get('uri', '') is not '' and poll.get('vip_only', True)]
                        %>
                        %if len(vip_polls) > 0:
                            %for poll in vip_polls:
                                <a href="/polls${poll['uri']}" class="poll_link">${poll['name']}</a>
                            %endfor
                        %endif
                    </div>
                    <div data-tab="memes" style="padding: 3px; display:none">
                        <a href="//reddit.com/r/bestofandyschat">/r/bestofandyschat</a> - For all your dank meme needs
                    </div>
                </div>
            %endif
        </div>
        <div class="chat-container">
        %if active_page == "/vip":
            <script id="cid0020000090554645135" data-cfasync="false" async src="//st.chatango.com/js/gz/emb.js" style="width: 350px;height: 700px;">{"handle":"handysprivatechat","arch":"js","styles":{"a":"1A64B7","b":100,"c":"FBBF16","d":"FBBF16","e":"ffffff","h":"ffffff","l":"cccccc","m":"dadada","p":"9","q":"FBBF16","r":100,"t":0,"usricon":0.61,"sbc":"FBBF16","surl":0}}</script>
        %else:
            <script id="cid0020000090554645135" data-cfasync="false" async src="//st.chatango.com/js/gz/emb.js" style="width: 350px;height: 700px;">{"handle":"andthefoot","arch":"js","styles":{"a":"1A64B7","b":100,"c":"FBBF16","d":"FBBF16","e":"ffffff","h":"ffffff","l":"cccccc","m":"dadada","p":"9","q":"FBBF16","r":100,"t":0,"usricon":0.61,"sbc":"FBBF16","surl":0}}</script>
        %endif
        </div>
        <div class="clear"></div>
    %else:
        <form style="padding: 0 20px;" class="pw_form" action="" method="post">
        %if active_page == "/vip":
            Username: <br> <input type="text" name="pw_user" id="pw_user"/><br/><br>
        %endif
            Password: <br> <input type="password" name="pw_input" id="pw_input"/><br/><br>
            <input type="submit" style="font-size: 1.5em;" value="GO"/><br/>
        %if active_page == "/vip":
            <br/>
                <span style="font-weight: 500">
            VIPs vote on the music and games they want to see, and have access to a top secret VIP lounge. <a
                href="https://www.twitchalerts.com/donate/handrewbrozel" target="_blank">Make a donation</a> to support us and gain access to this elite club.
            </span>
        %endif
        </form>
    %endif
</div>
<footer>
    enjoy our streams? <a href="https://www.twitchalerts.com/donate/handrewbrozel" target="_blank">donate</a> to help us out and become a <a href="/vip">vip</a>!
</footer>
</body>
</html>