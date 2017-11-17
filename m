From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 83/83] perf tools: Move symbol__calc_percent() call to outside symbol__disassemble()
Date: Fri, 17 Nov 2017 17:16:01 -0300
Message-ID: <20171117201601.24110-84-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need to call symbol__calc_percent() periodicaly for top, so it's no
longer convenient to keep it in symbol__disassemble().

Let's separate the symbol__disassemble() to allocate and init
the symbol annotation structs and symbol__calc_percent() to
compute the lines percentages based on symbol hists data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-gtnp8t4tb00q6lag07psn5nq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 2 ++
 tools/perf/ui/gtk/annotate.c      | 2 ++
 tools/perf/util/annotate.c        | 9 +++------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 5a2f37a91feb..03b7363a49c9 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1126,6 +1126,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 		goto out_free_offsets;
 	}
 
+	symbol__calc_percent(sym, evsel);
+
 	ui_helpline__push("Press ESC to exit");
 
 	notes = symbol__annotation(sym);
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 5e0a56df0b4c..cdb5ecf91666 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -177,6 +177,8 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 		return -1;
 	}
 
+	symbol__calc_percent(sym, evsel);
+
 	if (perf_gtk__is_active_context(pgctx)) {
 		window = pgctx->main_window;
 		notebook = pgctx->notebook;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 846abb4955ac..22ea7936d92f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1653,12 +1653,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		}
 	}
 
-	err = symbol__disassemble(sym, &args);
-	if (!err)
-		symbol__calc_percent(sym, evsel);
-
-	return err;
-
+	return symbol__disassemble(sym, &args);
 }
 
 static void insert_source_line(struct rb_root *root, struct annotation_line *al)
@@ -2005,6 +2000,8 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	if (symbol__annotate(sym, map, evsel, 0, NULL, NULL) < 0)
 		return -1;
 
+	symbol__calc_percent(sym, evsel);
+
 	if (print_lines) {
 		srcline_full_filename = full_paths;
 		symbol__calc_lines(sym, map, &source_line);
-- 
2.13.6
