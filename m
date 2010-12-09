From: "David S. Ahern" <daahern@cisco.com>
Subject: perf timechart: segfault in c_state_end
Date: Wed, 08 Dec 2010 17:56:04 -0700
Message-ID: <4D002924.9060504@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:31041 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab0LIA4G (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 8 Dec 2010 19:56:06 -0500
Received: from [10.20.182.150] (sjc-daahern-8915.cisco.com [10.20.182.150])
	by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id oB90u4NA018663
	for <linux-perf-users@vger.kernel.org>; Thu, 9 Dec 2010 00:56:05 GMT
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

'perf timechart' is segfaulting.

Latest perf-core.git: commit c277443cfc29b1623b4923219ff0bdb48b91b589

(gdb) set args timechart -i /tmp/perf-tc.data

(gdb) run
Starting program: /tmp/build-perf/perf timechart -i /tmp/perf-tc.data
[Thread debugging using libthread_db enabled]
Detaching after fork from child process 23900.

Program received signal SIGSEGV, Segmentation fault.
0x0000000000417199 in c_state_end (cpu=6291457,
timestamp=30181412965584) at builtin-timechart.c:364
364		pwr->state = cpus_cstate_state[cpu];

(gdb) bt
#0  0x0000000000417199 in c_state_end (cpu=6291457,
timestamp=30181412965584)
    at builtin-timechart.c:364
#1  0x0000000000417832 in process_sample_event (event=0x7ffff7f467e8,
sample=0x7fffffffdb30,
    session=0xba3990) at builtin-timechart.c:505
#2  0x0000000000447096 in perf_session_deliver_event (session=0xba3990,
event=0x7ffff7f467e8,
    sample=0x7fffffffdb30, ops=0x741560) at util/session.c:675
#3  0x0000000000446a26 in flush_sample_queue (s=0xba3990, ops=0x741560)
at util/session.c:487
#4  0x0000000000446b32 in process_finished_round (event=0x7ffff7f557c0,
session=0xba3990,
    ops=0x741560) at util/session.c:545
#5  0x000000000044748e in perf_session__process_event (session=0xba3990,
event=0x7ffff7f557c0,
    ops=0x741560, file_offset=128960) at util/session.c:757
#6  0x0000000000447cac in __perf_session__process_events
(session=0xba3990, data_offset=1160,
    data_size=669144, file_size=670304, ops=0x741560) at util/session.c:968
#7  0x0000000000447f14 in perf_session__process_events (self=0xba3990,
ops=0x741560)
    at util/session.c:1038
#8  0x0000000000418935 in __cmd_timechart () at builtin-timechart.c:949
#9  0x0000000000418bcf in cmd_timechart (argc=0, argv=0x7fffffffe150,
prefix=0x0)
    at builtin-timechart.c:1044

(gdb) print {struct sample_data} 0x7fffffffdb30
$1 = {ip = 18446744071579611228, pid = 0, tid = 0, time =
30181412965584, addr = 5210168, id = 50,
  stream_id = 17768320, period = 16, cpu = 0, raw_size = 28, raw_data =
0x7ffff7f4681c,
  callchain = 0xbb248679b4370ba3}

(gdb) print {struct power_entry} 0x7ffff7f4681c
$2 = {te = {type = 326, flags = 4 '\004', preempt_count = 0 '\000', pid
= 0, lock_depth = -1},
  type = 0, value = 38654705664, cpu_id = 9298719120581197825}
