Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64FB1E1025
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202630; cv=none; b=kSaq9MoK45ktvHrB0oD67F8FgQ7BqMvr4LmvGE+bT9OHTAyzpNBZfvBu7cXHIf+RShjlbQuO1t7PaCtgIwQCPxOFp3BV2jtEXAusrh6yy58DgNr4AC2xrUyaUj/8mdsyuJBwIIo44LBt1jwhoRzqdI5FpKO7PIVsomt/D9xshzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202630; c=relaxed/simple;
	bh=h0omKkhpf550wB/6tupvXGMU7TLP62105Zo9gREXZS0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=NGkfBjaPhHDeePlbLgxQ0YyOA31wdGYz1VjhzIakv0xw8vtTbKcPQD8Q0+g8nE4goeXBld3WE+bR2Dl3IxZlX30CSsWid2hgjoV2Ny0CgRHiJUOD9PLP4yiY0HOftWXC2T43sKeXln5Izb9wQmbpw+iACmfQNBjH0bIbtK9SH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgTQQQWi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgTQQQWi"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e4c27270591so10706306276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 14:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736202626; x=1736807426; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SHUpyX/clP8/JtK1z4b3BSGwhl4v91tRoP89wrgAOss=;
        b=zgTQQQWiiti+vkkKvKnoBd7YvqhIepr9BHysaYlwmyNrPeX2MXMWm/i6MdIdFLbJ+3
         90vVge97e17QRiQ6KcyU0QxwhDj7vIo3rpOWqJAggcJr7MNCnS/vD0KQ7ij9ieSjdvi0
         wLsNG/q/80aTMXEkncUwZOUEvPy+5Tv2P7Lq8uIcZdfvzCLk2tlhX1zVVvTns6/ieXPr
         57PhtxXyq2oEGL02LCjB0cHPnUGZK35hToSNV7Qr3nvCvTdcLinrrUkbw0XoA1GLbxWw
         TiLCEnUhhxH9abmPmgRq6Ew9QYoSG176NId6KZq/Jv+GCRtLKRTTPD2W3+iXh05PZOkK
         gO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202626; x=1736807426;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHUpyX/clP8/JtK1z4b3BSGwhl4v91tRoP89wrgAOss=;
        b=EHkIpPwJam5PoHI7mR0xt/8rmcbwbcg7yGayJ0xdMXRaojAPA2b4IwdCiec6eXCODu
         6TebcX3Jw9K0zJBknI7z3XvW6fG2G0u8dzRIlxORGrZlhzWha6xJdGvbavNdBC5Gsg2o
         xUCecKVwIgo7uXB/1AqbNmjS+6Az8/Ileo+6Z3WpwN2XOmw3fJiRMyIAspgtUNDrevP/
         RHYNS+aeEXEY3R/C+xR783TK5bTOqxkCUXRwU7FjHGP6tfsP+WYx520CPlp49+tndxif
         xpAI8z5jf6WApBvCA+XjVGsJzkBRHPfOKaGutI2znK76BdrZEycjmfIwXUgMQmGSYAYh
         0Q7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDgYjgM3gaFtVJETyNZbWM4gVaeWFjeumJNJqb8mR0sxN1f3bS2TsuNeW2R/myTt7W5xsHON91XMfTdIcbTCiT@vger.kernel.org
X-Gm-Message-State: AOJu0YzNgP1smmrJswbSDjO/Kjs/IahEZrmqyEyVcizS1iv9M8KU2pha
	3Pf6m3gqWwyACV64hgbUT7wC1yzFMbF0YNtJqZeHmlB9OjPztY5cYtB8aqsTBK5DNVqvXzh4F5Z
	zTaskMQ==
X-Google-Smtp-Source: AGHT+IFbomZvsATQ1msE9hjn4aZzXmSfB+Her/H0OnfzKZZqmew9+EAQsX3vbrTcZ1ufafNVmShZhlJEAQky
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ede7:40c7:c970:8d77])
 (user=irogers job=sendgmr) by 2002:a25:8c08:0:b0:e39:aa0b:bee7 with SMTP id
 3f1490d57ef6-e538c223c09mr152919276.4.1736202625690; Mon, 06 Jan 2025
 14:30:25 -0800 (PST)
Date: Mon,  6 Jan 2025 14:30:21 -0800
Message-Id: <20250106223021.458674-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2] perf annotate: Prefer passing evsel to evsel->core.idx
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chen Ni <nichen@iscas.ac.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

