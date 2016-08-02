<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Graft – A high-quality LAMP environment for WordPress development</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="shortcut icon" sizes="16x16 24x24 32x32 48x48 64x64" href="https://www.themejuice.it/assets/favicon.ico">
  <link href="https://fonts.googleapis.com/css?family=Ubuntu:400,700,300" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Ubuntu+Mono:400" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/normalize/4.2.0/normalize.min.css" rel="stylesheet" type="text/css">
  <style>
    html,
    body {
      box-sizing: border-box;
    }
    *,
    *:before,
    *:after {
      box-sizing: inherit;
    }
    body {
      color: #253b3e;
      font: 400 14px/1.5 "Ubuntu", sans-serif;
      background-color: #eff1ef;
    }
    a {
      color: inherit;
      text-decoration: none;
      border-bottom: 2px solid rgba(109,129,132,0.25);
    }
    .header {
      position: relative;
      width: 100%;
      background-color: #253b3e;
      overflow: hidden;
      clear: both;
    }
    .navigation {
      max-width: 75em;
      margin-right: auto;
      margin-left: auto;
      padding: 1rem 0;
    }
    .navigation__list {
      list-style: none;
      margin: 0;
      padding: 0;
      overflow: hidden;
    }
    .navigation__item {
      display: inline;
      color: #eff1ef;
      margin: 0.35rem 1rem 0;
    }
    .navigation__link {
      border-bottom: none;
    }
    .welcome {
      color: #eff1ef;
      text-align: center;
      background-color: #8bb756;
      padding: 4rem 0;
      border-top: 4px solid #a0cf67;
    }
    .welcome__content {
      max-width: 50rem;
      margin: 0 auto 3rem;
    }
    .welcome__heading {
      font-weight: 700;
      font-size: 4rem;
      text-transform: uppercase;
      margin: 0;
    }
    .welcome__heading span {
      font-weight: 300;
      text-transform: lowercase;
    }
    .welcome__body {
      font-weight: 300;
      font-size: 1.25rem;
    }
    .tools {
      max-width: 75em;
      margin: 0 auto;
      padding: 1rem 0.5rem;
    }
    .tools__list {
      list-style: none;
      margin: 0;
      padding: 0;
      overflow: hidden;
    }
    .tools__item {
      float: left;
      width: 100%;
      padding: 0.5rem;
    }
    @media (min-width: 50em) {
      .tools__item {
        width: 25%;
      }
    }
    .tools__icon {
      -webkit-transition: 350ms;
      transition: 350ms;
      display: block;
      color: #6d8184;
      font-size: 4rem;
      text-align: center;
      margin-bottom: 0.75rem;
    }
    .tools__link {
      display: block;
      padding: 2rem 1rem;
      background: #253b3e;
      border: 2px solid #a0cf67;
      border-radius: 4px;
    }
    .tools__link:hover .tools__icon {
      color: #eff1ef;
    }
    .specs {
      max-width: 75em;
      margin: 0 auto;
      padding: 1rem;
    }
    .specs i {
      color: #a0cf67;
      line-height: 0.25;
      position: relative;
      top: 0.5rem;
    }
    .specs__heading {
      color: #ff9a2f;
      font-size: 2.5rem;
      margin-bottom: 2rem;
      border-bottom: 2px solid #e2e5e6;
    }
    .specs__table {
      width: 100%;
      border: 2px solid #6d8184;
      border-spacing: 0;
      border-collapse: collapse;
    }
    .specs__table td {
      text-align: left;
      padding: 1rem;
      border: 1px solid #6d8184;
    }
    .specs__table td:first-of-type {
      font-weight: 700;
    }
    .specs__table tr:nth-child(odd) {
      background-color: #eff0f1;
    }
    .specs__table tr:nth-child(even) {
      background-color: #e2e5e6;
    }
    .call-to-action {
      text-align: center;
      max-width: 75em;
      margin: 5rem auto;
    }
    .call-to-action__content {
      color: #6d8184;
      font-weight: 300;
      font-size: 2rem;
    }
    .call-to-action__content i {
      /*color: #ffee1f;*/
      font-size: 1.25em;
      position: relative;
      top: 0.15em;
    }
    .footer__wrapper {
      width: 100%;
      background-color: #253b3e;
    }
    .footer {
      max-width: 75em;
      margin-right: auto;
      margin-left: auto;
      padding: 2.5rem;
      overflow: hidden;
    }
    .footer__credits {
      color: #6d8184;
      font-size: 1.25rem;
      font-weight: 200;
      text-align: center;
      margin-bottom: 2rem;
    }
    .footer__credits__code,
    .footer__credits__heart {
      position: relative;
      top: 0.25rem;
    }
    .footer__credits__heart {
      -webkit-animation: heartbeat 2000ms infinite;
      animation: heartbeat 2000ms infinite;
      color: #f98e1c;
    }
    @-webkit-keyframes heartbeat {
      0%, 40%, 60%, 80% {
        -webkit-transform: scale(1);
        transform: scale(1);
      }
      50%, 70% {
        -webkit-transform: scale(1.25);
        transform: scale(1.25);
      }
    }
    @keyframes heartbeat {
      0%, 40%, 60%, 80% {
        -webkit-transform: scale(1);
        transform: scale(1);
      }
      50%, 70% {
        -webkit-transform: scale(1.25);
        transform: scale(1.25);
      }
    }
    .footer__social {
      text-align: center;
    }
    .footer__social__twitter,
    .footer__social__facebook {
      margin-top: 1rem;
    }
  </style>
