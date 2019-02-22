From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 02/15] perf script python: add Python3 support to check-perf-trace.py
Date: Fri, 22 Feb 2019 15:06:06 -0800
Message-ID: <20190222230619.17887-3-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, Tony Jones <tonyj@suse.de>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Tom Zanussi <tzanussi@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

Support both Python 2 and Python 3 in the check-perf-trace.py script.

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

Also correct inconsistent indentation which was being flagged by Python3.

The use of from __future__ implies the minimum supported version of
Python2 is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Tom Zanussi <tzanussi@gmail.com>
---
 tools/perf/scripts/python/check-perf-trace.py | 68 ++++++++++---------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scripts/python/check-perf-trace.py
index 334599c6032c..2851cf0e6b4b 100644
--- a/tools/perf/scripts/python/check-perf-trace.py
+++ b/tools/perf/scripts/python/check-perf-trace.py
@@ -7,11 +7,13 @@
 # events, etc.  Basically, if this script runs successfully and
 # displays expected results, Python scripting support should be ok.
 
+from __future__ import print_function
+
 import os
 import sys
 
-sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+sys.path.append(os.environ['PERF_EXEC_PATH'] +
+    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 
 from Core import *
 from perf_trace_context import *
@@ -19,37 +21,38 @@ from perf_trace_context import *
 unhandled = autodict()
 
 def trace_begin():
-	print "trace_begin"
-	pass
+    print("trace_begin")
+    pass
 
 def trace_end():
-        print_unhandled()
+    print_unhandled()
 
 def irq__softirq_entry(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, vec):
-		print_header(event_name, common_cpu, common_secs, common_nsecs,
-			common_pid, common_comm)
+    common_secs, common_nsecs, common_pid, common_comm,
+    common_callchain, vec):
+
+    print_header(event_name, common_cpu, common_secs, common_nsecs,
+        common_pid, common_comm)
 
-                print_uncommon(context)
+    print_uncommon(context)
 
-		print "vec=%s\n" % \
-		(symbol_str("irq__softirq_entry", "vec", vec)),
+    print("vec=%s" %
+        (symbol_str("irq__softirq_entry", "vec", vec)))
 
 def kmem__kmalloc(event_name, context, common_cpu,
-	common_secs, common_nsecs, common_pid, common_comm,
-	common_callchain, call_site, ptr, bytes_req, bytes_alloc,
-	gfp_flags):
-		print_header(event_name, common_cpu, common_secs, common_nsecs,
-			common_pid, common_comm)
+    common_secs, common_nsecs, common_pid, common_comm,
+    common_callchain, call_site, ptr, bytes_req, bytes_alloc,
+    gfp_flags):
 
-                print_uncommon(context)
+    print_header(event_name, common_cpu, common_secs, common_nsecs,
+        common_pid, common_comm)
 
-		print "call_site=%u, ptr=%u, bytes_req=%u, " \
-		"bytes_alloc=%u, gfp_flags=%s\n" % \
-		(call_site, ptr, bytes_req, bytes_alloc,
+    print_uncommon(context)
 
-		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)),
+    print("call_site=%u, ptr=%u, bytes_req=%u, "
+        "bytes_alloc=%u, gfp_flags=%s\n" %
+        (call_site, ptr, bytes_req, bytes_alloc,
+        flag_str("kmem__kmalloc", "gfp_flags", gfp_flags))),
 
 def trace_unhandled(event_name, context, event_fields_dict):
     try:
@@ -58,25 +61,26 @@ def trace_unhandled(event_name, context, event_fields_dict):
         unhandled[event_name] = 1
 
 def print_header(event_name, cpu, secs, nsecs, pid, comm):
-	print "%-20s %5u %05u.%09u %8u %-20s " % \
-	(event_name, cpu, secs, nsecs, pid, comm),
+    print("%-20s %5u %05u.%09u %8u %-20s " %
+        (event_name, cpu, secs, nsecs, pid, comm),
+                end='')
 
 # print trace fields not included in handler args
 def print_uncommon(context):
-    print "common_preempt_count=%d, common_flags=%s, common_lock_depth=%d, " \
-        % (common_pc(context), trace_flag_str(common_flags(context)), \
-               common_lock_depth(context))
+    print("common_preempt_count=%d, common_flags=%s, common_lock_depth=%d, " %
+        (common_pc(context), trace_flag_str(common_flags(context)),
+        common_lock_depth(context))),
 
 def print_unhandled():
     keys = unhandled.keys()
     if not keys:
         return
 
-    print "\nunhandled events:\n\n",
+    print("\nunhandled events:\n")
 
-    print "%-40s  %10s\n" % ("event", "count"),
-    print "%-40s  %10s\n" % ("----------------------------------------", \
-                                 "-----------"),
+    print("%-40s  %10s" % ("event", "count"))
+    print("%-40s  %10s" % ("----------------------------------------",
+                 "-----------"))
 
     for event_name in keys:
-	print "%-40s  %10d\n" % (event_name, unhandled[event_name])
+        print("%-40s  %10d\n" % (event_name, unhandled[event_name]))
-- 
2.20.1
