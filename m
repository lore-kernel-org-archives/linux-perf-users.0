From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/8] perf tests attr: Fix task term values
Date: Tue,  3 Oct 2017 09:55:33 -0300
Message-ID: <20171003125540.331-2-acme@kernel.org>
References: <20171003125540.331-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003125540.331-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The perf_event_attr::task is 1 by default for first (tracking) event in
the session. Setting task=1 as default and adding task=0 for cases that
need it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/base-record                | 2 +-
 tools/perf/tests/attr/test-record-group          | 1 +
 tools/perf/tests/attr/test-record-group-sampling | 2 +-
 tools/perf/tests/attr/test-record-group1         | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 31e0b1da830b..37940665f736 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -23,7 +23,7 @@ comm=1
 freq=1
 inherit_stat=0
 enable_on_exec=1
-task=0
+task=1
 watermark=0
 precise_ip=0|1|2|3
 mmap_data=0
diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
index 6e7961f6f7a5..618ba1c17474 100644
--- a/tools/perf/tests/attr/test-record-group
+++ b/tools/perf/tests/attr/test-record-group
@@ -17,5 +17,6 @@ sample_type=327
 read_format=4
 mmap=0
 comm=0
+task=0
 enable_on_exec=0
 disabled=0
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index ef59afd6d635..f906b793196f 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -23,7 +23,7 @@ sample_type=343
 
 # PERF_FORMAT_ID | PERF_FORMAT_GROUP
 read_format=12
-
+task=0
 mmap=0
 comm=0
 enable_on_exec=0
diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/attr/test-record-group1
index 87a222d014d8..48e8bd12fe46 100644
--- a/tools/perf/tests/attr/test-record-group1
+++ b/tools/perf/tests/attr/test-record-group1
@@ -18,5 +18,6 @@ sample_type=327
 read_format=4
 mmap=0
 comm=0
+task=0
 enable_on_exec=0
 disabled=0
-- 
2.13.6