</head>
<body>
  <div id="fb-root"></div>
  <script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.7&appId=409378179117106";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));</script>

  <header class="header">
    <nav class="navigation">
      <ul class="navigation__list">
        <li class="navigation__item">
          <a class="navigation__link" href="http://www.themejuice.it/docs">Documentation</a>
        </li>
        <li class="navigation__item">
          <a class="navigation__link" href="http://www.themejuice.it/support">Support</a>
        </li>
        <li class="navigation__item">
          <a class="navigation__link" href="http://www.themejuice.it">Desktop App</a>
        </li>
        <li class="navigation__item">
          <a class="navigation__link" href="http://cli.themejuice.it">CLI</a>
        </li>
      </ul>
    </nav>
  </header>

  <main class="welcome">

    <div class="welcome__content">
      <h1 class="welcome__heading">
        Welcome <span>to Graft</span>
      </h1>
      <p class="welcome__body">
        Graft is the official virtual machine for Theme Juice, designed specifically for WordPress development. Below are a few development tools that you might find useful (we sure do), as well as the specs for your brand new virtual machine. Enjoy!
      </p>
    </div>

    <nav class="tools">
      <ul class="tools__list">
        <li class="tools__item">
          <a class="tools__link" href="/phpinfo">
            <i class="material-icons tools__icon">settings</i>
            PHP Info
          </a>
        </li>
        <li class="tools__item">
          <a class="tools__link" href="/phpmyadmin">
            <i class="material-icons tools__icon">dns</i>
            phpMyAdmin
          </a>
        </li>
        <li class="tools__item">
          <a class="tools__link" href="/phpmemcacheadmin">
            <i class="material-icons tools__icon">memory</i>
            phpMemcacheAdmin
          </a>
        </li>
        <li class="tools__item">
          <a class="tools__link" href="/webgrind">
            <i class="material-icons tools__icon">pie_chart</i>
            Webgrind
          </a>
        </li>
      </ul>
    </nav>

  </main>

  <aside class="specs">

    <h2 class="specs__heading">System</h2>
    <table class="specs__table">
      <tr>
        <td>OS</td>
        <td>Ubuntu 14.04 LTS (Trusty Tahr)</td>
      </tr>
      <tr>
        <td>PHP</td>
        <td><?php echo phpversion(); ?></td>
      </tr>
      <tr>
        <td>MySQL</td>
        <td>
          <?php
          $mysqli = @new mysqli('localhost', 'root', 'root');
          if ( ! $mysqli->connect_error ) {
            echo $mysqli->server_info;
          }
          $mysqli->close();
          ?>
        </td>
      </tr>
      <tr>
        <td>Apache</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>Composer</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>WP-CLI</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>Node 6.3</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>NPM</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>RVM</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>Ruby 2.3</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>Mailcatcher</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>Xdebug</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>Memcached</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>GD/Imagick</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>SQLite</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>cURL</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>Git</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>Vim</td>
        <td><i class="material-icons">check</i></td>
      </tr>
      <tr>
        <td>Mcrypt</td>
        <td><i class="material-icons">check</i></td>
      </tr>
    </table>

    <h2 class="specs__heading">Database</h2>
    <table class="specs__table">
      <?php
      $mysql_exists = extension_loaded("mysql") || extension_loaded("mysqli");
      $mysqli = @new mysqli("localhost", "root", "root");
      $mysql_running = !$mysqli->connect_error;
      $mysql_version = $mysqli->server_info;
      $mysqli->close();
      ?>
      <tr>
        <td>MySQL is installed</td>
        <td><i class="material-icons"><?php echo ($mysql_exists ? 'check' : 'close'); ?></i></td>
      </tr>
      <tr>
        <td>MySQL is connected</td>
        <td><i class="material-icons"><?php echo ($mysql_running ? 'check' : 'close'); ?></i></td>
      </tr>
      <tr>
        <td>MySQL Version</td>
        <td><?php echo ($mysql_running ? $mysql_version : 'N/A'); ?></td>
      </tr>
    </table>

    <h2 class="specs__heading">Caching</h2>
    <table class="specs__table">
      <?php
      $memcache_running = false;
      $memcache_version = false;
      if ( class_exists("Memcache") ) {
        $memcache = new Memcache();
        if ( $memcache->addServer("localhost", 11211) ) {
          $memcache_running = true;
          $memcache_version = $memcache->getVersion();
        }
      }
      ?>
      <tr>
        <td>Memcache is running</td>
        <td><i class="material-icons"><?php echo ($memcache_running ? 'check' : 'close'); ?></i></td>
      </tr>
      <tr>
        <td>Memcache version</td>
        <td><?php echo ($memcache_version ? $memcache_version : 'N/A'); ?></td>
      </tr>
    </table>

    <h2 class="specs__heading">MySQL Credentials</h2>
    <table class="specs__table">
      <tr>
        <td>Host</td>
        <td>localhost</td>
      </tr>
      <tr>
        <td>User</td>
        <td>root</td>
      </tr>
      <tr>
        <td>Password</td>
        <td>root</td>
      </tr>
    </table>

    <h2 class="specs__heading">SSH Credentials</h2>
    <table class="specs__table">
      <tr>
        <td>Host</td>
        <td><a href="http://<?php echo $_SERVER["SERVER_ADDR"]; ?>"><?php echo $_SERVER["SERVER_ADDR"]; ?></a></td>
      </tr>
      <tr>
        <td>User</td>
        <td>vagrant</td>
      </tr>
      <tr>
        <td>Password</td>
        <td>vagrant</td>
      </tr>
    </table>

    <h2 class="specs__heading">Mailcatcher</h2>
    <table class="specs__table">
      <tr>
        <td>URL</td>
        <td><a href="http://<?php echo $_SERVER["SERVER_ADDR"]; ?>:1080"><?php echo $_SERVER["SERVER_ADDR"]; ?>:1080</a></td>
      </tr>
    </table>

    <h2 class="specs__heading">PHP Modules</h2>
    <table class="specs__table">
      <?php
      $modules = get_loaded_extensions();
      asort($modules);
      foreach ( $modules as $extension ) {
        ?>
        <tr>
          <td><?php echo $extension; ?></td>
          <td><i class="material-icons">check</i></td>
        </tr>
        <?php
      }
      ?>
    </table>

  </aside>

  <aside class="call-to-action">
    <h3 class="call-to-action__content">
      <a href="https://github.com/themejuice">
        <i class="material-icons">star_outline</i> us on GitHub
      </a>
    </h3>
  </aside>

  <footer class="footer__wrapper">
    <div class="footer">
      <div class="footer__credits">
        <i class="material-icons footer__credits__code">code</i> with
        <i class="material-icons footer__credits__heart">favorite</i> by
        <a href="http://www.produceresults.com">Produce Results</a>
      </div>
      <div class="footer__social">
        <div class="footer__social__twitter">
          <a href="https://twitter.com/themejuice" class="twitter-follow-button" data-show-count="false">Follow @themejuice</a><script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
        </div>
        <div class="footer__social__facebook">
          <div class="fb-like" data-href="https://facebook.com/themejuice" data-layout="button" data-action="like" data-size="small" data-show-faces="false" data-share="true"></div>
        </div>
      </div>
    </div>
  </footer>

</body>
</html>
