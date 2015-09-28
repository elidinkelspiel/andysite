__author__ = 'Nadav'
import os
import json
import cherrypy
import mimetypes
if not mimetypes.inited:
    mimetypes.init()
mimetypes.add_type('image/svg+xml', '.svg', True)
from mako.lookup import TemplateLookup

class renderer(object):
    @cherrypy.expose
    def admin(self, *args, **kw):
        page_url = "admin"
        if cherrypy.request.method == "GET":
            # return open('index.html')
            tmpl = tmpltLookup.get_template("admin.mako")
            return tmpl.render(config=config, active_page=page_url)
        elif cherrypy.request.method == "POST":
            cfg = kw.get('config', '')
            if cfg != "":
                FILE = open('admin.cfg', 'r+')
                FILE.seek(0)
                FILE.write(cfg)
                FILE.truncate()
                FILE.close()
                FILE2 = open('admin.cfg')
                ADMIN_CFG = FILE2.read()
                global config
                global URLS
                config = json.loads(ADMIN_CFG)
                URLS = [x['uri'] for x in config]
                FILE2.close()
                return 'success'
            tmpl = tmpltLookup.get_template("admin.mako")
            return tmpl.render(password=kw['pw_input'], config=config, active_page=page_url)

    @cherrypy.expose
    def default(self, *args, **kw):
        page_url = '/' + '/'.join(args)
        if page_url in URLS:
            pass
        else:
            page_url = "error"

        if cherrypy.request.method == "GET":
            # return open('index.html')
            tmpl = tmpltLookup.get_template("index.mako")
            return tmpl.render(config=config, active_page=page_url, page_config=[x for x in
                                                                                                    config if
                                                                                                    x['uri'] ==
                                                                                                    page_url][0])
        elif cherrypy.request.method == "POST":
            tmpl = tmpltLookup.get_template("index.mako")
            return tmpl.render(password = kw['pw_input'],config=config, active_page=page_url, page_config=[x for x in
                                                                                    config if
                                                                                    x['uri'] ==
                                                                                    page_url][0])

tmpltLookup = TemplateLookup(module_directory='CompiledTemplates', directories=['templates', ''],
                             input_encoding='utf-8',
                             output_encoding='utf-8')
curpath = os.path.dirname(os.path.realpath(__file__))
CFG_FILE = open('admin.cfg')
ADMIN_CFG = CFG_FILE.read()
config = json.loads(ADMIN_CFG)
URLS = [x['uri'] for x in config]
CFG_FILE.close()
os.chdir(curpath)
cherrypy.config.update('config.cfg')
app = cherrypy.tree.mount(renderer(), config='config.cfg')
cherrypy.quickstart(app)