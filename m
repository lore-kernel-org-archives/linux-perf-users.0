From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 1/2] perf evsel: split sample__fprintf_callchain in output and iteration
Date: Tue, 19 Feb 2019 19:38:09 +0100
Message-ID: <4f1e7f5086ce20e041c597577aa6da23a14cfa8c.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Split the iteration over the callchain and the actual output of an
link in the callchain into separate functions. This allows to reuse
the output function in a follow up patch to add inline symbols to
the output.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 tools/perf/util/evsel_fprintf.c | 111 ++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 95ea147f9e18..c710f687ddf4 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -99,12 +99,12 @@ int perf_evsel__fprintf(struct perf_evsel *evsel,
 	return ++printed;
 }
 
-int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
-			      unsigned int print_opts, struct callchain_cursor *cursor,
-			      FILE *fp)
+static int __fprintf_callchain_link(u64 ip, struct map *map, struct symbol *symbol,
+				    const char *srcline, bool first, int left_alignment,
+				    unsigned int print_opts, FILE *fp)
 {
+	u64 addr = 0;
 	int printed = 0;
-	struct callchain_cursor_node *node;
 	int print_ip = print_opts & EVSEL__PRINT_IP;
 	int print_sym = print_opts & EVSEL__PRINT_SYM;
 	int print_dso = print_opts & EVSEL__PRINT_DSO;
@@ -115,63 +115,80 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 	int print_arrow = print_opts & EVSEL__PRINT_CALLCHAIN_ARROW;
 	int print_skip_ignored = print_opts & EVSEL__PRINT_SKIP_IGNORED;
 	char s = print_oneline ? ' ' : '\t';
-	bool first = true;
+	struct addr_location node_al;
 
-	if (sample->callchain) {
-		struct addr_location node_al;
 
-		callchain_cursor_commit(cursor);
+	if (symbol && symbol->ignore && print_skip_ignored)
+		return 0;
 
-		while (1) {
-			u64 addr = 0;
+	printed += fprintf(fp, "%-*.*s", left_alignment, left_alignment, " ");
 
-			node = callchain_cursor_current(cursor);
-			if (!node)
-				break;
+	if (print_arrow && !first)
+		printed += fprintf(fp, " <-");
 
-			if (node->sym && node->sym->ignore && print_skip_ignored)
-				goto next;
+	if (print_ip)
+		printed += fprintf(fp, "%c%16" PRIx64, s, ip);
 
-			printed += fprintf(fp, "%-*.*s", left_alignment, left_alignment, " ");
+	if (map)
+		addr = map->map_ip(map, ip);
 
-			if (print_arrow && !first)
-				printed += fprintf(fp, " <-");
+	if (print_sym) {
+		printed += fprintf(fp, " ");
+		node_al.addr = addr;
+		node_al.map  = map;
 
-			if (print_ip)
-				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
+		if (print_symoffset) {
+			printed += __symbol__fprintf_symname_offs(symbol, &node_al,
+								  print_unknown_as_addr,
+								  true, fp);
+		} else {
+			printed += __symbol__fprintf_symname(symbol, &node_al,
+							     print_unknown_as_addr,
+							     fp);
+		}
+	}
 
-			if (node->map)
-				addr = node->map->map_ip(node->map, node->ip);
+	if (print_dso && (!symbol || !symbol->inlined)) {
+		printed += fprintf(fp, " (");
+		printed += map__fprintf_dsoname(map, fp);
+		printed += fprintf(fp, ")");
+	}
 
-			if (print_sym) {
-				printed += fprintf(fp, " ");
-				node_al.addr = addr;
-				node_al.map  = node->map;
+	if (print_srcline && srcline)
+		printed += fprintf(fp, "\n  %s", srcline);
+	else if (print_srcline)
+		printed += map__fprintf_srcline(map, addr, "\n  ", fp);
 
-				if (print_symoffset) {
-					printed += __symbol__fprintf_symname_offs(node->sym, &node_al,
-										  print_unknown_as_addr,
-										  true, fp);
-				} else {
-					printed += __symbol__fprintf_symname(node->sym, &node_al,
-									     print_unknown_as_addr, fp);
-				}
-			}
+	if (symbol && symbol->inlined)
+		printed += fprintf(fp, " (inlined)");
 
-			if (print_dso && (!node->sym || !node->sym->inlined)) {
-				printed += fprintf(fp, " (");
-				printed += map__fprintf_dsoname(node->map, fp);
-				printed += fprintf(fp, ")");
-			}
+	if (!print_oneline)
+		printed += fprintf(fp, "\n");
 
-			if (print_srcline)
-				printed += map__fprintf_srcline(node->map, addr, "\n  ", fp);
+	return printed;
+}
+
+int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
+			      unsigned int print_opts, struct callchain_cursor *cursor,
+			      FILE *fp)
+{
+	int printed = 0;
+	struct callchain_cursor_node *node;
+
+	if (sample->callchain) {
+		callchain_cursor_commit(cursor);
+
+		while (1) {
+			node = callchain_cursor_current(cursor);
+			if (!node)
+				break;
 
-			if (node->sym && node->sym->inlined)
-				printed += fprintf(fp, " (inlined)");
 
-			if (!print_oneline)
-				printed += fprintf(fp, "\n");
+			printed += __fprintf_callchain_link(node->ip, node->map,
+							    node->sym, NULL,
+							    (printed == 0),
+							    left_alignment,
+							    print_opts, fp);
 
 			/* Add srccode here too? */
 			if (symbol_conf.bt_stop_list &&
@@ -181,8 +198,6 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				break;
 			}
 
-			first = false;
-next:
 			callchain_cursor_advance(cursor);
 		}
 	}
-- 
2.19.2
