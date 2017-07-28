From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/15] perf annotate TUI: Set appropriate column width for period/percent
Date: Fri, 28 Jul 2017 17:00:18 -0300
Message-ID: <20170728200021.11389-13-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Either when we start 'perf annotate' or 'perf report' with
--show-total-period or when we, in the annotate browser, press 't' to
toggle period/percent for the first column, we need to adjust the width
for the 'period' case.

Based-on-a-patch-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-n2np5qcs20u6qjdr9orygne6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 46f297a4e94b..80f38dab9c3a 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -110,7 +110,7 @@ static int annotate_browser__set_jumps_percent_color(struct annotate_browser *br
 
 static int annotate_browser__pcnt_width(struct annotate_browser *ab)
 {
-	return 7 * ab->nr_events;
+	return (annotate_browser__opts.show_total_period ? 12 : 7) * ab->nr_events;
 }
 
 static int annotate_browser__cycles_width(struct annotate_browser *ab)
@@ -153,7 +153,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 						bdl->samples[i].percent,
 						current_entry);
 			if (annotate_browser__opts.show_total_period) {
-				ui_browser__printf(browser, "%6" PRIu64 " ",
+				ui_browser__printf(browser, "%11" PRIu64 " ",
 						   bdl->samples[i].he.period);
 			} else {
 				ui_browser__printf(browser, "%6.2f ",
@@ -165,8 +165,10 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 
 		if (!show_title)
 			ui_browser__write_nstring(browser, " ", pcnt_width);
-		else
-			ui_browser__printf(browser, "%*s", 7, annotate_browser__opts.show_total_period ? "Period" : "Percent");
+		else {
+			ui_browser__printf(browser, "%*s", pcnt_width,
+					   annotate_browser__opts.show_total_period ? "Period" : "Percent");
+		}
 	}
 	if (ab->have_cycles) {
 		if (dl->ipc)
-- 
2.9.4
