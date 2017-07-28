From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/15] perf annotate TUI: Use sym_hist_entry in disasm_line_samples
Date: Fri, 28 Jul 2017 17:00:14 -0300
Message-ID: <20170728200021.11389-9-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752890AbdG1UBB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2017 16:01:01 -0400
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just paving the way to fix --show-total-period in the TUI, i.e. now
we save in struct disasm_line_samples not just the number of samples,
but also the total period.

Based-on-a-patch-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/n/tip-1sup5hkwrxocjvrmrmhs732o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index dbe4e630b90f..680fff70f7a0 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -17,8 +17,8 @@
 #include <sys/ttydefaults.h>
 
 struct disasm_line_samples {
-	double		percent;
-	u64		nr;
+	double		      percent;
+	struct sym_hist_entry he;
 };
 
 #define IPC_WIDTH 6
@@ -152,7 +152,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 						current_entry);
 			if (annotate_browser__opts.show_total_period) {
 				ui_browser__printf(browser, "%6" PRIu64 " ",
-						   bdl->samples[i].nr);
+						   bdl->samples[i].he.nr_samples);
 			} else {
 				ui_browser__printf(browser, "%6.2f ",
 						   bdl->samples[i].percent);
@@ -457,7 +457,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 						pos->offset,
 						next ? next->offset : len,
 						&path, &sample);
-			bpos->samples[i].nr = sample.nr_samples;
+			bpos->samples[i].he = sample;
 
 			if (max_percent < bpos->samples[i].percent)
 				max_percent = bpos->samples[i].percent;
-- 
2.9.4
