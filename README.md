## metrics-log

### top-metrics-log

Metrics from software **top** for write to the log file

Service path: **/etc/systemd/system/top-metrics-log.service** \
Script path: **/root/top-metrics-log.sh** \
Script variables: \
**path** - path to log file (example: /var/log/top-metrics.log) \
**trigger** - CPU load percentage (example: 20 %)

`systemctl daemon-reload` \
`systemctl enable icmp-test-log.service` \
`systemctl start icmp-test-log` \
`systemctl status icmp-test-log`

```bash
root@devops-01:~# systemctl status top-metrics-log.service
● top-metrics-log.service - Metrics from soft top for write to the log file
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
Sep 04 13:16:44 devops-01 bash[2404498]: 4 Sep 01:16:43  CPU(user): 60.0 %  CPU(system): 6.7 %  Proc: 1/239  Users: 2  MEM: 1599.3/3876.4 MB>
Sep 04 13:16:44 devops-01 bash[2404522]: Warning:  4 Sep 01:16:43  Top Process: java  Time: 5:12.71  CPU: 95.0 %  MEM: 13.6 MB  User: jenkins
Sep 04 13:16:46 devops-01 bash[2404572]: 4 Sep 01:16:46  CPU(user): 6.2 %  CPU(system): 6.2 %  Proc: 1/238  Users: 2  MEM: 1599.3/3876.4 MB >
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
