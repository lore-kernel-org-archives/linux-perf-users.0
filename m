From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC PATCH] perf hists: Do column alignment on the format iterator
Date: Thu, 11 Feb 2016 17:27:18 -0300
Message-ID: <20160211202718.GD32168@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

We were doing column alignment in the format function for each cell,
returning a string padded with spaces so that when the next column is
printed the cursor is at its column alignment.

This ends up needlessly printing trailing spaces, do it at the format
iterator, that is where we know if it is needed, i.e. if there is more
columns to be printed.

This eliminates the need for triming lines when doing a dump using 'P'
in the TUI browser and also produces far saner results with things like
piping 'perf report' to 'less'.

Right now only the formatters for sym->name and the 'locked' column
(perf mem report), that are the ones that end up at the end of lines
in the default 'perf report', 'perf top' and 'perf mem report' tools,
the others will be done in a subsequent patch.

In the end the 'width' parameter for the formatters now mean, in
'printf' terms, the 'precision', where before it was the field 'width'.

Reported-by: Dave Jones <davej@codemonkey.org.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/n/tip-s7iwl2gj23w92l6tibnrcqzr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 17 ++++++++++-------
 tools/perf/ui/stdio/hist.c     |  1 +
 tools/perf/util/hist.c         | 21 +++++++++++++++++++++
 tools/perf/util/hist.h         |  5 +++++
 tools/perf/util/sort.c         | 13 +++----------
 5 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a5a5390476ac..af608d5da17d 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1086,16 +1086,17 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 			.folded_sign	= folded_sign,
 			.current_entry	= current_entry,
 		};
-		struct perf_hpp hpp = {
-			.buf		= s,
-			.size		= sizeof(s),
-			.ptr		= &arg,
-		};
 		int column = 0;
 
 		hist_browser__gotorc(browser, row, 0);
 
 		hists__for_each_format(browser->hists, fmt) {
+			struct perf_hpp hpp = {
+				.buf	= s,
+				.size	= sizeof(s),
+				.ptr	= &arg,
+			};
+
 			if (perf_hpp__should_skip(fmt, entry->hists) ||
 			    column++ < browser->b.horiz_scroll)
 				continue;
@@ -1122,8 +1123,9 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 			if (fmt->color) {
 				width -= fmt->color(fmt, &hpp, entry);
 			} else {
-				width -= fmt->entry(fmt, &hpp, entry);
+				hist_entry__snprintf_alignment(entry, &hpp, fmt, fmt->entry(fmt, &hpp, entry));
 				ui_browser__printf(&browser->b, "%s", s);
+				width -= hpp.buf - s;
 			}
 		}
 
@@ -1452,9 +1454,10 @@ static int hist_browser__fprintf_entry(struct hist_browser *browser,
 			first = false;
 
 		ret = fmt->entry(fmt, &hpp, he);
+		ret = hist_entry__snprintf_alignment(he, &hpp, fmt, ret);
 		advance_hpp(&hpp, ret);
 	}
-	printed += fprintf(fp, "%s\n", rtrim(s));
+	printed += fprintf(fp, "%s\n", s);
 
 	if (folded_sign == '-')
 		printed += hist_browser__fprintf_callchain(browser, he, fp);
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 1a6e8f7f38c4..87b022ff03d8 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -403,6 +403,7 @@ static int hist_entry__snprintf(struct hist_entry *he, struct perf_hpp *hpp)
 		else
 			ret = fmt->entry(fmt, hpp, he);
 
+		ret = hist_entry__snprintf_alignment(he, hpp, fmt, ret);
 		advance_hpp(hpp, ret);
 	}
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 12f2d794dc28..561e9473a915 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1015,6 +1015,27 @@ void hist_entry__delete(struct hist_entry *he)
 }
 
 /*
+ * If this is not the last column, then we need to pad it according to the
+ * pre-calculated max lenght for this column, otherwise don't bother adding
+ * spaces because that would break viewing this with, for instance, 'less',
+ * that would show tons of trailing spaces when a long C++ demangled method
+ * names is sampled.
+*/
+int hist_entry__snprintf_alignment(struct hist_entry *he, struct perf_hpp *hpp,
+				   struct perf_hpp_fmt *fmt, int printed)
+{
+	if (!list_is_last(&fmt->list, &he->hists->hpp_list->fields)) {
+		const int width = fmt->width(fmt, hpp, hists_to_evsel(he->hists));
+		if (printed < width) {
+			advance_hpp(hpp, printed);
+			printed = scnprintf(hpp->buf, hpp->size, "%-*s", width - printed, " ");
+		}
+	}
+
+	return printed;
+}
+
+/*
  * collapse the histogram
  */
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 1c7544a8fe1a..840b6d6aa44f 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -122,11 +122,16 @@ struct hist_entry *__hists__add_entry(struct hists *hists,
 int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 			 int max_stack_depth, void *arg);
 
+struct perf_hpp;
+struct perf_hpp_fmt;
+
 int64_t hist_entry__cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t hist_entry__collapse(struct hist_entry *left, struct hist_entry *right);
 int hist_entry__transaction_len(void);
 int hist_entry__sort_snprintf(struct hist_entry *he, char *bf, size_t size,
 			      struct hists *hists);
+int hist_entry__snprintf_alignment(struct hist_entry *he, struct perf_hpp *hpp,
+				   struct perf_hpp_fmt *fmt, int printed);
 void hist_entry__delete(struct hist_entry *he);
 
 void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *prog);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index de620f7f40f4..c0ddde280584 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -247,10 +247,8 @@ static int _hist_entry__sym_snprintf(struct map *map, struct symbol *sym,
 			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
 			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
 					ip - map->unmap_ip(map, sym->start));
-			ret += repsep_snprintf(bf + ret, size - ret, "%-*s",
-				       width - ret, "");
 		} else {
-			ret += repsep_snprintf(bf + ret, size - ret, "%-*s",
+			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
 					       width - ret,
 					       sym->name);
 		}
@@ -258,14 +256,9 @@ static int _hist_entry__sym_snprintf(struct map *map, struct symbol *sym,
 		size_t len = BITS_PER_LONG / 4;
 		ret += repsep_snprintf(bf + ret, size - ret, "%-#.*llx",
 				       len, ip);
-		ret += repsep_snprintf(bf + ret, size - ret, "%-*s",
-				       width - ret, "");
 	}
 
-	if (ret > width)
-		bf[width] = '\0';
-
-	return width;
+	return ret;
 }
 
 static int hist_entry__sym_snprintf(struct hist_entry *he, char *bf,
@@ -811,7 +804,7 @@ static int hist_entry__locked_snprintf(struct hist_entry *he, char *bf,
 	else
 		out = "No";
 
-	return repsep_snprintf(bf, size, "%-*s", width, out);
+	return repsep_snprintf(bf, size, "%.*s", width, out);
 }
 
 static int64_t
-- 
2.5.0
