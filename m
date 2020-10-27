From: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
Subject: [PATCH v3] perf trace: Segfault when trying to trace events by cgroup
Date: Tue, 27 Oct 2020 12:43:57 +0300
Message-ID: <20201027094357.94881-1-sivanichkin@yandex-team.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, dmtrmonakhov@yandex-team.ru, namhyung@gmail.com
List-Id: linux-perf-users.vger.kernel.org

 # ./perf trace -e sched:sched_switch -G test -a sleep 1
 perf: Segmentation fault
 Obtained 11 stack frames.
 ./perf(sighandler_dump_stack+0x43) [0x55cfdc636db3]
 /lib/x86_64-linux-gnu/libc.so.6(+0x3efcf) [0x7fd23eecafcf]
 ./perf(parse_cgroups+0x36) [0x55cfdc673f36]
 ./perf(+0x3186ed) [0x55cfdc70d6ed]
 ./perf(parse_options_subcommand+0x629) [0x55cfdc70e999]
 ./perf(cmd_trace+0x9c2) [0x55cfdc5ad6d2]
 ./perf(+0x1e8ae0) [0x55cfdc5ddae0]
 ./perf(+0x1e8ded) [0x55cfdc5ddded]
 ./perf(main+0x370) [0x55cfdc556f00]
 /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe6) [0x7fd23eeadb96]
 ./perf(_start+0x29) [0x55cfdc557389]
 Segmentation fault

 It happens because "struct trace" in option->value is passed to
 parse_cgroups function instead of "struct evlist".

 v3:
   - missed commit message (Namhyung Kim)

 v2:
   - struct declaration fixed (Namhyung Kim)

Fixes: 9ea42ba4411ac ("perf trace: Support setting cgroups as targets")
Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 44a75f234db1..de80534473af 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4639,9 +4639,9 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	err = 0;
 
 	if (lists[0]) {
-		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
-					       "event selector. use 'perf list' to list available events",
-					       parse_events_option);
+		struct option o = {
+			.value = &trace->evlist,
+		};
 		err = parse_events_option(&o, lists[0], 0);
 	}
 out:
@@ -4655,9 +4655,12 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 {
 	struct trace *trace = opt->value;
 
-	if (!list_empty(&trace->evlist->core.entries))
-		return parse_cgroups(opt, str, unset);
-
+	if (!list_empty(&trace->evlist->core.entries)) {
+		struct option o = {
+			.value = &trace->evlist,
+		};
+		return parse_cgroups(&o, str, unset);
+	}
 	trace->cgroup = evlist__findnew_cgroup(trace->evlist, str);
 
 	return 0;
-- 
2.17.1
