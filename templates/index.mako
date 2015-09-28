<!DOCTYPE html>
<html>
<head lang="en">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <link rel="shortcut icon" type="image/png" href="/favicon.png"/>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:300,500,700' rel='stylesheet' type='text/css'>
    <meta charset="UTF-8">
    <title>${page_config.get('name','').title()} - Handrewbrozel</title>
    <link rel="stylesheet" href="/css/style.css">
    <script src="http://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="/js/master.js" type="text/javascript"></script>
</head>
<body>
<nav>
    <img src="/assets/gswlogo.svg" class="logo" />
    %for link in config:
        %if link['name'] != "error":
            <a class="${"active" if link['uri']==active_page else ""}" href="${link['uri']}">${link['name']}</a>
        %endif
%endfor
</nav>
<div class="container">
    %if page_config.get('password', UNDEFINED) is UNDEFINED or (page_config.get('password', UNDEFINED) is UNDEFINED and password is UNDEFINED) or password==page_config['password']:
        <div style="max-width: ${page_config.get('max_stream_width', 99999)}px;" class="video-container">
            ${page_config.get('text','')}
            %if active_page == "/":
                <div class="below" style="max-width: ${page_config.get('max_stream_width', 99999)}px;">
                    <ul class="tab-control">
                        <li id="livescores" class="active-tab">Live Scores</li>
                        <li id="teamstats">Team Stats</li>
                    </ul>
                    <div style="padding:5px" data-tab="livescores">
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
            <script id="cid0020000090554645135" data-cfasync="false" async src="//st.chatango.com/js/gz/emb.js" style="width: 350px;height: 700px;">{"handle":"andthefoot","arch":"js","styles":{"a":"1A64B7","b":100,"c":"FBBF16","d":"FBBF16","e":"ffffff","h":"ffffff","l":"cccccc","m":"dadada","p":"9","q":"FBBF16","r":100,"t":0,"usricon":0.61,"sbc":"FBBF16","surl":0,"cnrs":"1"}}</script>
        </div>
        <div class="clear"></div>
    %else:
        <form class="pw_form" action="" method="post">
        Enter password: <input type="password" name="pw_input" id="pw_input"/> <input type="submit" value="GO"/>
        </form>
    %endif
</div>
<footer>
    enjoy our streams? <a href="https://www.twitchalerts.com/donate/handrewbrozel" target="_blank">donate</a> to help us out
</footer>
</body>
</html>