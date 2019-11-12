From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/15] perf map_groups: Pass the object to map_groups__find_ams()
Date: Tue, 12 Nov 2019 15:37:45 -0300
Message-ID: <20191112183757.28660-4-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were just passing a map to look for and reuse its map->groups member,
but the idea is that this is going away, as a map can be in multiple
rb_trees when being reused via a map_node, so do as all the other
map_groups methods and pass as its first arg the object being operated
on.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-nmi2pbggqloogwl6vxrvex5a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 2 +-
 tools/perf/util/annotate.c                   | 6 +++---
 tools/perf/util/map.c                        | 6 +++---
 tools/perf/util/map_groups.h                 | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index a50e70baf918..20050fb54948 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -38,7 +38,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 		return -1;
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(&target) == 0 &&
+	if (map_groups__find_ams(map->groups, &target) == 0 &&
 	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bee0fee122f8..ecc024495f56 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -271,7 +271,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 find_target:
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(&target) == 0 &&
+	if (map_groups__find_ams(map->groups, &target) == 0 &&
 	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
 
@@ -391,7 +391,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
 	 */
-	if (map_groups__find_ams(&target) == 0 &&
+	if (map_groups__find_ams(map->groups, &target) == 0 &&
 	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.sym;
 
@@ -1544,7 +1544,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 			.addr = dl->ops.target.addr,
 		};
 
-		if (!map_groups__find_ams(&target) &&
+		if (!map_groups__find_ams(map->groups, &target) &&
 		    target.sym->start == target.al_addr)
 			dl->ops.target.sym = target.sym;
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a4d889c0fa88..db842568f4be 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -703,12 +703,12 @@ struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
 	return maps__find_symbol_by_name(&mg->maps, name, mapp);
 }
 
-int map_groups__find_ams(struct addr_map_symbol *ams)
+int map_groups__find_ams(struct map_groups *mg, struct addr_map_symbol *ams)
 {
 	if (ams->addr < ams->map->start || ams->addr >= ams->map->end) {
-		if (ams->map->groups == NULL)
+		if (mg == NULL)
 			return -1;
-		ams->map = map_groups__find(ams->map->groups, ams->addr);
+		ams->map = map_groups__find(mg, ams->addr);
 		if (ams->map == NULL)
 			return -1;
 	}
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index bfbdbf5a443a..99cb810acc7c 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -100,7 +100,7 @@ struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg, const char
 
 struct addr_map_symbol;
 
-int map_groups__find_ams(struct addr_map_symbol *ams);
+int map_groups__find_ams(struct map_groups *mg, struct addr_map_symbol *ams);
 
 int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp);
 
-- 
2.21.0
