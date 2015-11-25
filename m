From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [BUGFIX PATCH perf/core ] perf probe: Fix to free temporal
 Dwarf_Frame correctly
Date: Wed, 25 Nov 2015 19:34:32 +0900
Message-ID: <20151125103432.1473.31009.stgit@localhost.localdomain>
References: <20151124145424.GC18140@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:60754 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbbKYKmT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Nov 2015 05:42:19 -0500
In-Reply-To: <20151124145424.GC18140@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Michael Petlan <mpetlan@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

The commit 05c8d802fa52 ("perf probe: Fix to free temporal Dwarf_Frame")
tried to fix the memory leak of Dwarf_Frame, but it released the frame
at wrong point. Since the dwarf_frame_cfa(frame, &pf->fb_ops, &nops)
can return an address inside the frame data structure to pf->fb_ops,
we can not release the frame before using pf->fb_ops.

This reverts the commit and releases the frame afterwards (right before
returning from call_probe_finder) correctly.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: Michael Petlan <mpetlan@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Ahern <dsahern@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
---
 tools/perf/util/probe-finder.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 1cab05a..2be10fb 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -654,6 +654,7 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
 static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 {
 	Dwarf_Attribute fb_attr;
+	Dwarf_Frame *frame = NULL;
 	size_t nops;
 	int ret;
 
@@ -683,26 +684,24 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 	ret = dwarf_getlocation_addr(&fb_attr, pf->addr, &pf->fb_ops, &nops, 1);
 	if (ret <= 0 || nops == 0) {
 		pf->fb_ops = NULL;
-		ret = 0;
 #if _ELFUTILS_PREREQ(0, 142)
 	} else if (nops == 1 && pf->fb_ops[0].atom == DW_OP_call_frame_cfa &&
 		   pf->cfi != NULL) {
-		Dwarf_Frame *frame = NULL;
 		if (dwarf_cfi_addrframe(pf->cfi, pf->addr, &frame) != 0 ||
 		    dwarf_frame_cfa(frame, &pf->fb_ops, &nops) != 0) {
 			pr_warning("Failed to get call frame on 0x%jx\n",
 				   (uintmax_t)pf->addr);
-			ret = -ENOENT;
+			free(frame);
+			return -ENOENT;
 		}
-		free(frame);
 #endif
 	}
 
 	/* Call finder's callback handler */
-	if (ret >= 0)
-		ret = pf->callback(sc_die, pf);
+	ret = pf->callback(sc_die, pf);
 
-	/* *pf->fb_ops will be cached in libdw. Don't free it. */
+	/* Since *pf->fb_ops can be a part of frame. we should free it here. */
+	free(frame);
 	pf->fb_ops = NULL;
 
 	return ret;
