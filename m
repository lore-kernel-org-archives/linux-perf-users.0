From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/19] perf callchain: Fix double mapping al->addr for children without self period
Date: Fri,  3 Nov 2017 10:54:58 -0300
Message-ID: <20171103135503.4921-15-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Milian Wolff found a problem he described in [1] and that for him would
get fixed:

"Note how most of the large offset values are now gone. Most notably, we
get proper srcline resolution for the random.h and complex headers."

Then Namhyung found the root cause:

"I looked into it and found a bug handling cumulative (children)
entries.  For children entries that have no self period, the al->addr (so
he->ip) ends up having an doubly-mapped address.

It seems to be there from the beginning but only affects entries that
have no srclines - finding srcline itself is done using a different
address but it will show the invalid address if no srcline was found.  I
think we should fix the commit c7405d85d7a3 ("perf tools: Update cpumode
for each cumulative entry")."

[1] https://lkml.kernel.org/r/20171018185350.14893-7-milian.wolff@kdab.com

Reported-by: Milian Wolff <milian.wolff@kdab.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: kernel-team@lge.com
Fixes: c7405d85d7a3 ("perf tools: Update cpumode for each cumulative entry")
Link: https://lkml.kernel.org/r/20171020051533.GA2746@sejong
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 3a3916934a92..837012147c7b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1091,10 +1091,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 	al->map = node->map;
 	al->sym = node->sym;
 	al->srcline = node->srcline;
-	if (node->map)
-		al->addr = node->map->map_ip(node->map, node->ip);
-	else
-		al->addr = node->ip;
+	al->addr = node->ip;
 
 	if (al->sym == NULL) {
 		if (hide_unresolved)
-- 
2.13.6
