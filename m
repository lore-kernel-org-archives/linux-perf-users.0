From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/46] perf annotate: Introduce symbol__hists()
Date: Tue,  5 Jun 2018 14:49:55 -0300
Message-ID: <20180605175030.32549-12-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In this case we're wanting just notes->src->histograms, allocating it if needed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4iatualjskia7sojmdb65cmm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a5a6d686004e..467bae0279ce 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -863,18 +863,38 @@ static struct annotation *symbol__get_annotation(struct symbol *sym, bool cycles
 	return notes;
 }
 
+static struct annotated_source *symbol__hists(struct symbol *sym)
+{
+	struct annotation *notes = symbol__annotation(sym);
+
+	if (notes->src == NULL) {
+		notes->src = annotated_source__new();
+		if (notes->src == NULL)
+			return NULL;
+		goto alloc_histograms;
+	}
+
+	if (notes->src->histograms == NULL) {
+alloc_histograms:
+		annotated_source__alloc_histograms(notes->src, symbol__size(sym),
+						   symbol_conf.nr_events);
+	}
+
+	return notes->src;
+}
+
 static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 				    struct perf_evsel *evsel, u64 addr,
 				    struct perf_sample *sample)
 {
-	struct annotation *notes;
+	struct annotated_source *src;
 
 	if (sym == NULL)
 		return 0;
-	notes = symbol__get_annotation(sym, false);
-	if (notes == NULL)
+	src = symbol__hists(sym);
+	if (src == NULL)
 		return -ENOMEM;
-	return __symbol__inc_addr_samples(sym, map, notes->src, evsel->idx, addr, sample);
+	return __symbol__inc_addr_samples(sym, map, src, evsel->idx, addr, sample);
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
-- 
2.14.3
