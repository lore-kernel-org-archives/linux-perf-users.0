From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 55/86] perf tests attr: Add optional term
Date: Wed, 19 Jul 2017 11:29:19 -0300
Message-ID: <20170719142950.3747-56-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Some of the stat events are quite rare to find on common machines (like
front end cycles).

Adding an 'optional' term to mark such events in attr tests. Event
marked as optional will not fail the test case if it's not found in
results.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.py                   | 14 +++++++++++---
 tools/perf/tests/attr/test-stat-default    |  2 ++
 tools/perf/tests/attr/test-stat-detailed-1 |  2 ++
 tools/perf/tests/attr/test-stat-detailed-2 |  3 +++
 tools/perf/tests/attr/test-stat-detailed-3 |  5 +++++
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index b03261c6b1ed..6bb50e82a3e3 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -105,6 +105,11 @@ class Event(dict):
                 return False
         return True
 
+    def optional(self):
+        if self.has_key('optional') and self['optional'] == '1':
+            return True
+        return False
+
     def diff(self, other):
         for t in Event.terms:
             if not self.has_key(t) or not other.has_key(t):
@@ -244,9 +249,12 @@ class Test(object):
             log.debug("    match: [%s] matches %s" % (exp_name, str(exp_list)))
 
             # we did not any matching event - fail
-            if (not exp_list):
-		exp_event.diff(res_event)
-                raise Fail(self, 'match failure');
+            if not exp_list:
+                if exp_event.optional():
+                    log.debug("    %s does not match, but is optional" % exp_name)
+                else:
+                    exp_event.diff(res_event)
+                    raise Fail(self, 'match failure');
 
             match[exp_name] = exp_list
 
diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/attr/test-stat-default
index 19270f54c96e..e911dbd4eb47 100644
--- a/tools/perf/tests/attr/test-stat-default
+++ b/tools/perf/tests/attr/test-stat-default
@@ -38,12 +38,14 @@ config=0
 fd=6
 type=0
 config=7
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
 [event7:base-stat]
 fd=7
 type=0
 config=8
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_INSTRUCTIONS
 [event8:base-stat]
diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/tests/attr/test-stat-detailed-1
index 51426b87153b..b39270a08e74 100644
--- a/tools/perf/tests/attr/test-stat-detailed-1
+++ b/tools/perf/tests/attr/test-stat-detailed-1
@@ -39,12 +39,14 @@ config=0
 fd=6
 type=0
 config=7
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
 [event7:base-stat]
 fd=7
 type=0
 config=8
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_INSTRUCTIONS
 [event8:base-stat]
diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/tests/attr/test-stat-detailed-2
index 8de5acc31c27..45f8e6ea34f8 100644
--- a/tools/perf/tests/attr/test-stat-detailed-2
+++ b/tools/perf/tests/attr/test-stat-detailed-2
@@ -39,12 +39,14 @@ config=0
 fd=6
 type=0
 config=7
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
 [event7:base-stat]
 fd=7
 type=0
 config=8
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_INSTRUCTIONS
 [event8:base-stat]
@@ -108,6 +110,7 @@ config=65538
 fd=15
 type=3
 config=1
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/tests/attr/test-stat-detailed-3
index 0a1f45bf7d79..30ae0fb7a3fd 100644
--- a/tools/perf/tests/attr/test-stat-detailed-3
+++ b/tools/perf/tests/attr/test-stat-detailed-3
@@ -39,12 +39,14 @@ config=0
 fd=6
 type=0
 config=7
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
 [event7:base-stat]
 fd=7
 type=0
 config=8
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_INSTRUCTIONS
 [event8:base-stat]
@@ -108,6 +110,7 @@ config=65538
 fd=15
 type=3
 config=1
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
@@ -162,6 +165,7 @@ config=65540
 fd=21
 type=3
 config=512
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -171,3 +175,4 @@ config=512
 fd=22
 type=3
 config=66048
+optional=1
-- 
2.9.4
