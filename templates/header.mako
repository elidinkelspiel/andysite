<nav>
    <span class="mobile-nav">&#9776;</span>
    <img src="/assets/gswlogo.svg" class="logo"/>
    <span class="hand">geoffgeoff</span>


        %for link in config:
            %if link['name'] != "error":
                <a class="${"active" if link['uri']==active_page else ""}" href="${link['uri']}" ${"onclick=\'return false\'" if link['uri'] == "/polls" else ""}>
                    ${link['name']}
                %if link['uri'] == "/polls":
                    <ul class="polls">
                        %for poll in polls:
                            %if poll.get('uri', '') is not '' and not poll.get('vip_only', True):
                                <li data-href="/polls${poll['uri']}">${poll['name']}</li>
                            %endif
                        %endfor
                    </ul>
                %endif
                </a>
            %endif
        %endfor
        <%doc>%if len([poll for poll in polls if poll.get('uri', '') is not '' and not poll.get('vip_only', True)]) > 0:
            <a href="/polls" onclick="return false">POLLS
                <ul class="polls">
                    %for poll in polls:
                        %if poll.get('uri', '') is not '' and not poll.get('vip_only', True):
                            <li data-href="/polls${poll['uri']}">${poll['name']}</li>
                        %endif
                    %endfor
                </ul>
            </a>
        %endif</%doc>
</nav>