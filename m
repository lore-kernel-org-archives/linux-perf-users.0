From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/83] perf annotate: Move ipc/cycles into annotation_line struct
Date: Fri, 17 Nov 2017 17:14:43 -0300
Message-ID: <20171117201601.24110-6-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934408AbdKQUQf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:35 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Move ipc/cycles into annotation_line struct to be used as generic
members for any annotation source.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 16 ++++++++--------
 tools/perf/util/annotate.h        |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 73d921c3e3ec..d1aff2f7cb6c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -144,7 +144,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 
 	if ((row == 0) && (dl->al.offset == -1 || percent_max == 0.0)) {
 		if (ab->have_cycles) {
-			if (dl->ipc == 0.0 && dl->cycles == 0)
+			if (dl->al.ipc == 0.0 && dl->al.cycles == 0)
 				show_title = true;
 		} else
 			show_title = true;
@@ -178,16 +178,16 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		}
 	}
 	if (ab->have_cycles) {
-		if (dl->ipc)
-			ui_browser__printf(browser, "%*.2f ", IPC_WIDTH - 1, dl->ipc);
+		if (dl->al.ipc)
+			ui_browser__printf(browser, "%*.2f ", IPC_WIDTH - 1, dl->al.ipc);
 		else if (!show_title)
 			ui_browser__write_nstring(browser, " ", IPC_WIDTH);
 		else
 			ui_browser__printf(browser, "%*s ", IPC_WIDTH - 1, "IPC");
 
-		if (dl->cycles)
+		if (dl->al.cycles)
 			ui_browser__printf(browser, "%*" PRIu64 " ",
-					   CYCLES_WIDTH - 1, dl->cycles);
+					   CYCLES_WIDTH - 1, dl->al.cycles);
 		else if (!show_title)
 			ui_browser__write_nstring(browser, " ", CYCLES_WIDTH);
 		else
@@ -474,7 +474,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 				max_percent = bpos->samples[i].percent;
 		}
 
-		if (max_percent < 0.01 && pos->ipc == 0) {
+		if (max_percent < 0.01 && pos->al.ipc == 0) {
 			RB_CLEAR_NODE(&bpos->rb_node);
 			continue;
 		}
@@ -994,7 +994,7 @@ static void count_and_fill(struct annotate_browser *browser, u64 start, u64 end,
 			struct disasm_line *dl = browser->offsets[offset];
 
 			if (dl)
-				dl->ipc = ipc;
+				dl->al.ipc = ipc;
 		}
 	}
 }
@@ -1025,7 +1025,7 @@ static void annotate__compute_ipc(struct annotate_browser *browser, size_t size,
 				count_and_fill(browser, ch->start, offset, ch);
 			dl = browser->offsets[offset];
 			if (dl && ch->num_aggr)
-				dl->cycles = ch->cycles_aggr / ch->num_aggr;
+				dl->al.cycles = ch->cycles_aggr / ch->num_aggr;
 			browser->have_cycles = true;
 		}
 	}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index b7ca62855760..a822c0a4987e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -64,13 +64,13 @@ struct annotation_line {
 	s64			 offset;
 	char			*line;
 	int			 line_nr;
+	float			 ipc;
+	u64			 cycles;
 };
 
 struct disasm_line {
 	struct annotation_line	 al;
 	struct ins		 ins;
-	float			 ipc;
-	u64			 cycles;
 	struct ins_operands	 ops;
 };
 
-- 
2.13.6
