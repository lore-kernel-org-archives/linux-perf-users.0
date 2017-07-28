From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/15] perf annotate stdio: Set enough columns for --show-total-period
Date: Fri, 28 Jul 2017 17:00:12 -0300
Message-ID: <20170728200021.11389-7-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that we set the first column header according to wether
--show-total-period is being used, we need to size it accordingly.

Based-on-a-patch-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/n/tip-pu504ffnit4m334k09hxcbs3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c2b4b00166ed..5125c2bbacaa 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1142,7 +1142,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 			color = get_percent_color(percent);
 
 			if (symbol_conf.show_total_period)
-				color_fprintf(stdout, color, " %7" PRIu64,
+				color_fprintf(stdout, color, " %11" PRIu64,
 					      sample.period);
 			else
 				color_fprintf(stdout, color, " %7.2f", percent);
@@ -1165,7 +1165,7 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 	} else if (max_lines && printed >= max_lines)
 		return 1;
 	else {
-		int width = 8;
+		int width = symbol_conf.show_total_period ? 12 : 8;
 
 		if (queue)
 			return -1;
@@ -1806,7 +1806,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	int printed = 2, queue_len = 0;
 	int more = 0;
 	u64 len;
-	int width = 8;
+	int width = symbol_conf.show_total_period ? 12 : 8;
 	int graph_dotted_len;
 
 	filename = strdup(dso->long_name);
-- 
2.9.4
