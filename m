From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/28] perf trace: Add "_from_option" suffix to trace__set_filter()
Date: Thu, 22 Nov 2018 00:35:52 -0300
Message-ID: <20181122033611.15890-10-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As we'll need that name for a new function to set filters for both
tracepoints and BPF maps for filtering pids.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mdkck6hf3fnd21rz2766280q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d86ba17fcf44..8f966c7a7d0d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3104,8 +3104,8 @@ static int trace__set_duration(const struct option *opt, const char *str,
 	return 0;
 }
 
-static int trace__set_filter_pids(const struct option *opt, const char *str,
-				  int unset __maybe_unused)
+static int trace__set_filter_pids_from_option(const struct option *opt, const char *str,
+					      int unset __maybe_unused)
 {
 	int ret = -1;
 	size_t i;
@@ -3363,7 +3363,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_STRING('t', "tid", &trace.opts.target.tid, "tid",
 		    "trace events on existing thread id"),
 	OPT_CALLBACK(0, "filter-pids", &trace, "CSV list of pids",
-		     "pids to filter (by the kernel)", trace__set_filter_pids),
+		     "pids to filter (by the kernel)", trace__set_filter_pids_from_option),
 	OPT_BOOLEAN('a', "all-cpus", &trace.opts.target.system_wide,
 		    "system-wide collection from all CPUs"),
 	OPT_STRING('C', "cpu", &trace.opts.target.cpu_list, "cpu",
-- 
2.14.5
