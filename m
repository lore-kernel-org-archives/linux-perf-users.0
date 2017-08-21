From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/13] perf annotate browser: Circulate percent, total-period and nr-samples view
Date: Mon, 21 Aug 2017 16:25:49 -0300
Message-ID: <20170821192549.17251-14-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

Using the existing 't' hotkey, support the three views: percent, total
period and number of samples on the annotate TUI browser, circulating
them like below:

  Percent -> Total Period -> Nr Samples -> Percent ...

Committer notes:

Removed new 'e' hotkey, should be resubmitted as a separate patch, with
proper justification for its inclusion.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Link: http://lkml.kernel.org/r/1503046028-5691-1-git-send-email-treeze.taeung@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index faca1b94496e..ba0aee576a2b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -835,7 +835,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"n             Search next string\n"
 		"o             Toggle disassembler output/simplified view\n"
 		"s             Toggle source code view\n"
-		"t             Toggle total period view\n"
+		"t             Circulate percent, total period, samples view\n"
 		"/             Search string\n"
 		"k             Toggle line numbers\n"
 		"r             Run available scripts\n"
@@ -912,8 +912,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			}
 			continue;
 		case 't':
-			annotate_browser__opts.show_total_period =
-			  !annotate_browser__opts.show_total_period;
+			if (annotate_browser__opts.show_total_period) {
+				annotate_browser__opts.show_total_period = false;
+				annotate_browser__opts.show_nr_samples = true;
+			} else if (annotate_browser__opts.show_nr_samples)
+				annotate_browser__opts.show_nr_samples = false;
+			else
+				annotate_browser__opts.show_total_period = true;
 			annotate_browser__update_addr_width(browser);
 			continue;
 		case K_LEFT:
-- 
2.13.5
