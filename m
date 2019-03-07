From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/35] perf script python: add Python3 support to check-perf-trace.py
Date: Thu,  7 Mar 2019 14:44:24 -0300
Message-ID: <20190307174433.28819-27-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Tom Zanussi <tzanussi@gmail.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python 2 and Python 3 in the check-perf-trace.py script.

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of from __future__ implies the minimum supported version of
Python2 is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Tom Zanussi <tzanussi@gmail.com>
Link: http://lkml.kernel.org/r/20190302011903.2416-4-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/check-perf-trace.py | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scripts/python/check-perf-trace.py
index f4838db3e518..d2c22954800d 100644
--- a/tools/perf/scripts/python/check-perf-trace.py
+++ b/tools/perf/scripts/python/check-perf-trace.py
@@ -7,6 +7,8 @@
 # events, etc.  Basically, if this script runs successfully and
 # displays expected results, Python scripting support should be ok.
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -19,7 +21,7 @@ from perf_trace_context import *
 unhandled = autodict()
 
 def trace_begin():
-	print "trace_begin"
+	print("trace_begin")
 	pass
 
 def trace_end():
@@ -33,7 +35,7 @@ def irq__softirq_entry(event_name, context, common_cpu,
 
 	print_uncommon(context)
 
-	print "vec=%s\n" % (symbol_str("irq__softirq_entry", "vec", vec)),
+	print("vec=%s" % (symbol_str("irq__softirq_entry", "vec", vec)))
 
 def kmem__kmalloc(event_name, context, common_cpu,
 		  common_secs, common_nsecs, common_pid, common_comm,
@@ -44,10 +46,10 @@ def kmem__kmalloc(event_name, context, common_cpu,
 
 	print_uncommon(context)
 
-	print "call_site=%u, ptr=%u, bytes_req=%u, " \
-		"bytes_alloc=%u, gfp_flags=%s\n" % \
+	print("call_site=%u, ptr=%u, bytes_req=%u, "
+		"bytes_alloc=%u, gfp_flags=%s" %
 		(call_site, ptr, bytes_req, bytes_alloc,
-		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)),
+		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)))
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	try:
@@ -56,26 +58,27 @@ def trace_unhandled(event_name, context, event_fields_dict):
 		unhandled[event_name] = 1
 
 def print_header(event_name, cpu, secs, nsecs, pid, comm):
-	print "%-20s %5u %05u.%09u %8u %-20s " % \
+	print("%-20s %5u %05u.%09u %8u %-20s " %
 		(event_name, cpu, secs, nsecs, pid, comm),
+		end=' ')
 
 # print trace fields not included in handler args
 def print_uncommon(context):
-	print "common_preempt_count=%d, common_flags=%s, " \
-		"common_lock_depth=%d, " % \
+	print("common_preempt_count=%d, common_flags=%s, "
+		"common_lock_depth=%d, " %
 		(common_pc(context), trace_flag_str(common_flags(context)),
-		common_lock_depth(context))
+		common_lock_depth(context)))
 
 def print_unhandled():
 	keys = unhandled.keys()
 	if not keys:
 		return
 
-	print "\nunhandled events:\n\n",
+	print("\nunhandled events:\n")
 
-	print "%-40s  %10s\n" % ("event", "count"),
-	print "%-40s  %10s\n" % ("----------------------------------------", \
-				"-----------"),
+	print("%-40s  %10s" % ("event", "count"))
+	print("%-40s  %10s" % ("----------------------------------------",
+				"-----------"))
 
 	for event_name in keys:
-		print "%-40s  %10d\n" % (event_name, unhandled[event_name])
+		print("%-40s  %10d\n" % (event_name, unhandled[event_name]))
-- 
2.20.1
