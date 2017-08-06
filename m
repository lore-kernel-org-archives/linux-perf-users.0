From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v2 05/14] perf report: mark inlined frames in output by " (inlined)" suffix
Date: Sun,  6 Aug 2017 23:24:37 +0200
Message-ID: <20170806212446.24925-6-milian.wolff@kdab.com>
References: <20170806212446.24925-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806212446.24925-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

The original patch that introduced inline frame output in the
various browsers used this suffix already. The new centralized
approach that uses fake symbols for inlined frames was missing
this approach so far.

Instead of changing the symbol name itself, we only print the
suffix where needed. This allows us to efficiently lookup
the symbol for a given name without first having to append the
suffix before the lookup.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/callchain.c | 10 +++++++---
 tools/perf/util/sort.c      |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 6afa8ccd75b5..5e099fe0b9dc 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1100,11 +1100,15 @@ char *callchain_list__sym_name(struct callchain_list *cl,
 	int printed;
 
 	if (cl->ms.sym) {
+		const char *inlined = cl->ms.sym->inlined ? " (inlined)" : "";
+
 		if (show_srcline && cl->srcline)
-			printed = scnprintf(bf, bfsize, "%s %s",
-					cl->ms.sym->name, cl->srcline);
+			printed = scnprintf(bf, bfsize, "%s %s%s",
+					    cl->ms.sym->name, cl->srcline,
+					    inlined);
 		else
-			printed = scnprintf(bf, bfsize, "%s", cl->ms.sym->name);
+			printed = scnprintf(bf, bfsize, "%s%s",
+					    cl->ms.sym->name, inlined);
 	} else
 		printed = scnprintf(bf, bfsize, "%#" PRIx64, cl->ip);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 12359bd986db..66fa841717fb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -283,6 +283,9 @@ static int _hist_entry__sym_snprintf(struct map *map, struct symbol *sym,
 			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
 					       width - ret,
 					       sym->name);
+			if (sym->inlined)
+				ret += repsep_snprintf(bf + ret, size - ret,
+						       " (inlined)");
 		}
 	} else {
 		size_t len = BITS_PER_LONG / 4;
-- 
2.13.3
