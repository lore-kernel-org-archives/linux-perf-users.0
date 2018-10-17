From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/11] perf evsel: Store ids for events with their own cpus perf_event__synthesize_event_update_cpus
Date: Wed, 17 Oct 2018 19:54:55 -0300
Message-ID: <20181017225501.32150-6-acme@kernel.org>
References: <20181017225501.32150-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

John reported crash when recording on an event under PMU with cpumask defined:

  root@localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
  perf: Segmentation fault
  Obtained 9 stack frames.
  ./perf_debug_() [0x4c5ef8]
  [0xffff82ba267c]
  ./perf_debug_() [0x4bc5a8]
  ./perf_debug_() [0x419550]
  ./perf_debug_() [0x41a928]
  ./perf_debug_() [0x472f58]
  ./perf_debug_() [0x473210]
  ./perf_debug_() [0x4070f4]
  /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe0) [0xffff8294c8a0]
  Segmentation fault (core dumped)

We synthesize an update event that needs to touch the evsel id array, which is
not defined at that time. Fixing this by forcing the id allocation for events
with their own cpus.

Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Fixes: bfd8f72c2778 ("perf record: Synthesize unit/scale/... in event update")
Link: http://lkml.kernel.org/r/20181003212052.GA32371@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 1 +
 tools/perf/util/evsel.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 76e12bcd1765..b2188e623e22 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -981,6 +981,7 @@ int cmd_report(int argc, const char **argv)
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_event__process_auxtrace_info,
 			.auxtrace	 = perf_event__process_auxtrace,
+			.event_update	 = perf_event__process_event_update,
 			.feature	 = process_feature_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1a61628a1c12..e596ae358c4d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1089,6 +1089,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
+	if (evsel->own_cpus)
+		evsel->attr.read_format |= PERF_FORMAT_ID;
+
 	/*
 	 * Apply event specific term settings,
 	 * it overloads any global configuration.
-- 
2.14.4
