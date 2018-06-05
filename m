From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/46] perf annotate: __symbol__inc_addr_samples() needs just annotated_source
Date: Tue,  5 Jun 2018 14:49:54 -0300
Message-ID: <20180605175030.32549-11-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It only operates on the histograms, so no need for the encompassing
'struct annotation'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2se2v7rrjil0kwqywks04ey2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 +++---
 tools/perf/util/annotate.h | 8 ++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a6fa49bf879b..a5a6d686004e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -819,7 +819,7 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
 }
 
 static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
-				      struct annotation *notes, int evidx, u64 addr,
+				      struct annotated_source *src, int evidx, u64 addr,
 				      struct perf_sample *sample)
 {
 	unsigned offset;
@@ -835,7 +835,7 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	}
 
 	offset = addr - sym->start;
-	h = annotation__histogram(notes, evidx);
+	h = annotated_source__histogram(src, evidx);
 	h->nr_samples++;
 	h->addr[offset].nr_samples++;
 	h->period += sample->period;
@@ -874,7 +874,7 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	notes = symbol__get_annotation(sym, false);
 	if (notes == NULL)
 		return -ENOMEM;
-	return __symbol__inc_addr_samples(sym, map, notes, evsel->idx, addr, sample);
+	return __symbol__inc_addr_samples(sym, map, notes->src, evsel->idx, addr, sample);
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 94b60e34c3a7..2a73f9084930 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -267,10 +267,14 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 void annotation__update_column_widths(struct annotation *notes);
 void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
 
+static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
+{
+	return ((void *)src->histograms) + (src->sizeof_sym_hist * idx);
+}
+
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
-	return (((void *)notes->src->histograms) +
-	 	(notes->src->sizeof_sym_hist * idx));
+	return annotated_source__histogram(notes->src, idx);
 }
 
 static inline struct annotation *symbol__annotation(struct symbol *sym)
-- 
2.14.3
