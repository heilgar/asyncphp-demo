<?php

namespace Heilgar\Asyncphp;

class Process
{
    private int $id;
    private BlockingExecutor $executor;

    public function __construct($id)
    {
        $this->id = $id;
        $this->executor = new BlockingExecutor();
    }

    public function run(): mixed
    {
        $sleep = rand(1, 5);

        print "++ Executing task $this->id" . PHP_EOL;
//        sleep($sleep);
        $data = $this->executor->get($this->id);
        $data['sleep'] = $sleep;

        $this->executor->post($data);

        print "++ Finished task $this->id" . PHP_EOL;

        return $data;
    }
}