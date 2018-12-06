From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 54/75] perf top: Save and display the drop count stats
Date: Thu,  6 Dec 2018 18:25:41 -0300
Message-ID: <20181206212602.20474-55-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add drop count to 'perf top' headers:

  # perf top --stdio
   PerfTop:    3549 irqs/sec  kernel:51.8%  exact: 100.0% lost: 0/0 drop: 0/0 [4000Hz cycles:ppp],  (all, 8 CPUs)

  # perf top
  Samples: 0  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 0 lost: 0/0 drop: 0/0

The format is: <current period drop>/<total drop>

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-2lj87zz8tq9ye1ntax3ulw0n@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c       | 5 ++++-
 tools/perf/ui/browsers/hists.c | 4 ++++
 tools/perf/util/top.c          | 7 ++++---
 tools/perf/util/top.h          | 2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 234232d538c2..9166f6087e3f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1112,8 +1112,11 @@ static int deliver_event(struct ordered_events *qe,
 	struct machine *machine;
 	int ret = -1;
 
-	if (should_drop(qevent, top))
+	if (should_drop(qevent, top)) {
+		top->drop++;
+		top->drop_total++;
 		return 0;
+	}
 
 	ret = perf_evlist__parse_sample(evlist, event, &sample);
 	if (ret) {
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ae208c16c8a3..36b262c49f51 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2223,6 +2223,10 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 				     " lost: %" PRIu64 "/%" PRIu64,
 				     top->lost, top->lost_total);
 
+		printed += scnprintf(bf + printed, size - printed,
+				     " drop: %" PRIu64 "/%" PRIu64,
+				     top->drop, top->drop_total);
+
 		if (top->zero)
 			printed += scnprintf(bf + printed, size - printed, " [z]");
 	}
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index e6582fa6a4db..31a8dee9af69 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -46,8 +46,9 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 							samples_per_sec;
 		ret = SNPRINTF(bf, size,
 			       "   PerfTop:%8.0f irqs/sec  kernel:%4.1f%%"
-			       "  exact: %4.1f%% lost: %" PRIu64 "/%" PRIu64 " [", samples_per_sec,
-			       ksamples_percent, esamples_percent, top->lost, top->lost_total);
+			       "  exact: %4.1f%% lost: %" PRIu64 "/%" PRIu64 " drop: %" PRIu64 "/%" PRIu64 " [",
+			       samples_per_sec, ksamples_percent, esamples_percent,
+			       top->lost, top->lost_total, top->drop, top->drop_total);
 	} else {
 		float us_samples_per_sec = top->us_samples / top->delay_secs;
 		float guest_kernel_samples_per_sec = top->guest_kernel_samples / top->delay_secs;
@@ -113,5 +114,5 @@ void perf_top__reset_sample_counters(struct perf_top *top)
 {
 	top->samples = top->us_samples = top->kernel_samples =
 	top->exact_samples = top->guest_kernel_samples =
-	top->guest_us_samples = top->lost = 0;
+	top->guest_us_samples = top->lost = top->drop = 0;
 }
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 5bce62ebcf14..19f95eaf75c8 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -22,7 +22,7 @@ struct perf_top {
 	 * Symbols will be added here in perf_event__process_sample and will
 	 * get out after decayed.
 	 */
-	u64		   samples, lost, lost_total;
+	u64		   samples, lost, lost_total, drop, drop_total;
 	u64		   kernel_samples, us_samples;
 	u64		   exact_samples;
 	u64		   guest_us_samples, guest_kernel_samples;
-- 
2.19.2
