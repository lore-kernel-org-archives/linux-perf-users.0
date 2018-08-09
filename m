From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/44] perf annotate: Pass browser percent_type in annotate_browser__calc_percent()
Date: Thu,  9 Aug 2018 11:58:05 -0300
Message-ID: <20180809145822.21391-28-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Pass browser percent_type in annotate_browser__calc_percent().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index cfe611c28987..2a3a34d450d5 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -318,7 +318,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			double percent;
 
 			percent = annotation_data__percent(&pos->al.data[i],
-							   PERCENT_HITS_LOCAL);
+							   browser->opts->percent_type);
 
 			if (max_percent < percent)
 				max_percent = percent;
-- 
2.14.4
