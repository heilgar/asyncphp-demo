<?php

require __DIR__ . '/vendor/autoload.php';

use Heilgar\Asyncphp\Process;
use Heilgar\Asyncphp\ProcessTask;
use Amp\Future;
use Amp\Parallel\Worker;

$tasks = [];
for ($i = 1; $i < 11; $i++) {
    $tasks[$i] = Worker\submit(
        new ProcessTask(
            new Process($i)
        )
    );
}

$responses = Future\await(array_map(
    fn (Worker\Execution $e) => $e->getFuture(),
    $tasks,
));

foreach ($tasks as $id => $task) {
    print "++ Task $id returned: " . var_export($responses[$id], true) . PHP_EOL;
}