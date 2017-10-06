From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: perf inject -s
Date: Fri, 06 Oct 2017 14:40:07 +0200
Message-ID: <2345862.hisy4Es4m5@agathebauer>
References: <5221d1a0-7172-9f6d-fef9-178283ce75e4@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:49214 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdJFMkL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Oct 2017 08:40:11 -0400
In-Reply-To: <5221d1a0-7172-9f6d-fef9-178283ce75e4@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Paul Clarke <pc@us.ibm.com>
Cc: linux-perf-users@vger.kernel.org

On Mittwoch, 4. Oktober 2017 19:38:59 CEST Paul Clarke wrote:
> Is there a better description of what "perf inject -s" does?
> 
> The man page for "perf inject" says:
> --
>        -s, --sched-stat
>            Merge sched_stat and sched_switch for getting events
>            where and how long tasks slept. sched_switch contains
>            a callchain where a task slept and sched_stat contains
>            a timeslice how long a task slept.
> --
> 
> Is it creating a new type of event?  If so, is the new event type visible to
> "perf script" and "perf script -s" ?

It's meant to be used for off-CPU profiling and also depends on the scheduler 
stat tracepoints, see also:

https://perf.wiki.kernel.org/index.php/Tutorial#Profiling_sleep_times
https://github.com/milianw/shell-helpers/blob/master/perf-sleep-record

I concur that the documentation should be expanded. The situation you show 
below shows an issue with `perf inject`: It currently takes the cost of the 
`sched_stat` tracepoint and sets it as the period of the `sched_switch` 
tracepoint. That makes it impossible to trace multiple stats in one go. 
Instead, one would need to take the switch out event's callgraph and set it on 
the `sched_stat` tracepoints, which would fix this situation.

Hope that helps

