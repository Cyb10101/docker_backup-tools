#!/usr/bin/env php
<?php
class Cron {
    protected $cronFilename = 'development.php';

    public function cronLog(string $message) {
        $outputMessage = date('Y-m-d H:i') . ' Cron \'' . $this->cronFilename . '\': ' . $message;
        exec('echo "' . $outputMessage . '" >> /proc/1/fd/1');
    }
}

$cron = new Cron();
$cron->cronLog('Starting...');

# Your backup script
file_put_contents('/root/backup/development.txt', 'PHP:  ' . date('Y-m-d H:i:s') . PHP_EOL,  FILE_APPEND);

$cron->cronLog('Finished.');
