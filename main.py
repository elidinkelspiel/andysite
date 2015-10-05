__author__ = 'Nadav'
import os
import threading
import json
import mimetypes
import requests
import cherrypy

if not mimetypes.inited:
    mimetypes.init()
mimetypes.add_type('image/svg+xml', '.svg', True)
from mako.lookup import TemplateLookup


def set_interval(func, sec):
    def func_wrapper():
        set_interval(func, sec)
        func()

    t = threading.Timer(sec, func_wrapper)
    t.start()
    return t

def get_scores():
    r = requests.get('http://sports.espn.go.com/nba/bottomline/scores').text
    global livescores
    livescores = r

class renderer(object):
    @cherrypy.expose
    def livescores(self, *args, **kw):
        return livescores
    @cherrypy.expose
    def admin(self, *args, **kw):
        page_url = "admin"
        if cherrypy.request.method == "GET":
            # return open('index.html')
            tmpl = tmpltLookup.get_template("admin.mako")
            return tmpl.render(config=config, vips=vips, polls=polls, active_page=page_url)
        elif cherrypy.request.method == "POST":
            cfg = kw.get('config', '')
            pls = kw.get('polls', '')
            very = kw.get('vips', '')
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
            elif pls != "":
                FILE = open('polls.cfg', 'r+')
                FILE.seek(0)
                FILE.write(pls)
                FILE.truncate()
                FILE.close()
                FILE2 = open('polls.cfg')
                POLL_CFG = FILE2.read()
                global polls
                global POLL_URLS
                polls = json.loads(POLL_CFG)
                POLL_URLS = ['/polls' + x['uri'] for x in polls if x.get('uri', '') is not '']
                FILE2.close()
                return 'success'
            elif very != "":
                FILE = open('vips.cfg', 'r+')
                FILE.seek(0)
                FILE.write(very)
                FILE.truncate()
                FILE.close()
                FILE2 = open('vips.cfg')
                VIP_CFG = FILE2.read()
                global vips
                vips = json.loads(VIP_CFG)
                FILE2.close()
                return 'success'
            tmpl = tmpltLookup.get_template("admin.mako")
            return tmpl.render(vips=vips, password=kw['pw_input'], polls=polls, config=config, active_page=page_url)

    @cherrypy.expose
    def test(self):
        return "memes"
    @cherrypy.expose
    def default(self, *args, **kw):
        page_url = '/' + '/'.join(args)
        if page_url in URLS or page_url in POLL_URLS:
            pass
        else:
            page_url = "/error"

        if page_url in URLS:
            if cherrypy.request.method == "GET":
                # return open('index.html')
                tmpl = tmpltLookup.get_template("index.mako")
                return tmpl.render(polls=polls, vips=vips, config=config, active_page=page_url, page_config=[x for x in
                                                                                                config if
                                                                                                x['uri'] ==
                                                                                                page_url][0])
            elif cherrypy.request.method == "POST":
                tmpl = tmpltLookup.get_template("index.mako")
                return tmpl.render(polls=polls, vips=vips, password=kw['pw_input'], username=kw.get('pw_user', None), config=config,
                                   active_page=page_url,
                                   page_config=[x for x in
                                                config if
                                                x[
                                                    'uri'] ==
                                                page_url][
                                       0])
        elif page_url in POLL_URLS:
            poll = [poll for poll in polls if page_url.endswith(poll.get('uri', 'kjhdfkgjhdfkgjhdf'))][0]
            cookie_name = str('vote' + ''.join(args) + poll.get('version',''))
            if cherrypy.request.method == "GET":
                tmpl = tmpltLookup.get_template("poll.mako")
                if cherrypy.request.cookie.get(cookie_name, False) is False:
                    return tmpl.render(poll=poll, config=config, vips=vips, voted=False, polls=polls)
                else:
                    return tmpl.render(poll=poll, config=config, vips=vips, voted=True, polls=polls)
            elif cherrypy.request.method == "POST":
                tmpl = tmpltLookup.get_template("poll.mako")
                vote = kw.get('vote', '')
                # cookie_name = 'abcdef'
                if vote == '' and cherrypy.request.cookie.get(cookie_name, False) is False:
                    return tmpl.render(polls=polls, voted=False, poll=poll, config=config, vips=vips, password=kw['pw_input'],
                                       username=kw.get('pw_user', None))
                elif vote != '':
                    # TODO parse array and add votes, cookie
                    cherrypy.response.cookie[cookie_name] = True
                    cherrypy.response.cookie[cookie_name]['max-age'] = 315569260
                    FILE = open('polls.cfg', 'r+')
                    FILE.seek(0)
                    vote_obj = json.loads(vote)
                    for opt in poll['options']:
                        if opt['name'] in vote_obj:
                            opt['votes'] = opt['votes']+1
                    FILE.write(json.dumps(polls))
                    FILE.truncate()
                    FILE.close()
                    FILE2 = open('polls.cfg')
                    POLL_CFG = FILE2.read()
                    global polls
                    polls = json.loads(POLL_CFG)
                    FILE2.close()
                    return 'success'
                else:
                    return tmpl.render(voted=True, poll=poll, config=config, vips=vips, password=kw.get('pw_input', ''),
                                       username=kw.get('pw_user', None), polls=polls)


tmpltLookup = TemplateLookup(module_directory='CompiledTemplates', directories=['templates', ''],
                             input_encoding='utf-8',
                             output_encoding='utf-8')
curpath = os.path.dirname(os.path.realpath(__file__))
POLL_FILE = open('polls.cfg')
CFG_FILE = open('admin.cfg')
VIP_FILE = open('vips.cfg')
ADMIN_CFG = CFG_FILE.read()
POLL_CFG = POLL_FILE.read()
VIP_CFG = VIP_FILE.read()
polls = json.loads(POLL_CFG)
livescores = ""
config = json.loads(ADMIN_CFG)
vips = json.loads(VIP_CFG)
URLS = [x['uri'] for x in config]
POLL_URLS = ['/polls' + x['uri'] for x in polls if x.get('uri', '') is not '']
CFG_FILE.close()
os.chdir(curpath)
cherrypy.config.update('config.cfg')
app = cherrypy.tree.mount(renderer(), config='config.cfg')
get_scores()
set_interval(get_scores, 59)
cherrypy.quickstart(app)
