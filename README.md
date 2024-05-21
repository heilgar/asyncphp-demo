# Async PHP with Symfony HttpClient and Amp

This is a demonstration project focused on testing non-blocking function execution in PHP using [AMP (Asynchronous Multiprocessing)](https://github.com/amphp/parallel) and [Symfony HttpClient](https://github.com/symfony/http-client). The project serves to illustrate how asynchronous programming techniques can enhance the performance and efficiency of PHP applications

## Project Objectives:
The primary objective of this project is to methodically assess the capabilities and performance of the AMP approach before its gradual integration into the mission-critical functionalities of the main project.

## Purpose:

The primary purpose of this project is to conduct a thorough evaluation of the capabilities and performance of AMP in an isolated environment. Through comprehensive testing and experimentation, the aim is to ensure the stability and effectiveness of the asynchronous functionality before its deployment in the main project. This proactive approach mitigates potential risks and ensures a seamless integration process, ultimately enhancing the overall reliability and efficiency of the main project.
## Prerequisites
- Docker

## Installation
```bash
git clone git@github.com:heilgar/asyncphp-demo.git # Clone the repository
cd asyncphp-demo # Change to the project directory
chmod +x ./commands.sh # Make the script executable
./commands.sh build # Install dependencies and build the docker image
```

## Usage
```bash
./commands.sh bash # Run bash in the container

./command.sh serve # Start the PHP built-in server as a API server where requests are sent; Note: It will block terminal on purpose

./commands.sh run async # Run demo script asynchronously
./commands.sh run sync # Run demo script synchronously

# check execution time
docker run -v "$(pwd):/app" php time php async.php > /dev/null
docker run -v "$(pwd):/app" php time php sync.php > /dev/null
```

URLs for the HTTP requests are defined in the `src/BlockingExecutor.php`. You can modify the URLs to test different endpoints.
Number of parallel requests can be adjusted in the `main.php`.

## PHP Script Details
The main PHP script (main.php) performs the following tasks:

- Generates asynchronous tasks using ProcessTask class
- Executes tasks asynchronously using Amp parallel workers
- Utilizes Symfony HttpClient to make asynchronous HTTP requests
- Demonstrates asynchronous response handling and data processing