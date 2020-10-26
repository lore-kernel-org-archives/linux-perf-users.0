From: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
Subject: [PATCH v2] perf trace: Segfault when trying to trace events by cgroup
Date: Mon, 26 Oct 2020 16:20:34 +0300
Message-ID: <20201026132034.80464-1-sivanichkin@yandex-team.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, dmtrmonakhov@yandex-team.ru, namhyung@gmail.com
List-Id: linux-perf-users.vger.kernel.org

  v2:
    - struct declaration fixed (Namhyung Kim)

Fixes: 9ea42ba4411ac ("perf trace: Support setting cgroups as targets")
Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
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
