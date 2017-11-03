From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/19] perf script: Add a few missing conversions to fprintf style
Date: Fri,  3 Nov 2017 10:54:45 -0300
Message-ID: <20171103135503.4921-2-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In a1a587073ccd ("perf script: Use fprintf like printing uniformly")
there were a few cases that were missed, fix it.

Reported-by: yuzhoujian <yuzhoujian@didichuxing.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-sq9hvfk5mkjdqzlpyiq7jkos@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a3add2cd7856..db4ff1510dc5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1447,7 +1447,7 @@ static void process_event(struct perf_script *script,
 	perf_sample__fprintf_start(sample, thread, evsel, fp);
 
 	if (PRINT_FIELD(PERIOD))
-		printf("%10" PRIu64 " ", sample->period);
+		fprintf(fp, "%10" PRIu64 " ", sample->period);
 
 	if (PRINT_FIELD(EVNAME)) {
 		const char *evname = perf_evsel__name(evsel);
@@ -1455,8 +1455,7 @@ static void process_event(struct perf_script *script,
 		if (!script->name_width)
 			script->name_width = perf_evlist__max_name_len(script->session->evlist);
 
-		printf("%*s: ", script->name_width,
-		       evname ? evname : "[unknown]");
+		fprintf(fp, "%*s: ", script->name_width, evname ?: "[unknown]");
 	}
 
 	if (print_flags)
@@ -1513,8 +1512,8 @@ static void process_event(struct perf_script *script,
 	perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
 
 	if (PRINT_FIELD(PHYS_ADDR))
-		printf("%16" PRIx64, sample->phys_addr);
-	printf("\n");
+		fprintf(fp, "%16" PRIx64, sample->phys_addr);
+	fprintf(fp, "\n");
 }
 
 static struct scripting_ops	*scripting_ops;
-- 
2.13.6
