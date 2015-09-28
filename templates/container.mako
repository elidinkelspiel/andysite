</head>
<body>
<nav id="header"><span class="logo">LoadoutTrack</span>
    <ul id="menu">

        <li class="home"><a href="/loadouttrack"><i class="fa fa-home"></i> </a></li>
        <li><a href="/loadouttrack/browse">BROWSE</a>
            <ul class="sub-menu">
                <li>
                    <a href="/loadouttrack/browse?itemType=w">WEAPONS</a>
                </li>
                <li>
                    <a href="/loadouttrack/browse?itemType=l">LOADOUTS</a>
                </li>
                <li>
                    <a href="#">HOT</a>
                </li>
            </ul>
        </li>
        <li><a href="/loadouttrack/upload">UPLOAD</a><ul class="sub-menu">
                <li>
                    <a href="/loadouttrack/upload?q=w">WEAPON</a>
                </li>
                <li>
                    <a href="/loadouttrack/upload?q=l">LOADOUT</a>
                </li>
            </ul></li>
        <li><a href="#">ACCOUNT
        %if user is not None:
            (${user.Username})</a><ul class="sub-menu">
                <li>
                    <a href="#">MY ACCOUNT</a>
                </li>
                <li>
                    <a href="#">FRIENDS</a>
                </li>
            <li>
                    <a href="logout">LOGOUT</a>
                </li>
            </ul>
        % else:
            </a><ul class="sub-menu">
                <li>
                    <a href="login">LOG IN</a>
                </li>
                <li>
                    <a href="register">REGISTER</a>
                </li>
            </ul>
        %endif

        </li>
        <li class="about"><a href="/"><i class="fa fa-question"></i></a></li>
    </ul>
</nav>
<div id="container">