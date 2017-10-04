From: Paul Clarke <pc@us.ibm.com>
Subject: perf inject -s
Date: Wed, 4 Oct 2017 12:38:59 -0500
Message-ID: <5221d1a0-7172-9f6d-fef9-178283ce75e4@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751161AbdJDRjG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Oct 2017 13:39:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v94Hca3G087973
        for <linux-perf-users@vger.kernel.org>; Wed, 4 Oct 2017 13:39:05 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dd0e36kr9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Oct 2017 13:39:05 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
        Wed, 4 Oct 2017 13:39:04 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v94Hd0gR41681034
        for <linux-perf-users@vger.kernel.org>; Wed, 4 Oct 2017 17:39:00 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9FFDAC041
        for <linux-perf-users@vger.kernel.org>; Wed,  4 Oct 2017 13:39:37 -0400 (EDT)
Received: from oc8582848023.ibm.com (unknown [9.80.231.199])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS id 7230DAC043
        for <linux-perf-users@vger.kernel.org>; Wed,  4 Oct 2017 13:39:37 -0400 (EDT)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Is there a better description of what "perf inject -s" does?

The man page for "perf inject" says:
--
       -s, --sched-stat
           Merge sched_stat and sched_switch for getting events
           where and how long tasks slept. sched_switch contains
           a callchain where a task slept and sched_stat contains
           a timeslice how long a task slept.
--

Is it creating a new type of event?  If so, is the new event type visible to "perf script" and "perf script -s" ?

I just see events disappearing:
--
$ perf --version
perf version 4.13.rc4.gf2f132
$ perf record -e '{sched:sched_switch,sched:sched_migrate_task,sched:sched_process_exec,sched:sched_process_fork,sched:sched_process_exit,sched:sched_stat_runtime,sched:sched_stat_wait,sched:sched_stat_sleep,sched:sched_stat_blocked,sched:sched_stat_iowait}' -a sleep 0.001
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.144 MB perf.data (39 samples) ]
$ perf script
            perf  5852 [042] 2591904.272752: sched:sched_migrate_task: comm=perf pid=5853 prio=120 orig_cpu=49 dest_cpu=43
            perf  5852 [042] 2591904.272756:   sched:sched_stat_sleep: comm=perf pid=5853 delay=159273628 [ns]
         swapper     0 [043] 2591904.272760:    sched:sched_stat_wait: comm=perf pid=5853 delay=0 [ns]
         swapper     0 [043] 2591904.272761:       sched:sched_switch: swapper/43:0 [120] R ==> perf:5853 [120]
            perf  5853 [043] 2591904.273032: sched:sched_stat_runtime: comm=perf pid=5853 runtime=274344 [ns] vruntime=5217430079833775 [ns]
            perf  5853 [043] 2591904.273034:       sched:sched_switch: perf:5853 [120] R ==> migration/43:222 [0]
    migration/43   222 [043] 2591904.273058:    sched:sched_stat_wait: comm=perf pid=5853 delay=26246 [ns]
    migration/43   222 [043] 2591904.273061: sched:sched_migrate_task: comm=perf pid=5853 prio=120 orig_cpu=43 dest_cpu=50
         swapper     0 [050] 2591904.273126:    sched:sched_stat_wait: comm=perf pid=5853 delay=0 [ns]
    migration/43   222 [043] 2591904.273127:       sched:sched_switch: migration/43:222 [0] S ==> swapper/43:0 [120]
         swapper     0 [050] 2591904.273129:       sched:sched_switch: swapper/50:0 [120] R ==> perf:5853 [120]
            perf  5852 [042] 2591904.273647: sched:sched_stat_runtime: comm=perf pid=5852 runtime=3500692 [ns] vruntime=5674786469460196 [ns]
            perf  5852 [042] 2591904.273648:       sched:sched_switch: perf:5852 [120] S ==> swapper/42:0 [120]
           sleep  5853 [050] 2591904.273726: sched:sched_process_exec: filename=/bin/sleep pid=5853 old_pid=5853
           sleep  5853 [050] 2591904.274095: sched:sched_stat_runtime: comm=sleep pid=5853 runtime=1032442 [ns] vruntime=5600051654842876 [ns]
         swapper     0 [043] 2591904.274112:   sched:sched_stat_sleep: comm=rcu_sched pid=7 delay=4010582 [ns]
         swapper     0 [043] 2591904.274115:    sched:sched_stat_wait: comm=rcu_sched pid=7 delay=0 [ns]
         swapper     0 [043] 2591904.274115:       sched:sched_switch: swapper/43:0 [120] R ==> rcu_sched:7 [120]
       rcu_sched     7 [043] 2591904.274135: sched:sched_stat_runtime: comm=rcu_sched pid=7 runtime=23894 [ns] vruntime=2504293416526246 [ns]
       rcu_sched     7 [043] 2591904.274136:       sched:sched_switch: rcu_sched:7 [120] S ==> swapper/43:0 [120]
         swapper     0 [031] 2591904.274136:       sched:sched_switch: swapper/31:0 [120] R ==> watchdog/31:161 [0]
         swapper     0 [028] 2591904.274136:       sched:sched_switch: swapper/28:0 [120] R ==> watchdog/28:146 [0]
         swapper     0 [029] 2591904.274136:       sched:sched_switch: swapper/29:0 [120] R ==> watchdog/29:151 [0]
         swapper     0 [030] 2591904.274136:       sched:sched_switch: swapper/30:0 [120] R ==> watchdog/30:156 [0]
     watchdog/30   156 [030] 2591904.274144:       sched:sched_switch: watchdog/30:156 [0] S ==> swapper/30:0 [120]
     watchdog/31   161 [031] 2591904.274144:       sched:sched_switch: watchdog/31:161 [0] S ==> swapper/31:0 [120]
     watchdog/29   151 [029] 2591904.274144:       sched:sched_switch: watchdog/29:151 [0] S ==> swapper/29:0 [120]
     watchdog/28   146 [028] 2591904.274144:       sched:sched_switch: watchdog/28:146 [0] S ==> swapper/28:0 [120]
           sleep  5853 [050] 2591904.274335: sched:sched_stat_runtime: comm=sleep pid=5853 runtime=240060 [ns] vruntime=5600051655082936 [ns]
           sleep  5853 [050] 2591904.274337:       sched:sched_switch: sleep:5853 [120] S ==> swapper/50:0 [120]
         swapper     0 [050] 2591904.275412:   sched:sched_stat_sleep: comm=sleep pid=5853 delay=1073820 [ns]
         swapper     0 [050] 2591904.275415:    sched:sched_stat_wait: comm=sleep pid=5853 delay=0 [ns]
         swapper     0 [050] 2591904.275416:       sched:sched_switch: swapper/50:0 [120] R ==> sleep:5853 [120]
           sleep  5853 [050] 2591904.275507: sched:sched_process_exit: comm=sleep pid=5853 prio=120
         swapper     0 [042] 2591904.275595:   sched:sched_stat_sleep: comm=perf pid=5852 delay=1947804 [ns]
         swapper     0 [042] 2591904.275598:    sched:sched_stat_wait: comm=perf pid=5852 delay=0 [ns]
         swapper     0 [042] 2591904.275598:       sched:sched_switch: swapper/42:0 [120] R ==> perf:5852 [120]
           sleep  5853 [050] 2591904.275600: sched:sched_stat_runtime: comm=sleep pid=5853 runtime=189998 [ns] vruntime=5600051655272934 [ns]
           sleep  5853 [050] 2591904.275604:       sched:sched_switch: sleep:5853 [120] x ==> swapper/50:0 [120]
