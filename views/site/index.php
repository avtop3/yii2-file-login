<?php


use yii\helpers\Html;

/* @var $this yii\web\View */

$this->title = 'My Yii Application';
?>
<div class="site-index">

    <?php if (Yii::$app->user->isGuest): ?>
        <h1>Вы не представились!</h1>
    <?php else: ?>
        <h1>Добрый день, <?= Yii::$app->user->identity->username ?></h1>
        <?= Html::beginForm(['/site/logout'], 'post', ['class' => 'navbar-form'])
        . Html::submitButton(
            'Logout',
            ['class' => 'btn btn-primary']
        )
        . Html::endForm() ?>
    <?php endif ?>

</div>
