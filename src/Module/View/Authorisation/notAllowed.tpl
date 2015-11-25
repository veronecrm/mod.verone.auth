<div class="error-panel">
    <div class="error-code">403</div>
    <div class="title">{{ t('authNotAllowedAccess') }}</div>
    <div class="description">{{ t('authAccessPageNotAllowed') }}</div>
    <button class="btn btn-danger app-history-back">{{ t('back') }}</button>
</div>

<style>
    .error-panel {text-align:center;margin-top:100px;}
    .error-panel .error-code {font-size:100px;color:#C82E29;line-height:1;padding:0;}
    .error-panel .title {font-size:17px;color:#333;line-height:1.3;margin:4px 0 10px;}
    .error-panel .description {font-size:12px;color:#555;line-height:1.3;margin-bottom:30px;}
</style>
