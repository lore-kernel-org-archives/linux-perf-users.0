From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/13] perf trace: Fix off by one string allocation problem
Date: Mon, 21 Aug 2017 16:25:39 -0300
Message-ID: <20170821192549.17251-4-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need to consider the null terminator, oops, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 017037ff3d0b ("perf trace: Allow specifying list of syscalls and events in -e/--expr/--event")
Link: http://lkml.kernel.org/n/tip-j79jpqqe91gvxqmsgxgfn2ni@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index de02413a25d3..91905839e386 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2806,7 +2806,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	struct trace *trace = (struct trace *)opt->value;
 	const char *s = str;
 	char *sep = NULL, *lists[2] = { NULL, NULL, };
-	int len = strlen(str), err = -1, list;
+	int len = strlen(str) + 1, err = -1, list;
 	char *strace_groups_dir = system_path(STRACE_GROUPS_DIR);
 	char group_name[PATH_MAX];
 
-- 
2.13.5
