From: Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 4/8] perf scripts python: Add Python 3 support to Util.py
Date: Tue, 8 May 2018 21:27:46 +0000
Message-ID: <0100016341a730c6-8db8b9b1-da2d-4ee3-96bf-47e0ae9796bd-000000@email.amazonses.com>
References: <cover.1525811971.git.jeremy@jcline.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, "Herton R . Krzesinski" <herton@redhat.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>
List-Id: linux-perf-users.vger.kernel.org

Support both Python 2 and Python 3 in Util.py. The dict class no longer
has a ``has_key`` method and print is now a function rather than a
statement. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py     | 11 ++++++-----
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
2.17.0
