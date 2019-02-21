From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 2/3] perf machine: use map__inlines in append_inlines
Date: Thu, 21 Feb 2019 17:06:51 +0100
Message-ID: <20190221160652.1788-3-jonas.rabenstein@studium.uni-erlangen.de>
References: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, David Miller <davem@davemloft.net>, Eric Saint-Etienne <eric.saint.etienne@oracle.com>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Gardner <rob.gardner@oracle.com>, Sandipan Das <sandipan@linux.ibm.com>, linux-kernel@vger.kernel.org, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
List-Id: linux-perf-users.vger.kernel.org

The previous patch provides a generic way to lookup the root node of the
inlined symbols for a specific address. Reuse that implementation
instead of a duplicated version of the required steps.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 tools/perf/util/machine.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 143f7057d581..dce29c21e4ea 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2330,23 +2330,12 @@ static int append_inlines(struct callchain_cursor *cursor,
 {
 	struct inline_node *inline_node;
 	struct inline_list *ilist;
-	u64 addr;
 	int ret = 1;
 
-	if (!symbol_conf.inline_name || !map || !sym)
+	inline_node = map__inlines(map, ip, sym);
+	if (!inline_node)
 		return ret;
 
-	addr = map__map_ip(map, ip);
-	addr = map__rip_2objdump(map, addr);
-
-	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
-	if (!inline_node) {
-		inline_node = dso__parse_addr_inlines(map->dso, addr, sym);
-		if (!inline_node)
-			return ret;
-		inlines__tree_insert(&map->dso->inlined_nodes, inline_node);
-	}
-
 	list_for_each_entry(ilist, &inline_node->val, list) {
 		ret = callchain_cursor_append(cursor, ip, map,
 					      ilist->symbol, false,
-- 
2.19.2
