From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/36] perf report: Set browser mode right before setup_browser()
Date: Wed,  6 Dec 2017 11:41:12 -0300
Message-ID: <20171206144115.15097-34-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seokho Song <0xdevssh@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Park Ju Hyung <qkrwngud825@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Seokho Song <0xdevssh@gmail.com>

There are codes that print messages to the screen between assignment of
the use_browser variable and setup_browser().

But since the GUI browser is not initialized during that period, all
messages fail to show if the user passed the --gtk option to perf as GTK
is not initialized yet.

Reorder the code to assign use_browser variable right before
setup_browser() is called.

Signed-off-by: Seokho Song <0xdevssh@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171204160244.6332-1-0xdevssh@gmail.com
Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index af5dd038195e..eb9ce6327e71 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -921,13 +921,6 @@ int cmd_report(int argc, const char **argv)
 		return -EINVAL;
 	}
 
-	if (report.use_stdio)
-		use_browser = 0;
-	else if (report.use_tui)
-		use_browser = 1;
-	else if (report.use_gtk)
-		use_browser = 2;
-
 	if (report.inverted_callchain)
 		callchain_param.order = ORDER_CALLER;
 	if (symbol_conf.cumulate_callchain && !callchain_param.order_set)
@@ -1014,6 +1007,13 @@ int cmd_report(int argc, const char **argv)
 		perf_hpp_list.need_collapse = true;
 	}
 
+	if (report.use_stdio)
+		use_browser = 0;
+	else if (report.use_tui)
+		use_browser = 1;
+	else if (report.use_gtk)
+		use_browser = 2;
+
 	/* Force tty output for header output and per-thread stat. */
 	if (report.header || report.header_only || report.show_threads)
 		use_browser = 0;
-- 
2.13.6
