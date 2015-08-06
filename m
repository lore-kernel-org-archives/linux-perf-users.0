From: Tony Jones <tonyj@suse.com>
Subject: [PATCH] perf script/python: add new compaction-times script
Date: Thu,  6 Aug 2015 16:01:56 -0700
Message-ID: <1438902116-9320-1-git-send-email-tonyj@suse.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54785 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbbHFXBw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Aug 2015 19:01:52 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mel Gorman <mgorman@suse.com>

This patch creates a new script (compaction-times) to report time
spent in mm compaction. Report times in nanoseconds (default) or
microseconds (-u). Option -p will break down times by process id,
-pv will further decompose by each compaction entry/exit.
Entries may be further filtered by pid, pid-range or comm (regex).

The script is useful when analysing workloads that compact memory.
The most common example will be THP allocations on systems with a
lot of uptime that has fragmented memory. This is an example of
using the script to analyse a thpscale from mmtests which
deliberately fragments memory and allocates THP in 4 separate
threads

   # Recording step, one of the following;
   $ perf record -e 'compaction:mm_compaction_*' ./workload
   $ perf script record compaction-times

   # Reporting: basic
   $ perf script report compaction-times
   total: 15825912302ns (1416084 migrated 160674 failed)

   # Reporting: Per task stall times
   $ perf script report compaction-times -- -p
   total: 15825912302ns (1416084 migrated 160674 failed)
   5024[thpscale]: 2588338168ns (476189 migrated 32 failed)
   5025[thpscale]: 2469205861ns (460767 migrated 7 failed)
   5026[thpscale]: 8246032631ns (659 migrated 160621 failed)
   5023[thpscale]: 2522335642ns (478469 migrated 14 failed)

   # Reporting: Per-compaction attempt broken down by task
   $ perf script report compaction-times -- -pv
   total: 15825912302ns (1416084 migrated 160674 failed)
   5024[thpscale]: 2588338168ns (476189 migrated 32 failed)
   5024[thpscale].1: 3549721ns (352 migrated 0 failed)
   5024[thpscale].2: 173091ns (32 migrated 0 failed)
   5024[thpscale].3: 695548ns (160 migrated 0 failed)
   5024[thpscale].4: 138561ns (32 migrated 0 failed)
   5024[thpscale].5: 1123068ns (224 migrated 0 failed)
   5024[thpscale].6: 163610ns (32 migrated 0 failed)
   ..... output continues ...

Signed-off-by: Tony Jones <tonyj@suse.com>
Cc: Mel Gorman <mgorman@suse.com>
---
 .../scripts/python/bin/compaction-times-record     |   2 +
 .../scripts/python/bin/compaction-times-report     |   4 +
 tools/perf/scripts/python/compaction-times.py      | 219 +++++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 tools/perf/scripts/python/bin/compaction-times-record
 create mode 100644 tools/perf/scripts/python/bin/compaction-times-report
 create mode 100644 tools/perf/scripts/python/compaction-times.py

