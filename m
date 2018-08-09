From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/44] perf annotate: Make annotation_line__max_percent static
Date: Thu,  9 Aug 2018 11:57:52 -0300
Message-ID: <20180809145822.21391-15-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no outside user of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 3 ++-
 tools/perf/util/annotate.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b6e7d0d56622..956c9b19d81c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2441,7 +2441,8 @@ bool ui__has_annotation(void)
 }
 
 
-double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes)
+static double annotation_line__max_percent(struct annotation_line *al,
+					   struct annotation *notes)
 {
 	double percent_max = 0.0;
 	int i;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5f24fc9dcc7c..a93502d0c582 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -169,7 +169,6 @@ struct annotation_write_ops {
 	void (*write_graph)(void *obj, int graph);
 };
 
-double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes);
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
 			    struct annotation_write_ops *ops);
 
-- 
2.14.4
