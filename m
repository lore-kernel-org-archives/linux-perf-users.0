From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/32] perf evsel: Fix incorrect handling of type _TERM_DRV_CFG
Date: Wed, 17 Jan 2018 13:11:51 -0300
Message-ID: <20180117161222.15611-2-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Commit ("d0565132605f perf evsel: Enable type checking for
perf_evsel_config_term types") assumes PERF_EVSEL__CONFIG_TERM_DRV_CFG
isn't used and as such adds a BUG_ON().

Since the enumeration type is used in macro ADD_CONFIG_TERM() the change
break CoreSight trace acquisition.

This patch restores the original code.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: d0565132605f ("perf evsel: Enable type checking for perf_evsel_config_term types")
Link: http://lkml.kernel.org/r/1515617211-32024-1-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d934f04e3110..4eea3b404507 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -781,7 +781,7 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			attr->write_backward = term->val.overwrite ? 1 : 0;
 			break;
 		case PERF_EVSEL__CONFIG_TERM_DRV_CFG:
-			BUG_ON(1);
+			break;
 		default:
 			break;
 		}
-- 
2.14.3
