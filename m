From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 48/75] perf top: Save and display the lost count stats
Date: Thu,  6 Dec 2018 18:25:35 -0300
Message-ID: <20181206212602.20474-49-acme@kernel.org>
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

Add a 'lost count' to 'perf top' headers:

  # perf top --stdio
   PerfTop:    3850 irqs/sec  kernel:49.0%  exact: 100.0% lost: 0/0 [4000Hz cycles:ppp],  (all, 8 CPUs)

  # perf top
  Samples: 0  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 0 lost: 0/0

The format is: <current period lost>/<total lost>

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-zo11rn270gij5jtp8fknpf8u@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c       | 27 +++++++++++++++++++++++++++
 tools/perf/ui/browsers/hists.c |  4 ++++
 tools/perf/util/top.c          |  6 +++---
 tools/perf/util/top.h          |  2 +-
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1beb3e360521..c02ea537d5a7 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -800,6 +800,29 @@ static void perf_event__process_sample(struct perf_tool *tool,
 	addr_location__put(&al);
 }
 
+static void
+perf_top__process_lost(struct perf_top *top, union perf_event *event,
+		       struct perf_evsel *evsel)
+{
+	struct hists *hists = evsel__hists(evsel);
+
+	top->lost += event->lost.lost;
+	top->lost_total += event->lost.lost;
+	hists->stats.total_lost += event->lost.lost;
+}
+
+static void
+perf_top__process_lost_samples(struct perf_top *top,
+			       union perf_event *event,
+			       struct perf_evsel *evsel)
+{
+	struct hists *hists = evsel__hists(evsel);
+
+	top->lost += event->lost_samples.lost;
+	top->lost_total += event->lost_samples.lost;
+	hists->stats.total_lost_samples += event->lost_samples.lost;
+}
+
 static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 {
 	struct record_opts *opts = &top->record_opts;
@@ -865,6 +888,10 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		if (event->header.type == PERF_RECORD_SAMPLE) {
 			perf_event__process_sample(&top->tool, event, evsel,
 						   &sample, machine);
+		} else if (event->header.type == PERF_RECORD_LOST) {
+			perf_top__process_lost(top, event, evsel);
+		} else if (event->header.type == PERF_RECORD_LOST_SAMPLES) {
+			perf_top__process_lost_samples(top, event, evsel);
 		} else if (event->header.type < PERF_RECORD_MAX) {
 			hists__inc_nr_events(evsel__hists(evsel), event->header.type);
 			machine__process_event(machine, event, &sample);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a96f62ca984a..ae208c16c8a3 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2219,6 +2219,10 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 	if (!is_report_browser(hbt)) {
 		struct perf_top *top = hbt->arg;
 
+		printed += scnprintf(bf + printed, size - printed,
+				     " lost: %" PRIu64 "/%" PRIu64,
+				     top->lost, top->lost_total);
+
 		if (top->zero)
 			printed += scnprintf(bf + printed, size - printed, " [z]");
 	}
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 8e517def925b..e6582fa6a4db 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -46,8 +46,8 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 							samples_per_sec;
 		ret = SNPRINTF(bf, size,
 			       "   PerfTop:%8.0f irqs/sec  kernel:%4.1f%%"
-			       "  exact: %4.1f%% [", samples_per_sec,
-			       ksamples_percent, esamples_percent);
+			       "  exact: %4.1f%% lost: %" PRIu64 "/%" PRIu64 " [", samples_per_sec,
+			       ksamples_percent, esamples_percent, top->lost, top->lost_total);
 	} else {
 		float us_samples_per_sec = top->us_samples / top->delay_secs;
 		float guest_kernel_samples_per_sec = top->guest_kernel_samples / top->delay_secs;
@@ -113,5 +113,5 @@ void perf_top__reset_sample_counters(struct perf_top *top)
 {
 	top->samples = top->us_samples = top->kernel_samples =
 	top->exact_samples = top->guest_kernel_samples =
-	top->guest_us_samples = 0;
+	top->guest_us_samples = top->lost = 0;
 }
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 9add1f72ce95..1fbcbd79720a 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -22,7 +22,7 @@ struct perf_top {
 	 * Symbols will be added here in perf_event__process_sample and will
 	 * get out after decayed.
 	 */
-	u64		   samples;
+	u64		   samples, lost, lost_total;
 	u64		   kernel_samples, us_samples;
 	u64		   exact_samples;
 	u64		   guest_us_samples, guest_kernel_samples;
-- 
2.19.2
