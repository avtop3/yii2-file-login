<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model app\models\LoginForm */

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

$this->title = 'Login';

$js = <<<JS
var countdown = $('#countdown');
var initSeconds = countdown.data('init') || 0;

tick(initSeconds);
function tick(seconds) {
    setTimeout(function () {
        if (seconds > 0) {
            seconds--;
            tick(seconds);
        }
        countdown.html(seconds);
    }, 1000);
}
JS;
?>

<div class="site-login">
    <h1><?= Html::encode($this->title) ?></h1>

    <p>Please fill out the following fields to login:</p>

    <?php if ($model->blockPeriodLeft > 0) { ?>
        <div class="alert alert-danger" role="alert">
            Попробуйте еще раз через
            <strong>
                <span id="countdown" data-init="<?= $model->blockPeriodLeft ?>"><?= $model->blockPeriodLeft ?></span>
                секунд
            </strong>
        </div>

        <?php
        $this->registerJs($js);
    }
    ?>


    <?php $form = ActiveForm::begin([
        'id' => 'login-form',
        'options' => ['class' => 'form-horizontal'],
        'fieldConfig' => [
            'template' => "{label}\n<div class=\"col-lg-3\">{input}</div>\n<div class=\"col-lg-8\">{error}</div>",
            'labelOptions' => ['class' => 'col-lg-1 control-label'],
        ],
    ]); ?>

    <?= $form->field($model, 'username')->textInput(['autofocus' => true]) ?>

    <?= $form->field($model, 'password')->passwordInput() ?>

    <div class="form-group">
        <div class="col-lg-offset-1 col-lg-11">
            <?= Html::submitButton('Login', ['class' => 'btn btn-primary', 'name' => 'login-button']) ?>
        </div>
    </div>

    <?php ActiveForm::end(); ?>
</div>