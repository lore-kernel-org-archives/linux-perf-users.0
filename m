From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/83] perf annotate: Remove disasm__calc_percent function
Date: Fri, 17 Nov 2017 17:15:00 -0300
Message-ID: <20171117201601.24110-23-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161440AbdKQURb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:31 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Remove disasm__calc_percent() function, because it's no longer needed.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-22-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 44 --------------------------------------------
 tools/perf/util/annotate.h |  2 --
 2 files changed, 46 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 209a25545542..29cf2a5ef620 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1010,50 +1010,6 @@ annotation_line__next(struct annotation_line *pos, struct list_head *head)
 	return NULL;
 }
 
-double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
-			    s64 end, const char **path, struct sym_hist_entry *sample)
-{
-	struct source_line *src_line = notes->src->lines;
-	double percent = 0.0;
-
-	sample->nr_samples = sample->period = 0;
-
-	if (src_line) {
-		size_t sizeof_src_line = sizeof(*src_line) +
-				sizeof(src_line->samples) * (src_line->nr_pcnt - 1);
-
-		while (offset < end) {
-			src_line = (void *)notes->src->lines +
-					(sizeof_src_line * offset);
-
-			if (*path == NULL)
-				*path = src_line->path;
-
-			percent += src_line->samples[evidx].percent;
-			sample->nr_samples += src_line->samples[evidx].nr;
-			offset++;
-		}
-	} else {
-		struct sym_hist *h = annotation__histogram(notes, evidx);
-		unsigned int hits = 0;
-		u64 period = 0;
-
-		while (offset < end) {
-			hits   += h->addr[offset].nr_samples;
-			period += h->addr[offset].period;
-			++offset;
-		}
-
-		if (h->nr_samples) {
-			sample->period	   = period;
-			sample->nr_samples = hits;
-			percent = 100.0 * hits / h->nr_samples;
-		}
-	}
-
-	return percent;
-}
-
 static const char *annotate__address_color(struct block_range *br)
 {
 	double cov = block_range__coverage(br);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 927810b19f0d..f98acb2ad721 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -107,8 +107,6 @@ struct annotation_line *
 annotation_line__next(struct annotation_line *pos, struct list_head *head);
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
-double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
-			    s64 end, const char **path, struct sym_hist_entry *sample);
 int symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
 
 struct sym_hist {
-- 
2.13.6
