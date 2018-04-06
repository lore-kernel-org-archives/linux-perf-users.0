From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/6] perf report: Remove duplicated 'samples' in lost samples warning
Date: Fri,  6 Apr 2018 08:24:38 -0300
Message-ID: <20180406112439.21685-6-acme@kernel.org>
References: <20180406112439.21685-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406112439.21685-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Kan Liang <kan.liang@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The following message, emitted when samples are lost due to system
overload, had one 'samples' too many, ditch it:

   Processed 25333 samples and lost 20.88% samples!

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: https://lkml.kernel.org/n/tip-oev1469y02hmfere6r2kkxp6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c71ced7db152..f4a7a437ee87 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1591,7 +1591,7 @@ static void perf_session__warn_about_errors(const struct perf_session *session)
 		drop_rate = (double)stats->total_lost_samples /
 			    (double) (stats->nr_events[PERF_RECORD_SAMPLE] + stats->total_lost_samples);
 		if (drop_rate > 0.05) {
-			ui__warning("Processed %" PRIu64 " samples and lost %3.2f%% samples!\n\n",
+			ui__warning("Processed %" PRIu64 " samples and lost %3.2f%%!\n\n",
 				    stats->nr_events[PERF_RECORD_SAMPLE] + stats->total_lost_samples,
 				    drop_rate * 100.0);
 		}
-- 
2.14.3
