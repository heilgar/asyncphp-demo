<?php

namespace Heilgar\Asyncphp;

use Amp\Cancellation;
use Amp\Parallel\Worker\Task;
use Amp\Sync\Channel;

class ProcessTask implements Task {
    public function __construct(private Process $process) {}

    public function run(Channel $channel, Cancellation $cancellation): mixed
    {
        return $this->process->run();
    }
}