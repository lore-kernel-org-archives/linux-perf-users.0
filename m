From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/30] perf top: Use signal interface for SIGWINCH handler
Date: Tue, 28 Nov 2017 12:02:08 -0300
Message-ID: <20171128150220.5064-19-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need for SA_SIGINFO data in SIGWINCH handler, switching it to
register the handler via signal interface as we do for the rest of the
signals in perf top.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-elxp1vdnaog1scaj13cx7cu0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 489573883936..9e0d2645ae13 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -86,8 +86,7 @@ static void perf_top__update_print_entries(struct perf_top *top)
 	top->print_entries = top->winsize.ws_row - HEADER_LINE_NR;
 }
 
-static void perf_top__sig_winch(int sig __maybe_unused,
-				siginfo_t *info __maybe_unused, void *arg __maybe_unused)
+static void winch_sig(int sig __maybe_unused)
 {
 	resize = 1;
 }
@@ -477,12 +476,8 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 		case 'e':
 			prompt_integer(&top->print_entries, "Enter display entries (lines)");
 			if (top->print_entries == 0) {
-				struct sigaction act = {
-					.sa_sigaction = perf_top__sig_winch,
-					.sa_flags     = SA_SIGINFO,
-				};
 				perf_top__resize(top);
-				sigaction(SIGWINCH, &act, NULL);
+				signal(SIGWINCH, winch_sig);
 			} else {
 				signal(SIGWINCH, SIG_DFL);
 			}
@@ -1363,12 +1358,8 @@ int cmd_top(int argc, const char **argv)
 
 	get_term_dimensions(&top.winsize);
 	if (top.print_entries == 0) {
-		struct sigaction act = {
-			.sa_sigaction = perf_top__sig_winch,
-			.sa_flags     = SA_SIGINFO,
-		};
 		perf_top__update_print_entries(&top);
-		sigaction(SIGWINCH, &act, NULL);
+		signal(SIGWINCH, winch_sig);
 	}
 
 	status = __cmd_top(&top);
-- 
2.13.6
