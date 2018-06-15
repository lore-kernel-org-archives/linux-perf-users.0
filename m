From: Solio Sarabia <solio.sarabia@intel.com>
Subject: Differences in cpu utilization reported by sar, emon
Date: Thu, 14 Jun 2018 20:41:33 -0700
Message-ID: <20180615034133.GA5932@ssarabia-MOBL7.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, kys@microsoft.com, stephen@networkplumber.org, shiny.sebastian@intel.com, amy.l.leeland@intel.com, solio.sarabia@intel.com
List-Id: linux-perf-users.vger.kernel.org

Hello --

I'm running into an issue where sar, mpstat, top, and other tools show
less cpu utilization compared to emon [1]. Sar uses /proc/stat as its
source, and was configured to collect in 1s intervals. Emon reads
hardware counter MSRs in the PMU in timer intervals, 0.1s for this
scenario.

The platform is based on Xeon E5-2699 v3 (Haswell) 2.3GHz, 2_sockets,
18_cores/socket, 36_cores in total, running Ubuntu 16.04, Linux
4.4.0-128-generic. A network micro workload, ntttcp-for-linux [2],
sends packets from client to server, through a 40GbE direct link.
Numbers below are from server side.

                 total %util
           CPU11    CPU21    CPU22    CPU25
emon       99.99    15.90    36.22    36.82
sar        99.99     0.06     0.36     0.35

                 interrupts/sec
           CPU11    CPU21    CPU22    CPU25
intrs/sec    846    28923    12844     6304
    Contributors to /proc/interrupts:
    CPU11: Local timer interrupts and Rescheduling interrupts
    CPU21-CPU25: PCI MSI vector from network driver

                 softirqs/sec
           CPU11    CPU21    CPU22    CPU25
TIMER        198        1        2        1
NET_RX         1    28889    23553    18546
TASKLET        0    28889    11676     6249


Somehow hardware irqs and softirqs do not have an effect on the core's
utilization. Another observation is that as more cores are used to
process packets, the emon/sar gap increases.

Kernels used default HZ=250. I also tried HZ=1000, which helped improve
throughput, but difference in util is still there. Same for newer
kernels 4.13, 4.15. I would appreciate pointers to debug this, or
insights as what could cause this behavior.

[1] https://software.intel.com/en-us/download/emon-users-guide
[2] https://github.com/simonxiaoss/ntttcp-for-linux

Thanks,
-Solio
