From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 82/83] perf tools: Change (symbol|annotation)__calc_percent return type to void
Date: Fri, 17 Nov 2017 17:16:00 -0300
Message-ID: <20171117201601.24110-83-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161839AbdKQUUn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:20:43 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

There's no need for symbol__calc_percent and annotation__calc_percent
functions to return any value, since it's always zero. Changing both
function to return void.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-z0gs28hh24m4gia1t1ctraye@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 17 ++++++++---------
 tools/perf/util/annotate.h |  2 +-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 30d74dabdc42..846abb4955ac 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1584,8 +1584,8 @@ static void calc_percent(struct sym_hist *hist,
 	}
 }
 
-static int annotation__calc_percent(struct annotation *notes,
-				    struct perf_evsel *evsel, s64 len)
+static void annotation__calc_percent(struct annotation *notes,
+				     struct perf_evsel *evsel, s64 len)
 {
 	struct annotation_line *al, *next;
 
@@ -1609,15 +1609,13 @@ static int annotation__calc_percent(struct annotation *notes,
 			calc_percent(hist, sample, al->offset, end);
 		}
 	}
-
-	return 0;
 }
 
-int symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel)
+void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
-	return annotation__calc_percent(notes, evsel, symbol__size(sym));
+	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
 int symbol__annotate(struct symbol *sym, struct map *map,
@@ -1656,10 +1654,11 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	}
 
 	err = symbol__disassemble(sym, &args);
-	if (err)
-		return err;
+	if (!err)
+		symbol__calc_percent(sym, evsel);
+
+	return err;
 
-	return symbol__calc_percent(sym, evsel);
 }
 
 static void insert_source_line(struct rb_root *root, struct annotation_line *al)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 4fc805a271d2..6d7289e88fa3 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -107,7 +107,7 @@ struct annotation_line *
 annotation_line__next(struct annotation_line *pos, struct list_head *head);
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
-int symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
+void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
 
 struct sym_hist {
 	u64		      nr_samples;
-- 
2.13.6