> I just see events disappearing:
> --
> $ perf --version
> perf version 4.13.rc4.gf2f132
> $ perf record -e
> '{sched:sched_switch,sched:sched_migrate_task,sched:sched_process_exec,sche
> d:sched_process_fork,sched:sched_process_exit,sched:sched_stat_runtime,sched
> :sched_stat_wait,sched:sched_stat_sleep,sched:sched_stat_blocked,sched:sched
> _stat_iowait}' -a sleep 0.001 [ perf record: Woken up 1 times to write data
> ]
> [ perf record: Captured and wrote 0.144 MB perf.data (39 samples) ]
> $ perf script
>             perf  5852 [042] 2591904.272752: sched:sched_migrate_task:
> comm=perf pid=5853 prio=120 orig_cpu=49 dest_cpu=43 perf  5852 [042]
> 2591904.272756:   sched:sched_stat_sleep: comm=perf pid=5853
> delay=159273628 [ns] swapper     0 [043] 2591904.272760:   
> sched:sched_stat_wait: comm=perf pid=5853 delay=0 [ns] swapper     0 [043]
> 2591904.272761:       sched:sched_switch: swapper/43:0 [120] R ==>
> perf:5853 [120] perf  5853 [043] 2591904.273032: sched:sched_stat_runtime:
> comm=perf pid=5853 runtime=274344 [ns] vruntime=5217430079833775 [ns] perf 
> 5853 [043] 2591904.273034:       sched:sched_switch: perf:5853 [120] R ==>
> migration/43:222 [0] migration/43   222 [043] 2591904.273058:   
> sched:sched_stat_wait: comm=perf pid=5853 delay=26246 [ns] migration/43  
> 222 [043] 2591904.273061: sched:sched_migrate_task: comm=perf pid=5853
> prio=120 orig_cpu=43 dest_cpu=50 swapper     0 [050] 2591904.273126:   
> sched:sched_stat_wait: comm=perf pid=5853 delay=0 [ns] migration/43   222
> [043] 2591904.273127:       sched:sched_switch: migration/43:222 [0] S ==>
> swapper/43:0 [120] swapper     0 [050] 2591904.273129:      
> sched:sched_switch: swapper/50:0 [120] R ==> perf:5853 [120] perf  5852
> [042] 2591904.273647: sched:sched_stat_runtime: comm=perf pid=5852
> runtime=3500692 [ns] vruntime=5674786469460196 [ns] perf  5852 [042]
> 2591904.273648:       sched:sched_switch: perf:5852 [120] S ==>
> swapper/42:0 [120] sleep  5853 [050] 2591904.273726:
> sched:sched_process_exec: filename=/bin/sleep pid=5853 old_pid=5853 sleep 
> 5853 [050] 2591904.274095: sched:sched_stat_runtime: comm=sleep pid=5853
> runtime=1032442 [ns] vruntime=5600051654842876 [ns] swapper     0 [043]
> 2591904.274112:   sched:sched_stat_sleep: comm=rcu_sched pid=7
> delay=4010582 [ns] swapper     0 [043] 2591904.274115:   
> sched:sched_stat_wait: comm=rcu_sched pid=7 delay=0 [ns] swapper     0
> [043] 2591904.274115:       sched:sched_switch: swapper/43:0 [120] R ==>
> rcu_sched:7 [120] rcu_sched     7 [043] 2591904.274135:
> sched:sched_stat_runtime: comm=rcu_sched pid=7 runtime=23894 [ns]
> vruntime=2504293416526246 [ns] rcu_sched     7 [043] 2591904.274136:      
> sched:sched_switch: rcu_sched:7 [120] S ==> swapper/43:0 [120] swapper    
> 0 [031] 2591904.274136:       sched:sched_switch: swapper/31:0 [120] R ==>
> watchdog/31:161 [0] swapper     0 [028] 2591904.274136:      
> sched:sched_switch: swapper/28:0 [120] R ==> watchdog/28:146 [0] swapper   
>  0 [029] 2591904.274136:       sched:sched_switch: swapper/29:0 [120] R ==>
> watchdog/29:151 [0] swapper     0 [030] 2591904.274136:      
> sched:sched_switch: swapper/30:0 [120] R ==> watchdog/30:156 [0]
> watchdog/30   156 [030] 2591904.274144:       sched:sched_switch:
> watchdog/30:156 [0] S ==> swapper/30:0 [120] watchdog/31   161 [031]
> 2591904.274144:       sched:sched_switch: watchdog/31:161 [0] S ==>
> swapper/31:0 [120] watchdog/29   151 [029] 2591904.274144:      
> sched:sched_switch: watchdog/29:151 [0] S ==> swapper/29:0 [120]
> watchdog/28   146 [028] 2591904.274144:       sched:sched_switch:
> watchdog/28:146 [0] S ==> swapper/28:0 [120] sleep  5853 [050]
> 2591904.274335: sched:sched_stat_runtime: comm=sleep pid=5853
> runtime=240060 [ns] vruntime=5600051655082936 [ns] sleep  5853 [050]
> 2591904.274337:       sched:sched_switch: sleep:5853 [120] S ==>
> swapper/50:0 [120] swapper     0 [050] 2591904.275412:  
> sched:sched_stat_sleep: comm=sleep pid=5853 delay=1073820 [ns] swapper    
> 0 [050] 2591904.275415:    sched:sched_stat_wait: comm=sleep pid=5853
> delay=0 [ns] swapper     0 [050] 2591904.275416:       sched:sched_switch:
> swapper/50:0 [120] R ==> sleep:5853 [120] sleep  5853 [050] 2591904.275507:
> sched:sched_process_exit: comm=sleep pid=5853 prio=120 swapper     0 [042]
> 2591904.275595:   sched:sched_stat_sleep: comm=perf pid=5852 delay=1947804
> [ns] swapper     0 [042] 2591904.275598:    sched:sched_stat_wait:
> comm=perf pid=5852 delay=0 [ns] swapper     0 [042] 2591904.275598:      
> sched:sched_switch: swapper/42:0 [120] R ==> perf:5852 [120] sleep  5853
> [050] 2591904.275600: sched:sched_stat_runtime: comm=sleep pid=5853
> runtime=189998 [ns] vruntime=5600051655272934 [ns] sleep  5853 [050]
> 2591904.275604:       sched:sched_switch: sleep:5853 [120] x ==>
> swapper/50:0 [120] $ perf inject -v -s -i perf.data -o perf-inject.data
> registering plugin:
> /home/pc/perf/install/lib64/traceevent/plugins/plugin_cfg80211.so
> registering plugin:
> /home/pc/perf/install/lib64/traceevent/plugins/plugin_hrtimer.so
> registering plugin:
> /home/pc/perf/install/lib64/traceevent/plugins/plugin_kvm.so registering
> plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_function.so
> registering plugin:
> /home/pc/perf/install/lib64/traceevent/plugins/plugin_sched_switch.so
> registering plugin:
> /home/pc/perf/install/lib64/traceevent/plugins/plugin_mac80211.so
> registering plugin:
> /home/pc/perf/install/lib64/traceevent/plugins/plugin_jbd2.so registering
> plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_xen.so
> registering plugin:
> /home/pc/perf/install/lib64/traceevent/plugins/plugin_kmem.so registering
> plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_scsi.so
> overriding event (228) sched:sched_switch with new print handler
> build id event received for [kernel.kallsyms]:
> 3a023a26703f05608a46e35e461924ec56867d60 build id event received for
> [vdso]: 105a65948f683eafab4085b19c97f00175dbf175 Looking at the
> vmlinux_path (8 entries long)
> Failed to open /proc/kcore. Note /proc/kcore requires CAP_SYS_RAWIO
> capability to access. Using /proc/kallsyms for symbols
> Using CPUID 004b0201
> $ perf script -i perf-inject.data
>             perf  5852 [042] 2591904.272752: sched:sched_migrate_task:
> comm=perf pid=5853 prio=120 orig_cpu=49 dest_cpu=43 perf  5853 [043]
> 2591904.273058:       sched:sched_switch: perf:5853 [120] R ==>
> migration/43:222 [0] migration/43   222 [043] 2591904.273061:
> sched:sched_migrate_task: comm=perf pid=5853 prio=120 orig_cpu=43
> dest_cpu=50 perf  5853 [043] 2591904.273126:       sched:sched_switch:
> perf:5853 [120] R ==> migration/43:222 [0] sleep  5853 [050]
> 2591904.273726: sched:sched_process_exec: filename=/bin/sleep pid=5853
> old_pid=5853 sleep  5853 [043] 2591904.274095:       sched:sched_switch:
> perf:5853 [120] R ==> migration/43:222 [0] sleep  5853 [043]
> 2591904.274335:       sched:sched_switch: perf:5853 [120] R ==>
> migration/43:222 [0] sleep  5853 [050] 2591904.275412:      
> sched:sched_switch: sleep:5853 [120] S ==> swapper/50:0 [120] sleep  5853
> [050] 2591904.275415:       sched:sched_switch: sleep:5853 [120] S ==>
> swapper/50:0 [120] perf  5852 [042] 2591904.275595:      
> sched:sched_switch: perf:5852 [120] S ==> swapper/42:0 [120] perf  5852
> [042] 2591904.275598:       sched:sched_switch: perf:5852 [120] S ==>
> swapper/42:0 [120] --
> PC
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
