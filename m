From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 79/83] perf top: Fix window dimensions change handling
Date: Fri, 17 Nov 2017 17:15:57 -0300
Message-ID: <20171117201601.24110-80-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161369AbdKQUUd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:20:33 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

The stdio perf top crashes when we change the terminal
window size. The reason is that we assumed we get the
perf_top pointer as a signal handler argument which is
not the case.

Changing the SIGWINCH handler logic to change global
resize variable, which is checked in the main thread
loop.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ysuzwz77oev1ftgvdscn9bpu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 865191281591..4cbd3dd14a33 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -77,6 +77,7 @@
 #include "sane_ctype.h"
 
 static volatile int done;
+static volatile int resize;
 
 #define HEADER_LINE_NR  5
 
@@ -86,10 +87,13 @@ static void perf_top__update_print_entries(struct perf_top *top)
 }
 
 static void perf_top__sig_winch(int sig __maybe_unused,
-				siginfo_t *info __maybe_unused, void *arg)
+				siginfo_t *info __maybe_unused, void *arg __maybe_unused)
 {
-	struct perf_top *top = arg;
+	resize = 1;
+}
 
+static void perf_top__resize(struct perf_top *top)
+{
 	get_term_dimensions(&top->winsize);
 	perf_top__update_print_entries(top);
 }
@@ -480,7 +484,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 					.sa_sigaction = perf_top__sig_winch,
 					.sa_flags     = SA_SIGINFO,
 				};
-				perf_top__sig_winch(SIGWINCH, NULL, top);
+				perf_top__resize(top);
 				sigaction(SIGWINCH, &act, NULL);
 			} else {
 				signal(SIGWINCH, SIG_DFL);
@@ -1035,6 +1039,11 @@ static int __cmd_top(struct perf_top *top)
 
 		if (hits == top->samples)
 			ret = perf_evlist__poll(top->evlist, 100);
+
+		if (resize) {
+			perf_top__resize(top);
+			resize = 0;
+		}
 	}
 
 	ret = 0;
-- 
2.13.6
