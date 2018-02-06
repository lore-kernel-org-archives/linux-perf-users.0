From: "Du, Changbin" <changbin.du@intel.com>
Subject: A problem about 'perf sched latency'
Date: Tue, 6 Feb 2018 21:50:02 +0800
Message-ID: <20180206135002.sn32vfqgfz326rcb@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jolsa@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: changbin.du@intel.com
List-Id: linux-perf-users.vger.kernel.org

Hello all,
I am using perf sched tool to analyzer sched data on my machine. But it seems that 
'perf sched latency' report incorrect 'Switches'. What I did is as below.

First, record...
$ sudo perf sched record time pi 2000000 > /dev/null

Then check statistics. It says 'pi' only sched-in 1 time.
$ sudo ./perf sched latency | grep pi
  compiz:4054           |      6.389 ms |       30 | avg:    0.023 ms | max:    0.122 ms | max at:  94546.021080 s
  pi:4059               |   2083.241 ms |        1 | avg:    0.007 ms | max:    0.007 ms | max at:  94545.201435 s

But the sched event show 'pi' has been sched-in 7 times.
$ sudo ./perf sched script | grep pi:
              pi  4059 [001] 94545.820858:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1:32237 [120]
     kworker/1:1 32237 [001] 94545.820868:       sched:sched_switch: kworker/1:1:32237 [120] R ==> pi:4059 [120]
              pi  4059 [001] 94545.885412:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1H:320 [100]
    kworker/1:1H   320 [001] 94545.885419:       sched:sched_switch: kworker/1:1H:320 [100] R ==> pi:4059 [120]
              pi  4059 [001] 94545.907869:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1H:320 [100]
    kworker/1:1H   320 [001] 94545.907875:       sched:sched_switch: kworker/1:1H:320 [100] R ==> pi:4059 [120]
              pi  4059 [001] 94545.908104:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1H:320 [100]
    kworker/1:1H   320 [001] 94545.908108:       sched:sched_switch: kworker/1:1H:320 [100] R ==> pi:4059 [120]
              pi  4059 [001] 94545.916135:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1H:320 [100]
    kworker/1:1H   320 [001] 94545.916154:       sched:sched_switch: kworker/1:1H:320 [100] R ==> pi:4059 [120]
              pi  4059 [001] 94546.812856:       sched:sched_switch: pi:4059 [120] S ==> kworker/1:1:32237 [120]
     kworker/1:1 32237 [001] 94546.813148:       sched:sched_switch: kworker/1:1:32237 [120] R ==> pi:4059 [120]
              pi  4059 [001] 94546.885227:       sched:sched_switch: pi:4059 [120] S ==> i915/signal:1:207 [98]
   i915/signal:1   207 [001] 94546.885232:       sched:sched_switch: i915/signal:1:207 [98] D ==> pi:4059 [120]
              pi  4059 [001] 94547.285049:       sched:sched_switch: pi:4059 [120] x ==> swapper/1:0 [120]

Does anyone know why? Thank you! :)

-- 
Thanks,
Changbin Du
