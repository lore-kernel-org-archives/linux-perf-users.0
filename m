From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCHv2 2/2] perf evsel: add inline functions to sample callchain output
Date: Wed, 20 Feb 2019 11:59:13 +0100
Message-ID: <20190220105913.1321-1-jonas.rabenstein@studium.uni-erlangen.de>
References: <20190220001116.3b3yyndjjmqs3hmm@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220001116.3b3yyndjjmqs3hmm@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Andi Kleen <ak@linux.intel.com>, "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>, linux-kernel@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
List-Id: linux-perf-users.vger.kernel.org

Whenever a callchain shall be printed search for each address whether
inline information is available and add those symbols to the output
if symbol_conf.inline_name is enabled.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
v2:
 - fix handling of static binaries

 tools/perf/util/evsel_fprintf.c | 55 +++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index c710f687ddf4..a8d6465af1aa 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -168,6 +168,52 @@ static int __fprintf_callchain_link(u64 ip, struct map *map, struct symbol *symb
 	return printed;
 }
 
+static int __fprintf_callchain(struct callchain_cursor_node *node, bool first,
+			       int left_alignment, unsigned int print_opts,
+			       FILE *fp)
+{
+	int printed = 0;
+	struct inline_node *inline_node;
+	struct inline_list *ilist;
+	u64 addr;
+
+	if (!symbol_conf.inline_name)
+		goto no_inline;
+
+	if (!node->map || !node->map->dso)
+		goto no_inline;
+
+	addr = node->map->map_ip(node->map, node->ip);
+	addr = map__rip_2objdump(node->map, addr);
+
+	inline_node = inlines__tree_find(&node->map->dso->inlined_nodes,
+					 addr);
+	if (!inline_node) {
+		inline_node = dso__parse_addr_inlines(node->map->dso,
+						      addr, node->sym);
+		if (!inline_node)
+			goto no_inline;
+		inlines__tree_insert(&node->map->dso->inlined_nodes,
+				     inline_node);
+	}
+
+	list_for_each_entry(ilist, &inline_node->val, list) {
+		printed += __fprintf_callchain_link(node->ip, node->map,
+						    ilist->symbol,
+						    ilist->srcline,
+						    first, left_alignment,
+						    print_opts, fp);
+		first = (first && printed == 0);
+	}
+
+	return printed;
+
+no_inline:
+	return __fprintf_callchain_link(node->ip, node->map, node->sym,
+					NULL, first, left_alignment,
+					print_opts, fp);
+}
+
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			      unsigned int print_opts, struct callchain_cursor *cursor,
 			      FILE *fp)
@@ -183,12 +229,9 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (!node)
 				break;
 
-
-			printed += __fprintf_callchain_link(node->ip, node->map,
-							    node->sym, NULL,
-							    (printed == 0),
-							    left_alignment,
-							    print_opts, fp);
+			printed += __fprintf_callchain(node, (printed == 0),
+						       left_alignment,
+						       print_opts, fp);
 
 			/* Add srccode here too? */
 			if (symbol_conf.bt_stop_list &&
-- 
2.19.2
