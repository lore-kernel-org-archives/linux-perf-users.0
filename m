From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/15] perf unwind: Use 'struct map_symbol' in 'struct unwind_entry'
Date: Tue, 12 Nov 2019 15:37:48 -0300
Message-ID: <20191112183757.28660-7-acme@kernel.org>
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

To help in passing that info around to callchain routines that, for the
same reason, are moving to use 'struct map_symbol'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-epsiibeprpxa8qpwji47uskc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/dwarf-unwind.c          |  2 +-
 tools/perf/util/machine.c                | 17 +++++++++--------
 tools/perf/util/unwind-libdw.c           |  6 +++---
 tools/perf/util/unwind-libunwind-local.c |  6 +++---
 tools/perf/util/unwind.h                 |  8 +++-----
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 4f4ecbcbe87e..779ce280a0e9 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -59,7 +59,7 @@ int test_dwarf_unwind__krava_1(struct thread *thread);
 static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	unsigned long *cnt = (unsigned long *) arg;
-	char *symbol = entry->sym ? entry->sym->name : NULL;
+	char *symbol = entry->ms.sym ? entry->ms.sym->name : NULL;
 	static const char *funcs[MAX_STACK] = {
 		"test__arch_unwind_sample",
 		"test_dwarf_unwind__thread",
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e768ef24633f..3874bb89ac79 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2448,9 +2448,10 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	return 0;
 }
 
-static int append_inlines(struct callchain_cursor *cursor,
-			  struct map *map, struct symbol *sym, u64 ip)
+static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip)
 {
+	struct symbol *sym = ms->sym;
+	struct map *map = ms->map;
 	struct inline_node *inline_node;
 	struct inline_list *ilist;
 	u64 addr;
@@ -2488,22 +2489,22 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	const char *srcline = NULL;
 	u64 addr = entry->ip;
 
-	if (symbol_conf.hide_unresolved && entry->sym == NULL)
+	if (symbol_conf.hide_unresolved && entry->ms.sym == NULL)
 		return 0;
 
-	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
+	if (append_inlines(cursor, &entry->ms, entry->ip) == 0)
 		return 0;
 
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
 	 */
-	if (entry->map)
-		addr = map__map_ip(entry->map, entry->ip);
+	if (entry->ms.map)
+		addr = map__map_ip(entry->ms.map, entry->ip);
 
-	srcline = callchain_srcline(entry->map, entry->sym, addr);
+	srcline = callchain_srcline(entry->ms.map, entry->ms.sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
-				       entry->map, entry->sym,
+				       entry->ms.map, entry->ms.sym,
 				       false, NULL, 0, 0, 0, srcline);
 }
 
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 15f6e46d7124..73c00d776a5f 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -80,9 +80,9 @@ static int entry(u64 ip, struct unwind_info *ui)
 	if (__report_module(&al, ip, ui))
 		return -1;
 
-	e->ip  = ip;
-	e->map = al.map;
-	e->sym = al.sym;
+	e->ip	  = ip;
+	e->ms.map = al.map;
+	e->ms.sym = al.sym;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 1800887b2255..6e3873dd9a31 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -575,9 +575,9 @@ static int entry(u64 ip, struct thread *thread,
 	struct unwind_entry e;
 	struct addr_location al;
 
-	e.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
-	e.ip  = ip;
-	e.map = al.map;
+	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
+	e.ip     = ip;
+	e.ms.map = al.map;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index 3a7d00c20d86..50337c966979 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -4,17 +4,15 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include "util/map_symbol.h"
 
-struct map;
 struct map_groups;
 struct perf_sample;
-struct symbol;
 struct thread;
 
 struct unwind_entry {
-	struct map	*map;
-	struct symbol	*sym;
-	u64		ip;
+	struct map_symbol ms;
+	u64		  ip;
 };
 
 typedef int (*unwind_entry_cb_t)(struct unwind_entry *entry, void *arg);
-- 
2.21.0
