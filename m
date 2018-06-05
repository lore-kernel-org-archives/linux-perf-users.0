From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/46] perf annotate: Introduce symbol__cycle_hists()
Date: Tue,  5 Jun 2018 14:49:56 -0300
Message-ID: <20180605175030.32549-13-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In this case we're wanting just notes->src->cycles_hist, allocating it if needed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-pqj81aneunhftlntm66tmhz0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 467bae0279ce..f11199f0be27 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -848,19 +848,23 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	return 0;
 }
 
-static struct annotation *symbol__get_annotation(struct symbol *sym, bool cycles)
+static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
 	if (notes->src == NULL) {
-		if (symbol__alloc_hist(sym) < 0)
+		notes->src = annotated_source__new();
+		if (notes->src == NULL)
 			return NULL;
+		goto alloc_cycles_hist;
 	}
-	if (!notes->src->cycles_hist && cycles) {
-		if (symbol__alloc_hist_cycles(sym) < 0)
-			return NULL;
+
+	if (!notes->src->cycles_hist) {
+alloc_cycles_hist:
+		symbol__alloc_hist_cycles(sym);
 	}
-	return notes;
+
+	return notes->src->cycles_hist;
 }
 
 static struct annotated_source *symbol__hists(struct symbol *sym)
@@ -900,13 +904,13 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 static int symbol__account_cycles(u64 addr, u64 start,
 				  struct symbol *sym, unsigned cycles)
 {
-	struct annotation *notes;
+	struct cyc_hist *cycles_hist;
 	unsigned offset;
 
 	if (sym == NULL)
 		return 0;
-	notes = symbol__get_annotation(sym, true);
-	if (notes == NULL)
+	cycles_hist = symbol__cycles_hist(sym);
+	if (cycles_hist == NULL)
 		return -ENOMEM;
 	if (addr < sym->start || addr >= sym->end)
 		return -ERANGE;
@@ -918,7 +922,7 @@ static int symbol__account_cycles(u64 addr, u64 start,
 			start = 0;
 	}
 	offset = addr - sym->start;
-	return __symbol__account_cycles(notes->src->cycles_hist,
+	return __symbol__account_cycles(cycles_hist,
 					start ? start - sym->start : 0,
 					offset, cycles,
 					!!start);
-- 
2.14.3
