# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 9
_modified_time = 1443381202.969
_enable_loop = True
_template_filename = 'templates/admin.mako'
_template_uri = 'admin.mako'
_source_encoding = 'utf-8'
_exports = []


def render_body(context,**pageargs):
    __M_caller = context.caller_stack._push_frame()
    try:
        __M_locals = __M_dict_builtin(pageargs=pageargs)
        password = context.get('password', UNDEFINED)
        config = context.get('config', UNDEFINED)
        active_page = context.get('active_page', UNDEFINED)
        __M_writer = context.writer()
        # SOURCE LINE 1
        __M_writer(u'<!DOCTYPE html>\r\n<html>\r\n<head lang="en">\r\n    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">\r\n    <link rel="shortcut icon" type="image/png" href="/favicon.png"/>\r\n    <link href=\'https://fonts.googleapis.com/css?family=Work+Sans:300,500,700\' rel=\'stylesheet\' type=\'text/css\'>\r\n    <meta charset="UTF-8">\r\n    <title>Top Sikrit Admin Config</title>\r\n    <link rel="stylesheet" href="/css/style.css">\r\n    <script src="http://code.jquery.com/jquery-2.1.4.min.js" type="text/javascript"></script>\r\n    <script src="/js/master.js" type="text/javascript"></script>\r\n</head>\r\n<body>\r\n<nav>\r\n    <img src="/assets/gswlogo.svg" class="logo"/>\r\n')
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
        __M_writer(u'</nav>\r\n<div class="container pw_form">\r\n')
        # SOURCE LINE 23
        if password is not UNDEFINED and password == "ayylmaomemes":
            # SOURCE LINE 24
            __M_writer(u'        <div class="admin-action" id="save-link-items"\r\n             style="font-size: 1.5em;color: #FBBF16;border: 2px solid #FBBF16;background-color: #1A64B7;">SAVE\r\n        </div>\r\n        <br/>\r\n')
            # SOURCE LINE 28
            for link in config:
                # SOURCE LINE 29
                __M_writer(u'        <div class="link-item">\r\n')
                # SOURCE LINE 30
                if link['uri'] != "/":
                    # SOURCE LINE 31
                    __M_writer(u'                <span>DELETE</span>\r\n')
                # SOURCE LINE 33
                __M_writer(u'            Page Title: <input type="text" data-key="name" value="')
                __M_writer(unicode(link['name']))
                __M_writer(u'"/><br/>\r\n            Page URL: <input type="text" data-key="uri" value="')
                # SOURCE LINE 34
                __M_writer(unicode(link['uri']))
                __M_writer(u'"/><br/>\r\n            Page password: <input type="text" data-key="password" value="')
                # SOURCE LINE 35
                __M_writer(unicode(link.get('password','')))
                __M_writer(u'"/> (leave blank for no\r\n            password)<br/>\r\n            Maximum Video Width: <input type="number" data-key="max_stream_width"\r\n                                        value="')
                # SOURCE LINE 38
                __M_writer(unicode(link.get('max_stream_width','')))
                __M_writer(u'"/> (leave blank for unlimited)\r\n            <br/>\r\n            Page Embed Code / Text:<br/>\r\n            <textarea data-key="text" style="width:100%; height: 100px">')
                # SOURCE LINE 41
                __M_writer(unicode(link['text']))
                __M_writer(u'</textarea>\r\n        </div>\r\n        <br/>\r\n')
            # SOURCE LINE 45
            __M_writer(u'        <div class="admin-action" id="new-link-item">+</div>\r\n')
            # SOURCE LINE 46
        else:
            # SOURCE LINE 47
            __M_writer(u'        <form action="" method="post">\r\n            Enter password: <input type="password" name="pw_input" id="pw_input"/> <input type="submit" value="GO"/>\r\n        </form>\r\n')
        # SOURCE LINE 51
        __M_writer(u'</div>\r\n</body>\r\n</html>')
        return ''
    finally:
        context.caller_stack._pop_frame()


