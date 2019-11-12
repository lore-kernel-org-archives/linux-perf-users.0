From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/15] perf annotate: Stop using map->groups, use map_symbol->mg instead
Date: Tue, 12 Nov 2019 15:37:53 -0300
Message-ID: <20191112183757.28660-12-acme@kernel.org>
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

These were the last uses of map->groups, next cset will nuke it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-n3g0foos7l7uxq9nar0zo0vj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 2 +-
 tools/perf/ui/browsers/annotate.c            | 1 +
 tools/perf/util/annotate.c                   | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index bdd7ab34ce4f..2a6662e42f89 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -38,7 +38,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 		return -1;
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(map->groups, &target) == 0 &&
+	if (map_groups__find_ams(ms->mg, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ad1fe5b6d0cd..992705c78bd0 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -430,6 +430,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 		return true;
 	}
 
+	target_ms.mg  = ms->mg;
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	pthread_mutex_unlock(&notes->lock);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e0a9e9e49bb1..5ea9a4534848 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -271,7 +271,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 find_target:
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (map_groups__find_ams(map->groups, &target) == 0 &&
+	if (map_groups__find_ams(ms->mg, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -391,7 +391,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
 	 */
-	if (map_groups__find_ams(map->groups, &target) == 0 &&
+	if (map_groups__find_ams(ms->mg, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -1545,7 +1545,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 			.ms = { .map = map, },
 		};
 
-		if (!map_groups__find_ams(map->groups, &target) &&
+		if (!map_groups__find_ams(args->ms.mg, &target) &&
 		    target.ms.sym->start == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
 	}
-- 
2.21.0
