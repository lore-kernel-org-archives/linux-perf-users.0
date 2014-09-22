From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Mon, 22 Sep 2014 16:56:31 +0900
Message-ID: <87lhpcks0g.fsf@sejong.aot.lge.com>
References: <2221771.b2oSN5LR6X@milian-kdab2>
	<2297882.Vc1x1zOfA6@milian-kdab2> <20140918155745.GH2770@kernel.org>
	<45528931.El8SOGvs6Z@milian-kdab2> <20140918191713.GK2770@kernel.org>
	<874mw4m9pg.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo02.lge.com ([156.147.1.126]:35197 "EHLO
	lgeamrelo02.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbaIVH4e (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Sep 2014 03:56:34 -0400
In-Reply-To: <874mw4m9pg.fsf@sejong.aot.lge.com> (Namhyung Kim's message of
	"Fri, 19 Sep 2014 14:59:55 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <mail@milianw.de>, linux-perf-users <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>, David Ahern <dsahern@gmail.com>

On Fri, 19 Sep 2014 14:59:55 +0900, Namhyung Kim wrote:
> I'm also *very* interest in collecting idle/wait info using perf.  Looks
> like we can somehow use sched:* tracepoints but it requires root
> privilege though (unless /proc/sys/kernel/perf_event_paranoid being -1).
>
> With that restriction however, we might improve perf sched (or even
> plain perf record/report) to provide such info..  David may have an
> idea. :)

I wrote a naive script called tasktime that uses task-clock and
sched:sched_switch events to record and report task execution and wait
time.  Very lightly tested only..

The idea is that it counts time between context-switch and next
task-clock event as an wait time.  Callchain is searched with a pattern
similar to the parent pattern to find the reason of the switch.

Please have a look and give some comments! :)

Thanks,
Namhyung



From ff8497d91277c25d8c2c7688b7c056b38f799614 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 22 Sep 2014 16:08:30 +0900
Subject: [PATCH] perf script: Introduce a new 'tasktime' python script

The tasktime script record and report task execution (and wait) time
using task-clock and sched:sched_switch events.  When a task goes to a
context switch it searches callchain to have a certain pattern
(sys_.*|.*[^b][Ll]ock|page_fault) and prints with a "wait: " prefix.
If it fails to find the pattern in the callchain, it prints 'idle' or
'context-switch' depends on the next task scheduled.

Below is an example run of this script.  You can see 'context-switch'
overhead is around 0.8% of total execution time in this workload.

Note that this script is not complete and posted only for discussion.

  $ perf script record tasktime -- make clean all
  $ perf script report tasktime | head -20
   Overhead  Command           Shared Object         Symbol
   --------  ----------------  --------------------  ----------------
      2.15%  cc1               cc1                   ht_lookup_with_hash
      2.10%  cc1               cc1                   _cpp_lex_direct
      1.78%  cc1               libc-2.17.so          _int_malloc
      1.44%  cc1               cc1                   ggc_internal_alloc_stat
      1.39%  cc1               cc1                   htab_find_slot_with_hash
      0.85%  cc1               cc1                   bitmap_set_bit
      0.84%  cc1               cc1                   lex_identifier
      0.82%  cc1               libc-2.17.so          _int_free
      0.80%  cc1               <kernel>              context-switch
      0.57%  cc1               [kernel.kallsyms]     __do_page_fault
      0.55%  cc1               cc1                   cpp_get_token_1
      0.54%  cc1               cc1                   df_note_compute
      0.53%  cc1               cc1                   htab_find_with_hash
      0.53%  cc1               cc1                   for_each_rtx_1
      0.50%  cc1               libc-2.17.so          malloc_consolidate
      0.48%  cc1               cc1                   grokdeclarator
      0.46%  as                libc-2.17.so          __strncmp_sse42
      0.46%  as                as                    4260905

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/scripts/python/bin/tasktime-record |   3 +
 tools/perf/scripts/python/bin/tasktime-report |   3 +
 tools/perf/scripts/python/tasktime.py         | 125 ++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 tools/perf/scripts/python/bin/tasktime-record
 create mode 100644 tools/perf/scripts/python/bin/tasktime-report
 create mode 100644 tools/perf/scripts/python/tasktime.py

diff --git a/tools/perf/scripts/python/bin/tasktime-record b/tools/perf/scripts/python/bin/tasktime-record
new file mode 100644
index 000000000000..5aebcef93e55
--- /dev/null
+++ b/tools/perf/scripts/python/bin/tasktime-record
@@ -0,0 +1,3 @@
+#!/bin/bash
+perf record -gR -e task-clock -e sched:sched_switch $@
+
diff --git a/tools/perf/scripts/python/bin/tasktime-report b/tools/perf/scripts/python/bin/tasktime-report
new file mode 100644
index 000000000000..a21f8dea15e7
--- /dev/null
+++ b/tools/perf/scripts/python/bin/tasktime-report
@@ -0,0 +1,3 @@
+#!/bin/bash
+# description: analyze task execution and wait time
+perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/tasktime.py
diff --git a/tools/perf/scripts/python/tasktime.py b/tools/perf/scripts/python/tasktime.py
new file mode 100644
index 000000000000..0d69d94cb31b
--- /dev/null
+++ b/tools/perf/scripts/python/tasktime.py
@@ -0,0 +1,125 @@
+# perf script event handlers, generated by perf script -g python
+# Licensed under the terms of the GNU GPL License version 2
+
+# The common_* event handler fields are the most useful fields common to
+# all events.  They don't necessarily correspond to the 'common_*' fields
+# in the format files.  Those fields not available as handler params can
+# be retrieved using Python functions of the form common_*(context).
+# See the perf-trace-python Documentation for the list of available functions.
+
+import os
+import sys
+import re
+
+sys.path.append(os.environ['PERF_EXEC_PATH'] + \
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+from perf_trace_context import *
+from Core import *
+
+time_table = {}
+wait_table = []
+evcount = {}
+sample_count = {}
+wait_pattern = ''
+
+total_time = 0
+
+def trace_begin():
+	global wait_pattern
+	wait_pattern = re.compile(".*[^b][Ll]ock.*|sys_.*|page_fault")
+
+def trace_end():
+	output = [(k,time_table[k]) for k in time_table]
+	output.sort(key=lambda e: e[1], reverse=True)
+
+	print " Overhead  Command           Shared Object         Symbol"
+	print " --------  ----------------  --------------------  ----------------"
+	for entry in output:
+		key = entry[0].split(',')
+		print "  %6.2f%%  %-16s  %-20s  %s" % \
+		    ((100.0 * entry[1] / total_time), key[0], key[1], key[2])
+
+	print
+	print "[event stats]"
+	print "Total time:", total_time
+	print "Number of events:"
+	for k in evcount:
+		print "   ", k, evcount[k]
+
+def sched__sched_switch(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, prev_comm, prev_pid, prev_prio, prev_state, 
+	next_comm, next_pid, next_prio):
+
+	global total_time
+	if 'sched_switch' not in evcount:
+		evcount['sched_switch'] = 0
+	evcount['sched_switch'] += 1
+
+	ts = common_secs * 1000000000 + common_nsecs
+
+	if next_comm == 'swapper':
+		name = "idle"
+	else:
+		name = "context-switch"
+	dso = '<kernel>'
+
+	if common_callchain:
+		for entry in common_callchain:
+			if 'sym' not in entry:
+				continue
+			symname = entry['sym']['name']
+			if symname and wait_pattern.match(symname):
+				name = "wait: " + symname
+				dso = '<unknown>'
+				break
+
+	key = ','.join([common_comm, dso, name])
+	if key not in sample_count:
+		sample_count[key] = 0
+	sample_count[key] += 1
+	wait_table.insert(0, {'start': ts, 'end': 0, 'key': key,
+			      'prev': prev_comm, 'next': next_comm })
+
+def process_event(param_dict):
+	global total_time
+	event = param_dict['ev_name']
+	if event not in evcount:
+		evcount[event] = 0
+	evcount[event] += 1
+
+	comm = param_dict['comm']
+	if 'dso' in param_dict:
+		dso = os.path.basename(param_dict['dso'])
+	else:
+		dso = '<unknown>'
+	if 'symbol' in param_dict:
+		sym = param_dict['symbol']
+	else:
+		sym = str(param_dict['sample']['ip'])
+
+	key = ','.join([comm, dso, sym])
+	if key not in time_table:
+		time_table[key] = 0
+	time_table[key] += param_dict['sample']['period']
+	total_time += param_dict['sample']['period']
+
+	if key not in sample_count:
+		sample_count[key] = 0
+	sample_count[key] += 1
+
+	if len(wait_table) > 0 and wait_table[0]['end'] == 0:
+		ts_end = param_dict['sample']['time']
+		wait_table[0]['end'] = ts_end - param_dict['sample']['period']
+		waittime = wait_table[0]['end'] - wait_table[0]['start']
+		if waittime <= 0:
+			waittime = param_dict['sample']['period'] / 2
+		key = wait_table[0]['key']
+		if key not in time_table:
+			time_table[key] = 0
+		time_table[key] += waittime
+		total_time += waittime
+
+def trace_unhandled(event_name, context, event_fields_dict):
+		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
-- 
2.1.0
