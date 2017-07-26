From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/40] perf annotate: Store the sample period in each histogram bucket
Date: Wed, 26 Jul 2017 11:17:10 -0300
Message-ID: <20170726141730.30750-21-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

We'll use it soon, when fixing --show-total-period.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1500500215-16646-1-git-send-email-treeze.taeung@gmail.com
[ split from a larger patch, do the math in __symbol__inc_addr_samples() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 17 ++++++++++++-----
 tools/perf/util/annotate.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c2fe16d5e473..00e085fc945b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -698,7 +698,7 @@ static int __symbol__account_cycles(struct annotation *notes,
 
 static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 				      struct annotation *notes, int evidx, u64 addr,
-				      struct perf_sample *sample __maybe_unused)
+				      struct perf_sample *sample)
 {
 	unsigned offset;
 	struct sym_hist *h;
@@ -716,10 +716,13 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	h = annotation__histogram(notes, evidx);
 	h->nr_samples++;
 	h->addr[offset].nr_samples++;
+	h->period += sample->period;
+	h->addr[offset].period += sample->period;
 
 	pr_debug3("%#" PRIx64 " %s: period++ [addr: %#" PRIx64 ", %#" PRIx64
-		  ", evidx=%d] => %" PRIu64 "\n", sym->start, sym->name,
-		  addr, addr - sym->start, evidx, h->addr[offset].nr_samples);
+		  ", evidx=%d] => nr_samples: %" PRIu64 ", period: %" PRIu64 "\n",
+		  sym->start, sym->name, addr, addr - sym->start, evidx,
+		  h->addr[offset].nr_samples, h->addr[offset].period);
 	return 0;
 }
 
@@ -937,7 +940,7 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 	struct source_line *src_line = notes->src->lines;
 	double percent = 0.0;
 
-	sample->nr_samples = 0;
+	sample->nr_samples = sample->period = 0;
 
 	if (src_line) {
 		size_t sizeof_src_line = sizeof(*src_line) +
@@ -957,11 +960,15 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 	} else {
 		struct sym_hist *h = annotation__histogram(notes, evidx);
 		unsigned int hits = 0;
+		u64 period = 0;
 
-		while (offset < end)
+		while (offset < end) {
 			hits += h->addr[offset++].nr_samples;
+			period += h->addr[offset++].period;
+		}
 
 		if (h->nr_samples) {
+			sample->period	   = period;
 			sample->nr_samples = hits;
 			percent = 100.0 * hits / h->nr_samples;
 		}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 720f18195046..9ce575c25fd9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -88,6 +88,7 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 
 struct sym_hist {
 	u64		      nr_samples;
+	u64		      period;
 	struct sym_hist_entry addr[0];
 };
 
-- 
2.9.4
