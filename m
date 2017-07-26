From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/40] perf annotate stdio: Fix column header when using --show-total-period
Date: Wed, 26 Jul 2017 11:17:29 -0300
Message-ID: <20170726141730.30750-40-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

Currently the first column header is always "Percent", fix it to show
correct column name based on given options, i.e. if using
--show-total-period, show "Event count" as a first column.

Reported-by: Milian Wolff <milian.wolff@kdab.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/c3c902e7-95bc-16d4-366f-12eb034c5c8d@gmail.com
[ Extracted from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 004072f82511..c2b4b00166ed 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1824,7 +1824,8 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 		width *= evsel->nr_members;
 
 	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
-	       width, width, "Percent", d_filename, evsel_name, h->nr_samples);
+				  width, width, symbol_conf.show_total_period ? "Event count" : "Percent",
+				  d_filename, evsel_name, h->nr_samples);
 
 	printf("%-*.*s----\n",
 	       graph_dotted_len, graph_dotted_len, graph_dotted_line);
-- 
2.9.4
