From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/46] perf annotate: Introduce constructor/destructor for annotated_source
Date: Tue,  5 Jun 2018 14:49:52 -0300
Message-ID: <20180605175030.32549-9-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

More stuff will go in there, all the parts that are not needed when a
symbol had no samples and that were mistakenly added to 'struct
annotation'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-u4761kyzhixw9ydk6kib3f0o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f0c6941bca6c..f6c9bb29ac84 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -678,6 +678,25 @@ static struct arch *arch__find(const char *name)
 	return bsearch(name, architectures, nmemb, sizeof(struct arch), arch__key_cmp);
 }
 
+static struct annotated_source *annotated_source__new(void)
+{
+	struct annotated_source *src = zalloc(sizeof(*src));
+
+	if (src != NULL)
+		INIT_LIST_HEAD(&src->source);
+
+	return src;
+}
+
+static void annotated_source__delete(struct annotated_source *src)
+{
+	if (src == NULL)
+		return;
+	zfree(&src->histograms);
+	zfree(&src->cycles_hist);
+	free(src);
+}
+
 int symbol__alloc_hist(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
@@ -704,17 +723,17 @@ int symbol__alloc_hist(struct symbol *sym)
 	if (sizeof_sym_hist > SIZE_MAX / symbol_conf.nr_events)
 		return -1;
 
-	notes->src = zalloc(sizeof(*notes->src));
+	notes->src = annotated_source__new();
 	if (notes->src == NULL)
 		return -1;
 	notes->src->histograms = calloc(symbol_conf.nr_events, sizeof_sym_hist);
 	if (notes->src->histograms == NULL) {
-		zfree(&notes->src);
+		annotated_source__delete(notes->src);
+		notes->src = NULL;
 		return -1;
 	}
 	notes->src->sizeof_sym_hist = sizeof_sym_hist;
 	notes->src->nr_histograms   = symbol_conf.nr_events;
-	INIT_LIST_HEAD(&notes->src->source);
 	return 0;
 }
 
-- 
2.14.3
