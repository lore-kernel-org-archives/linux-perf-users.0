From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/21] perf top: Remove lost events checking
Date: Tue,  6 Feb 2018 13:53:45 -0300
Message-ID: <20180206165350.2570-17-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753081AbeBFQyq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:46 -0500
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Kan Liang <kan.liang@intel.com>

There would be some records lost in overwrite mode because of pausing
the ringbuffer. It has little impact for the accuracy of the snapshot
and could be tolerated by 'perf top'.

Remove the lost events checking.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-16-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7def861a9ec4..59653062bb48 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -283,8 +283,9 @@ static void perf_top__print_sym_table(struct perf_top *top)
 
 	printf("%-*.*s\n", win_width, win_width, graph_dotted_line);
 
-	if (hists->stats.nr_lost_warned !=
-	    hists->stats.nr_events[PERF_RECORD_LOST]) {
+	if (!top->record_opts.overwrite &&
+	    (hists->stats.nr_lost_warned !=
+	    hists->stats.nr_events[PERF_RECORD_LOST])) {
 		hists->stats.nr_lost_warned =
 			      hists->stats.nr_events[PERF_RECORD_LOST];
 		color_fprintf(stdout, PERF_COLOR_RED,
@@ -611,7 +612,8 @@ static void *display_thread_tui(void *arg)
 
 	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
 				      top->min_percent,
-				      &top->session->header.env, true);
+				      &top->session->header.env,
+				      !top->record_opts.overwrite);
 
 	done = 1;
 	return NULL;
-- 
2.14.3
