#!/bin/bash


# Function to convert GB to MB
convert_gb_to_mb() {
    # 1gb => 1024mb
    local gb=$1
    echo "$(echo "scale=2; $gb * 1024" | bc)"
}
convert_mb_togb(){
    local mb=$1
    echo "$(echo "scale=2; $mb / 1024" | bc)"
}
# Function to display total CPU usage
get_cpu_usage() {
    echo "----- Total CPU Usage -----"
    # Declaring Bash variables
    cpu_usage=""
    # Calculate CPU usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8 "%"}')
    # get idle percentage for cpu and subtract it from 100 to get cpu usage
    # Output the result in a structured way
    echo "CPU Usage: $cpu_usage"
    echo ""
}


# Function to get memory usage
get_memory_usage() {
    echo "----- Total Memory (RAM) Usage -----"

    # Extract memory values
    memory_stats=$(free -h | grep Mem | awk '{print $2, $3, $4}' | sed 's/[A-Za-z]//g')
    # $2 -> total memory
    # $3 -> used memory
    # $4 -> free memory

    # sed 's/[A-Za-z]//g ' removes the unit (GB, MB, etc.) from the output

    total_memory=$(echo "$memory_stats" | awk '{print $1}')
    used_memory=$(echo "$memory_stats" | awk '{print $2}')
    free_memory=$(echo "$memory_stats" | awk '{print $3}')

    # Convert to desired units if necessary
    total_memory_gb=$(echo "scale=2; $total_memory" | bc)
    total_memory_mb=$(convert_gb_to_mb "$total_memory_gb")

    used_memory_mb=$(convert_gb_to_mb "$used_memory")
    used_memory_gb=$(convert_mb_togb "$used_memory_mb")

    free_memory_mb=$(convert_gb_to_mb "$free_memory")
    free_memory_gb=$(convert_mb_togb "$free_memory_mb")

    # Output the results
    echo "Total Memory: ($total_memory_gb GB - $total_memory_mb MB)"
    echo "Used Memory:  ($used_memory_gb GB - $used_memory_mb MB)"
    echo "Free Memory: ($free_memory_gb GB - $free_memory_mb MB)"
    echo ""


}


# Function to display total disk usage (free vs used)
get_disk_usage() {
    echo "----- Total Disk Usage -----"

    # Run `df -h` to get human-readable disk usage statistics and filter the root partition.
    disk_usage=$(df -h | awk '$NF=="/" {print $3}')  # Get the used disk space for the root partition.
    total_disk=$(df -h | awk '$NF=="/" {print $2}')  # Get the total disk space for the root partition.
    usage_percentage=$(df -h | awk '$NF=="/" {print $5}')  # Get the percentage of disk usage.
#   $NF -> Last Field

    # Display the results in a readable format.
    echo "Disk Usage: $disk_usage / $total_disk ($usage_percentage used)"
    echo ""
}

# Function to display top 5 processes by CPU usage
get_top_cpu_processes() {
    echo "----- Top 5 Processes by CPU Usage -----"
    # `top -bn1` provides a snapshot of the top processes. Sort by CPU usage using `head`.
    top -bn1 -o %CPU| head -n 15 | tail -n 5
    echo ""
}
get_top_mem_processes(){
    echo "----- Top 5 Processes by Memory Usage -----"
      # `top -bn1` provides a snapshot of the top processes. Sort by memory usage using `head`.
    top -bn1 -o %MEM | head -n 15 | tail -n 5

    echo ""
}


# Function to display OS version
get_os_version() {
    echo "----- OS Version -----"
    # `lsb_release -a` linux distro info
    lsb_release -a
    echo ""
}


get_logged_in_users(){
    echo "----- Logged-in Users -----"
    # `who` shows who is logged in to the system.
    who
    echo ""
}

# Function to display system uptime
get_uptime() {
    echo "----- Uptime -----"
    # `uptime` shows the system uptime, load averages, and number of users.
    uptime
    echo ""
}

# Function to display failed login attempts
get_failed_logins() {
    echo "----- Failed Login Attempts -----"
    # On Ubuntu, failed login attempts are logged in `/var/log/auth.log`.
    # `grep` filters the log for "Failed" attempts.
    # grep "Failed password" /var/log/auth.log | wc -l
    cat /var/log/auth.log | grep "Failed password"|wc -l
    echo ""
}
# Main function to call all stats
get_server_stats() {
    # get_cpu_usage
    get_memory_usage
    get_disk_usage
    get_top_cpu_processes
    get_top_mem_processes
    get_os_version
    get_uptime
    get_logged_in_users
    get_failed_logins
}

get_server_stats