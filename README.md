# Server Statistics Bash Script

## Overview

This Bash script provides a comprehensive system monitoring tool that collects and displays various server performance and system information metrics. It offers a quick and easy way to get an overview of your server's current state.

## Features

The script provides the following system statistics:

### Memory Usage
- Total memory
- Used memory
- Free memory
- Displayed in both GB and MB

### Disk Usage
- Total disk space
- Used disk space
- Usage percentage for the root partition

### Process Monitoring
- Top 5 processes by CPU usage
- Top 5 processes by Memory usage

### System Information
- Operating System version
- System uptime
- Currently logged-in users
- Number of failed login attempts

## Prerequisites

- Bash shell
- Basic Linux utilities:
  - `top`
  - `free`
  - `df`
  - `lsb_release`
  - `who`
  - `uptime`
  - `bc` (for calculations)
  - `grep`
  - `awk`
  - `sed`

## Installation

1. Download the script
2. Make it executable:
   ```bash
   chmod +x server_stats.sh
   ```

## Usage

Run the script directly:
```bash
./server_stats.sh
```

## Functions

- `convert_gb_to_mb()`: Converts gigabytes to megabytes
- `convert_mb_togb()`: Converts megabytes to gigabytes
- `get_memory_usage()`: Retrieves and displays memory statistics
- `get_disk_usage()`: Shows disk space usage
- `get_top_cpu_processes()`: Lists top 5 CPU-intensive processes
- `get_top_mem_processes()`: Lists top 5 memory-intensive processes
- `get_os_version()`: Displays operating system details
- `get_uptime()`: Shows system uptime
- `get_logged_in_users()`: Lists currently logged-in users
- `get_failed_logins()`: Counts failed login attempts

## Notes

- Tested on Ubuntu/Debian-based systems
- Requires read access to system log files


## 📜 License  


- This project is licensed under the MIT License - see the [MIT](LICENSE) file for details.
---

## Acknowledgments

 Huge thanks to [roadmap.sh](https://roadmap.sh) for inspiring this server performance monitoring journey and empowering developers with clear, actionable system insights! 💡🚀 [Roadmap Project Link](https://roadmap.sh/projects/server-stats)
## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For support, please open an issue in the repository or contact the maintainer at zaidanali028@gmail.com.
---