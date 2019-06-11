From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/85] perf cs-etm: Refactor error path in cs_etm_decoder__new()
Date: Tue, 11 Jun 2019 15:58:28 -0300
Message-ID: <20190611185911.11645-43-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

There is no point in having two different error goto statement since the
openCSD API to free a decoder handles NULL pointers.  As such function
cs_etm_decoder__free() can be called to deal with all aspect of freeing
decoder memory.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-7-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 39fe21e1cf93..5dafec421b0d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -577,7 +577,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	/* init library print logging support */
 	ret = cs_etm_decoder__init_def_logger_printing(d_params, decoder);
 	if (ret != 0)
-		goto err_free_decoder_tree;
+		goto err_free_decoder;
 
 	/* init raw frame logging if required */
 	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
@@ -587,15 +587,13 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 							 &t_params[i],
 							 decoder);
 		if (ret != 0)
-			goto err_free_decoder_tree;
+			goto err_free_decoder;
 	}
 
 	return decoder;
 
-err_free_decoder_tree:
-	ocsd_destroy_dcd_tree(decoder->dcd_tree);
 err_free_decoder:
-	free(decoder);
+	cs_etm_decoder__free(decoder);
 	return NULL;
 }
 
-- 
2.20.1
