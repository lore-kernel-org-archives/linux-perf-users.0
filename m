From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/19] perf script: Use event_format__fprintf()
Date: Fri,  3 Nov 2017 10:54:47 -0300
Message-ID: <20171103135503.4921-4-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Another case where we a1a587073ccd ("perf script: Use fprintf like
printing uniformly") forgot to redirect output to the FILE descriptor,
fix this too.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Link: http://lkml.kernel.org/n/tip-jmwx4pgfezw98ezfoj9t957s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index af0267072d43..b27f21638207 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1465,9 +1465,10 @@ static void process_event(struct perf_script *script,
 		return;
 	}
 
-	if (PRINT_FIELD(TRACE))
-		event_format__print(evsel->tp_format, sample->cpu,
-				    sample->raw_data, sample->raw_size);
+	if (PRINT_FIELD(TRACE)) {
+		event_format__fprintf(evsel->tp_format, sample->cpu,
+				      sample->raw_data, sample->raw_size, fp);
+	}
 
 	if (attr->type == PERF_TYPE_SYNTH && PRINT_FIELD(SYNTH))
 		perf_sample__fprintf_synth(sample, evsel, fp);
-- 
2.13.6
