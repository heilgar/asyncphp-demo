<?php

require __DIR__ . '/vendor/autoload.php';

use Heilgar\Asyncphp\Process;

$tasks = [];
for ($i = 1; $i < 11; $i++) {
    $tasks[$i] = (new Process($i))->run();
}

// Wait for all tasks to complete

foreach ($tasks as $id => $data) {
    print "++ Task $id returned: " . var_export($data, true) . PHP_EOL;
}