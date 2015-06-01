From: =?UTF-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>
Subject: Re: [RFC] Add --show-total-period for perf annotate
Date: Mon, 01 Jun 2015 13:08:17 +0200
Message-ID: <556C3D21.6040808@suse.cz>
References: <555F3F8A.6000204@suse.cz> <87mw0wc4vt.fsf@tassilo.jf.intel.com>	<5562D33F.70706@suse.cz> <20150525151450.GK19417@two.firstfloor.org>	<5564685D.1020204@suse.cz> <20150526170316.GO19417@two.firstfloor.org>	<55658462.1000605@suse.cz> <20150527140431.GT19417@two.firstfloor.org>	<55686262.7010307@suse.cz> <877frridiy.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080803040005050601000201"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39971 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbbFALIT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 1 Jun 2015 07:08:19 -0400
In-Reply-To: <877frridiy.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

This is a multi-part message in MIME format.
--------------080803040005050601000201
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 05/29/2015 05:55 PM, Andi Kleen wrote:
> Martin Liška <mliska@suse.cz> writes:
>>
>> Following patch sums samples that belong to a line in assembly language.
>> What do you think about it, would it be acceptable solution?
> 
> Basic patch looks good to me now. Thanks.
> 
> The only ugly thing is the global variable, perhaps that could be
> cleaned up.
> 
> -Andi
> 

Hello.

You are right, the global variable is not needed anymore as we do not
count any fraction related to samples related to a line in assembly language.

Please look at attached patch.

Thank you,
Martin

--------------080803040005050601000201
Content-Type: text/x-patch;
 name="0001-perf-annotate-With-show-total-period-display-total-o-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-perf-annotate-With-show-total-period-display-total-o-v2";
 filename*1=".patch"

From 285596ea221e1b6bb2fb8cb06ade6ae5f04a09a0 Mon Sep 17 00:00:00 2001
From: mliska <mliska@suse.cz>
Date: Wed, 27 May 2015 10:54:42 +0200
Subject: [PATCH] perf annotate: With --show-total-period, display total # of
 samples.

To compare two records on an instruction base, with --show-total-period
option provided, display total number of samples that belong to a line
in assembly language.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 tools/perf/builtin-annotate.c     |  2 ++
 tools/perf/ui/browsers/annotate.c | 42 ++++++++++++++++++++++++---------------
 tools/perf/util/annotate.c        | 28 ++++++++++++++++++++------
 tools/perf/util/annotate.h        |  3 ++-
 4 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index b57a027..cce19d6 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -326,6 +326,8 @@ int cmd_annotate(int argc, const char **argv, const char *prefix __maybe_unused)
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
 		    "Show event group information together"),
+	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
+		    "Show a column with the sum of periods"),
 	OPT_END()
 	};
 	int ret = hists__init();
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e5250eb..5c92fd5 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -11,16 +11,21 @@
 #include "../../util/evsel.h"
 #include <pthread.h>
 
