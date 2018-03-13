From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/31] perf top: Fix top.call-graph config option reading
Date: Tue, 13 Mar 2018 09:05:04 -0300
Message-ID: <20180313120508.29327-28-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Yisheng Xie <xieyisheng1@huawei.com>

When trying to add the "call-graph" variable for top into the
.perfconfig file, like:

      [top]
            call-graph = fp

I that perf_top_config() do not parse this variable.

Fix it by calling perf_default_config() when the top.call-graph variable
is set.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: b8cbb349061e ("perf config: Bring perf_default_config to the very beginning at main()")
Link: http://lkml.kernel.org/r/1520853957-36106-1-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0a26b56afcc5..113c298ed38b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1223,8 +1223,10 @@ parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 
 static int perf_top_config(const char *var, const char *value, void *cb __maybe_unused)
 {
-	if (!strcmp(var, "top.call-graph"))
-		var = "call-graph.record-mode"; /* fall-through */
+	if (!strcmp(var, "top.call-graph")) {
+		var = "call-graph.record-mode";
+		return perf_default_config(var, value, cb);
+	}
 	if (!strcmp(var, "top.children")) {
 		symbol_conf.cumulate_callchain = perf_config_bool(var, value);
 		return 0;
-- 
2.14.3
