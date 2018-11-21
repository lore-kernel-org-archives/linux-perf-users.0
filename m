From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/7] perf tools: Fix crash on synthesizing the unit
Date: Wed, 21 Nov 2018 11:24:59 -0300
Message-ID: <20181121142505.27379-2-acme@kernel.org>
References: <20181121142505.27379-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121142505.27379-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adam Lee <leeadamrobert@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adam reported a record command crash for simple session like:

  $ perf record -e cpu-clock ls

with following backtrace:

  Program received signal SIGSEGV, Segmentation fault.
  3543            ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->id[0]);
  (gdb) bt
  #0  perf_event__synthesize_event_update_unit
  #1  0x000000000051e469 in perf_event__synthesize_extra_attr
  #2  0x00000000004445cb in record__synthesize
  #3  0x0000000000444bc5 in __cmd_record
  ...

We synthesize an update event that needs to touch the evsel id array,
which is not defined at that time. Fix this by forcing the id allocation
for events with their unit defined.

Reflecting possible read_format ID bit in the attr tests.

Reported-by: Yongxin Liu <yongxin.liu@outlook.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adam Lee <leeadamrobert@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201477
Fixes: bfd8f72c2778 ("perf record: Synthesize unit/scale/... in event update")
Link: http://lkml.kernel.org/r/20181112130012.5424-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/base-record | 2 +-
 tools/perf/util/evsel.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 37940665f736..efd0157b9d22 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -9,7 +9,7 @@ size=112
 config=0
 sample_period=*
 sample_type=263
-read_format=0
+read_format=0|4
 disabled=1
 inherit=1
 pinned=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d37bb1566cd9..dbc0466db368 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1092,7 +1092,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->own_cpus)
+	if (evsel->own_cpus || evsel->unit)
 		evsel->attr.read_format |= PERF_FORMAT_ID;
 
 	/*
-- 
2.14.5
