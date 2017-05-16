From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf report: fix memory leak in addr2line when called by addr2inlines
Date: Tue, 16 May 2017 23:53:59 +0200
Message-ID: <20170516215359.16356-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:43950 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbdEPVyO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 May 2017 17:54:14 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>

When a filename was found in addr2line it was duplicated via strdup
but never freed. Now we pass NULL and handle this gracefully in
addr2line.

Detected by Valgrind:

==16331== 1,680 bytes in 21 blocks are definitely lost in loss record 148 of 220
==16331==    at 0x4C2AF1F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==16331==    by 0x672FA69: strdup (in /usr/lib/libc-2.25.so)
==16331==    by 0x52769F: addr2line (srcline.c:256)
==16331==    by 0x52769F: addr2inlines (srcline.c:294)
==16331==    by 0x52769F: dso__parse_addr_inlines (srcline.c:502)
==16331==    by 0x574D7A: inline__fprintf (hist.c:41)
==16331==    by 0x574D7A: ipchain__fprintf_graph (hist.c:147)
==16331==    by 0x57518A: __callchain__fprintf_graph (hist.c:212)
==16331==    by 0x5753CF: callchain__fprintf_graph.constprop.6 (hist.c:337)
==16331==    by 0x57738E: hist_entry__fprintf (hist.c:628)
==16331==    by 0x57738E: hists__fprintf (hist.c:882)
==16331==    by 0x44A20F: perf_evlist__tty_browse_hists (builtin-report.c:399)
==16331==    by 0x44A20F: report__browse_hists (builtin-report.c:491)
==16331==    by 0x44A20F: __cmd_report (builtin-report.c:624)
==16331==    by 0x44A20F: cmd_report (builtin-report.c:1054)
==16331==    by 0x4A49CE: run_builtin (perf.c:296)
==16331==    by 0x4A4CC0: handle_internal_command (perf.c:348)
==16331==    by 0x434371: run_argv (perf.c:392)
==16331==    by 0x434371: main (perf.c:530)

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/srcline.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index df051a52393c..62cf42c36955 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -253,10 +253,11 @@ static int addr2line(const char *dso_name, u64 addr,
 	}
 
 	if (a2l->found && a2l->filename) {
-		*file = strdup(a2l->filename);
-		*line = a2l->line;
-
-		if (*file)
+		if (file)
+			*file = strdup(a2l->filename);
+		if (line)
+			*line = a2l->line;
+		if (*a2l->filename)
 			ret = 1;
 	}
 
@@ -278,8 +279,6 @@ void dso__free_a2l(struct dso *dso)
 static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	struct dso *dso)
 {
-	char *file = NULL;
-	unsigned int line = 0;
 	struct inline_node *node;
 
 	node = zalloc(sizeof(*node));
@@ -291,7 +290,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	INIT_LIST_HEAD(&node->val);
 	node->addr = addr;
 
-	if (!addr2line(dso_name, addr, &file, &line, dso, TRUE, node))
+	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node))
 		goto out_free_inline_node;
 
 	if (list_empty(&node->val))
-- 
2.13.0
