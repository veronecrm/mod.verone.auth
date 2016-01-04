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
        <div class="unlock-panel">
            <form role="form" action="<?php echo $app->createUrl('Home'); ?>" method="post">
                <fieldset>
                    <h3>Witaj, <b><?php echo $app->user()->getName(); ?></b></h3>
                    <div class="input-group">
                        <input class="form-control" name="password" type="password" id="password" value="" placeholder="{{ t('password') }}" />
                        <span class="input-group-btn">
                            <button type="submit" class="btn btn-primary btn-block">{{ t('unlockScreen') }}</button>
                        </span>
                    </div>
                    <a href="?logout=1">{{ t('switchAccount') }}</a>
                </fieldset>
            </form>
        </div>
    </div>
    <div class="background-images"></div>
    <a class="unslpash-credits" href="https://unsplash.com/" target="_blank">Images by: unsplash.com</a>
    <script>
        $(function() {
            var password = $('input[name=password]');

            $('form').submit(function() {
                if(password.val() == '')
                    password.parent().addClass('has-error');
                else
                    password.parent().removeClass('has-error');

                if(password.parent().hasClass('has-error'))
                    return false;
                else
                    return true;
            });
        });
    </script>
    <?=$app->assetter()->all('body')?>
    <script>createBackgroundSlider();</script>
</body>
</html>
