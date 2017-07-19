From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/86] perf tests attr: Add proper return values
Date: Wed, 19 Jul 2017 11:29:14 -0300
Message-ID: <20170719142950.3747-51-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The record command now properly returns the status of the tracee if
there's any. We need to properly set the expected return value of the
tracee in the attr tests.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/test-record-C0                     | 1 +
 tools/perf/tests/attr/test-record-basic                  | 1 +
 tools/perf/tests/attr/test-record-branch-any             | 1 +
 tools/perf/tests/attr/test-record-branch-filter-any      | 1 +
 tools/perf/tests/attr/test-record-branch-filter-any_call | 1 +
 tools/perf/tests/attr/test-record-branch-filter-any_ret  | 1 +
 tools/perf/tests/attr/test-record-branch-filter-hv       | 1 +
 tools/perf/tests/attr/test-record-branch-filter-ind_call | 1 +
 tools/perf/tests/attr/test-record-branch-filter-k        | 1 +
 tools/perf/tests/attr/test-record-branch-filter-u        | 1 +
 tools/perf/tests/attr/test-record-count                  | 1 +
 tools/perf/tests/attr/test-record-data                   | 1 +
 tools/perf/tests/attr/test-record-freq                   | 1 +
 tools/perf/tests/attr/test-record-graph-default          | 1 +
 tools/perf/tests/attr/test-record-graph-dwarf            | 1 +
 tools/perf/tests/attr/test-record-graph-fp               | 1 +
 tools/perf/tests/attr/test-record-group                  | 1 +
 tools/perf/tests/attr/test-record-group-sampling         | 1 +
 tools/perf/tests/attr/test-record-group1                 | 1 +
 tools/perf/tests/attr/test-record-no-buffering           | 1 +
 tools/perf/tests/attr/test-record-no-inherit             | 1 +
 tools/perf/tests/attr/test-record-no-samples             | 1 +
 tools/perf/tests/attr/test-record-period                 | 1 +
 tools/perf/tests/attr/test-record-raw                    | 1 +
 24 files changed, 24 insertions(+)

diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
index d6a7e43f61b3..cb0a3138fa54 100644
--- a/tools/perf/tests/attr/test-record-C0
+++ b/tools/perf/tests/attr/test-record-C0
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -C 0 kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 cpu=0
diff --git a/tools/perf/tests/attr/test-record-basic b/tools/perf/tests/attr/test-record-basic
index 55c0428370ca..85a23cf35ba1 100644
--- a/tools/perf/tests/attr/test-record-basic
+++ b/tools/perf/tests/attr/test-record-basic
@@ -1,5 +1,6 @@
 [config]
 command = record
 args    = kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-any b/tools/perf/tests/attr/test-record-branch-any
