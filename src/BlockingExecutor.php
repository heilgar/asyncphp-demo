<?php

namespace Heilgar\Asyncphp;

use Symfony\Component\HttpClient\HttpClient;
use Symfony\Contracts\HttpClient\HttpClientInterface;

class BlockingExecutor
{
    private HttpClientInterface $client;

    public function __construct()
    {
        $this->client = HttpClient::create();
    }

    public function get(int $id)
    {
        $response = $this->client
            ->request('GET', 'https://jsonplaceholder.typicode.com/posts/' . $id);
        $content = $response->getContent();
        $data = json_decode($content, true);

        return $data;
    }


    public function post(array $data)
    {
        $response = $this->client
            ->request('POST', 'http://host.docker.internal:8000/echo.php', [
                'json' => $data
            ]);
        $content = $response->getContent();
        $data = json_decode($content, true);

        return $data;
    }
}