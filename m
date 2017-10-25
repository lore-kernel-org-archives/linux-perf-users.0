From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/15] perf callchain: Mark inlined frames in output by " (inlined)" suffix
Date: Wed, 25 Oct 2017 13:00:05 -0300
Message-ID: <20171025160013.11136-8-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbdJYQAt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 12:00:49 -0400
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Milian Wolff <milian.wolff@kdab.com>

The original patch that introduced inline frame output in the various
browsers used this suffix already. The new centralized approach that
uses fake symbols for inlined frames was missing this approach so far.

Instead of changing the symbol name itself, we only print the suffix
where needed. This allows us to efficiently lookup the symbol for a
given name without first having to append the suffix before the lookup.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20171009203310.17362-8-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 10 +++++++---
 tools/perf/util/sort.c      |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 0f2ba493a7a3..77031efdca5c 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1111,11 +1111,15 @@ char *callchain_list__sym_name(struct callchain_list *cl,
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
2.13.6
