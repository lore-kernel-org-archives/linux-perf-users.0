From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/43] perf ui stdio: No need to use 'spaces' to left align
Date: Mon,  1 Jul 2019 23:25:46 -0300
Message-ID: <20190702022616.1259-14-acme@kernel.org>
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

We can just use the 'field width' for the %s used to print the
alignment, this way we'll get the same result without requiring having a
variable with just lots of space chars.

No way to do that for the dots tho, we still need that variable filled
with dot chars.

  # perf report --stdio --hierarchy > before
  # perf report --stdio --hierarchy > after
  # diff before after
  #

I.e. it continues as:

  # perf report --stdio --hierarchy | head -15
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 107  of event 'cycles'
  # Event count (approx.): 31378313
  #
  #       Overhead  Command / Shared Object / Symbol
  # ..............  ............................................
  #
      80.13%        swapper
         72.29%        [kernel.vmlinux]
            49.85%        [k] intel_idle
             9.05%        [k] tick_nohz_next_event
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9s1dxik37waveor7c84hqti2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/stdio/hist.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index a60f2993d390..4c97e3cdf173 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -566,10 +566,14 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 static int print_hierarchy_indent(const char *sep, int indent,
 				  const char *line, FILE *fp)
 {
+	int width;
+
 	if (sep != NULL || indent < 2)
 		return 0;
 
-	return fprintf(fp, "%-.*s", (indent - 2) * HIERARCHY_INDENT, line);
+	width = (indent - 2) * HIERARCHY_INDENT;
+
+	return fprintf(fp, "%-*.*s", width, width, line);
 }
 
 static int hists__fprintf_hierarchy_headers(struct hists *hists,
@@ -587,7 +591,7 @@ static int hists__fprintf_hierarchy_headers(struct hists *hists,
 	indent = hists->nr_hpp_node;
 
 	/* preserve max indent depth for column headers */
-	print_hierarchy_indent(sep, indent, spaces, fp);
+	print_hierarchy_indent(sep, indent, " ", fp);
 
 	/* the first hpp_list_node is for overhead columns */
 	fmt_node = list_first_entry(&hists->hpp_formats,
@@ -816,7 +820,7 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		if (!h->leaf && !hist_entry__has_hierarchy_children(h, min_pcnt)) {
 			int depth = hists->nr_hpp_node + h->depth + 1;
 
-			print_hierarchy_indent(sep, depth, spaces, fp);
+			print_hierarchy_indent(sep, depth, " ", fp);
 			fprintf(fp, "%*sno entry >= %.2f%%\n", indent, "", min_pcnt);
 
 			if (max_rows && ++nr_rows >= max_rows)
-- 
2.20.1
