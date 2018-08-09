From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/44] perf annotate: Add support to toggle percent type
Date: Thu,  9 Aug 2018 11:58:06 -0300
Message-ID: <20180809145822.21391-29-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add new key bindings to toggle percent type/base in annotation UI browser:

 'p' to switch between local and global percent type
 'b' to switch between hits and perdio percent base

Add the following help messages to the UI browser '?' window:

  ...
  p             Toggle percent type [local/global]
  b             Toggle percent base [period/hits]
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-17-jolsa@kernel.org
[ Moved percent_type to be the last arg to sym_title(), its an arg to what is being formmated (buf, size) ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 52 ++++++++++++++++++++++++++++++++++++---
 tools/perf/util/annotate.h        | 16 ++++++++++++
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 2a3a34d450d5..1d00e5ec7906 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <sys/ttydefaults.h>
+#include <asm/bug.h>
 
 struct disasm_line_samples {
 	double		      percent;
@@ -383,9 +384,10 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 #define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
 
 static int sym_title(struct symbol *sym, struct map *map, char *title,
-		     size_t sz)
+		     size_t sz, int percent_type)
 {
-	return snprintf(title, sz, "%s  %s", sym->name, map->dso->long_name);
+	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name, map->dso->long_name,
+			percent_type_str(percent_type));
 }
 
 /*
@@ -423,7 +425,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 
 	pthread_mutex_unlock(&notes->lock);
 	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt, browser->opts);
-	sym_title(ms->sym, ms->map, title, sizeof(title));
+	sym_title(ms->sym, ms->map, title, sizeof(title), browser->opts->percent_type);
 	ui_browser__show_title(&browser->b, title);
 	return true;
 }
@@ -598,6 +600,7 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 
 static int annotate_browser__show(struct ui_browser *browser, char *title, const char *help)
 {
+	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct map_symbol *ms = browser->priv;
 	struct symbol *sym = ms->sym;
 	char symbol_dso[SYM_TITLE_MAX_SIZE];
@@ -605,7 +608,7 @@ static int annotate_browser__show(struct ui_browser *browser, char *title, const
 	if (ui_browser__show(browser, title, help) < 0)
 		return -1;
 
-	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso));
+	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso), ab->opts->percent_type);
 
 	ui_browser__gotorc_title(browser, 0, 0);
 	ui_browser__set_color(browser, HE_COLORSET_ROOT);
@@ -613,6 +616,39 @@ static int annotate_browser__show(struct ui_browser *browser, char *title, const
 	return 0;
 }
 
+static void
+switch_percent_type(struct annotation_options *opts, bool base)
+{
+	switch (opts->percent_type) {
+	case PERCENT_HITS_LOCAL:
+		if (base)
+			opts->percent_type = PERCENT_PERIOD_LOCAL;
+		else
+			opts->percent_type = PERCENT_HITS_GLOBAL;
+		break;
+	case PERCENT_HITS_GLOBAL:
+		if (base)
+			opts->percent_type = PERCENT_PERIOD_GLOBAL;
+		else
+			opts->percent_type = PERCENT_HITS_LOCAL;
+		break;
+	case PERCENT_PERIOD_LOCAL:
+		if (base)
+			opts->percent_type = PERCENT_HITS_LOCAL;
+		else
+			opts->percent_type = PERCENT_PERIOD_GLOBAL;
+		break;
+	case PERCENT_PERIOD_GLOBAL:
+		if (base)
+			opts->percent_type = PERCENT_HITS_GLOBAL;
+		else
+			opts->percent_type = PERCENT_PERIOD_LOCAL;
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct perf_evsel *evsel,
 				 struct hist_browser_timer *hbt)
@@ -703,6 +739,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"k             Toggle line numbers\n"
 		"P             Print to [symbol_name].annotation file.\n"
 		"r             Run available scripts\n"
+		"p             Toggle percent type [local/global]\n"
+		"b             Toggle percent base [period/hits]\n"
 		"?             Search string backwards\n");
 			continue;
 		case 'r':
@@ -802,6 +840,12 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				notes->options->show_minmax_cycle = true;
 			annotation__update_column_widths(notes);
 			continue;
+		case 'p':
+		case 'b':
+			switch_percent_type(browser->opts, key == 'b');
+			hists__scnprintf_title(hists, title, sizeof(title));
+			annotate_browser__show(&browser->b, title, help);
+			continue;
 		case K_LEFT:
 		case K_ESC:
 		case 'q':
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3d4579e68d28..760a6678edff 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <pthread.h>
+#include <asm/bug.h>
 
 struct ins_ops;
 
@@ -149,6 +150,21 @@ static inline double annotation_data__percent(struct annotation_data *data,
 	return which < PERCENT_MAX ? data->percent[which] : -1;
 }
 
+static inline const char *percent_type_str(unsigned int type)
+{
+	static const char *str[PERCENT_MAX] = {
+		"local hits",
+		"global hits",
+		"local period",
+		"global period",
+	};
+
+	if (WARN_ON(type >= PERCENT_MAX))
+		return "N/A";
+
+	return str[type];
+}
+
 static inline struct disasm_line *disasm_line(struct annotation_line *al)
 {
 	return al ? container_of(al, struct disasm_line, al) : NULL;
-- 
2.14.4
