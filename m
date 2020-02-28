From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/15] perf annotate: Remove privsize from symbol__annotate() args
Date: Fri, 28 Feb 2020 11:00:11 -0300
Message-ID: <20200228140014.1236-13-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

privsize is passed as 0 from all the symbol__annotate() callers.
Remove it from argument list.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200204045233.474937-2-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c     | 2 +-
 tools/perf/ui/gtk/annotate.c | 2 +-
 tools/perf/util/annotate.c   | 7 ++++---
 tools/perf/util/annotate.h   | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index cc26aeab6a66..f6dd1a63f159 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -143,7 +143,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(&he->ms, evsel, 0, &top->annotation_opts, NULL);
+	err = symbol__annotate(&he->ms, evsel, &top->annotation_opts, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 22cc240f7371..35f9641bf670 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -174,7 +174,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (ms->map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(ms, evsel, 0, &annotation__default_options, NULL);
+	err = symbol__annotate(ms, evsel, &annotation__default_options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3b79da595db6..a76309fcf381 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2149,9 +2149,10 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int symbol__annotate(struct map_symbol *ms, struct evsel *evsel, size_t privsize,
+int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		     struct annotation_options *options, struct arch **parch)
 {
+	size_t privsize = 0;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
@@ -2790,7 +2791,7 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 
-	if (symbol__annotate(ms, evsel, 0, opts, NULL) < 0)
+	if (symbol__annotate(ms, evsel, opts, NULL) < 0)
 		return -1;
 
 	symbol__calc_percent(sym, evsel);
@@ -3070,7 +3071,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
 
-	err = symbol__annotate(ms, evsel, 0, options, parch);
+	err = symbol__annotate(ms, evsel, options, parch);
 	if (err)
 		goto out_free_offsets;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 8e54184b43dc..7bc60988e478 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -350,7 +350,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct map_symbol *ms,
-		     struct evsel *evsel, size_t privsize,
+		     struct evsel *evsel,
 		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct map_symbol *ms,
-- 
2.21.1
