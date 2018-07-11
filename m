From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/14] perf scripts python: Add Python 3 support to sched-migration.py
Date: Wed, 11 Jul 2018 16:42:56 -0400
Message-ID: <20180711204305.12924-6-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Herton Krzesinski <herton@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

Support both Python 2 and Python 3 in the sched-migration.py script.
This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a737a5-44ec436f-3440-4cac-a03f-ddfa589bf308-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/sched-migration.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scripts/python/sched-migration.py
index de66cb3b72c9..3473e7f66081 100644
--- a/tools/perf/scripts/python/sched-migration.py
+++ b/tools/perf/scripts/python/sched-migration.py
@@ -9,13 +9,17 @@
 # This software is distributed under the terms of the GNU General
 # Public License ("GPL") version 2 as published by the Free Software
 # Foundation.
-
+from __future__ import print_function
 
 import os
 import sys
 
 from collections import defaultdict
-from UserList import UserList
+try:
+    from UserList import UserList
+except ImportError:
+    # Python 3: UserList moved to the collections package
+    from collections import UserList
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -300,7 +304,7 @@ class TimeSliceList(UserList):
 		if i == -1:
 			return
 
-		for i in xrange(i, len(self.data)):
+		for i in range(i, len(self.data)):
 			timeslice = self.data[i]
 			if timeslice.start > end:
 				return
@@ -336,8 +340,8 @@ class SchedEventProxy:
 		on_cpu_task = self.current_tsk[headers.cpu]
 
 		if on_cpu_task != -1 and on_cpu_task != prev_pid:
-			print "Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s(%d)" % \
-				(headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next_pid)
+			print("Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s(%d)" % \
+				headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next_pid)
 
 		threads[prev_pid] = prev_comm
 		threads[next_pid] = next_comm
-- 
2.14.4
