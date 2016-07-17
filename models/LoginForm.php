<?php

namespace app\models;

use Yii;
use yii\base\Model;

/**
 * LoginForm is the model behind the login form.
 *
 * @property User|null $user This property is read-only.
 *
 */
class LoginForm extends Model
{
    public $username;
    public $password;
    public $rememberMe = true;

    public $attemptCount = 3;
    public $attemptPeriod = 60; //in seconds
    public $blockPeriod = 60; //in seconds
    public $blockPeriodLeft = 0; //in seconds

    private $_user = false;

    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [
            // username and password are both required
            [['username', 'password'], 'required'],
            // rememberMe must be a boolean value
            ['rememberMe', 'boolean'],
            // password is validated by validatePassword()
            ['password', 'validatePassword'],
        ];
    }

    /**
     * Validates the password.
     * This method serves as the inline validation for password.
     *
     * @param string $attribute the attribute currently being validated
     * @param array $params the additional name-value pairs given in the rule
     */
    public function validatePassword($attribute, $params)
    {
        if (!$this->hasErrors()) {
            $user = $this->getUser();

            if (!$user || !$user->validatePassword($this->password)) {
                $this->addError($attribute, 'Incorrect username or password.');
            }
        }
    }

    public function beforeValidate()
    {
        parent::beforeValidate();

        return $this->checkRateLimit();
    }

    /**
     * Logs in a user using the provided username and password.
     * @return boolean whether the user is logged in successfully
     */
    public function login()
    {
        if ($this->validate()) {
            $this->removeLogFile();
            return Yii::$app->user->login($this->getUser(), $this->rememberMe ? 3600 * 24 * 30 : 0);
        } else {
            $this->logTime();
            $this->checkRateLimit();
        }
        return false;
    }

    public function removeLogFile()
    {
        if (file_exists(self::getLogFile())) {
            unlink(self::getLogFile());
        }
    }

    public function logTime()
    {
        if (count($this->getLogFileContent()) < 3) {
            file_put_contents(self::getLogFile(), date('U') . PHP_EOL, FILE_APPEND);
        }
    }

    public function checkRateLimit()
    {
        $logEntries = $this->getLogFileContent();

        if (count($logEntries) >= 3) {
//            print_r(end($logEntries));exit;

            if (date('U') - end($logEntries) < $this->blockPeriod) {
                $this->blockPeriodLeft = $this->blockPeriod - (date('U') - end($logEntries));
            }else{
                $this->removeLogFile();
                return true;
            }

            return false;
        }
        return true;
    }

    /**
     * Finds user by [[username]]
     *
     * @return User|null
     */
    public function getUser()
    {
        if ($this->_user === false) {
            $this->_user = User::findByUsername($this->username);
        }

        return $this->_user;
    }

    public static function getLogFile()
    {
        return Yii::$app->basePath . '/log/loginFails/' . Yii::$app->request->userIP;
    }

    public static function getLogFileContent()
    {
        if (!file_exists(self::getLogFile())) {
            return [];
        }
        $allTimestamps = file_get_contents(self::getLogFile());
        $timestamps = explode(PHP_EOL, $allTimestamps);
        $timestamps = array_filter($timestamps);

        return $timestamps;
    }
}