An evsel idx may not be stable due to sorting, evlist removal,
etc. Try to reduce it being part of APIs by explicitly passing the
evsel in annotate code. Internally the code just reads evsel->core.idx
so behavior is unchanged.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2. Fix gtk build issue reported by Arnaldo.
---
 tools/perf/builtin-top.c          |  4 ++--
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/ui/gtk/annotate.c      | 15 ++++++++-------
 tools/perf/util/annotate.c        | 32 +++++++++++++++----------------
 tools/perf/util/annotate.h        | 20 ++++++++++---------
 5 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 724a79386321..881e6cf26979 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -267,9 +267,9 @@ static void perf_top__show_details(struct perf_top *top)
 
 	if (top->evlist->enabled) {
 		if (top->zero)
-			symbol__annotate_zero_histogram(symbol, top->sym_evsel->core.idx);
+			symbol__annotate_zero_histogram(symbol, top->sym_evsel);
 		else
-			symbol__annotate_decay_histogram(symbol, top->sym_evsel->core.idx);
+			symbol__annotate_decay_histogram(symbol, top->sym_evsel);
 	}
 	if (more != 0)
 		printf("%d lines not displayed, maybe increase display entries [e]\n", more);
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d7e727345dab..135d6ce88fb3 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -754,7 +754,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				hbt->timer(hbt->arg);
 
 			if (delay_secs != 0) {
-				symbol__annotate_decay_histogram(sym, evsel->core.idx);
+				symbol__annotate_decay_histogram(sym, evsel);
 				hists__scnprintf_title(hists, title, sizeof(title));
 				annotate_browser__show(&browser->b, title, help);
 			}
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 6da24aa039eb..6db76fadbbee 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -26,7 +26,7 @@ static const char *const col_names[] = {
 };
 
 static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
-				 struct disasm_line *dl, int evidx)
+				 struct disasm_line *dl, const struct evsel *evsel)
 {
 	struct annotation *notes;
 	struct sym_hist *symhist;
@@ -42,8 +42,8 @@ static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
 		return 0;
 
 	notes = symbol__annotation(sym);
-	symhist = annotation__histogram(notes, evidx);
-	entry = annotated_source__hist_entry(notes->src, evidx, dl->al.offset);
+	symhist = annotation__histogram(notes, evset);
+	entry = annotated_source__hist_entry(notes->src, evsel, dl->al.offset);
 	if (entry)
 		nr_samples = entry->nr_samples;
 
@@ -139,16 +139,17 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
 		gtk_list_store_append(store, &iter);
 
 		if (evsel__is_group_event(evsel)) {
-			for (i = 0; i < evsel->core.nr_members; i++) {
+			struct evsel *cur_evsel;
+
+			for_each_group_evsel(cur_evsel, evsel__leader(evsel)) {
 				ret += perf_gtk__get_percent(s + ret,
 							     sizeof(s) - ret,
 							     sym, pos,
-							     evsel->core.idx + i);
+							     cur_evsel);
 				ret += scnprintf(s + ret, sizeof(s) - ret, " ");
 			}
 		} else {
-			ret = perf_gtk__get_percent(s, sizeof(s), sym, pos,
-						    evsel->core.idx);
+			ret = perf_gtk__get_percent(s, sizeof(s), sym, pos, evsel);
 		}
 
 		if (ret)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 32e15c9f53f3..0d2ea22bd9e4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -209,7 +209,7 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
 }
 
 static int __symbol__inc_addr_samples(struct map_symbol *ms,
-				      struct annotated_source *src, int evidx, u64 addr,
+				      struct annotated_source *src, struct evsel *evsel, u64 addr,
 				      struct perf_sample *sample)
 {
 	struct symbol *sym = ms->sym;
@@ -228,14 +228,14 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	}
 
 	offset = addr - sym->start;
-	h = annotated_source__histogram(src, evidx);
+	h = annotated_source__histogram(src, evsel);
 	if (h == NULL) {
 		pr_debug("%s(%d): ENOMEM! sym->name=%s, start=%#" PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 ", func: %d\n",
 			 __func__, __LINE__, sym->name, sym->start, addr, sym->end, sym->type == STT_FUNC);
 		return -ENOMEM;
 	}
 
-	hash_key = offset << 16 | evidx;
+	hash_key = offset << 16 | evsel->core.idx;
 	if (!hashmap__find(src->samples, hash_key, &entry)) {
 		entry = zalloc(sizeof(*entry));
 		if (entry == NULL)
@@ -252,7 +252,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 
 	pr_debug3("%#" PRIx64 " %s: period++ [addr: %#" PRIx64 ", %#" PRIx64
 		  ", evidx=%d] => nr_samples: %" PRIu64 ", period: %" PRIu64 "\n",
-		  sym->start, sym->name, addr, addr - sym->start, evidx,
+		  sym->start, sym->name, addr, addr - sym->start, evsel->core.idx,
 		  entry->nr_samples, entry->period);
 	return 0;
 }
