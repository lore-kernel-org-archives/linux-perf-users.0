From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 1/3] perf map: add function to lookup inline symbols
Date: Thu, 21 Feb 2019 17:06:50 +0100
Message-ID: <20190221160652.1788-2-jonas.rabenstein@studium.uni-erlangen.de>
References: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, David Miller <davem@davemloft.net>, Eric Saint-Etienne <eric.saint.etienne@oracle.com>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Gardner <rob.gardner@oracle.com>, Sandipan Das <sandipan@linux.ibm.com>, linux-kernel@vger.kernel.org, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
List-Id: linux-perf-users.vger.kernel.org

Inlined symbols should always be added to the dso's inlined_nodes tree
in order to reuse them for a later lookup for the same address. Instead
of repeating those steps at the different users, provide a central
method to lookup and register inline symbols for a map.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 tools/perf/util/map.c | 23 +++++++++++++++++++++++
 tools/perf/util/map.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6751301a755c..0fe74e83ca8d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -988,3 +988,26 @@ struct map_groups *map__kmaps(struct map *map)
 	}
 	return kmap->kmaps;
 }
+
+struct inline_node *map__inlines(struct map *map, u64 addr, struct symbol *sym)
+{
+	struct inline_node *node;
+
+	if (!symbol_conf.inline_name)
+		return NULL;
+
+	if (!map->dso)
+		return NULL;
+
+	addr = map->map_ip(map, addr);
+	addr = map__rip_2objdump(map, addr);
+
+	node = inlines__tree_find(&map->dso->inlined_nodes, addr);
+	if (node)
+		return node;
+
+	node = dso__parse_addr_inlines(map->dso, addr, sym);
+	if (node)
+		inlines__tree_insert(&map->dso->inlined_nodes, node);
+	return node;
+}
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 09282aa45c80..bdcc6e77e26e 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -270,4 +270,7 @@ static inline bool is_entry_trampoline(const char *name)
 	return !strcmp(name, ENTRY_TRAMPOLINE_NAME);
 }
 
+struct inline_node *map__inlines(struct map *map, u64 addr,
+				 struct symbol *sym);
+
 #endif /* __PERF_MAP_H */
-- 
2.19.2
