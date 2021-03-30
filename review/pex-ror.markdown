# Typical problems on RoR:

## Start Resque:
log on as admin user on the app servers:

```bash

ls -1 pex/ | while read gcc; do cd pex/$gcc/current && ( QUEUES="enterprise_store, bod_queue, document_queue, payperiod_queue, resubmit_bod" RBENV_ROOT=~/.rbenv RBENV_VERSION=2.1.2 ~/.rbenv/bin/rbenv exec bundle exec rake RAILS_ENV=production QUEUE="*" PIDFILE=/var/run/resque/$gcc/resque_work_2.pid BACKGROUND=yes VERBOSE=1 INTERVAL=5 environment resque:work >> /dev/null 2>> /dev/null ) && cd ~ ; done

```


## Check processes status:

```bash
pyxadmqas01@pyxrrqap01:~> passenger-status 12494 --verbose
Version : 4.0.59
Date    : 2015-05-12 16:15:21 +0200
Instance: 12494
----------- General information -----------
Max pool size : 3
Processes     : 1
Requests in top-level queue : 0

----------- Application groups -----------
/home/pyxadmqas01/pex/lun/current#default:
  App root: /home/pyxadmqas01/pex/lun/current
  Requests in queue: 0
  * PID: 17563   Sessions: 0       Processed: 30      Uptime: 4h 0m 31s
    CPU: 0%      Memory  : 235M    Last used: 19m 10s a
    URL     : http://127.0.0.1:53765
    Password: DTwE2g0zvvELqdDyviXrzi3FvNADc0PVc1l03TX084R

pyxadmqas01@pyxrrqap01:~> curl -H "X-Passenger-Connect-Password: DTwE2g0zvvELqdDyviXrzi3FvNADc0PVc1l03TX084R" http://127.0.0.1:53765



```
You can connect to each process at the admin port and see if they are alive or not.
