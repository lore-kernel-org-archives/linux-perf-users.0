From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/63] perf cs-etm: Refactor enumeration cs_etm_sample_type
Date: Tue, 18 Dec 2018 19:06:59 -0300
Message-ID: <20181218220733.15839-30-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The values in enumeration cs_etm_sample_type are defined with setting
bit N for each packet type, this is not suggested in the usual case.

This patch refactor cs_etm_sample_type by converting from bit shifting
values to continuous numbers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-5-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index b295dd2b8292..3819a04a2c27 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,9 +23,9 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
-	CS_ETM_EMPTY = 0,
-	CS_ETM_RANGE = 1 << 0,
-	CS_ETM_TRACE_ON = 1 << 1,
+	CS_ETM_EMPTY,
+	CS_ETM_RANGE,
+	CS_ETM_TRACE_ON,
 };
 
 enum cs_etm_isa {
-- 
2.19.2
