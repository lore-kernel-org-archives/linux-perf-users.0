From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 6/7] perf report: mark inlined frames in output by " (inlined)" suffix
Date: Thu, 18 May 2017 21:34:10 +0200
Message-ID: <20170518193411.22380-7-milian.wolff@kdab.com>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:59266 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757560AbdERTex (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2017 15:34:53 -0400
In-Reply-To: <20170518193411.22380-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>

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
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 211ed3713fac..4350c7ceaca1 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1061,11 +1061,15 @@ char *callchain_list__sym_name(struct callchain_list *cl,
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
 
-- 
2.13.0
