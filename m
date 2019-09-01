From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/47] perf tools: Move 'struct events_stats' and prototypes to separate header
Date: Sun,  1 Sep 2019 09:23:07 -0300
Message-ID: <20190901122326.5793-29-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This will allow us to untangle the header dependency a bit more, as some
places will not need event.h anymore.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-enqncj29ovzaat3cd9203rwl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h     |  5 ++++
 tools/perf/util/event.h        | 42 ----------------------------
 tools/perf/util/events_stats.h | 51 ++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h       |  2 +-
 tools/perf/util/hist.h         |  4 +--
 tools/perf/util/sort.h         |  1 -
 6 files changed, 58 insertions(+), 47 deletions(-)
 create mode 100644 tools/perf/util/events_stats.h

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index b5ac24c770d4..c539e7b6ed56 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -30,6 +30,11 @@ struct record_opts;
 struct perf_record_auxtrace_info;
 struct events_stats;
 
+enum auxtrace_error_type {
+       PERF_AUXTRACE_ERROR_ITRACE  = 1,
+       PERF_AUXTRACE_ERROR_MAX
+};
+
 /* Auxtrace records must have the same alignment as perf event records */
 #define PERF_AUXTRACE_RECORD_ALIGNMENT 8
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 006aa432be19..47ad81d47b1a 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -151,11 +151,6 @@ struct perf_sample {
 	 PERF_MEM_S(LOCK, NA) |\
 	 PERF_MEM_S(TLB, NA))
 
-enum auxtrace_error_type {
-	PERF_AUXTRACE_ERROR_ITRACE  = 1,
-	PERF_AUXTRACE_ERROR_MAX
-};
-
 /* Attribute type for custom synthesized events */
 #define PERF_TYPE_SYNTH		(INT_MAX + 1U)
 
@@ -277,43 +272,6 @@ static inline void *perf_synth__raw_data(void *p)
 
 #define perf_sample__bad_synth_size(s, d) ((s)->raw_size < sizeof(d) - 4)
 
-/*
- * The kernel collects the number of events it couldn't send in a stretch and
- * when possible sends this number in a PERF_RECORD_LOST event. The number of
- * such "chunks" of lost events is stored in .nr_events[PERF_EVENT_LOST] while
- * total_lost tells exactly how many events the kernel in fact lost, i.e. it is
- * the sum of all struct perf_record_lost.lost fields reported.
- *
- * The kernel discards mixed up samples and sends the number in a
- * PERF_RECORD_LOST_SAMPLES event. The number of lost-samples events is stored
- * in .nr_events[PERF_RECORD_LOST_SAMPLES] while total_lost_samples tells
- * exactly how many samples the kernel in fact dropped, i.e. it is the sum of
- * all struct perf_record_lost_samples.lost fields reported.
- *
- * The total_period is needed because by default auto-freq is used, so
- * multipling nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
- * the total number of low level events, it is necessary to to sum all struct
- * perf_record_sample.period and stash the result in total_period.
- */
-struct events_stats {
-	u64 total_period;
-	u64 total_non_filtered_period;
-	u64 total_lost;
-	u64 total_lost_samples;
-	u64 total_aux_lost;
-	u64 total_aux_partial;
-	u64 total_invalid_chains;
-	u32 nr_events[PERF_RECORD_HEADER_MAX];
-	u32 nr_non_filtered_samples;
-	u32 nr_lost_warned;
-	u32 nr_unknown_events;
-	u32 nr_invalid_chains;
-	u32 nr_unknown_id;
-	u32 nr_unprocessable_samples;
-	u32 nr_auxtrace_errors[PERF_AUXTRACE_ERROR_MAX];
-	u32 nr_proc_map_timeout;
-};
-
 enum {
 	PERF_STAT_ROUND_TYPE__INTERVAL	= 0,
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
diff --git a/tools/perf/util/events_stats.h b/tools/perf/util/events_stats.h
new file mode 100644
index 000000000000..859cb34fcff2
--- /dev/null
+++ b/tools/perf/util/events_stats.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_EVENTS_STATS_
+#define __PERF_EVENTS_STATS_
+
+#include <stdio.h>
+#include <perf/event.h>
+#include <linux/types.h>
+#include "auxtrace.h"
+
+/*
+ * The kernel collects the number of events it couldn't send in a stretch and
+ * when possible sends this number in a PERF_RECORD_LOST event. The number of
+ * such "chunks" of lost events is stored in .nr_events[PERF_EVENT_LOST] while
+ * total_lost tells exactly how many events the kernel in fact lost, i.e. it is
+ * the sum of all struct perf_record_lost.lost fields reported.
+ *
+ * The kernel discards mixed up samples and sends the number in a
+ * PERF_RECORD_LOST_SAMPLES event. The number of lost-samples events is stored
+ * in .nr_events[PERF_RECORD_LOST_SAMPLES] while total_lost_samples tells
+ * exactly how many samples the kernel in fact dropped, i.e. it is the sum of
+ * all struct perf_record_lost_samples.lost fields reported.
+ *
+ * The total_period is needed because by default auto-freq is used, so
+ * multipling nr_events[PERF_EVENT_SAMPLE] by a frequency isn't possible to get
+ * the total number of low level events, it is necessary to to sum all struct
+ * perf_record_sample.period and stash the result in total_period.
+ */
+struct events_stats {
+	u64 total_period;
+	u64 total_non_filtered_period;
+	u64 total_lost;
+	u64 total_lost_samples;
+	u64 total_aux_lost;
+	u64 total_aux_partial;
+	u64 total_invalid_chains;
+	u32 nr_events[PERF_RECORD_HEADER_MAX];
+	u32 nr_non_filtered_samples;
+	u32 nr_lost_warned;
+	u32 nr_unknown_events;
+	u32 nr_invalid_chains;
+	u32 nr_unknown_id;
+	u32 nr_unprocessable_samples;
+	u32 nr_auxtrace_errors[PERF_AUXTRACE_ERROR_MAX];
+	u32 nr_proc_map_timeout;
+};
+
+void events_stats__inc(struct events_stats *stats, u32 type);
+
+size_t events_stats__fprintf(struct events_stats *stats, FILE *fp);
+
+#endif /* __PERF_EVENTS_STATS_ */
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index ee288644e9e4..a55f0f2546e5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -9,7 +9,7 @@
 #include <api/fd/array.h>
 #include <stdio.h>
 #include <internal/evlist.h>
-#include "event.h"
+#include "events_stats.h"
 #include "evsel.h"
 #include "mmap.h"
 #include <signal.h>
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 1c0a635e5e32..34803e33dc80 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -6,8 +6,8 @@
 #include <linux/types.h>
 #include <pthread.h>
 #include "evsel.h"
-#include "header.h"
 #include "color.h"
+#include "events_stats.h"
 
 struct hist_entry;
 struct hist_entry_ops;
@@ -190,8 +190,6 @@ void hists__reset_stats(struct hists *hists);
 void hists__inc_stats(struct hists *hists, struct hist_entry *h);
 void hists__inc_nr_events(struct hists *hists, u32 type);
 void hists__inc_nr_samples(struct hists *hists, bool filtered);
-void events_stats__inc(struct events_stats *stats, u32 type);
-size_t events_stats__fprintf(struct events_stats *stats, FILE *fp);
 
 size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		      int max_cols, float min_pcnt, FILE *fp,
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 3d7cef73924c..7b93f34ac1f4 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -9,7 +9,6 @@
 #include "symbol_conf.h"
 #include "callchain.h"
 #include "values.h"
-
 #include "hist.h"
 
 struct option;
-- 
2.21.0
