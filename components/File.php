<?php
/**
 * Created by PhpStorm.
 * User: Alex
 * Date: 05.07.2016
 * Time: 20:49
 */
namespace app\components;

use yii\base\Component;
use yii\base\Exception;

class File extends Component
{
    public $fileName;
    public $allUsers;

    private $_file;

    public function init()
    {
        $this->_file = file_get_contents($this->fileName);
        if ($this->_file) {
            $this->fillUsers();
        } else {
            throw new Exception('Wrong fileName property, ' . $this->fileName . ' has been given!');
        }
    }

    private function fillUsers()
    {
        $userScope = [];
        $strings = explode(PHP_EOL, $this->_file);
        foreach ($strings as $tsvUser) {
            $raw = explode("\t", $tsvUser);
            $userScope[$raw[0]] = ['id' => $raw[0], 'username' => $raw[1], 'password' => $raw[2]];
        }

        $this->allUsers = $userScope;
    }


} 