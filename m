From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 2/2] perf evsel: add inline functions to sample callchain output
Date: Tue, 19 Feb 2019 19:38:10 +0100
Message-ID: <6aab7b5b0816426fed3cb2f2a2ba08e73e4c51e2.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Whenever a callchain shall be printed search for each address whether
inline information is available and add those symbols to the output
if symbol_conf.inline_name is enabled.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 tools/perf/util/evsel_fprintf.c | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index c710f687ddf4..9f9ece453dc4 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -168,6 +168,49 @@ static int __fprintf_callchain_link(u64 ip, struct map *map, struct symbol *symb
 	return printed;
 }
 
+static int __fprintf_callchain_inlines(struct callchain_cursor_node *node,
+				       bool first, int left_alignment,
+				       unsigned int print_opts, FILE *fp)
+{
+	int printed = 0;
+	struct inline_node *inline_node;
+	struct inline_list *ilist;
+	u64 addr;
+
+	if (!symbol_conf.inline_name)
+		return 0;
+
+	if (!node->map || !node->map->dso)
+		return 0;
+
+	addr = node->map->map_ip(node->map, node->ip);
+
+	inline_node = inlines__tree_find(&node->map->dso->inlined_nodes,
+					 addr);
+	if (!inline_node) {
+		inline_node = dso__parse_addr_inlines(node->map->dso,
+						      addr, node->sym);
+		if (!inline_node)
+			return 0;
+		inlines__tree_insert(&node->map->dso->inlined_nodes,
+				     inline_node);
+	}
+
+	list_for_each_entry(ilist, &inline_node->val, list) {
+		if (ilist->symbol == node->sym)
+			break;
+
+		printed += __fprintf_callchain_link(node->ip, node->map,
+						    ilist->symbol,
+						    ilist->srcline,
+						    first, left_alignment,
+						    print_opts, fp);
+		first = (first && printed == 0);
+	}
+
+	return printed;
+}
+
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			      unsigned int print_opts, struct callchain_cursor *cursor,
 			      FILE *fp)
@@ -183,6 +226,9 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (!node)
 				break;
 
+			printed += __fprintf_callchain_inlines(node, (printed ==  0),
+							       left_alignment,
+							       print_opts, fp);
 
 			printed += __fprintf_callchain_link(node->ip, node->map,
 							    node->sym, NULL,
-- 
2.19.2
