From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/43] perf tools: Remove trim() implementation, use tools/lib's strim()
Date: Mon,  1 Jul 2019 23:26:06 -0300
Message-ID: <20190702022616.1259-34-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Moving more stuff out of tools/perf/util/ and using the kernel idiom.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wpj8rktj62yse5dq6ckny6de@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 3 ++-
 tools/perf/ui/browsers/hists.c  | 3 ++-
 tools/perf/ui/gtk/hists.c       | 5 +++--
 tools/perf/ui/stdio/hist.c      | 2 +-
 tools/perf/util/string2.h       | 5 -----
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cd72ff0f7658..66a82badc1d1 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -22,6 +22,7 @@
 #include "string2.h"
 #include "symbol.h"
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <subcmd/exec-cmd.h>
 
 static bool dont_fork;
@@ -438,7 +439,7 @@ static const char *shell_test__description(char *description, size_t size,
 	description = fgets(description, size, fp);
 	fclose(fp);
 
-	return description ? trim(description + 1) : NULL;
+	return description ? strim(description + 1) : NULL;
 }
 
 #define for_each_shell_test(dir, base, ent)	\
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 04a56114df92..10243408f3dc 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/rbtree.h>
+#include <linux/string.h>
 #include <sys/ttydefaults.h>
 #include <linux/time64.h>
 
@@ -1686,7 +1687,7 @@ static int hists_browser__scnprintf_hierarchy_headers(struct hist_browser *brows
 			ret = fmt->header(fmt, &dummy_hpp, hists, 0, NULL);
 			dummy_hpp.buf[ret] = '\0';
 
-			start = trim(dummy_hpp.buf);
+			start = strim(dummy_hpp.buf);
 			ret = strlen(start);
 
 			if (start != dummy_hpp.buf)
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 6341c421a8f7..3955ed1d1bd9 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -9,6 +9,7 @@
 #include "../string2.h"
 #include "gtk.h"
 #include <signal.h>
+#include <linux/string.h>
 
 #define MAX_COLUMNS			32
 
@@ -459,7 +460,7 @@ static void perf_gtk__add_hierarchy_entries(struct hists *hists,
 			advance_hpp(hpp, ret + 2);
 		}
 
-		gtk_tree_store_set(store, &iter, col_idx, trim(bf), -1);
+		gtk_tree_store_set(store, &iter, col_idx, strim(bf), -1);
 
 		if (!he->leaf) {
 			hpp->buf = bf;
@@ -555,7 +556,7 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 			first_col = false;
 
 			fmt->header(fmt, &hpp, hists, 0, NULL);
-			strcat(buf, trim(hpp.buf));
+			strcat(buf, strim(hpp.buf));
 		}
 	}
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 594e56628904..9eb0131c3ade 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -620,7 +620,7 @@ static int hists__fprintf_hierarchy_headers(struct hists *hists,
 
 			fmt->header(fmt, hpp, hists, 0, NULL);
 
-			header_width += fprintf(fp, "%s", trim(hpp->buf));
+			header_width += fprintf(fp, "%s", strim(hpp->buf));
 		}
 	}
 
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index db02059e31c5..5bc3fea52cdc 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -25,11 +25,6 @@ char *strxfrchar(char *s, char from, char to);
 
 char *rtrim(char *s);
 
-static inline char *trim(char *s)
-{
-	return skip_spaces(rtrim(s));
-}
-
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
 
 static inline char *asprintf_expr_in_ints(const char *var, size_t nints, int *ints)
-- 
2.20.1
