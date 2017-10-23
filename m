From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/24] perf tests attr: Make hw events optional
Date: Mon, 23 Oct 2017 20:47:26 -0300
Message-ID: <20171023234736.5335-15-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Otherwise we fail on virtual machines with no support for specific HW
events.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171009130712.14747-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/test-stat-C0         |  1 +
 tools/perf/tests/attr/test-stat-basic      |  1 +
 tools/perf/tests/attr/test-stat-default    |  4 ++++
 tools/perf/tests/attr/test-stat-detailed-1 |  8 ++++++++
 tools/perf/tests/attr/test-stat-detailed-2 | 13 +++++++++++++
 tools/perf/tests/attr/test-stat-detailed-3 | 13 +++++++++++++
 tools/perf/tests/attr/test-stat-no-inherit |  1 +
 7 files changed, 41 insertions(+)

diff --git a/tools/perf/tests/attr/test-stat-C0 b/tools/perf/tests/attr/test-stat-C0
index 67717fe6a65d..a2c76d10b2bb 100644
--- a/tools/perf/tests/attr/test-stat-C0
+++ b/tools/perf/tests/attr/test-stat-C0
@@ -7,3 +7,4 @@ ret     = 1
 # events are disabled by default when attached to cpu
 disabled=1
 enable_on_exec=0
+optional=1
diff --git a/tools/perf/tests/attr/test-stat-basic b/tools/perf/tests/attr/test-stat-basic
index 74e17881f2ba..69867d049fda 100644
--- a/tools/perf/tests/attr/test-stat-basic
+++ b/tools/perf/tests/attr/test-stat-basic
@@ -4,3 +4,4 @@ args    = -e cycles kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-stat]
+optional=1
diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/attr/test-stat-default
index e911dbd4eb47..d9e99b3f77e6 100644
--- a/tools/perf/tests/attr/test-stat-default
+++ b/tools/perf/tests/attr/test-stat-default
@@ -32,6 +32,7 @@ config=2
 fd=5
 type=0
 config=0
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
 [event6:base-stat]
@@ -52,15 +53,18 @@ optional=1
 fd=8
 type=0
 config=1
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/tests/attr/test-stat-detailed-1
index b39270a08e74..8b04a055d154 100644
--- a/tools/perf/tests/attr/test-stat-detailed-1
+++ b/tools/perf/tests/attr/test-stat-detailed-1
@@ -33,6 +33,7 @@ config=2
 fd=5
 type=0
 config=0
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
 [event6:base-stat]
@@ -53,18 +54,21 @@ optional=1
 fd=8
 type=0
 config=1
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -74,6 +78,7 @@ config=5
 fd=11
 type=3
 config=0
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -83,6 +88,7 @@ config=0
 fd=12
 type=3
 config=65536
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -92,6 +98,7 @@ config=65536
 fd=13
 type=3
 config=2
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -101,3 +108,4 @@ config=2
 fd=14
 type=3
 config=65538
+optional=1
diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/tests/attr/test-stat-detailed-2
index 45f8e6ea34f8..4fca9f1bfbf8 100644
--- a/tools/perf/tests/attr/test-stat-detailed-2
+++ b/tools/perf/tests/attr/test-stat-detailed-2
@@ -33,6 +33,7 @@ config=2
 fd=5
 type=0
 config=0
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
 [event6:base-stat]
@@ -53,18 +54,21 @@ optional=1
 fd=8
 type=0
 config=1
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -74,6 +78,7 @@ config=5
 fd=11
 type=3
 config=0
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -83,6 +88,7 @@ config=0
 fd=12
 type=3
 config=65536
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -92,6 +98,7 @@ config=65536
 fd=13
 type=3
 config=2
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -101,6 +108,7 @@ config=2
 fd=14
 type=3
 config=65538
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
@@ -120,6 +128,7 @@ optional=1
 fd=16
 type=3
 config=65537
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
@@ -129,6 +138,7 @@ config=65537
 fd=17
 type=3
 config=3
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
@@ -138,6 +148,7 @@ config=3
 fd=18
 type=3
 config=65539
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
@@ -147,6 +158,7 @@ config=65539
 fd=19
 type=3
 config=4
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
@@ -156,3 +168,4 @@ config=4
 fd=20
 type=3
 config=65540
+optional=1
diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/tests/attr/test-stat-detailed-3
index 30ae0fb7a3fd..4bb58e1c82a6 100644
--- a/tools/perf/tests/attr/test-stat-detailed-3
+++ b/tools/perf/tests/attr/test-stat-detailed-3
@@ -33,6 +33,7 @@ config=2
 fd=5
 type=0
 config=0
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
 [event6:base-stat]
@@ -53,18 +54,21 @@ optional=1
 fd=8
 type=0
 config=1
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_INSTRUCTIONS
 [event9:base-stat]
 fd=9
 type=0
 config=4
+optional=1
 
 # PERF_TYPE_HARDWARE / PERF_COUNT_HW_BRANCH_MISSES
 [event10:base-stat]
 fd=10
 type=0
 config=5
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -74,6 +78,7 @@ config=5
 fd=11
 type=3
 config=0
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
@@ -83,6 +88,7 @@ config=0
 fd=12
 type=3
 config=65536
+optional=1
 
 # PERF_TYPE_HW_CACHE /
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -92,6 +98,7 @@ config=65536
 fd=13
 type=3
 config=2
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
@@ -101,6 +108,7 @@ config=2
 fd=14
 type=3
 config=65538
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
@@ -120,6 +128,7 @@ optional=1
 fd=16
 type=3
 config=65537
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
@@ -129,6 +138,7 @@ config=65537
 fd=17
 type=3
 config=3
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
@@ -138,6 +148,7 @@ config=3
 fd=18
 type=3
 config=65539
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
@@ -147,6 +158,7 @@ config=65539
 fd=19
 type=3
 config=4
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
@@ -156,6 +168,7 @@ config=4
 fd=20
 type=3
 config=65540
+optional=1
 
 # PERF_TYPE_HW_CACHE,
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
diff --git a/tools/perf/tests/attr/test-stat-no-inherit b/tools/perf/tests/attr/test-stat-no-inherit
index d54b2a1e3e28..924fbb9300d1 100644
--- a/tools/perf/tests/attr/test-stat-no-inherit
+++ b/tools/perf/tests/attr/test-stat-no-inherit
@@ -5,3 +5,4 @@ ret     = 1
 
 [event:base-stat]
 inherit=0
+optional=1
-- 
2.13.6