+struct percent_tuple {
+    double		percent;
+    double		samples;
+};
+
 struct browser_disasm_line {
-	struct rb_node	rb_node;
-	u32		idx;
-	int		idx_asm;
-	int		jump_sources;
+	struct rb_node		rb_node;
+	u32			idx;
+	int			idx_asm;
+	int			jump_sources;
 	/*
 	 * actual length of this array is saved on the nr_events field
 	 * of the struct annotate_browser
 	 */
-	double		percent[1];
+	struct percent_tuple    tuples[1];
 };
 
 static struct annotate_browser_opt {
@@ -105,15 +110,18 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	char bf[256];
 
 	for (i = 0; i < ab->nr_events; i++) {
-		if (bdl->percent[i] > percent_max)
-			percent_max = bdl->percent[i];
+		if (bdl->tuples[i].percent > percent_max)
+			percent_max = bdl->tuples[i].percent;
 	}
 
 	if (dl->offset != -1 && percent_max != 0.0) {
 		for (i = 0; i < ab->nr_events; i++) {
-			ui_browser__set_percent_color(browser, bdl->percent[i],
+			ui_browser__set_percent_color(browser, bdl->tuples[i].percent,
 						      current_entry);
-			slsmg_printf("%6.2f ", bdl->percent[i]);
+			if (symbol_conf.show_total_period)
+				slsmg_printf("%7.0f ", bdl->tuples[i].samples);
+			else
+				slsmg_printf("%6.2f ", bdl->tuples[i].percent);
 		}
 	} else {
 		ui_browser__set_percent_color(browser, 0, current_entry);
@@ -273,9 +281,9 @@ static int disasm__cmp(struct browser_disasm_line *a,
 	int i;
 
 	for (i = 0; i < nr_pcnt; i++) {
-		if (a->percent[i] == b->percent[i])
+		if (a->tuples[i].percent == b->tuples[i].percent)
 			continue;
-		return a->percent[i] < b->percent[i];
+		return a->tuples[i].percent < b->tuples[i].percent;
 	}
 	return 0;
 }
@@ -366,14 +374,16 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		next = disasm__get_next_ip_line(&notes->src->source, pos);
 
 		for (i = 0; i < browser->nr_events; i++) {
-			bpos->percent[i] = disasm__calc_percent(notes,
+			double samples;
+			bpos->tuples[i].percent = disasm__calc_percent(notes,
 						evsel->idx + i,
 						pos->offset,
 						next ? next->offset : len,
-					        &path);
+					        &path, &samples);
+			bpos->tuples[i].samples = samples;
 
-			if (max_percent < bpos->percent[i])
-				max_percent = bpos->percent[i];
+			if (max_percent < bpos->tuples[i].percent)
+				max_percent = bpos->tuples[i].percent;
 		}
 
 		if (max_percent < 0.01) {
@@ -925,7 +935,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 
 	if (perf_evsel__is_group_event(evsel)) {
 		nr_pcnt = evsel->nr_members;
-		sizeof_bdl += sizeof(double) * (nr_pcnt - 1);
+		sizeof_bdl += sizeof(struct percent_tuple) * (nr_pcnt - 1);
 	}
 
 	if (symbol__annotate(sym, map, sizeof_bdl) < 0) {
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7f5bdfc..797ce62 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -647,10 +647,11 @@ struct disasm_line *disasm__get_next_ip_line(struct list_head *head, struct disa
 }
 
 double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
-			    s64 end, const char **path)
+			    s64 end, const char **path, double *samples)
 {
 	struct source_line *src_line = notes->src->lines;
 	double percent = 0.0;
+	*samples = 0.0;
 
 	if (src_line) {
 		size_t sizeof_src_line = sizeof(*src_line) +
@@ -664,6 +665,7 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 				*path = src_line->path;
 
 			percent += src_line->p[evidx].percent;
+			*samples += src_line->p[evidx].samples;
 			offset++;
 		}
 	} else {
@@ -673,8 +675,10 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 		while (offset < end)
 			hits += h->addr[offset++];
 
-		if (h->sum)
+		if (h->sum) {
+			*samples = hits;
 			percent = 100.0 * hits / h->sum;
+		}
 	}
 
 	return percent;
@@ -689,8 +693,9 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 
 	if (dl->offset != -1) {
 		const char *path = NULL;
-		double percent, max_percent = 0.0;
+		double percent, samples, max_percent = 0.0;
 		double *ppercents = &percent;
+		double *psamples= &samples;
 		int i, nr_percent = 1;
 		const char *color;
 		struct annotation *notes = symbol__annotation(sym);
@@ -703,8 +708,10 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		if (perf_evsel__is_group_event(evsel)) {
 			nr_percent = evsel->nr_members;
 			ppercents = calloc(nr_percent, sizeof(double));
-			if (ppercents == NULL)
+			psamples= calloc(nr_percent, sizeof(double));
+			if (ppercents == NULL || psamples == NULL) {
 				return -1;
+			}
 		}
 
 		for (i = 0; i < nr_percent; i++) {
@@ -712,9 +719,10 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 					notes->src->lines ? i : evsel->idx + i,
 					offset,
 					next ? next->offset : (s64) len,
-					&path);
+					&path, &samples);
 
 			ppercents[i] = percent;
+			psamples[i] = samples;
 			if (percent > max_percent)
 				max_percent = percent;
 		}
@@ -752,8 +760,13 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 
 		for (i = 0; i < nr_percent; i++) {
 			percent = ppercents[i];
+			samples = psamples[i];
 			color = get_percent_color(percent);
-			color_fprintf(stdout, color, " %7.2f", percent);
+
+			if (symbol_conf.show_total_period)
+				color_fprintf(stdout, color, " %7.0f", samples);
+			else
+				color_fprintf(stdout, color, " %7.2f", percent);
 		}
 
 		printf(" :	");
@@ -763,6 +776,9 @@ static int disasm_line__print(struct disasm_line *dl, struct symbol *sym, u64 st
 		if (ppercents != &percent)
 			free(ppercents);
 
+		if (psamples != &samples)
+			free(psamples);
+
 	} else if (max_lines && printed >= max_lines)
 		return 1;
 	else {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index cadbdc9..b3ffb87 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -72,7 +72,7 @@ struct disasm_line *disasm__get_next_ip_line(struct list_head *head, struct disa
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
-			    s64 end, const char **path);
+			    s64 end, const char **path, double *samples);
 
 struct sym_hist {
 	u64		sum;
@@ -81,6 +81,7 @@ struct sym_hist {
 
 struct source_line_percent {
 	double		percent;
+	double          samples;
 	double		percent_sum;
 };
 
-- 
2.1.4


--------------080803040005050601000201--
