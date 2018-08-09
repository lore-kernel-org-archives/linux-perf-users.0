From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/44] perf annotate: Display percent type in stdio output
Date: Thu,  9 Aug 2018 11:58:08 -0300
Message-ID: <20180809145822.21391-31-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

In following patches we will allow to switch percent type even for stdio
annotation outputs. Adding the percent type value into the annotation
outputs title.

  $ perf annotate --stdio
   Percent         |      Sou ... instructions:u } (2805 samples, percent: local period)
  --------------------------- ... ------------------------------------------------------
  ...

  $ perf annotate --stdio2
  Samples: 2K of events 'anon ...  count (approx.): 156525487, [percent: local period]
  safe_write.c() /usr/bin/yes
  Percent
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 05d15629afd0..6316fa96d984 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2056,10 +2056,12 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 		evsel_name = buf;
 	}
 
-	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
+	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples, "
+				  "percent: %s)\n",
 				  width, width, symbol_conf.show_total_period ? "Period" :
 				  symbol_conf.show_nr_samples ? "Samples" : "Percent",
-				  d_filename, evsel_name, h->nr_samples);
+				  d_filename, evsel_name, h->nr_samples,
+				  percent_type_str(opts->percent_type));
 
 	printf("%-*.*s----\n",
 	       graph_dotted_len, graph_dotted_len, graph_dotted_line);
@@ -2434,7 +2436,8 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 	}
 
 	hists__scnprintf_title(hists, buf, sizeof(buf));
-	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
+	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
+		buf, percent_type_str(opts->percent_type), sym->name, dso->long_name);
 	symbol__annotate_fprintf2(sym, stdout, opts);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
-- 
2.14.4
