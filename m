From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/14] perf scripts python: Add Python 3 support to Util.py
Date: Wed, 11 Jul 2018 16:42:55 -0400
Message-ID: <20180711204305.12924-5-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Herton Krzesinski <herton@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

Support both Python 2 and Python 3 in Util.py. The dict class no longer
has a ``has_key`` method and print is now a function rather than a
statement. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a730c6-8db8b9b1-da2d-4ee3-96bf-47e0ae9796bd-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py     | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
index f6c84966e4f8..7384dcb628c4 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
@@ -5,6 +5,7 @@
 # This software may be distributed under the terms of the GNU General
 # Public License ("GPL") version 2 as published by the Free Software
 # Foundation.
+from __future__ import print_function
 
 import errno, os
 
@@ -33,7 +34,7 @@ def nsecs_str(nsecs):
     return str
 
 def add_stats(dict, key, value):
-	if not dict.has_key(key):
+	if key not in dict:
 		dict[key] = (value, value, value, 1)
 	else:
 		min, max, avg, count = dict[key]
@@ -72,10 +73,10 @@ try:
 except:
 	if not audit_package_warned:
 		audit_package_warned = True
-		print "Install the audit-libs-python package to get syscall names.\n" \
-                    "For example:\n  # apt-get install python-audit (Ubuntu)" \
-                    "\n  # yum install audit-libs-python (Fedora)" \
-                    "\n  etc.\n"
+		print("Install the audit-libs-python package to get syscall names.\n"
+                    "For example:\n  # apt-get install python-audit (Ubuntu)"
+                    "\n  # yum install audit-libs-python (Fedora)"
+                    "\n  etc.\n")
 
 def syscall_name(id):
 	try:
-- 
2.14.4
