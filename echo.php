<?php

$input = file_get_contents('php://input');
$data = json_decode($input, true);

if (isset($data['sleep'])) {
    if (rand(0,1)) {
        sleep($data['sleep']);
    }
}

// Print the received data
$id = isset($data['id']) ? $data['id'] : 'Unknown';
$stdout = fopen('php://stdout', 'w');
fwrite($stdout, "++ Received $id : " . var_export($data, true) . PHP_EOL);
fclose($stdout);

$response = [
    'status' => 'success',
    'message' => 'Data received successfully',
    'data' => $data,
];


header('Content-Type: application/json');
echo json_encode($response);
