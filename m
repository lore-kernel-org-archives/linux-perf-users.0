From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 64/83] perf c2c: Fix spelling mistakes in browser help text
Date: Fri, 17 Nov 2017 17:15:42 -0300
Message-ID: <20171117201601.24110-65-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753708AbdKQUTo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:19:44 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Kim Phillips <kim.phillips@arm.com>

Togle -> Toggle, lenght -> length.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171114150447.f4b63bc5d97c83cdaa8bf7dc@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 17855c4626a0..f1da9b0833c0 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2224,9 +2224,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	struct hist_browser *browser;
 	int key = -1;
 	const char help[] =
-	" ENTER         Togle callchains (if present) \n"
-	" n             Togle Node details info \n"
-	" s             Togle full lenght of symbol and source line columns \n"
+	" ENTER         Toggle callchains (if present) \n"
+	" n             Toggle Node details info \n"
+	" s             Toggle full length of symbol and source line columns \n"
 	" q             Return back to cacheline list \n";
 
 	/* Display compact version first. */
@@ -2303,7 +2303,7 @@ static int perf_c2c__hists_browse(struct hists *hists)
 	int key = -1;
 	const char help[] =
 	" d             Display cacheline details \n"
-	" ENTER         Togle callchains (if present) \n"
+	" ENTER         Toggle callchains (if present) \n"
 	" q             Quit \n";
 
 	browser = perf_c2c_browser__new(hists);
-- 
2.13.6
