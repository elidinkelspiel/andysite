<!DOCTYPE html>
<html>
<head lang="en">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <link rel="shortcut icon" type="image/png" href="/favicon.png"/>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:300,500,700' rel='stylesheet' type='text/css'>
    <meta charset="UTF-8">
    <title>Top Sikrit Admin Config</title>
    <link rel="stylesheet" href="/css/style.css">
    <script src="http://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="/js/master.js" type="text/javascript"></script>
</head>
<body>
<nav>
    <img src="/assets/gswlogo.svg" class="logo"/>
    %for link in config:
        %if link['name'] != "error":
            <a class="${"active" if link['uri']==active_page else ""}" href="${link['uri']}">${link['name']}</a>
        %endif
    %endfor
</nav>
<div class="container pw_form">
    %if password is not UNDEFINED and password == "ayylmaomemes":
        <div class="admin-action" id="save-link-items"
             style="font-size: 1.5em;color: #FBBF16;border: 2px solid #FBBF16;background-color: #1A64B7;">SAVE
        </div>
        <br/>
    %for link in config:
        <div class="link-item">
            % if link['uri'] != "/":
                <span>DELETE</span>
            % endif
            Page Title: <input type="text" data-key="name" value="${link['name']}"/><br/>
            Page URL: <input type="text" data-key="uri" value="${link['uri']}"/><br/>
            Page password: <input type="text" data-key="password" value="${link.get('password','')}"/> (leave blank for no
            password)<br/>
            Maximum Video Width: <input type="number" data-key="max_stream_width"
                                        value="${link.get('max_stream_width','')}"/> (leave blank for unlimited)
            <br/>
            Page Embed Code / Text:<br/>
            <textarea data-key="text" style="width:100%; height: 100px">${link['text']}</textarea>
        </div>
        <br/>
    %endfor
        <div class="admin-action" id="new-link-item">+</div>
    %else:
        <form action="" method="post">
            Enter password: <input type="password" name="pw_input" id="pw_input"/> <input type="submit" value="GO"/>
        </form>
    %endif
</div>
</body>
</html>