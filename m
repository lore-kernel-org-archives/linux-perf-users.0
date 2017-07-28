From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/15] perf annotate TUI: Fix column header when toggling period/percent
Date: Fri, 28 Jul 2017 17:00:17 -0300
Message-ID: <20170728200021.11389-12-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

We have the 't' hotkey to toggle showing either the total period or the
percentage of samples for a given line, but we forgot to toggle as well
the column header, always showing "Percent", even when showing the
period, fix it.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1501172169-6761-1-git-send-email-treeze.taeung@gmail.com
[ Extracted from a larger patch, s/Event count/Period/g ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 0f4bcc0d140c..46f297a4e94b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -166,7 +166,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		if (!show_title)
 			ui_browser__write_nstring(browser, " ", pcnt_width);
 		else
-			ui_browser__printf(browser, "%*s", 7, "Percent");
+			ui_browser__printf(browser, "%*s", 7, annotate_browser__opts.show_total_period ? "Period" : "Percent");
 	}
 	if (ab->have_cycles) {
 		if (dl->ipc)
-- 
2.9.4
