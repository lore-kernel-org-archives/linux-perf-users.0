From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/28] perf test: Switch to new perf_mmap__read_event() interface for sw-clock
Date: Mon,  5 Mar 2018 11:29:29 -0300
Message-ID: <20180305142932.16921-26-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'sw-clock' still use the legacy interface.

No functional change.

Committer testing:

  # perf test clock
  22: Software clock events period values                   : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-11-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sw-clock.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index f6c72f915d48..e6320e267ba5 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -39,6 +39,8 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	};
 	struct cpu_map *cpus;
 	struct thread_map *threads;
+	struct perf_mmap *md;
+	u64 end, start;
 
 	attr.sample_freq = 500;
 
@@ -93,7 +95,11 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 
 	perf_evlist__disable(evlist);
 
-	while ((event = perf_evlist__mmap_read(evlist, 0)) != NULL) {
+	md = &evlist->mmap[0];
+	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		goto out_init;
+
+	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 		struct perf_sample sample;
 
 		if (event->header.type != PERF_RECORD_SAMPLE)
@@ -108,9 +114,11 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		total_periods += sample.period;
 		nr_samples++;
 next_event:
-		perf_evlist__mmap_consume(evlist, 0);
+		perf_mmap__consume(md, false);
 	}
+	perf_mmap__read_done(md);
 
+out_init:
 	if ((u64) nr_samples == total_periods) {
 		pr_debug("All (%d) samples have period value of 1!\n",
 			 nr_samples);
-- 
2.14.3
