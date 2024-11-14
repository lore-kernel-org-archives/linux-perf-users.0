Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4131B3954
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625653; cv=none; b=cvR+PxZG+DTByEfed+m3p275sg6YYECLqh/HZXg8SdmLGmmWdROAcNO6S+LFMXQi4KZgvRWxpiW+DKzy8rdWtVHsulEBEgdGnB459JEYXRVO8CMH3aPMy7j2YXaynq7Ra+aO43cyc1CRiI1cjE/0qQIsAlkf15v2eCXEH36bpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625653; c=relaxed/simple;
	bh=3JoeJuw8QxsbHL6WLuQjYhTPCcdRnI6vX0QdH3V4OBQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=t3D0hTKL57HZ3TqUJcmiLVU9eXAj0lYJdQhiohwom6OnbQq41FI1WHbmy6y2BONtil3PIN4NkWtDehCcAStuChNgVtMAAO55rHo04mfvPN5Os0+SLUSkOO+CpbqOFMqQq+NVBUAbs9Y+ZiAKOnzqsNOdPbzXWRCxgC7qiGwXXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9noGree; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9noGree"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e862eso14336867b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731625650; x=1732230450; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVuzS7YJqN+s4J7S8KkTY7fYBB6a47H7Bb0wygpO12c=;
        b=O9noGreeQrUw+HN9GJDABfpsJxOgJrHoPxP/ckJLU1jxj6hOC63zPjqM3q/7Ap+MiX
         chC5aWlnSuDANblQtiy0RH3JHcPOtmaLsEUPgH/PKkMB4uSCIe6LHGvzwFxAkkiUpK6f
         xfFSt8otyXW1lGb3Ku+9X4nEDsCB34ZFJdgI4UV1wVV0HBmCDWmV2fMRN9sEXDs/+5GE
         Z7hEJLWcKfejZE5sdoDisQ/7qb8RMq70l2v1jHjiAVis8S/1cDgNABIGMh2QotQZ+C5o
         Wi3V/RVOw8XCTpq2MIu5KbXyKgAeeOfgC3K+t7PAiPF0bqpj1h5YNJ0l+Ibk5JeozoHv
         fAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625650; x=1732230450;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVuzS7YJqN+s4J7S8KkTY7fYBB6a47H7Bb0wygpO12c=;
        b=TcYrgBm1QW2ISB2OnJOPmlc4DH95JZZDuFo/xclu4OfHxmLhB7huurgf50Z3QiAg6D
         d2kshkAlSiwrhfOqt9qUJ/RQ4K9Z2EmmYAfYYUl7Pq4GgHGMYcqajIL+701mZYqvjHeW
         aYZHcq53XS7yRcmhfu6Oxq+q8jISlpK3qvPgydihHwnN82F867KEhw1RP9CeH+/del9O
         ly0RIxkPwhsGQhkaR0btzVphS04QbgCMuVqbJDpeXuTAU90qWz+cwZYP/UN2pc4bVmj7
         5r7l2r76abCyNSF9JYwAo5HMDRpuaFRBzfGB3mXgJV2QlOWt/4hK/L5S588ZLFq6eqci
         pAlg==
X-Forwarded-Encrypted: i=1; AJvYcCXwPohKyEkvP4QHQ3i8Tlr42c75ljxRsqk/MWTwJBOmc+hGRWbQwhQoZagRfj3AdhjjdFIbfRCT9ZxjPknDH+WW@vger.kernel.org
X-Gm-Message-State: AOJu0YxJcHbZHcy66ow+rh9YrtE3OErA+je7vrzAEEcIx3qKlp6dafvz
	BWjyTQYzza7s/igcZ9NUD7DkzW6hg2q2iwToBMsWtXz98CdWspn8UVh7knPnDGLAedKU49uHbGs
	M5gfZPg==
X-Google-Smtp-Source: AGHT+IFb9RpEJSri/jcDuTntZilE5runTdMWKIlRz1CGZ9It41OwwGqQKjZdre9qJ3utbEntStgk+ArT4Jpr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7595:be86:b969:ac41])
 (user=irogers job=sendgmr) by 2002:a05:690c:8203:b0:6e2:ac0a:8982 with SMTP
 id 00721157ae682-6ee3c331f57mr386767b3.0.1731625650368; Thu, 14 Nov 2024
 15:07:30 -0800 (PST)
Date: Thu, 14 Nov 2024 15:07:13 -0800
In-Reply-To: <20241114230713.330701-1-irogers@google.com>
Message-Id: <20241114230713.330701-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114230713.330701-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 3/3] perf annotate: Prefer passing evsel to evsel->core.idx
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

An evsel idx may not be stable due to sorting, evlist removal,
etc. Try to reduce it being part of APIs by explicitly passing the
evsel in annotate code. Internally the code just reads evsel->core.idx
so behavior is unchanged.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c          |  4 ++--
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/util/annotate.c        | 32 +++++++++++++++----------------
 tools/perf/util/annotate.h        | 20 ++++++++++---------
 4 files changed, 29 insertions(+), 29 deletions(-)

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
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b1d98da79be8..9bd3f472a525 100644
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
index 8b9e05a1932f..2458e99abc18 100644
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
 
@@ -367,21 +367,23 @@ static inline u8 annotation__br_cntr_width(void)
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
@@ -442,8 +444,8 @@ enum symbol_disassemble_errno {
 int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen);
 
 int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel);
-void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
-void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
+void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel);
+void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel);
 void annotated_source__purge(struct annotated_source *as);
 
 int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
-- 
2.47.0.338.g60cca15819-goog