@@ -323,7 +323,7 @@ static int symbol__inc_addr_samples(struct map_symbol *ms,
 	if (sym == NULL)
 		return 0;
 	src = symbol__hists(sym, evsel->evlist->core.nr_entries);
-	return src ? __symbol__inc_addr_samples(ms, src, evsel->core.idx, addr, sample) : 0;
+	return src ? __symbol__inc_addr_samples(ms, src, evsel, addr, sample) : 0;
 }
 
 static int symbol__account_br_cntr(struct annotated_branch *branch,
@@ -861,15 +861,14 @@ static void calc_percent(struct annotation *notes,
 			 s64 offset, s64 end)
 {
 	struct hists *hists = evsel__hists(evsel);
-	int evidx = evsel->core.idx;
-	struct sym_hist *sym_hist = annotation__histogram(notes, evidx);
+	struct sym_hist *sym_hist = annotation__histogram(notes, evsel);
 	unsigned int hits = 0;
 	u64 period = 0;
 
 	while (offset < end) {
 		struct sym_hist_entry *entry;
 
-		entry = annotated_source__hist_entry(notes->src, evidx, offset);
+		entry = annotated_source__hist_entry(notes->src, evsel, offset);
 		if (entry) {
 			hits   += entry->nr_samples;
 			period += entry->period;
@@ -1140,15 +1139,14 @@ static void print_summary(struct rb_root *root, const char *filename)
 
 static void symbol__annotate_hits(struct symbol *sym, struct evsel *evsel)
 {
-	int evidx = evsel->core.idx;
 	struct annotation *notes = symbol__annotation(sym);
-	struct sym_hist *h = annotation__histogram(notes, evidx);
+	struct sym_hist *h = annotation__histogram(notes, evsel);
 	u64 len = symbol__size(sym), offset;
 
 	for (offset = 0; offset < len; ++offset) {
 		struct sym_hist_entry *entry;
 
-		entry = annotated_source__hist_entry(notes->src, evidx, offset);
+		entry = annotated_source__hist_entry(notes->src, evsel, offset);
 		if (entry && entry->nr_samples != 0)
 			printf("%*" PRIx64 ": %" PRIu64 "\n", BITS_PER_LONG / 2,
 			       sym->start + offset, entry->nr_samples);
@@ -1178,7 +1176,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
 	const char *d_filename;
 	const char *evsel_name = evsel__name(evsel);
 	struct annotation *notes = symbol__annotation(sym);
-	struct sym_hist *h = annotation__histogram(notes, evsel->core.idx);
+	struct sym_hist *h = annotation__histogram(notes, evsel);
 	struct annotation_line *pos, *queue = NULL;
 	struct annotation_options *opts = &annotate_opts;
 	u64 start = map__rip_2objdump(map, sym->start);
@@ -1364,18 +1362,18 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
 	return err;
 }
 
-void symbol__annotate_zero_histogram(struct symbol *sym, int evidx)
+void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	struct sym_hist *h = annotation__histogram(notes, evidx);
+	struct sym_hist *h = annotation__histogram(notes, evsel);
 
 	memset(h, 0, sizeof(*notes->src->histograms) * notes->src->nr_histograms);
 }
 
-void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
+void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	struct sym_hist *h = annotation__histogram(notes, evidx);
+	struct sym_hist *h = annotation__histogram(notes, evsel);
 	struct annotation_line *al;
 
 	h->nr_samples = 0;
@@ -1385,7 +1383,7 @@ void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
 		if (al->offset == -1)
 			continue;
 
-		entry = annotated_source__hist_entry(notes->src, evidx, al->offset);
+		entry = annotated_source__hist_entry(notes->src, evsel, al->offset);
 		if (entry == NULL)
 			continue;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index c6a59aaefdb8..0ba5846dad4d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -15,6 +15,7 @@
 #include "hashmap.h"
 #include "disasm.h"
 #include "branch.h"
+#include "evsel.h"
 
 struct hist_browser_timer;
 struct hist_entry;
@@ -23,7 +24,6 @@ struct map_symbol;
 struct addr_map_symbol;
 struct option;
 struct perf_sample;
-struct evsel;
 struct symbol;
 struct annotated_data_type;
 
@@ -373,21 +373,23 @@ static inline u8 annotation__br_cntr_width(void)
 void annotation__update_column_widths(struct annotation *notes);
 void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms);
 
-static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
+static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src,
+							   const struct evsel *evsel)
 {
-	return &src->histograms[idx];
+	return &src->histograms[evsel->core.idx];
 }
 
-static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
+static inline struct sym_hist *annotation__histogram(struct annotation *notes,
+						     const struct evsel *evsel)
 {
-	return annotated_source__histogram(notes->src, idx);
+	return annotated_source__histogram(notes->src, evsel);
 }
 
 static inline struct sym_hist_entry *
-annotated_source__hist_entry(struct annotated_source *src, int idx, u64 offset)
+annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset)
 {
 	struct sym_hist_entry *entry;
-	long key = offset << 16 | idx;
+	long key = offset << 16 | evsel->core.idx;
 
 	if (!hashmap__find(src->samples, key, &entry))
 		return NULL;
@@ -449,8 +451,8 @@ enum symbol_disassemble_errno {
 int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen);
 
 int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel);
-void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
-void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
+void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel);
+void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel);
 void annotated_source__purge(struct annotated_source *as);
 
 int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
-- 
2.47.1.613.gc27f4b7a9f-goog

