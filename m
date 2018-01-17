From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/32] perf script python: Add script to profile and resolve physical mem type
Date: Wed, 17 Jan 2018 13:11:53 -0300
Message-ID: <20180117161222.15611-4-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753860AbeAQQMw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Jan 2018 11:12:52 -0500
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <Kan.liang@intel.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Kan Liang <Kan.liang@intel.com>

There could be different types of memory in the system. E.g normal
System Memory, Persistent Memory. To understand how the workload maps to
those memories, it's important to know the I/O statistics of them.  Perf
can collect physical addresses, but those are raw data.  It still needs
extra work to resolve the physical addresses.  Provide a script to
facilitate the physical addresses resolving and I/O statistics.

Profile with MEM_INST_RETIRED.ALL_LOADS or MEM_UOPS_RETIRED.ALL_LOADS
event if any of them is available.

Look up the /proc/iomem and resolve the physical address.  Provide
memory type summary.

Here is an example output:

  # perf script report mem-phys-addr
  Event: mem_inst_retired.all_loads:P
  Memory type                                    count   percentage
  ----------------------------------------  -----------  -----------
  System RAM                                        74        53.2%
  Persistent Memory                                 55        39.6%
  N/A

  ---

Changes since V2:
 - Apply the new license rules.
 - Add comments for globals

Changes since V1:
 - Do not mix DLA and Load Latency. Do not compare the loads and stores.
   Only profile the loads.
 - Use event name to replace the RAW event

Signed-off-by: Kan Liang <Kan.liang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/r/1515099595-34770-1-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/bin/mem-phys-addr-record | 19 +++++
 tools/perf/scripts/python/bin/mem-phys-addr-report |  3 +
 tools/perf/scripts/python/mem-phys-addr.py         | 95 ++++++++++++++++++++++
 .../util/scripting-engines/trace-event-python.c    |  2 +
 4 files changed, 119 insertions(+)
 create mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-record
 create mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-report
 create mode 100644 tools/perf/scripts/python/mem-phys-addr.py

diff --git a/tools/perf/scripts/python/bin/mem-phys-addr-record b/tools/perf/scripts/python/bin/mem-phys-addr-record
new file mode 100644
index 000000000000..5a875122a904
--- /dev/null
+++ b/tools/perf/scripts/python/bin/mem-phys-addr-record
@@ -0,0 +1,19 @@
+#!/bin/bash
+
+#
+# Profiling physical memory by all retired load instructions/uops event
+# MEM_INST_RETIRED.ALL_LOADS or MEM_UOPS_RETIRED.ALL_LOADS
+#
+
+load=`perf list | grep mem_inst_retired.all_loads`
+if [ -z "$load" ]; then
+	load=`perf list | grep mem_uops_retired.all_loads`
+fi
+if [ -z "$load" ]; then
+	echo "There is no event to count all retired load instructions/uops."
+	exit 1
+fi
+
+arg=$(echo $load | tr -d ' ')
+arg="$arg:P"
+perf record --phys-data -e $arg $@
diff --git a/tools/perf/scripts/python/bin/mem-phys-addr-report b/tools/perf/scripts/python/bin/mem-phys-addr-report
new file mode 100644
index 000000000000..3f2b847e2eab
--- /dev/null
+++ b/tools/perf/scripts/python/bin/mem-phys-addr-report
@@ -0,0 +1,3 @@
+#!/bin/bash
+# description: resolve physical address samples
+perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/mem-phys-addr.py
diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
new file mode 100644
index 000000000000..ebee2c5ae496
--- /dev/null
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -0,0 +1,95 @@
+# mem-phys-addr.py: Resolve physical address samples
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2018, Intel Corporation.
+
+from __future__ import division
+import os
+import sys
+import struct
+import re
+import bisect
+import collections
+
+sys.path.append(os.environ['PERF_EXEC_PATH'] + \
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+#physical address ranges for System RAM
+system_ram = []
+#physical address ranges for Persistent Memory
+pmem = []
+#file object for proc iomem
+f = None
+#Count for each type of memory
+load_mem_type_cnt = collections.Counter()
+#perf event name
+event_name = None
+
+def parse_iomem():
+	global f
+	f = open('/proc/iomem', 'r')
+	for i, j in enumerate(f):
+		m = re.split('-|:',j,2)
+		if m[2].strip() == 'System RAM':
+			system_ram.append(long(m[0], 16))
+			system_ram.append(long(m[1], 16))
+		if m[2].strip() == 'Persistent Memory':
+			pmem.append(long(m[0], 16))
+			pmem.append(long(m[1], 16))
+
+def print_memory_type():
+	print "Event: %s" % (event_name)
+	print "%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"),
+	print "%-40s  %10s  %10s\n" % ("----------------------------------------", \
+					"-----------", "-----------"),
+	total = sum(load_mem_type_cnt.values())
+	for mem_type, count in sorted(load_mem_type_cnt.most_common(), \
+					key = lambda(k, v): (v, k), reverse = True):
+		print "%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
+
+def trace_begin():
+	parse_iomem()
+
+def trace_end():
+	print_memory_type()
+	f.close()
+
+def is_system_ram(phys_addr):
+	#/proc/iomem is sorted
+	position = bisect.bisect(system_ram, phys_addr)
+	if position % 2 == 0:
+		return False
+	return True
+
+def is_persistent_mem(phys_addr):
+	position = bisect.bisect(pmem, phys_addr)
+	if position % 2 == 0:
+		return False
+	return True
+
+def find_memory_type(phys_addr):
+	if phys_addr == 0:
+		return "N/A"
+	if is_system_ram(phys_addr):
+		return "System RAM"
+
+	if is_persistent_mem(phys_addr):
+		return "Persistent Memory"
+
+	#slow path, search all
+	f.seek(0, 0)
+	for j in f:
+		m = re.split('-|:',j,2)
+		if long(m[0], 16) <= phys_addr <= long(m[1], 16):
+			return m[2]
+	return "N/A"
+
+def process_event(param_dict):
+	name       = param_dict["ev_name"]
+	sample     = param_dict["sample"]
+	phys_addr  = sample["phys_addr"]
+
+	global event_name
+	if event_name == None:
+		event_name = name
+	load_mem_type_cnt[find_memory_type(phys_addr)] += 1
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c1848b543f27..ea070883c593 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -499,6 +499,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->time));
 	pydict_set_item_string_decref(dict_sample, "period",
 			PyLong_FromUnsignedLongLong(sample->period));
+	pydict_set_item_string_decref(dict_sample, "phys_addr",
+			PyLong_FromUnsignedLongLong(sample->phys_addr));
 	set_sample_read_in_dict(dict_sample, sample, evsel);
 	pydict_set_item_string_decref(dict, "sample", dict_sample);
 
-- 
2.14.3
