#!/usr/bin/env php
<?php
class Cron {
    protected $cronFilename = 'development.php';

    public function cronLog(string $message) {
        echo 'Cron \'' . $this->cronFilename . '\': ' . $message . PHP_EOL;
    }
}
$cron = new Cron();
$cron->cronLog('Starting...');

# Your backup script
file_put_contents('/root/development.txt', 'PHP:  ' . date('Y-m-d H:i:s') . PHP_EOL,  FILE_APPEND);

$cron->cronLog('Finished.');
