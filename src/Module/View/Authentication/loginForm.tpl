@no-extends
<?php
    $_route   = $app->get('routing')->getRoute();
    $_module  = $_route->getModule();

    $app->assetter()
        ->load('jquery')
        ->load('bs-css')
        ->load('bs-js')
        ->load('jquery-cookie')
        ->load([
                'files' => [
                    'js'  => [ '{ASSETS}/app/backgrounds-slider.js' ],
                    'css' => [ '{ASSETS}/app/login-page.css' ]
                ]
            ]);
?>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="pl"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="pl"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="pl"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="pl"> <!--<![endif]-->
<head>
    <meta name="viewport" content="width=device-width" />
    <meta charset="utf-8" />
    <title>Verone CRM</title>
    <meta name="generator" content="Verone CRM" />
    <meta name="robots" content="nofollow, noindex" />
    <!-- Only Fonts are loaded from CDN. -->
    <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700&amp;subset=latin,latin-ext" />
    <link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />
    <link id="page-favicon" rel="icon" href="<?=$app->request()->getUriForPath('/images/fi.png')?>" />
    <?=$app->assetter()->all('head')?>
    @show('head.bottom')
</head>
<body>
    <div class="slick-panel">
        @foreach $app->flashBag()->get('danger', []) as $flash
            <div class="alert alert-danger alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>{{ $flash|raw }}</div>
        @endforeach
        <div class="login-panel">
            <h3>{{ t('signin') }}</h3>
            <form role="form" action="<?php echo $app->createUrl('Home'); ?>" method="post">
                <fieldset>
                    <div class="form-group has-feedback first-group">
                        <input class="form-control" name="username" type="text" id="username" value="" placeholder="{{ t('username') }}" />
                        <span class="fa fa-user form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <div class="form-group has-feedback">
                        <input class="form-control" name="password" type="password" id="password" value="" placeholder="{{ t('password') }}" />
                        <span class="fa fa-lock form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <input type="submit" class="btn btn-lg btn-primary btn-block" value="{{ t('signin') }}" />
                </fieldset>
            </form>
            <form action="" method="post" class="lang-select">
                @set $locale $app->request()->getLocale()
                <i class="fa fa-language"></i> {{ t('language') }}:
                <select name="locale" onchange="document.location.href = '<?php echo $app->request()->getBasePath(); ?>?locale=' + this.value;">
                    <option value="pl" <?php echo $locale == 'pl' ? ' selected="selected"' : ''; ?>>{{ t('lngpl') }}</option>
                    <option value="en" <?php echo $locale == 'en' ? ' selected="selected"' : ''; ?>>{{ t('lngen') }}</option>
                </select>
            </form>
        </div>
    </div>
    <div class="background-images"></div>
    <a class="unslpash-credits" href="https://unsplash.com/" target="_blank">Images by: unsplash.com</a>
    <script>
        $(function() {
            var username = $('input[name=username]');
            var password = $('input[name=password]');

            username.trigger('focus');

            if($.cookie('authform.login'))
            {
                username.val($.cookie('authform.login'));
            }

            if(username.val())
            {
                password.trigger('focus');
            }

            $('form').submit(function() {
                if(username.val() == '')
                    username.parent().addClass('has-error');
                else
                    username.parent().removeClass('has-error');

                if(password.val() == '')
                    password.parent().addClass('has-error');
                else
                    password.parent().removeClass('has-error');

                if(username.parent().hasClass('has-error') || password.parent().hasClass('has-error'))
                {
                    return false;
                }
                else
                {
                    $.cookie('authform.login', username.val(), { expires: 365, path: '/' });
                    return true;
                }
            });
        });

        $.ajax({
            path: '{{ asset('/') }}',
            type: 'GET',
            data: { 'check-registration': '1' }
        });
    </script>
    <?=$app->assetter()->all('body')?>
    <script>createBackgroundSlider();</script>
</body>
</html>
