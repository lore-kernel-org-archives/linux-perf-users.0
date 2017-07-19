From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 52/86] perf tests attr: Fix sample_period setup
Date: Wed, 19 Jul 2017 11:29:16 -0300
Message-ID: <20170719142950.3747-53-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The final period can differ from what user specifies on command line due
to the perf_event_max_sample_rate sysctl setup.

Thus we can't predixt the sample_period value any more.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/base-record                        | 2 +-
 tools/perf/tests/attr/test-record-branch-any             | 1 -
 tools/perf/tests/attr/test-record-branch-filter-any      | 1 -
 tools/perf/tests/attr/test-record-branch-filter-any_call | 1 -
 tools/perf/tests/attr/test-record-branch-filter-any_ret  | 1 -
 tools/perf/tests/attr/test-record-branch-filter-hv       | 1 -
 tools/perf/tests/attr/test-record-branch-filter-ind_call | 1 -
 tools/perf/tests/attr/test-record-branch-filter-k        | 1 -
 tools/perf/tests/attr/test-record-branch-filter-u        | 1 -
 tools/perf/tests/attr/test-record-data                   | 2 --
 tools/perf/tests/attr/test-record-no-buffering           | 1 -
 tools/perf/tests/attr/test-record-raw                    | 1 -
 12 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index cdf3adf7d389..a9cb72b8fbb1 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -7,7 +7,7 @@ cpu=*
 type=0|1
 size=112
 config=0
-sample_period=4000
+sample_period=*
 sample_type=263
 read_format=0
 disabled=1
diff --git a/tools/perf/tests/attr/test-record-branch-any b/tools/perf/tests/attr/test-record-branch-any
index a2fe031e6f87..81f839e2fad0 100644
--- a/tools/perf/tests/attr/test-record-branch-any
+++ b/tools/perf/tests/attr/test-record-branch-any
@@ -4,6 +4,5 @@ args    = -b kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=2311
 branch_sample_type=8
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any b/tools/perf/tests/attr/test-record-branch-filter-any
index 7df6a489c9ac..357421f4dfce 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any
+++ b/tools/perf/tests/attr/test-record-branch-filter-any
@@ -4,6 +4,5 @@ args    = -j any kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=2311
 branch_sample_type=8
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_call b/tools/perf/tests/attr/test-record-branch-filter-any_call
index 6c93e07da61c..dbc55f2ab845 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_call
@@ -4,6 +4,5 @@ args    = -j any_call kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=2311
 branch_sample_type=16
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_ret b/tools/perf/tests/attr/test-record-branch-filter-any_ret
index daf8b83e257f..a0824ff8e131 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_ret
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_ret
@@ -4,6 +4,5 @@ args    = -j any_ret kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=2311
 branch_sample_type=32
diff --git a/tools/perf/tests/attr/test-record-branch-filter-hv b/tools/perf/tests/attr/test-record-branch-filter-hv
index fbf491da4f33..f34d6f120181 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-hv
+++ b/tools/perf/tests/attr/test-record-branch-filter-hv
@@ -4,6 +4,5 @@ args    = -j hv kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=2311
 branch_sample_type=8
diff --git a/tools/perf/tests/attr/test-record-branch-filter-ind_call b/tools/perf/tests/attr/test-record-branch-filter-ind_call
index c63cc50d2269..b86a35232248 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-ind_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-ind_call
@@ -4,6 +4,5 @@ args    = -j ind_call kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=2311
 branch_sample_type=64
diff --git a/tools/perf/tests/attr/test-record-branch-filter-k b/tools/perf/tests/attr/test-record-branch-filter-k
index e0f2f09ff07b..d3fbc5e1858a 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-k
+++ b/tools/perf/tests/attr/test-record-branch-filter-k
@@ -4,6 +4,5 @@ args    = -j k kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=2311
 branch_sample_type=8
diff --git a/tools/perf/tests/attr/test-record-branch-filter-u b/tools/perf/tests/attr/test-record-branch-filter-u
index 6cd36e01b6fc..a318f0dda173 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-u
+++ b/tools/perf/tests/attr/test-record-branch-filter-u
@@ -4,6 +4,5 @@ args    = -j u kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=2311
 branch_sample_type=8
diff --git a/tools/perf/tests/attr/test-record-data b/tools/perf/tests/attr/test-record-data
index 53c8890f6e5f..a9cf2233b0ce 100644
--- a/tools/perf/tests/attr/test-record-data
+++ b/tools/perf/tests/attr/test-record-data
@@ -4,8 +4,6 @@ args    = -d kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
-
 # sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
 # PERF_SAMPLE_ADDR | PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC
 sample_type=33039
diff --git a/tools/perf/tests/attr/test-record-no-buffering b/tools/perf/tests/attr/test-record-no-buffering
index 5bf349aeeb69..aa3956d8fe20 100644
--- a/tools/perf/tests/attr/test-record-no-buffering
+++ b/tools/perf/tests/attr/test-record-no-buffering
@@ -4,7 +4,6 @@ args    = --no-buffering kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=263
 watermark=0
 wakeup_events=1
diff --git a/tools/perf/tests/attr/test-record-raw b/tools/perf/tests/attr/test-record-raw
index 3b89f99c240b..a188a614a44c 100644
--- a/tools/perf/tests/attr/test-record-raw
+++ b/tools/perf/tests/attr/test-record-raw
@@ -4,5 +4,4 @@ args    = -R kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
-sample_period=4000
 sample_type=1415
-- 
2.9.4
