From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/28] perf cs-etm: Return errcode in cs_etm__process_auxtrace_info()
Date: Mon, 15 Jul 2019 18:11:58 -0300
Message-ID: <20190715211200.10984-27-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

The 'err' variable is set in the error path, but it's not returned to
callers.  Don't always return -EINVAL, return err.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
Link: http://lkml.kernel.org/r/20190321023122.21332-3-yuehaibing@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2e9f5bc45550..3d1c34fc4d68 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2517,8 +2517,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	session->auxtrace = &etm->auxtrace;
 
 	etm->unknown_thread = thread__new(999999999, 999999999);
-	if (!etm->unknown_thread)
+	if (!etm->unknown_thread) {
+		err = -ENOMEM;
 		goto err_free_queues;
+	}
 
 	/*
 	 * Initialize list node so that at thread__zput() we can avoid
@@ -2530,8 +2532,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
-	if (thread__init_map_groups(etm->unknown_thread, etm->machine))
+	if (thread__init_map_groups(etm->unknown_thread, etm->machine)) {
+		err = -ENOMEM;
 		goto err_delete_thread;
+	}
 
 	if (dump_trace) {
 		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
@@ -2575,5 +2579,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 err_free_hdr:
 	zfree(&hdr);
 
-	return -EINVAL;
+	return err;
 }
-- 
2.21.0
