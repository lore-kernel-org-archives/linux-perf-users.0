From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/28] perf test: Switch to new perf_mmap__read_event() interface for time-to-tsc
Date: Mon,  5 Mar 2018 11:29:28 -0300
Message-ID: <20180305142932.16921-25-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'time-to-tsc' still use the legacy interface.

No functional change.

Commiter notes:

Testing it:

  # perf test tsc
  57: Convert perf time to TSC                              : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-10-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 06abe8108b33..7f82d91ef473 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -60,6 +60,8 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	union perf_event *event;
 	u64 test_tsc, comm1_tsc, comm2_tsc;
 	u64 test_time, comm1_time = 0, comm2_time = 0;
+	struct perf_mmap *md;
+	u64 end, start;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	CHECK_NOT_NULL__(threads);
@@ -109,7 +111,11 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	perf_evlist__disable(evlist);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			struct perf_sample sample;
 
 			if (event->header.type != PERF_RECORD_COMM ||
@@ -128,8 +134,9 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 				comm2_time = sample.time;
 			}
 next_event:
-			perf_evlist__mmap_consume(evlist, i);
+			perf_mmap__consume(md, false);
 		}
+		perf_mmap__read_done(md);
 	}
 
 	if (!comm1_time || !comm2_time)
-- 
2.14.3
