# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 9
_modified_time = 1443388936.518
_enable_loop = True
_template_filename = 'templates/index.mako'
_template_uri = 'index.mako'
_source_encoding = 'utf-8'
_exports = []


def render_body(context,**pageargs):
    __M_caller = context.caller_stack._push_frame()
    try:
        __M_locals = __M_dict_builtin(pageargs=pageargs)
        password = context.get('password', UNDEFINED)
        config = context.get('config', UNDEFINED)
        page_config = context.get('page_config', UNDEFINED)
        active_page = context.get('active_page', UNDEFINED)
        __M_writer = context.writer()
        # SOURCE LINE 1
        __M_writer(u'<!DOCTYPE html>\r\n<html>\r\n<head lang="en">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">\r\n    <link rel="shortcut icon" type="image/png" href="/favicon.png"/>\r\n    <link href=\'https://fonts.googleapis.com/css?family=Work+Sans:300,500,700\' rel=\'stylesheet\' type=\'text/css\'>\r\n    <meta charset="UTF-8">\r\n    <title>')
        # SOURCE LINE 8
        __M_writer(unicode(page_config.get('name','').title()))
        __M_writer(u' - Handrewbrozel</title>\r\n    <link rel="stylesheet" href="/css/style.css">\r\n    <script src="http://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>\r\n    <script src="/js/master.js" type="text/javascript"></script>\r\n</head>\r\n<body>\r\n<nav>\r\n    <img src="/assets/gswlogo.svg" class="logo" />\r\n')
        # SOURCE LINE 16
        for link in config:
            # SOURCE LINE 17
            if link['name'] != "error":
                # SOURCE LINE 18
                __M_writer(u'            <a class="')
                __M_writer(unicode("active" if link['uri']==active_page else ""))
                __M_writer(u'" href="')
                __M_writer(unicode(link['uri']))
                __M_writer(u'">')
                __M_writer(unicode(link['name']))
                __M_writer(u'</a>\r\n')
        # SOURCE LINE 21
        __M_writer(u'</nav>\r\n<div class="container">\r\n')
        # SOURCE LINE 23
        if page_config.get('password', UNDEFINED) is UNDEFINED or (page_config.get('password', UNDEFINED) is UNDEFINED and password is UNDEFINED) or password==page_config['password']:
            # SOURCE LINE 24
            __M_writer(u'        <div style="max-width: ')
            __M_writer(unicode(page_config.get('max_stream_width', 99999)))
            __M_writer(u'px;" class="video-container">\r\n            ')
            # SOURCE LINE 25
            __M_writer(unicode(page_config.get('text','')))
            __M_writer(u'\r\n')
            # SOURCE LINE 26
            if active_page == "/":
                # SOURCE LINE 27
                __M_writer(u'                <div class="below" style="max-width: ')
                __M_writer(unicode(page_config.get('max_stream_width', 99999)))
                __M_writer(u'px;">\r\n                    <ul class="tab-control">\r\n                        <li id="livescores" class="active-tab">Live Scores</li>\r\n                        <li id="teamstats">Team Stats</li>\r\n                    </ul>\r\n                    <div style="padding:5px" data-tab="livescores">\r\n                        GSW 100 - LAC 0\r\n                    </div>\r\n                    <div data-tab="teamstats" style="display:none">\r\n                    <script type="text/javascript"\r\n                            src="http://widgets.sports-reference.com/wg.fcgi?css=1&site=bbr&url=%2Fteams%2FGSW%2F2015.html&div=div_totals"></script>\r\n                    </div>\r\n                </div>\r\n')
            # SOURCE LINE 41
            __M_writer(u'        </div>\r\n        <div class="chat-container">\r\n            <script id="cid0020000090554645135" data-cfasync="false" async src="//st.chatango.com/js/gz/emb.js" style="width: 350px;height: 700px;">{"handle":"andthefoot","arch":"js","styles":{"a":"04529c","b":100,"c":"ffcc33","d":"ffcc33","e":"ffffff","h":"ffffff","l":"cccccc","m":"dadada","p":"9","q":"ffcc33","r":100,"t":0,"usricon":0.61,"sbc":"ffcc33","surl":0,"cnrs":"1"}}</script>\r\n        </div>\r\n        <div class="clear"></div>\r\n')
            # SOURCE LINE 46
        else:
            # SOURCE LINE 47
            __M_writer(u'        <form class="pw_form" action="" method="post">\r\n        Enter password: <input type="password" name="pw_input" id="pw_input"/> <input type="submit" value="GO"/>\r\n        </form>\r\n')
        # SOURCE LINE 51
        __M_writer(u'</div>\r\n<footer>\r\n    enjoy our streams? <a href="https://www.twitchalerts.com/donate/handrewbrozel" target="_blank">donate</a> to help us out\r\n</footer>\r\n</body>\r\n</html>')
        return ''
    finally:
        context.caller_stack._pop_frame()


