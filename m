From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 12/15] perf script python: add Python3 support to stat-cpi.py
Date: Fri, 22 Feb 2019 15:06:16 -0800
Message-ID: <20190222230619.17887-13-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, Tony Jones <tonyj@suse.de>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Support both Python2 and Python3 in the stat-cpi.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/scripts/python/stat-cpi.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/stat-cpi.py b/tools/perf/scripts/python/stat-cpi.py
index a81ad8835a74..01fa933ff3cf 100644
--- a/tools/perf/scripts/python/stat-cpi.py
+++ b/tools/perf/scripts/python/stat-cpi.py
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 data    = {}
 times   = []
 threads = []
@@ -19,8 +21,8 @@ def store_key(time, cpu, thread):
         threads.append(thread)
 
 def store(time, event, cpu, thread, val, ena, run):
-    #print "event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" % \
-    #      (event, cpu, thread, time, val, ena, run)
+    #print("event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" %
+    #      (event, cpu, thread, time, val, ena, run))
 
     store_key(time, cpu, thread)
     key = get_key(time, event, cpu, thread)
@@ -58,7 +60,7 @@ def stat__interval(time):
             if ins != 0:
                 cpi = cyc/float(ins)
 
-            print "%15f: cpu %d, thread %d -> cpi %f (%d/%d)" % (time/(float(1000000000)), cpu, thread, cpi, cyc, ins)
+            print("%15f: cpu %d, thread %d -> cpi %f (%d/%d)" % (time/(float(1000000000)), cpu, thread, cpi, cyc, ins))
 
 def trace_end():
     pass
@@ -74,4 +76,4 @@ def trace_end():
 #                if ins != 0:
 #                    cpi = cyc/float(ins)
 #
-#                print "time %.9f, cpu %d, thread %d -> cpi %f" % (time/(float(1000000000)), cpu, thread, cpi)
+#                print("time %.9f, cpu %d, thread %d -> cpi %f" % (time/(float(1000000000)), cpu, thread, cpi))
-- 
2.20.1
