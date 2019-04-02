From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/44] tools lib traceevent: Remove call to exit() from tep_filter_add_filter_str()
Date: Tue,  2 Apr 2019 13:05:25 -0300
Message-ID: <20190402160549.13544-21-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tzvetomir Stoyanov <tstoyanov@vmware.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch removes call to exit() from tep_filter_add_filter_str(). A
library function should not force the application to exit. In the
current implementation tep_filter_add_filter_str() calls exit() when a
special "test_filters" mode is set, used only for debugging purposes.
When this mode is set and a filter is added - its string is printed to
the console and exit() is called. This patch changes the logic - when in
"test_filters" mode, the filter string is still printed, but the exit()
is not called. It is up to the application to track when "test_filters"
mode is set and to call exit, if needed.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190326154328.28718-9-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164344.121717482@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-filter.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 4ffd8b25a852..3320c0a0e343 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1346,9 +1346,6 @@ enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
 
 	free_events(events);
 
-	if (rtn >= 0 && pevent->test_filters)
-		exit(0);
-
 	return rtn;
 }
 
-- 
2.20.1
