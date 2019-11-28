From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/22] perf map_symbol: Rename ms->mg to ms->maps
Date: Thu, 28 Nov 2019 10:40:15 -0300
Message-ID: <20191128134027.23726-11-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step on the merge of 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-61rra2wg392rhvdgw421wzpt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 2 +-
 tools/perf/ui/browsers/annotate.c            | 2 +-
 tools/perf/util/annotate.c                   | 6 +++---
 tools/perf/util/callchain.c                  | 2 +-
 tools/perf/util/hist.c                       | 8 ++++----
 tools/perf/util/machine.c                    | 6 +++---
 tools/perf/util/map_symbol.h                 | 2 +-
 tools/perf/util/unwind-libdw.c               | 2 +-
 tools/perf/util/unwind-libunwind-local.c     | 2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 57be973aea74..0e136630659e 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -38,7 +38,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 		return -1;
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (maps__find_ams(ms->mg, &target) == 0 &&
+	if (maps__find_ams(ms->maps, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 992705c78bd0..badbddbb30f8 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -430,7 +430,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 		return true;
 	}
 
-	target_ms.mg  = ms->mg;
+	target_ms.maps = ms->maps;
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	pthread_mutex_unlock(&notes->lock);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 1b0980afdc3c..14f3edc3c261 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -271,7 +271,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 find_target:
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
-	if (maps__find_ams(ms->mg, &target) == 0 &&
+	if (maps__find_ams(ms->maps, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -391,7 +391,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * Actual navigation will come next, with further understanding of how
 	 * the symbol searching and disassembly should be done.
 	 */
-	if (maps__find_ams(ms->mg, &target) == 0 &&
+	if (maps__find_ams(ms->maps, &target) == 0 &&
 	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
 		ops->target.sym = target.ms.sym;
 
@@ -1545,7 +1545,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 			.ms = { .map = map, },
 		};
 
-		if (!maps__find_ams(args->ms.mg, &target) &&
+		if (!maps__find_ams(args->ms.maps, &target) &&
 		    target.ms.sym->start == target.al_addr)
 			dl->ops.target.sym = target.ms.sym;
 	}
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index c7270c057b6b..818aa4efd386 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1106,7 +1106,7 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
 			bool hide_unresolved)
 {
-	al->maps = node->ms.mg;
+	al->maps = node->ms.maps;
 	al->map = node->ms.map;
 	al->sym = node->ms.sym;
 	al->srcline = node->srcline;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 5ebfbe373442..ca5a8f4d007e 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -692,7 +692,7 @@ __hists__add_entry(struct hists *hists,
 			.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0,
 		},
 		.ms = {
-			.mg	= al->maps,
+			.maps	= al->maps,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
@@ -760,7 +760,7 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
 		.block_info = block_info,
 		.hists = hists,
 		.ms = {
-			.mg  = al->maps,
+			.maps = al->maps,
 			.map = al->map,
 			.sym = al->sym,
 		},
@@ -895,7 +895,7 @@ iter_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 	if (iter->curr >= iter->total)
 		return 0;
 
-	al->maps = bi[i].to.ms.mg;
+	al->maps = bi[i].to.ms.maps;
 	al->map = bi[i].to.ms.map;
 	al->sym = bi[i].to.ms.sym;
 	al->addr = bi[i].to.addr;
@@ -1072,7 +1072,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 		.comm = thread__comm(al->thread),
 		.ip = al->addr,
 		.ms = {
-			.mg  = al->maps,
+			.maps = al->maps,
 			.map = al->map,
 			.sym = al->sym,
 		},
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index de5d6b4727e3..c1ae5e6f84e2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1934,7 +1934,7 @@ static void ip__resolve_ams(struct thread *thread,
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
-	ams->ms.mg  = al.maps;
+	ams->ms.maps = al.maps;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = 0;
@@ -1952,7 +1952,7 @@ static void ip__resolve_data(struct thread *thread,
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
-	ams->ms.mg  = al.maps;
+	ams->ms.maps = al.maps;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = phys_addr;
@@ -2069,7 +2069,7 @@ static int add_callchain_ip(struct thread *thread,
 		iter_cycles = iter->cycles;
 	}
 
-	ms.mg  = al.maps;
+	ms.maps = al.maps;
 	ms.map = al.map;
 	ms.sym = al.sym;
 	srcline = callchain_srcline(&ms, al.addr);
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index bd985c1c6831..5b8ca93798e9 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -9,7 +9,7 @@ struct map;
 struct symbol;
 
 struct map_symbol {
-	struct maps   *mg;
+	struct maps   *maps;
 	struct map    *map;
 	struct symbol *sym;
 };
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index bb4f515bdff9..7a3dbc259cec 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -81,7 +81,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 		return -1;
 
 	e->ip	  = ip;
-	e->ms.mg  = al.maps;
+	e->ms.maps = al.maps;
 	e->ms.map = al.map;
 	e->ms.sym = al.sym;
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index a744dfaefef5..515131e85e9c 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -578,7 +578,7 @@ static int entry(u64 ip, struct thread *thread,
 	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 	e.ip     = ip;
 	e.ms.map = al.map;
-	e.ms.mg  = al.maps;
+	e.ms.maps = al.maps;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
-- 
2.21.0
