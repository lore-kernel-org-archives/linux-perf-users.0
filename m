From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/31] perf record: Avoid duplicate call of perf_default_config()
Date: Tue, 13 Mar 2018 09:05:03 -0300
Message-ID: <20180313120508.29327-27-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Yisheng Xie <xieyisheng1@huawei.com>

We have brought perf_default_config to the very beginning at main(), so
it no need to call perf_default_config() once more for most of config in
perf-record but only for record.call-graph.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1520853957-36106-2-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b81494587120..d33103291b02 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1279,10 +1279,12 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 			return -1;
 		return 0;
 	}
-	if (!strcmp(var, "record.call-graph"))
-		var = "call-graph.record-mode"; /* fall-through */
+	if (!strcmp(var, "record.call-graph")) {
+		var = "call-graph.record-mode";
+		return perf_default_config(var, value, cb);
+	}
 
-	return perf_default_config(var, value, cb);
+	return 0;
 }
 
 struct clockid_map {
-- 
2.14.3