$ perf inject -v -s -i perf.data -o perf-inject.data
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_cfg80211.so
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_hrtimer.so
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_kvm.so
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_function.so
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_sched_switch.so
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_mac80211.so
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_jbd2.so
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_xen.so
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_kmem.so
registering plugin: /home/pc/perf/install/lib64/traceevent/plugins/plugin_scsi.so
overriding event (228) sched:sched_switch with new print handler
build id event received for [kernel.kallsyms]: 3a023a26703f05608a46e35e461924ec56867d60
build id event received for [vdso]: 105a65948f683eafab4085b19c97f00175dbf175
Looking at the vmlinux_path (8 entries long)
Failed to open /proc/kcore. Note /proc/kcore requires CAP_SYS_RAWIO capability to access.
Using /proc/kallsyms for symbols
Using CPUID 004b0201
$ perf script -i perf-inject.data
            perf  5852 [042] 2591904.272752: sched:sched_migrate_task: comm=perf pid=5853 prio=120 orig_cpu=49 dest_cpu=43
            perf  5853 [043] 2591904.273058:       sched:sched_switch: perf:5853 [120] R ==> migration/43:222 [0]
    migration/43   222 [043] 2591904.273061: sched:sched_migrate_task: comm=perf pid=5853 prio=120 orig_cpu=43 dest_cpu=50
            perf  5853 [043] 2591904.273126:       sched:sched_switch: perf:5853 [120] R ==> migration/43:222 [0]
           sleep  5853 [050] 2591904.273726: sched:sched_process_exec: filename=/bin/sleep pid=5853 old_pid=5853
           sleep  5853 [043] 2591904.274095:       sched:sched_switch: perf:5853 [120] R ==> migration/43:222 [0]
           sleep  5853 [043] 2591904.274335:       sched:sched_switch: perf:5853 [120] R ==> migration/43:222 [0]
           sleep  5853 [050] 2591904.275412:       sched:sched_switch: sleep:5853 [120] S ==> swapper/50:0 [120]
           sleep  5853 [050] 2591904.275415:       sched:sched_switch: sleep:5853 [120] S ==> swapper/50:0 [120]
            perf  5852 [042] 2591904.275595:       sched:sched_switch: perf:5852 [120] S ==> swapper/42:0 [120]
            perf  5852 [042] 2591904.275598:       sched:sched_switch: perf:5852 [120] S ==> swapper/42:0 [120]
--
PC
