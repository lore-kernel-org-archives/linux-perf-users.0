From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/13] perf bpf-loader: use PTR_ERR_OR_ZERO inetead of return code
Date: Wed, 19 Sep 2018 11:25:30 -0300
Message-ID: <20180919142537.29985-7-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ding Xiang <dingxiang@cmss.chinamobile.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

Use PTR_ERR_OR_ZERO() in bpf__setup_stdout() return code instead of open
coded equivalent.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1536284082-23466-2-git-send-email-dingxiang@cmss.chinamobile.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 47aac41349a2..f9ae1a993806 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1615,7 +1615,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
-	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
+	return PTR_ERR_OR_ZERO(evsel);
 }
 
 #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
-- 
2.14.4