diff --git a/tools/perf/scripts/python/bin/compaction-times-record b/tools/perf/scripts/python/bin/compaction-times-record
new file mode 100644
index 0000000..2b7fc42
--- /dev/null
+++ b/tools/perf/scripts/python/bin/compaction-times-record
@@ -0,0 +1,2 @@
+#!/bin/bash
+perf record -e compaction:mm_compaction_begin -e compaction:mm_compaction_end -e compaction:mm_compaction_migratepages $@
diff --git a/tools/perf/scripts/python/bin/compaction-times-report b/tools/perf/scripts/python/bin/compaction-times-report
new file mode 100644
index 0000000..65c5b64
--- /dev/null
+++ b/tools/perf/scripts/python/bin/compaction-times-report
@@ -0,0 +1,4 @@
+#!/bin/bash
+#description: display time taken by mm compaction
+#args: [-p|-pv] [-u] [pid|pid-range|comm-regex]
+perf script -s "$PERF_EXEC_PATH"/scripts/python/compaction-times.py $@
diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
new file mode 100644
index 0000000..961bc27
--- /dev/null
+++ b/tools/perf/scripts/python/compaction-times.py
@@ -0,0 +1,219 @@
+# report time spent in compaction
+# Licensed under the terms of the GNU GPL License version 2
+
+# testing:
+# 'echo 1 > /proc/sys/vm/compact_memory' to force compaction of all zones
+
+import os
+import sys
+import re
+
+usage = "perf script -s compaction-times.py -- [-p|-pv] [-u] [pid|pid-range|comm-regex]"
+
+class pdisp:
+	DISP_DFL=0
+	DISP_PROC=1
+	DISP_PROC_VERBOSE=2
+
+class comm_filter:
+	def __init__(self, re):
+		self.re = re
+
+	def filter(self, pid, comm):
+		m=self.re.search(comm)
+		return m==None or m.group() == ""
+
+class pid_filter:
+	def __init__(self, low, high):
+		self.low = (0 if low == "" else int(low))
+		self.high = (0 if high == "" else int(high))
+
+	def filter(self, pid, comm):
+		return not (pid >= self.low and (self.high == 0 or pid <= self.high))
+
+def ns(sec, nsec):
+	return (sec * 1000000000) + nsec;
+
+def time(ns):
+	return "%dns" % ns if opt_ns else "%dus" % (round(ns, -3) / 1000)
+
+class cnode:
+	def __init__(self, ns=0, nmigrated=0, nfailed=0):
+		self.ns = ns
+		self.nmigrated = nmigrated
+		self.nfailed = nfailed
+
+	def complete(self, secs, nsecs):
+		self.ns = ns(secs, nsecs) - self.ns
+
+	def increment(self, nmigrated, nfailed):
+		self.nmigrated += nmigrated
+		self.nfailed += nfailed
+
+	def __str__(self):
+		return "%s (%d migrated %d failed)" % (time(self.ns), self.nmigrated, self.nfailed)
+
+class chead:
+	heads = {}
+	ns = 0
+	nmigrated = 0
+	nfailed = 0
+	fobj = None
+
+	@classmethod
+	def add_filter(cls, filter):
+		cls.fobj = filter
+
+	@classmethod
+	def create_pending(cls, pid, comm, start_secs, start_nsecs):
+		filtered=0
+		try:
+			head = cls.heads[pid]
+			filtered=head.is_filtered()
+		except KeyError:
+			if cls.fobj != None:
+				filtered=cls.fobj.filter(pid, comm)
+			head = cls.heads[pid] = chead(comm, pid, filtered)
+
+		if not filtered:
+			head.mark_pending(start_secs, start_nsecs)
+
+	@classmethod
+	def increment_pending(cls, pid, nmigrated, nfailed):
+		head = cls.heads[pid]
+		if not head.is_filtered():
+			if head.is_pending():
+				head.do_increment(nmigrated, nfailed)
+			else:
+				print "missing start compaction event for pid %d" % pid
+
+	@classmethod
+	def complete_pending(cls, pid, secs, nsecs):
+		head = cls.heads[pid]
+		if not head.is_filtered():
+			if head.is_pending():
+				head.make_complete(secs, nsecs)
+			else:
+				print "missing start compaction event for pid %d" % pid
+
+	@classmethod
+	def gen(cls):
+		if opt_proc != pdisp.DISP_DFL:
+			for i in cls.heads:
+				yield cls.heads[i]
+
+	@classmethod
+	def str(cls):
+		return "%s (%d migrated %d failed)" % (time(cls.ns), cls.nmigrated, cls.nfailed)
+
+	def __init__(self, comm, pid, filtered):
+		self.comm = comm
+		self.pid = pid
+		self.ns = 0
+		self.nmigrated = 0
+		self.nfailed = 0
+		self.filtered = filtered
+		self.list = []
+
+	def mark_pending(self, secs, nsecs):
+		self.pending = cnode(ns(secs, nsecs), 0, 0);
+
+	def do_increment(self, nmigrated, nfailed):
+		self.pending.increment(nmigrated, nfailed);
+
+	def make_complete(self, secs, nsecs):
+		self.pending.complete(secs, nsecs)
+		chead.ns += self.pending.ns
+		chead.nmigrated += self.pending.nmigrated
+		chead.nfailed += self.pending.nfailed
+		if opt_proc != pdisp.DISP_DFL:
+			self.ns += self.pending.ns
+			self.nmigrated += self.pending.nmigrated
+			self.nfailed += self.pending.nfailed
+			if opt_proc == pdisp.DISP_PROC_VERBOSE:
+				self.list.append(self.pending);
+		self.pending = None;
+
+	def enumerate(self):
+		if opt_proc == pdisp.DISP_PROC_VERBOSE and not self.is_filtered():
+			for i, pelem in enumerate(self.list):
+				print "%d[%s].%d: %s" % (self.pid, self.comm, i+1, pelem)
+
+	def is_pending(self):
+		return self.pending != None;
+
+	def is_filtered(self):
+		return self.filtered;
+
+	def display(self):
+		if not self.is_filtered():
+			print "%d[%s]: %s (%d migrated %d failed)" % (self.pid, self.comm, time(self.ns), self.nmigrated, self.nfailed)
+
+
+def trace_end():
+	print "total: %s" % chead.str()
+	for i in chead.gen():
+		i.display(),
+		i.enumerate();
+
+def compaction__mm_compaction_migratepages(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, nr_migrated, nr_failed):
+
+	chead.increment_pending(common_pid, nr_migrated, nr_failed);
+
+def compaction__mm_compaction_end(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, zone_start, migrate_start, free_start, zone_end,
+	sync, status):
+
+	chead.complete_pending(common_pid, common_secs, common_nsecs);
+
+def compaction__mm_compaction_begin(event_name, context, common_cpu,
+	common_secs, common_nsecs, common_pid, common_comm,
+	common_callchain, zone_start, migrate_start, free_start, zone_end,
+	sync):
+
+	chead.create_pending(common_pid, common_comm, common_secs, common_nsecs);
+
+comm_re=None
+pid_re=None
+pid_regex="^(\d*)-(\d*)$|^(\d*)$"
+
+opt_proc = pdisp.DISP_DFL
+opt_ns = True
+
+argc=len(sys.argv) - 1
+if argc >= 1:
+	pid_re = re.compile(pid_regex);
+
+	for i, opt in enumerate(sys.argv[1:]):
+		if opt[0] == "-":
+			if opt == "-p":
+				opt_proc = pdisp.DISP_PROC
+			elif opt == "-pv":
+				opt_proc = pdisp.DISP_PROC_VERBOSE
+			elif opt == '-u':
+				opt_ns = False
+			else:
+				print usage
+				exit(1)
+
+		elif i == argc - 1:
+			m=pid_re.search(opt)
+			if m != None and m.group() != "":
+				if m.group(3) != None:
+					f=pid_filter(m.group(3), m.group(3))
+				else:
+					f=pid_filter(m.group(1), m.group(2))
+			else:
+				try:
+					comm_re=re.compile(opt)
+				except:
+					print "invalid regex '%s'" % opt
+					print usage
+					exit(1)
+				f=comm_filter(comm_re)
+
+			chead.add_filter(f)
+
-- 
2.4.6
