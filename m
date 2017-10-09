From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v5 07/16] perf report: mark inlined frames in output by " (inlined)" suffix
Date: Mon,  9 Oct 2017 22:33:01 +0200
Message-ID: <20171009203310.17362-8-milian.wolff@kdab.com>
References: <20171009203310.17362-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171009203310.17362-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
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
index 007e8364ea01..b0ff56332134 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1107,11 +1107,15 @@ char *callchain_list__sym_name(struct callchain_list *cl,
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
index eb3ab902a1c0..acb9210fd18a 100644
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
2.14.2
