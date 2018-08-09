From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/44] perf annotate: Rename hist to sym_hist in annotation__calc_percent
Date: Thu,  9 Aug 2018 11:57:56 -0300
Message-ID: <20180809145822.21391-19-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We will need to bring in 'struct hists' variable in this scope, so it's
better we do this rename first.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8bd278a71004..728603636adc 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1753,7 +1753,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	goto out_free_command;
 }
 
-static void calc_percent(struct sym_hist *hist,
+static void calc_percent(struct sym_hist *sym_hist,
 			 struct annotation_data *data,
 			 s64 offset, s64 end)
 {
@@ -1761,15 +1761,15 @@ static void calc_percent(struct sym_hist *hist,
 	u64 period = 0;
 
 	while (offset < end) {
-		hits   += hist->addr[offset].nr_samples;
-		period += hist->addr[offset].period;
+		hits   += sym_hist->addr[offset].nr_samples;
+		period += sym_hist->addr[offset].period;
 		++offset;
 	}
 
-	if (hist->nr_samples) {
+	if (sym_hist->nr_samples) {
 		data->he.period     = period;
 		data->he.nr_samples = hits;
-		data->percent = 100.0 * hits / hist->nr_samples;
+		data->percent = 100.0 * hits / sym_hist->nr_samples;
 	}
 }
 
@@ -1790,12 +1790,12 @@ static void annotation__calc_percent(struct annotation *notes,
 
 		for (i = 0; i < al->data_nr; i++) {
 			struct annotation_data *data;
-			struct sym_hist *hist;
+			struct sym_hist *sym_hist;
 
-			hist = annotation__histogram(notes, evsel->idx + i);
+			sym_hist = annotation__histogram(notes, evsel->idx + i);
 			data = &al->data[i];
 
-			calc_percent(hist, data, al->offset, end);
+			calc_percent(sym_hist, data, al->offset, end);
 		}
 	}
 }
-- 
2.14.4
