#!/bin/bash

# Build Docker image
build() {
	docker run --rm --interactive --tty \
		-v "$(pwd):/app" \
		composer:lts install
    docker build -t php .
}

# Run bash shell in Docker container
bash() {
    docker run -it --rm -v "$(pwd):/app" php bash
}

# Run PHP script in Docker container with volume mount
run() {
    local script_name="$1.php"
    if [ -f "$script_name" ]; then
        docker run --add-host=host.docker.internal:172.17.0.1 -v "$(pwd):/app" php php "$script_name"
    else
        echo "Error: File $script_name not found."
        exit 1
    fi
}

serve() {
  docker run --add-host=host.docker.internal:172.17.0.1 -p 8000:8000 -v "$(pwd):/app" php -S 0.0.0.0:8000
}

execute_scripts_with_time() {
  docker run -v "$(pwd):/app" php time php async.php > /dev/null
  docker run -v "$(pwd):/app" php time php sync.php > /dev/null
#    local script1="$1"
#    local script2="$2"

    # TODO: Fix table output
    # Capture metrics for script 1
#    metrics_script1=$(docker run -v "$(pwd):/app" php time php "$script1.php" > /dev/null 2>&1)
#    echo "$metrics_script1"
#    user_time_script1=$(echo "$metrics_script1" | awk '{print $1}' | cut -d'u' -f1)
#    echo "$user_time_script1"
#    sys_time_script1=$(echo "$metrics_script1" | awk '{print $2}' | cut -d's' -f1)
#    elapsed_time_script1=$(echo "$metrics_script1" | awk '{print $3}' | cut -d'.' -f1-2)
#    cpu_usage_script1=$(echo "$metrics_script1" | awk '{print $4}' | cut -d'%' -f1)

    # Capture metrics for script 2
#    metrics_script2=$(docker run -v "$(pwd):/app" php time php "$script2.php" > /dev/null 2>&1)
#    echo "$metrics_script2"

#
#    user_time_script2=$(echo "$metrics_script2" | awk '{print $1}' | cut -d'u' -f1)
#    sys_time_script2=$(echo "$metrics_script2" | awk '{print $2}' | cut -d's' -f1)
#    elapsed_time_script2=$(echo "$metrics_script2" | awk '{print $3}' | cut -d'.' -f1-2)
#    cpu_usage_script2=$(echo "$metrics_script2" | awk '{print $4}' | cut -d'%' -f1)
#
#
#    echo "|  Script  |  Real Time (s)  |  User Time (s)  |  Sys Time (s)  |  CPU Usage (%)  |"
#    echo "|----------|-----------------|-----------------|----------------|-----------------|"
#    printf "|%-10s| %-16s| %-15s| %-15s| %-16s|\n" "$script1" "$elapsed_time_script1" "$user_time_script1" "$sys_time_script1" "$cpu_usage_script1"
#    printf "|%-10s| %-16s| %-15s| %-15s| %-16s|\n" "$script2" "$elapsed_time_script2" "$user_time_script2" "$sys_time_script2" "$cpu_usage_script2"

}

# Check command line arguments and execute corresponding function
case "$1" in
    build)
        build
        ;;
    bash)
        bash
        ;;
    serve)
        serve
        ;;
    run)
        if [ "$2" == "async" ]; then
            run "async"
        elif [ "$2" == "sync" ]; then
            run "sync"
        else
            echo "Usage: $0 run {async|sync}"
            exit 1
        fi
        ;;
    time) #todo: fix time output
        # Execute both scripts with time and display results
        execute_scripts_with_time "async" "sync"
        ;;
    *)
        echo "Usage: $0 {build|bash|run|time}"
        exit 1
        ;;
esac

exit 0