From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 10/15] perf script python: add Python3 support to sctop.py
Date: Fri, 22 Feb 2019 15:06:14 -0800
Message-ID: <20190222230619.17887-11-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, Tony Jones <tonyj@suse.de>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Tom Zanussi <tzanussi@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

Support both Python2 and Python3 in the sctop.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Tom Zanussi <tzanussi@gmail.com>
---
 tools/perf/scripts/python/sctop.py | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python/sctop.py
index 61621b93affb..987ffae7c8ca 100644
--- a/tools/perf/scripts/python/sctop.py
+++ b/tools/perf/scripts/python/sctop.py
@@ -8,7 +8,14 @@
 # will be refreshed every [interval] seconds.  The default interval is
 # 3 seconds.
 
-import os, sys, thread, time
+from __future__ import print_function
+
+import os, sys, time
+
+try:
+        import thread
+except ImportError:
+        import _thread as thread
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -62,18 +69,19 @@ def print_syscall_totals(interval):
 	while 1:
 		clear_term()
 		if for_comm is not None:
-			print "\nsyscall events for %s:\n\n" % (for_comm),
+			print("\nsyscall events for %s:\n" % (for_comm))
 		else:
-			print "\nsyscall events:\n\n",
+			print("\nsyscall events:\n")
 
-		print "%-40s  %10s\n" % ("event", "count"),
-		print "%-40s  %10s\n" % ("----------------------------------------", \
-						 "----------"),
+		print("%-40s  %10s" % ("event", "count"))
+		print("%-40s  %10s" %
+                        ("----------------------------------------",
+                        "----------"))
 
-		for id, val in sorted(syscalls.iteritems(), key = lambda(k, v): (v, k), \
+		for id, val in sorted(syscalls.items(), key = lambda kv: (kv[1], kv[0]), \
 					      reverse = True):
 			try:
-				print "%-40s  %10d\n" % (syscall_name(id), val),
+				print("%-40s  %10d" % (syscall_name(id), val))
 			except TypeError:
 				pass
 		syscalls.clear()
-- 
2.20.1
