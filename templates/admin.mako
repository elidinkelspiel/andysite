<!DOCTYPE html>
<html>
<head lang="en">
    <title>Top Sikrit Admin Config</title>
    <%include file="/templates/head_tags.mako"/>
</head>
<body>
    <%include file="/templates/header.mako"/>
<div class="container pw_form">
    %if password is not UNDEFINED and password == "ayylmaomemes":
        <ul class="tab-control">
            <li id="pages" class="active-tab">Pages</li>
            <li id="polls">Polls</li>
            <li id="vips">VIPs</li>
        </ul>
        <div class="admin-tab" data-tab="vips" style="display: none;">
            Manage VIP usernames and passwords.<br/><br>

            <div class="admin-action" id="save-vips"
                 style="font-size: 1.5em;color: #FBBF16;border: 2px solid #FBBF16;background-color: #1A64B7;">SAVE
            </div>
            <br>

            <div class="vip-list">
                %if len(vips.keys()) > 0:
                    %for key in vips.keys():
                        <div class="vip-item">
                            <input type="text" value="${key}" data-key="username" placeholder="Username">
                            <input type="text" value="${vips[key]}" data-key="password" placeholder="Password">
                            <span class="vip-del">(DELETE)</span>
                        </div>
                    %endfor
                %else:
                    <div class="vip-item">
                        <input type="text" data-key="username" placeholder="Username">
                        <input type="text" data-key="password" placeholder="Password">
                        <span class="vip-del">(DELETE)</span>
                    </div>
                %endif
            </div>
            <br>

            <div class="admin-action" id="new-vip">+</div>
        </div>
        <div class="admin-tab" data-tab="pages">
            <div class="admin-action" id="save-link-items"
                 style="font-size: 1.5em;color: #FBBF16;border: 2px solid #FBBF16;background-color: #1A64B7;">SAVE
            </div>
            <br/>
            <div class="admin-options">
            %for link in config:
                <div class="link-item"
                        style="margin-bottom: 10px;">
                    % if link['uri'] != "/":
                        <span class="delete">DELETE</span>
                    % endif
                    %if link.get('uri','') is not '':
                        <a href="${link.get('uri','')}">Link to Page</a><br/>
                    %endif
                    Page Title: <input type="text" data-key="name" value="${link['name']}"/><br/>
                    Page URL: <input type="text" data-key="uri" value="${link['uri']}"/><br/>
                    Page password: <input type="text" data-key="password" value="${link.get('password','')}"/> (leave
                    blank for no
                    password)<br/>
                    Maximum Video Width: <input type="number" data-key="max_stream_width"
                                                value="${link.get('max_stream_width','')}"/> (leave blank for unlimited)
                    <br/>
                    Page Embed Code / Text:<br/>
                    <textarea data-key="text" style="width:100%; height: 100px">${link.get('text','')}</textarea>
                </div>
            %endfor
            </div>
            <div class="admin-action" id="new-link-item">+</div>
        </div>
        <div class="admin-tab" data-tab="polls" style="display:none">
            <div class="admin-action" id="save-poll-items"
                 style="font-size: 1.5em;color: #FBBF16;border: 2px solid #FBBF16;background-color: #1A64B7;">SAVE
            </div>
            <br/>
        <div class="admin-options">
            %if len(polls) is 0:
                <div class="link-item" style="margin-bottom: 10px;">
                    <span class="delete">DELETE</span>
                    Page Title: <input type="text" data-key="name" value=""/><br/>
                    Page Description: <input type="text" data-key="description" value=""/><br/>
                    Page URL: <input type="text" data-key="uri" value=""/><br/> (leave blank for no external link) <br/>
                    VIPs only: <input data-key="vip_only" type="checkbox"/><br/>
                    Max options: <input data-key="max_opts" type="number" min="1" value="1"/> (leave blank for unlimited)<br/>
                    Version: <input data-key="version" type="number" min="1" value="1"/><br/>
                    Options: <br/>

                    <div data-key="options">
                        <input/> <b class="remove-poll-option" style="cursor: pointer;">X</b><span> -
                        <label>0</label> votes</span>
                        <br>
                        <b class="add-poll-option" style="cursor: pointer;">+</b>
                    </div>
                </div>

            %endif
            %for poll in polls:
                <div class="link-item" style="margin-bottom: 10px">
                    <span class="delete">DELETE</span>
                    %if poll.get('uri','') is not '':
                        <a href="/polls${poll.get('uri','')}">Link to Poll</a><br/>
                    %endif
                    Page Title: <input type="text" data-key="name" value="${poll['name']}"/><br/>
                    Page Description: <input type="text" data-key="description" value="${poll.get('description','')}"/><br/>
                    Page URL: <input type="text" data-key="uri" value="${poll.get('uri','')}"/> <br/>(leave blank for no
                    external
                    link) <br/>
                    VIPs only: <input data-key="vip_only" type="checkbox" ${"checked" if poll['vip_only'] else ""} />
                    <br/>
                    Max options: <input data-key="max_opts" type="number" min="1" value="${poll.get('max_opts','')}"/> (leave
                    blank for unlimited)<br/>
                    Version: <input data-key="version" type="number" min="1" value="${poll.get('version','')}"/><br/>
                    Options: <br/>

                    <div data-key="options">
                        %if len(poll['options']) is 0:
                            <input/> <b class="remove-poll-option" style="cursor: pointer;">X</b><span> -
                            <label>0</label> votes</span>
                            <br>
                            <b class="add-poll-option" style="cursor: pointer;">+</b>
                        %else:
                        %for opt in poll['options']:
                            <input value="${opt['name']}"/> <b class="remove-poll-option" style="cursor: pointer;">X</b><span> -
                            <label>${opt['votes']}</label> votes</span><br/>
                        %endfor

                            <b class="add-poll-option" style="cursor: pointer;">+</b>
                        %endif
                    </div>
                </div>

            %endfor
            </div>
            <div class="admin-action" id="new-poll-item">+</div>
        </div>
    %else:
        <form action="" method="post">
            Enter password: <input type="password" name="pw_input" id="pw_input"/> <input type="submit" value="GO"/>
        </form>
    %endif
</div>
</body>
</html>