## dir-monitor-log

Directory monitoring for get metric to **file count, size and modify.** When the number of files is changed, a diff of changes is logging.

**Service path:** /etc/systemd/system/[dir-monitor-log.service](https://github.com/Lifailon/get-metrics/blob/rsa/service/dir-monitor-log.service) \
**Script path:** /root/[dir-monitor-log.sh](https://github.com/Lifailon/get-metrics/blob/rsa/scripts/dir-monitor-log.sh) \
Script variables: \
**path_mon** - target directory for monitoring (example: **/var/lib/jenkins**) \
**path_log** - path to log file (example: **/var/log/metrics/dir-monitor.log**)

**Example:**

```bash
root@devops-01:~# systemctl daemon-reload
root@devops-01:~# systemctl enable dir-monitor-log.service
root@devops-01:~# systemctl start dir-monitor-log.service
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

## top-metrics-log

Collecting metrics from software **top** for write to the log file and **logging of high-load process**.

**Script path:** /root/[top-metrics-log.sh](https://github.com/Lifailon/get-metrics/blob/rsa/scripts/top-metrics-log.sh) \
Script variables: \
**path** - path to log file (example: **/var/log/metrics/top-metrics.log**) \
**trigger** - CPU load percentage (example: **20 %**) for logging for logging high-load process

**Initialization unit to systemd:** \
Creat service to path: /etc/systemd/system/[top-metrics-log.service](https://github.com/Lifailon/get-metrics/blob/rsa/service/top-metrics-log.service) \
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

Collection metrics **iostat** from the set sysstat for **write log file**

**Service path:** /etc/systemd/system/[iostat-metrics-log.service](https://github.com/Lifailon/get-metrics/blob/rsa/service/iostat-metrics-log.service) \
**Script path:** /root/[iostat-metrics-log.sh](https://github.com/Lifailon/get-metrics/blob/rsa/scripts/iostat-metrics-log.sh) \
Script variables: **path** - path to log file (example: **/var/log/metrics/iostat-metrics.log**)

```bash
root@devops-01:~# systemctl daemon-reload
root@devops-01:~# systemctl enable iostat-metrics-log.service
root@devops-01:~# systemctl start iostat-metrics-log.service
root@devops-01:~# systemctl status iostat-metrics-log.service
● iostat-metrics-log.service - Directory monitoring for get metric to file count, size and modify
     Loaded: loaded (/etc/systemd/system/iostat-metrics-log.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2023-09-05 12:44:33 MSK; 1min 20s ago
   Main PID: 724914 (bash)
      Tasks: 3 (limit: 4515)
     Memory: 14.7M
        CPU: 977ms
     CGroup: /system.slice/iostat-metrics-log.service
             ├─ 724914 /bin/bash /root/iostat-metrics-log.sh
             ├─ 729062 sleep 5
             └─2644388 iostat -yh /dev/sda 1

Sep 05 12:45:35 devops-01 bash[728116]: 5 Sep 12:45:34  tps = 0  read/s = 0.0k  write/s = 0.0k
Sep 05 12:45:41 devops-01 bash[728450]: 5 Sep 12:45:40  tps = 164  read/s = 0.0k  write/s = 1.4M
Sep 05 12:45:41 devops-01 bash[728465]: 5 Sep 12:45:40  tps = 0  read/s = 0.0k  write/s = 0.0k
Sep 05 12:45:41 devops-01 bash[728480]: 5 Sep 12:45:40  tps = 0  read/s = 0.0k  write/s = 0.0k
Sep 05 12:45:47 devops-01 bash[728776]: 5 Sep 12:45:46  tps = 123  read/s = 0.0k  write/s = 1.3M
Sep 05 12:45:47 devops-01 bash[728791]: 5 Sep 12:45:46  tps = 0  read/s = 0.0k  write/s = 0.0k
Sep 05 12:45:47 devops-01 bash[728806]: 5 Sep 12:45:46  tps = 0  read/s = 0.0k  write/s = 0.0k
Sep 05 12:45:54 devops-01 bash[729031]: 5 Sep 12:45:52  tps = 99  read/s = 0.0k  write/s = 1.2M
Sep 05 12:45:54 devops-01 bash[729046]: 5 Sep 12:45:52  tps = 0  read/s = 0.0k  write/s = 0.0k
Sep 05 12:45:54 devops-01 bash[729061]: 5 Sep 12:45:52  tps = 0  read/s = 0.0k  write/s = 0.0k
```

## logrotate

Automated log file rotation for all metrics: /etc/logrotate.d/[logrotate_metrics.conf](https://github.com/Lifailon/get-metrics/blob/rsa/logrotate_metrics.conf)

**Debug:**

``` bash
root@devops-01:~# logrotate -d /etc/logrotate.d/logrotate_metrics.conf
...
rotating pattern: /var/log/metrics/dir-monitor.log  10485760 bytes (2 rotations)
empty log files are rotated, old logs are removed
considering log /var/log/metrics/dir-monitor.log
Creating new state
  Now: 2023-09-05 21:31
  Last rotated at 2023-09-05 21:00
  log does not need rotating (log size is below the 'size' threshold)

rotating pattern: /var/log/metrics/top-metrics.log  10485760 bytes (2 rotations)
empty log files are rotated, old logs are removed
considering log /var/log/metrics/top-metrics.log
Creating new state
  Now: 2023-09-05 21:31
  Last rotated at 2023-09-05 21:00
  log does not need rotating (log size is below the 'size' threshold)

rotating pattern: /var/log/metrics/iostat-metrics.log  10485760 bytes (2 rotations)
empty log files are rotated, old logs are removed
considering log /var/log/metrics/iostat-metrics.log
Creating new state
  Now: 2023-09-05 21:31
  Last rotated at 2023-09-05 21:00
  log does not need rotating (log size is below the 'size' threshold)
```

## iostat-to-influxdb

**Service path:** /etc/systemd/system/[iostat-to-influxdb.service](https://github.com/Lifailon/get-metrics/blob/rsa/service/iostat-to-influxdb.service) \
**Script path:** /root/[iostat-to-influxdb.sh](https://github.com/Lifailon/get-metrics/blob/rsa/scripts/iostat-to-influxdb.sh) \
Script variables: \
**ip** - ip-address server InfluxDB \
**db** - Database name \
**table** - Measurement/Table name

```bash
root@devops-01:~# systemctl daemon-reload
root@devops-01:~# systemctl enable iostat-to-influxdb.service
root@devops-01:~# systemctl start iostat-to-influxdb.service
root@devops-01:~# systemctl status iostat-to-influxdb.service
● iostat-to-influxdb.service - Collection metrics iostat from the set sysstat for send to influxdb
     Loaded: loaded (/etc/systemd/system/iostat-to-influxdb.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2023-09-05 12:43:10 MSK; 1h 44min ago
   Main PID: 720656 (bash)
      Tasks: 4 (limit: 4515)
     Memory: 1.0M
        CPU: 1min 22.648s
     CGroup: /system.slice/iostat-to-influxdb.service
             ├─ 720656 /bin/bash /root/iostat-to-influxdb.sh
             ├─1039830 /bin/bash /root/iostat-to-influxdb.sh
             ├─1039831 iostat -ky /dev/sda /dev/sda1 /dev/sda2 /dev/sda3 /dev/sdb /dev/sdb1 /dev/sdc /dev/sdc1 1 1
             └─1039832 grep -w sd.

Sep 05 14:27:30 devops-01 bash[1039591]:                                  Dload  Upload   Total   Spent    Left  Speed
Sep 05 14:27:30 devops-01 bash[1039591]: [158B blob data]
Sep 05 14:27:30 devops-01 bash[1039591]: HTTP/1.1 204 No Content
Sep 05 14:27:30 devops-01 bash[1039591]: Content-Type: application/json
Sep 05 14:27:30 devops-01 bash[1039591]: Request-Id: 33045ca9-4bdf-11ee-bc29-000c294f9f2b
Sep 05 14:27:30 devops-01 bash[1039591]: X-Influxdb-Build: OSS
Sep 05 14:27:30 devops-01 bash[1039591]: X-Influxdb-Version: 1.7.11
Sep 05 14:27:30 devops-01 bash[1039591]: X-Request-Id: 33045ca9-4bdf-11ee-bc29-000c294f9f2b
Sep 05 14:27:30 devops-01 bash[1039591]: Date: Tue, 05 Sep 2023 11:27:30 GMT
Sep 05 14:27:30 devops-01 bash[1039591]:
```

### Data to InfluxDB

`SELECT * FROM "iostat_metrics_table" WHERE time > now() - 5m`

![Image alt](https://github.com/Lifailon/get-metrics/blob/rsa/screen/iostat-influxdb-data.jpg)

**Key by name selection:**

`SELECT * FROM iostat_metrics_table WHERE disk = 'sda' and time > now() - 10m`

![Image alt](https://github.com/Lifailon/get-metrics/blob/rsa/screen/iostat-influxdb-key-selection.jpg)

**Founction for output of the maximum tps value:**

`SELECT read_kb_sec,write_kb_sec,MAX(tps) FROM "iostat_metrics_table" GROUP BY instance`

![Image alt](https://github.com/Lifailon/get-metrics/blob/rsa/screen/iostat-influxdb-max-tps.jpg)
