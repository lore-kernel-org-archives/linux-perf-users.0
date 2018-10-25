From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/37] perf trace: Drop thread refcount in trace__event_handler()
Date: Thu, 25 Oct 2018 08:10:05 -0300
Message-ID: <20181025111031.3440-12-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We must pair:

   thread = machine__findnew_thread();

with thread__put(thread). Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: c4191e55b874 ("perf trace: Show comm and tid for tracepoint events")
Link: https://lkml.kernel.org/n/tip-dkxsb8cwg87rmkrzrbns1o4z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 77b8748ad5ed..589e0412652a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2152,8 +2152,8 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
-	thread__put(thread);
 out:
+	thread__put(thread);
 	return 0;
 }
 
-- 
2.14.4
