## top-metrics-log

Collecting metrics from software **top** for write to the log file and **logging of high-load process**.

Script path: **/root/[top-metrics-log.sh](https://github.com/Lifailon/monitoring-metrics-log/blob/rsa/scripts/top-metrics-log.sh)** \
Script set variables: \
**path** - path to log file (example: **/var/log/top-metrics.log**) \
**trigger** - CPU load percentage (example: **20 %**) for logging for logging high-load process

**Initialization unit systemd:** \
Creat service to path: **/etc/systemd/system/[top-metrics-log.service](https://github.com/Lifailon/monitoring-metrics-log/blob/rsa/service/top-metrics-log.service)** \
`systemctl daemon-reload` \
`systemctl enable top-metrics-log.service` \
`systemctl start top-metrics-log`

```bash
root@devops-01:~# systemctl status top-metrics-log.service
● top-metrics-log.service - Metrics from software top for write to the log file
     Loaded: loaded (/etc/systemd/system/top-metrics-log.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2023-09-04 09:45:32 MSK; 3h 31min ago
   Main PID: 2023242 (bash)
      Tasks: 2 (limit: 4515)
     Memory: 7.0M
        CPU: 6min 20.318s
     CGroup: /system.slice/top-metrics-log.service
             ├─2023242 /bin/bash /root/top-metrics-log.sh
             └─2404579 sleep 2

Sep 04 13:16:34 devops-01 bash[2404195]: 4 Sep 01:16:34  CPU(user): 14.3 %  CPU(system): 7.1 %  Proc: 1/239  Users: 2  MEM: 1598.5/3876.4 MB>
Sep 04 13:16:34 devops-01 bash[2404219]: Warning:  4 Sep 01:16:34  Top Process: mysqld  Time: 86:30.06  CPU: 12.5 %  MEM: 18.3 MB  User: mys>
Sep 04 13:16:36 devops-01 bash[2404278]: 4 Sep 01:16:36  CPU(user): 7.1 %  CPU(system): 7.1 %  Proc: 1/239  Users: 2  MEM: 1598.7/3876.4 MB >
Sep 04 13:16:39 devops-01 bash[2404334]: 4 Sep 01:16:39  CPU(user): 52.9 %  CPU(system): 5.9 %  Proc: 2/239  Users: 2  MEM: 1598.9/3876.4 MB>
Sep 04 13:16:39 devops-01 bash[2404358]: Warning:  4 Sep 01:16:39  Top Process: java  Time: 5:10.34  CPU: 50.0 %  MEM: 13.3 MB  User: jenkins
Sep 04 13:16:41 devops-01 bash[2404416]: 4 Sep 01:16:41  CPU(user): 58.8 %  CPU(system): 0.0 %  Proc: 2/239  Users: 2  MEM: 1598.9/3876.4 MB>
Sep 04 13:16:41 devops-01 bash[2404440]: Warning:  4 Sep 01:16:41  Top Process: java  Time: 5:11.27  CPU: 56.2 %  MEM: 13.4 MB  User: jenkins
~
~
~
root@devops-01:~# cat /var/log/top-metrics.log
4 Sep 01:16:34  CPU(user): 14.3 %  CPU(system): 7.1 %  Proc: 1/239  Users: 2  MEM: 1598.5/3876.4 MB  SWAP: 0.8/3889.0 MB
Warning:  4 Sep 01:16:34  Top Process: mysqld  Time: 86:30.06  CPU: 12.5 %  MEM: 18.3 MB  User: mysql
4 Sep 01:16:36  CPU(user): 7.1 %  CPU(system): 7.1 %  Proc: 1/239  Users: 2  MEM: 1598.7/3876.4 MB  SWAP: 0.8/3889.0 MB
4 Sep 01:16:39  CPU(user): 52.9 %  CPU(system): 5.9 %  Proc: 2/239  Users: 2  MEM: 1598.9/3876.4 MB  SWAP: 0.8/3889.0 MB
Warning:  4 Sep 01:16:39  Top Process: java  Time: 5:10.34  CPU: 50.0 %  MEM: 13.3 MB  User: jenkins
4 Sep 01:16:41  CPU(user): 58.8 %  CPU(system): 0.0 %  Proc: 2/239  Users: 2  MEM: 1598.9/3876.4 MB  SWAP: 0.8/3889.0 MB
Warning:  4 Sep 01:16:41  Top Process: java  Time: 5:11.27  CPU: 56.2 %  MEM: 13.4 MB  User: jenkins
4 Sep 01:16:43  CPU(user): 60.0 %  CPU(system): 6.7 %  Proc: 1/239  Users: 2  MEM: 1599.3/3876.4 MB  SWAP: 0.8/3889.0 MB
Warning:  4 Sep 01:16:43  Top Process: java  Time: 5:12.71  CPU: 95.0 %  MEM: 13.6 MB  User: jenkins
4 Sep 01:16:46  CPU(user): 6.2 %  CPU(system): 6.2 %  Proc: 1/238  Users: 2  MEM: 1599.3/3876.4 MB  SWAP: 0.8/3889.0 MB
4 Sep 01:16:48  CPU(user): 6.7 %  CPU(system): 6.7 %  Proc: 1/242  Users: 2  MEM: 1599.3/3876.4 MB  SWAP: 0.8/3889.0 MB
```

## iostat-metrics-log

Metrics for **iostat** from the set **sysstat**

```bash
root@devops-01:~# systemctl daemon-reload
root@devops-01:~# systemctl enable iostat-metrics-log.service
root@devops-01:~# systemctl start iostat-metrics-log.service
root@devops-01:~# systemctl status iostat-metrics-log.service
● iostat-metrics-log.service - Metrics for iostat from the set sysstat
     Loaded: loaded (/etc/systemd/system/iostat-metrics-log.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2023-09-04 15:27:38 MSK; 2min 46s ago
   Main PID: 2655004 (bash)
      Tasks: 3 (limit: 4515)
     Memory: 1.1M
        CPU: 894ms
     CGroup: /system.slice/iostat-metrics-log.service
             ├─2644388 iostat -yh /dev/sda 1
             ├─2655004 /bin/bash /root/iostat-metrics-log.sh
             └─2660908 sleep 5

Sep 04 15:29:19 devops-01 bash[2658546]: 4 Sep 03:29:17  tps = 56  read/s = 0.0k  write/s = 844.0k
Sep 04 15:29:26 devops-01 bash[2658766]: 4 Sep 03:29:24  tps = 50  read/s = 0.0k  write/s = 744.0k
Sep 04 15:29:33 devops-01 bash[2659097]: 4 Sep 03:29:31  tps = 72  read/s = 0.0k  write/s = 956.0k
Sep 04 15:29:40 devops-01 bash[2659464]: 4 Sep 03:29:38  tps = 85  read/s = 0.0k  write/s = 1020.0k
Sep 04 15:29:47 devops-01 bash[2659671]: 4 Sep 03:29:45  tps = 73  read/s = 0.0k  write/s = 1020.0k
Sep 04 15:29:54 devops-01 bash[2659900]: 4 Sep 03:29:52  tps = 96  read/s = 0.0k  write/s = 1.1M
Sep 04 15:30:01 devops-01 bash[2660152]: 4 Sep 03:29:59  tps = 63  read/s = 0.0k  write/s = 1.0M
Sep 04 15:30:08 devops-01 bash[2660359]: 4 Sep 03:30:06  tps = 73  read/s = 0.0k  write/s = 1.1M
Sep 04 15:30:15 devops-01 bash[2660615]: 4 Sep 03:30:13  tps = 61  read/s = 0.0k  write/s = 1.1M
Sep 04 15:30:22 devops-01 bash[2660906]: 4 Sep 03:30:20  tps = 135  read/s = 0.0k  write/s = 1.6M
```

## dir-monitor-log

Directory monitoring for get metric to **file count, size and modify.**

Service path: **/etc/systemd/system/dir-monitor-log.service** \
Script path: **/root/dir-monitor-log.sh** \
Script set variables: **path** - path to log file (example: **/var/log/dir-monitor.log**)

**Example test:**

```bash
root@devops-01:~# touch /var/lib/jenkins/test /var/lib/jenkins/test2
root@devops-01:~# sleep 10
root@devops-01:~# rm /var/lib/jenkins/test /var/lib/jenkins/test2
root@devops-01:~# sleep 10
root@devops-01:~# cat "/var/log/dir-monitor.log" | tail -n 15
4 Sep 01:40:41  Size: 333M  File Count: 12107  Modify: 4 Sep 13:35
4 Sep 01:40:52  Size: 333M  File Count: 12107  Modify: 4 Sep 13:35
4 Sep 01:41:02  Size: 333M  File Count: 12107  Modify: 4 Sep 13:35
4 Sep 01:41:12  Size: 333M  File Count: 12107  Modify: 4 Sep 13:35
4 Sep 01:41:22  Size: 333M  File Count: 12107  Modify: 4 Sep 13:35
4 Sep 01:41:32  Size: 333M  File Count: 12107  Modify: 4 Sep 13:35
4 Sep 01:41:43  Size: 333M  File Count: 12107  Modify: 4 Sep 13:35
4 Sep 01:41:53  Size: 333M  File Count: 12109  Modify: 4 Sep 13:41
+ 0     /var/lib/jenkins/test2
+ 0     /var/lib/jenkins/test
4 Sep 01:42:03  Size: 333M  File Count: 12107  Modify: 4 Sep 13:42
- 0     /var/lib/jenkins/test2
- 0     /var/lib/jenkins/test
4 Sep 01:42:13  Size: 333M  File Count: 12107  Modify: 4 Sep 13:42
4 Sep 01:42:24  Size: 333M  File Count: 12107  Modify: 4 Sep 13:42
```
