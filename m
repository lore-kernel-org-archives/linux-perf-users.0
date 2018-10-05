From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/5] perf record: Use unmapped IP for inline callchain cursors
Date: Fri,  5 Oct 2018 13:10:12 -0300
Message-ID: <20181005161012.18475-6-acme@kernel.org>
References: <20181005161012.18475-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005161012.18475-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Sandipan Das <sandipan@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

Only use the mapped IP to find inline frames, but keep using the
unmapped IP for the callchain cursor. This ensures we properly show the
unmapped IP when displaying a frame we received via the
dso__parse_addr_inlines API for a module which does not contain
sufficient debug symbols to show the srcline.

This is another follow-up to commit 19610184693c ("perf script: Show
virtual addresses instead of offsets").

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Fixes: 19610184693c ("perf script: Show virtual addresses instead of offsets")
Link: http://lkml.kernel.org/r/20180926135207.30263-2-milian.wolff@kdab.com
Link: http://lkml.kernel.org/r/20181002073949.3297-1-milian.wolff@kdab.com
[ Squashed a fix from Milian for a problem reported by Ravi, fixed up space damage ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cb4f8bf3ca7..111ae858cbcb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2286,7 +2286,8 @@ static int append_inlines(struct callchain_cursor *cursor,
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
 
-	addr = map__rip_2objdump(map, ip);
+	addr = map__map_ip(map, ip);
+	addr = map__rip_2objdump(map, addr);
 
 	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
 	if (!inline_node) {
-- 
2.14.4
