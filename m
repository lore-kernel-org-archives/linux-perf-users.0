From: Solio Sarabia <solio.sarabia@intel.com>
Subject: Re: Differences in cpu utilization reported by sar, emon
Date: Tue, 10 Jul 2018 11:33:39 -0700
Message-ID: <20180710183339.GA3796@ssarabia-MOBL7.amr.corp.intel.com>
References: <20180615034133.GA5932@ssarabia-MOBL7.amr.corp.intel.com>
 <20180620234140.GA13040@ssarabia-MOBL7.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620234140.GA13040@ssarabia-MOBL7.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, ak@linux.intel.com, stephen@networkplumber.org
Cc: linux-perf-users@vger.kernel.org, kys@microsoft.com, amy.l.leeland@intel.com, shiny.sebastian@intel.com, solio.sarabia@intel.com
List-Id: linux-perf-users.vger.kernel.org

Further analysis shows that even with CONFIG_IRQ_TIME_ACCOUNTING or
DYNTICKS (CONFIG_VIRT_CPU_ACCOUNTING_GEN) there are some CPU cycles
lost. This difference correlates with the number of interrupts/sec
handled in the core, as the number increases, difference also does.

Network example (linux baremetal):
         sar    emon   emon-sar  interrupts/sec
core18   19.2   20.9   1.7       11057
core21   25.1   30.5   5.4       31472
core27   18.3   20.1   1.8       10384
core30    5.6   11.4   5.8       35841
core34   17.8   20.5   2.7       10973

Storage example (fio, device attached directly to vm):
         sar    perfmon   emon-perfmon  interrupts/sec
core10   7.4    19.7      12.3          100481

In the storage case, up to 12% irq cycles were not accounted. As users
start adopting more capable SSDs for instance, the issue will be more
evident. I would like to understand the reason as to why this happens:

What could be the reason for this issue?
Any pointers to the kernel subsystem/code performing time accounting?

Thanks,
-Solio


On Wed, Jun 20, 2018 at 04:41:40PM -0700, Solio Sarabia wrote:
> Thanks Andi, Stephen, for your help/insights.
> 
> TICK_CPU_ACCOUNTING (default option) does not account for cpu util on
> cores handling irqs and softriqs.
> 
> IRQ_TIME_ACCOUNTING or VIRT_CPU_ACCOUTING_GEN helps to reduce the util
> gap. With either option, there is still a difference, for example, up to
> 8% in terms of sar/emon ratio (sar shows lesser util). This is an
> improvement to the default case though.
> 
> 
> This is a brief description of the Kbuild options:
> 
> -> General setup
>   -> CPU/Task time and stats accounting
>     -> Cputime accounting
> TICK_CPU_ACCOUNTING
>     Simple/basic tick based cpu accounting--maintains statistics about
>     user, system and idle time spent on per jiffies granularity.
> VIRT_CPU_ACCOUNTING_NATIVE (not available on my kernel)
>     Deterministic task and cpu time accounting--more accurate task
>     and cpu time accounting. Kernel reads a cpu counter on each kernel
>     entry and exit, and on transitions within the kernel between
>     system, softirq, and hardirq state, so there is a small performance
>     impact.
> VIRT_CPU_ACCOUTING_GEN
>     Full dynticks cpu time accounting--enable task and cpu time
>     accounting on full dynticks systems. Kernel watches every
>     kernel-user boundaries using the context tracking subsystem.
>     There is significant overhead. For now only useful if you are
>     working on the full dynticks subsystem development.
> IRQ_TIME_ACCOUNTING
>     Fine granularity task level irq time accounting--kernel reads a
>     timestamp on each transition between softirq and hardirq state,
>     so there can be a performance impact.
> 
> -Solio
> 
> 
> On Thu, Jun 14, 2018 at 08:41:33PM -0700, Solio Sarabia wrote:
> > Hello --
> > 
> > I'm running into an issue where sar, mpstat, top, and other tools show
> > less cpu utilization compared to emon [1]. Sar uses /proc/stat as its
> > source, and was configured to collect in 1s intervals. Emon reads
> > hardware counter MSRs in the PMU in timer intervals, 0.1s for this
> > scenario.
> > 
> > The platform is based on Xeon E5-2699 v3 (Haswell) 2.3GHz, 2_sockets,
> > 18_cores/socket, 36_cores in total, running Ubuntu 16.04, Linux
> > 4.4.0-128-generic. A network micro workload, ntttcp-for-linux [2],
> > sends packets from client to server, through a 40GbE direct link.
> > Numbers below are from server side.
> > 
> >                  total %util
> >            CPU11    CPU21    CPU22    CPU25
> > emon       99.99    15.90    36.22    36.82
> > sar        99.99     0.06     0.36     0.35
> > 
> >                  interrupts/sec
> >            CPU11    CPU21    CPU22    CPU25
> > intrs/sec    846    28923    12844     6304
> >     Contributors to /proc/interrupts:
> >     CPU11: Local timer interrupts and Rescheduling interrupts
> >     CPU21-CPU25: PCI MSI vector from network driver
> > 
> >                  softirqs/sec
> >            CPU11    CPU21    CPU22    CPU25
> > TIMER        198        1        2        1
> > NET_RX         1    28889    23553    18546
> > TASKLET        0    28889    11676     6249
> > 
> > 
> > Somehow hardware irqs and softirqs do not have an effect on the core's
> > utilization. Another observation is that as more cores are used to
> > process packets, the emon/sar gap increases.
> > 
> > Kernels used default HZ=250. I also tried HZ=1000, which helped improve
> > throughput, but difference in util is still there. Same for newer
> > kernels 4.13, 4.15. I would appreciate pointers to debug this, or
> > insights as what could cause this behavior.
> > 
> > [1] https://software.intel.com/en-us/download/emon-users-guide
> > [2] https://github.com/simonxiaoss/ntttcp-for-linux
> > 
> > Thanks,
> > -Solio
