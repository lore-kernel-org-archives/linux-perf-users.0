From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/37] perf script python: Add Python3 support to stat-cpi.py
Date: Mon, 25 Feb 2019 18:20:33 -0300
Message-ID: <20190225212035.24781-36-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the stat-cpi.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190222230619.17887-13-tonyj@suse.de
Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
