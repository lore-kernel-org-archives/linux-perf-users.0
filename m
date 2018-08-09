From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/44] perf annotate: Add PERCENT_HITS_GLOBAL percent value
Date: Thu,  9 Aug 2018 11:57:59 -0300
Message-ID: <20180809145822.21391-22-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding and computing global hits percent value for annotation line.
Storing it in struct annotation_data percent array under new
PERCENT_HITS_GLOBAL index.

At the moment it's not displayed, it's coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 8 +++++++-
 tools/perf/util/annotate.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 074adb2a831e..b7485a512da1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1759,6 +1759,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 }
 
 static void calc_percent(struct sym_hist *sym_hist,
+			 struct hists *hists,
 			 struct annotation_data *data,
 			 s64 offset, s64 end)
 {
@@ -1776,6 +1777,10 @@ static void calc_percent(struct sym_hist *sym_hist,
 		data->he.nr_samples = hits;
 		data->percent[PERCENT_HITS_LOCAL] = 100.0 * hits / sym_hist->nr_samples;
 	}
+
+	if (hists->stats.nr_non_filtered_samples)
+		data->percent[PERCENT_HITS_GLOBAL] = 100.0 * hits / hists->stats.nr_non_filtered_samples;
+
 }
 
 static void annotation__calc_percent(struct annotation *notes,
@@ -1795,6 +1800,7 @@ static void annotation__calc_percent(struct annotation *notes,
 		end  = next ? next->offset : len;
 
 		for_each_group_evsel(evsel, leader) {
+			struct hists *hists = evsel__hists(evsel);
 			struct annotation_data *data;
 			struct sym_hist *sym_hist;
 
@@ -1803,7 +1809,7 @@ static void annotation__calc_percent(struct annotation *notes,
 			sym_hist = annotation__histogram(notes, evsel->idx);
 			data = &al->data[i++];
 
-			calc_percent(sym_hist, data, al->offset, end);
+			calc_percent(sym_hist, hists, data, al->offset, end);
 		}
 	}
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0afbf8075fca..3a06cb2b6e28 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -103,6 +103,7 @@ struct sym_hist_entry {
 
 enum {
 	PERCENT_HITS_LOCAL,
+	PERCENT_HITS_GLOBAL,
 	PERCENT_MAX,
 };
 
-- 
2.14.4
