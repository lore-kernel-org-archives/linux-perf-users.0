From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/37] perf script python: Add Python3 support to failed-syscalls-by-pid.py
Date: Mon, 25 Feb 2019 18:20:27 -0300
Message-ID: <20190225212035.24781-30-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Tom Zanussi <tzanussi@gmail.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the failed-syscalls-by-pid.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Tom Zanussi <tzanussi@gmail.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-5-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/failed-syscalls-by-pid.py  | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/failed-syscalls-by-pid.py b/tools/perf/scripts/python/failed-syscalls-by-pid.py
index cafeff3d74db..3648e8b986ec 100644
--- a/tools/perf/scripts/python/failed-syscalls-by-pid.py
+++ b/tools/perf/scripts/python/failed-syscalls-by-pid.py
@@ -5,6 +5,8 @@
 # Displays system-wide failed system call totals, broken down by pid.
 # If a [comm] arg is specified, only syscalls called by [comm] are displayed.
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -32,7 +34,7 @@ if len(sys.argv) > 1:
 syscalls = autodict()
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	print_error_totals()
@@ -57,22 +59,21 @@ def syscalls__sys_exit(event_name, context, common_cpu,
 
 def print_error_totals():
     if for_comm is not None:
-	    print "\nsyscall errors for %s:\n\n" % (for_comm),
+	    print("\nsyscall errors for %s:\n" % (for_comm))
     else:
-	    print "\nsyscall errors:\n\n",
+	    print("\nsyscall errors:\n")
 
-    print "%-30s  %10s\n" % ("comm [pid]", "count"),
-    print "%-30s  %10s\n" % ("------------------------------", \
-                                 "----------"),
+    print("%-30s  %10s" % ("comm [pid]", "count"))
+    print("%-30s  %10s" % ("------------------------------", "----------"))
 
     comm_keys = syscalls.keys()
     for comm in comm_keys:
 	    pid_keys = syscalls[comm].keys()
 	    for pid in pid_keys:
-		    print "\n%s [%d]\n" % (comm, pid),
+		    print("\n%s [%d]" % (comm, pid))
 		    id_keys = syscalls[comm][pid].keys()
 		    for id in id_keys:
-			    print "  syscall: %-16s\n" % syscall_name(id),
+			    print("  syscall: %-16s" % syscall_name(id))
 			    ret_keys = syscalls[comm][pid][id].keys()
-			    for ret, val in sorted(syscalls[comm][pid][id].iteritems(), key = lambda(k, v): (v, k),  reverse = True):
-				    print "    err = %-20s  %10d\n" % (strerror(ret), val),
+			    for ret, val in sorted(syscalls[comm][pid][id].items(), key = lambda kv: (kv[1], kv[0]),  reverse = True):
+				    print("    err = %-20s  %10d" % (strerror(ret), val))
-- 
2.20.1