index 1421960ed4e9..a2fe031e6f87 100644
--- a/tools/perf/tests/attr/test-record-branch-any
+++ b/tools/perf/tests/attr/test-record-branch-any
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -b kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any b/tools/perf/tests/attr/test-record-branch-filter-any
index 915c4df0e0c2..7df6a489c9ac 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any
+++ b/tools/perf/tests/attr/test-record-branch-filter-any
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -j any kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_call b/tools/perf/tests/attr/test-record-branch-filter-any_call
index 8708dbd4f373..6c93e07da61c 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_call
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -j any_call kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_ret b/tools/perf/tests/attr/test-record-branch-filter-any_ret
index 0d3607a6dcbe..daf8b83e257f 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_ret
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_ret
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -j any_ret kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-branch-filter-hv b/tools/perf/tests/attr/test-record-branch-filter-hv
index f25526740cec..fbf491da4f33 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-hv
+++ b/tools/perf/tests/attr/test-record-branch-filter-hv
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -j hv kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-branch-filter-ind_call b/tools/perf/tests/attr/test-record-branch-filter-ind_call
index e862dd179128..c63cc50d2269 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-ind_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-ind_call
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -j ind_call kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-branch-filter-k b/tools/perf/tests/attr/test-record-branch-filter-k
index 182971e898f5..e0f2f09ff07b 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-k
+++ b/tools/perf/tests/attr/test-record-branch-filter-k
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -j k kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-branch-filter-u b/tools/perf/tests/attr/test-record-branch-filter-u
index 83449ef9e687..6cd36e01b6fc 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-u
+++ b/tools/perf/tests/attr/test-record-branch-filter-u
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -j u kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-count b/tools/perf/tests/attr/test-record-count
index 2f841de56f6b..34f6cc577263 100644
--- a/tools/perf/tests/attr/test-record-count
+++ b/tools/perf/tests/attr/test-record-count
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -c 123 kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=123
diff --git a/tools/perf/tests/attr/test-record-data b/tools/perf/tests/attr/test-record-data
index 716e143b5291..53c8890f6e5f 100644
--- a/tools/perf/tests/attr/test-record-data
+++ b/tools/perf/tests/attr/test-record-data
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -d kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-freq b/tools/perf/tests/attr/test-record-freq
index 600d0f8f2583..bf4cb459f0d5 100644
--- a/tools/perf/tests/attr/test-record-freq
+++ b/tools/perf/tests/attr/test-record-freq
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -F 100 kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=100
diff --git a/tools/perf/tests/attr/test-record-graph-default b/tools/perf/tests/attr/test-record-graph-default
index 853597a9a8f6..0b216e69760c 100644
--- a/tools/perf/tests/attr/test-record-graph-default
+++ b/tools/perf/tests/attr/test-record-graph-default
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -g kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_type=295
diff --git a/tools/perf/tests/attr/test-record-graph-dwarf b/tools/perf/tests/attr/test-record-graph-dwarf
index 8321c602dc38..da2fa73bd0a2 100644
--- a/tools/perf/tests/attr/test-record-graph-dwarf
+++ b/tools/perf/tests/attr/test-record-graph-dwarf
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = --call-graph dwarf -- kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_type=45359
diff --git a/tools/perf/tests/attr/test-record-graph-fp b/tools/perf/tests/attr/test-record-graph-fp
index 055e3bee7993..625d190bb798 100644
--- a/tools/perf/tests/attr/test-record-graph-fp
+++ b/tools/perf/tests/attr/test-record-graph-fp
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = --call-graph fp kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_type=295
diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
index 57739cacdb2a..6e7961f6f7a5 100644
--- a/tools/perf/tests/attr/test-record-group
+++ b/tools/perf/tests/attr/test-record-group
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = --group -e cycles,instructions kill >/dev/null 2>&1
+ret     = 1
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index 658f5d60c873..ef59afd6d635 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+ret     = 1
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/attr/test-record-group1
index c5548d054aff..87a222d014d8 100644
--- a/tools/perf/tests/attr/test-record-group1
+++ b/tools/perf/tests/attr/test-record-group1
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -e '{cycles,instructions}' kill >/dev/null 2>&1
+ret     = 1
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/attr/test-record-no-buffering b/tools/perf/tests/attr/test-record-no-buffering
index 0b0355af013a..5bf349aeeb69 100644
--- a/tools/perf/tests/attr/test-record-no-buffering
+++ b/tools/perf/tests/attr/test-record-no-buffering
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = --no-buffering kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
diff --git a/tools/perf/tests/attr/test-record-no-inherit b/tools/perf/tests/attr/test-record-no-inherit
index 44edcb2edcd5..560943decb87 100644
--- a/tools/perf/tests/attr/test-record-no-inherit
+++ b/tools/perf/tests/attr/test-record-no-inherit
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -i kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_type=263
diff --git a/tools/perf/tests/attr/test-record-no-samples b/tools/perf/tests/attr/test-record-no-samples
index d0141b2418b5..8eb73ab639e0 100644
--- a/tools/perf/tests/attr/test-record-no-samples
+++ b/tools/perf/tests/attr/test-record-no-samples
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -n kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=0
diff --git a/tools/perf/tests/attr/test-record-period b/tools/perf/tests/attr/test-record-period
index 8abc5314fc52..69bc748f0f27 100644
--- a/tools/perf/tests/attr/test-record-period
+++ b/tools/perf/tests/attr/test-record-period
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -c 100 -P kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=100
diff --git a/tools/perf/tests/attr/test-record-raw b/tools/perf/tests/attr/test-record-raw
index 4a8ef25b5f49..3b89f99c240b 100644
--- a/tools/perf/tests/attr/test-record-raw
+++ b/tools/perf/tests/attr/test-record-raw
@@ -1,6 +1,7 @@
 [config]
 command = record
 args    = -R kill >/dev/null 2>&1
+ret     = 1
 
 [event:base-record]
 sample_period=4000
-- 
2.9.4
