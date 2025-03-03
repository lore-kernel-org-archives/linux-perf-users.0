Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F423642B;
	Mon,  3 Mar 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023490; cv=none; b=gmA1pIbHpSsgIFfjsshALEFWlVxwlT8VrHVPqmuSgPQTPSqM3/5YGQ+XMwiXqG0XFES/47KSgzla1e0P51XBO/H0P1hwwBS0/J35OurhhpuiY0FkhPknZRaTqOqaDSfT8GuRx6oadlOXmefIRlncG8cqIy3GYaNnKB7o6szohmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023490; c=relaxed/simple;
	bh=rEbIym+iIuWU2V96v1iq1VdffvNBW+fmK+sk80Yhyj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exzzHQBULBZnD8hz3bgOGRm8MInjZCfRIZkHjOkhmrSuqFqo/CCmIfUrvGCoxuo3M5zCPvY/YUtzJlEB8+6bKtFjkEsdSw5gLSuiyizZDoeHSJKrKDwTxi7rjG4chxCbNT4h7vVBS7zJS9qHHDJyQiwGM/BbF6kSc23FRFZeKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNgDaZtj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNgDaZtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1F1C4CEEB;
	Mon,  3 Mar 2025 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023490;
	bh=rEbIym+iIuWU2V96v1iq1VdffvNBW+fmK+sk80Yhyj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNgDaZtj0AcPTVP3P37yOdCwUYc0FHHecKZ51VKrsAhtulLU92WQYxpEwcnv4Kh8s
	 9EyjoVgRIFpHgYNYxY2FEtuC6ATJ5QC6xFiIo5BK6f6eoCHF4GaTay4j3I6UrhcLGR
	 3jYs+np72d/wYgpGRKQfnFiZ5xa6wIMdgUd2antbaxr7w3+VkHFpXjNi+J3I8fnH0B
	 zupZXYckSnasNycFzsspzLeYiDgDsK4439/gyznfnnxNDWv9mwvBg/P9D1a54FB6OB
	 0z9o6WMqNorNtIGbHcAc18VcHZfMcOWKSZMDdajAj3+U/vnhSRQbwFzg2x4zeULnzb
	 ztgaCzvQag5rw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 4/7] perf annotate: Pass hist_entry to annotate functions
Date: Mon,  3 Mar 2025 09:38:04 -0800
Message-ID: <20250303173807.1765098-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303173807.1765098-1-namhyung@kernel.org>
References: <20250303173807.1765098-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a prepartion to support code annotation and data type
annotation at the same time.  Data type annotation needs more
information in the hist_entry so it needs to be passed deeper.

Also rename a function with the same name in the builtin-annotate.c
to hist_entry__stdio_annotate since it matches better to the command
line option.  And change the condition inside to be simpler.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 tools/perf/builtin-top.c      |  2 +-
 tools/perf/util/annotate.c    | 11 +++++++----
 tools/perf/util/annotate.h    |  7 +++----
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 836ae0122dabd0ea..966950c38306d6ea 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -321,14 +321,14 @@ static int process_feature_event(struct perf_session *session,
 	return 0;
 }
 
-static int hist_entry__tty_annotate(struct hist_entry *he,
+static int hist_entry__stdio_annotate(struct hist_entry *he,
 				    struct evsel *evsel,
 				    struct perf_annotate *ann)
 {
-	if (!ann->use_stdio2)
-		return symbol__tty_annotate(&he->ms, evsel);
+	if (ann->use_stdio2)
+		return hist_entry__tty_annotate2(he, evsel);
 
-	return symbol__tty_annotate2(&he->ms, evsel);
+	return hist_entry__tty_annotate(he, evsel);
 }
 
 static void print_annotate_data_stat(struct annotated_data_stat *s)
@@ -541,7 +541,7 @@ static void hists__find_annotations(struct hists *hists,
 			if (next != NULL)
 				nd = next;
 		} else {
-			hist_entry__tty_annotate(he, evsel, ann);
+			hist_entry__stdio_annotate(he, evsel, ann);
 			nd = rb_next(nd);
 		}
 	}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e1115b8317a0fe3d..7395fdef718d432d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -263,7 +263,7 @@ static void perf_top__show_details(struct perf_top *top)
 	printf("Showing %s for %s\n", evsel__name(top->sym_evsel), symbol->name);
 	printf("  Events  Pcnt (>=%d%%)\n", annotate_opts.min_pcnt);
 
-	more = symbol__annotate_printf(&he->ms, top->sym_evsel);
+	more = hist_entry__annotate_printf(he, top->sym_evsel);
 
 	if (top->evlist->enabled) {
 		if (top->zero)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 469fcc945126f4f7..029e47a521caf1af 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1174,8 +1174,9 @@ static int annotated_source__addr_fmt_width(struct list_head *lines, u64 start)
 	return 0;
 }
 
-int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
+int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 {
+	struct map_symbol *ms = &he->ms;
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
 	struct dso *dso = map__dso(map);
@@ -1600,8 +1601,9 @@ static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root)
 	annotation__calc_lines(notes, ms, root);
 }
 
-int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel)
+int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel)
 {
+	struct map_symbol *ms = &he->ms;
 	struct dso *dso = map__dso(ms->map);
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
@@ -1635,8 +1637,9 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel)
 	return 0;
 }
 
-int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel)
+int hist_entry__tty_annotate(struct hist_entry *he, struct evsel *evsel)
 {
+	struct map_symbol *ms = &he->ms;
 	struct dso *dso = map__dso(ms->map);
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
@@ -1660,7 +1663,7 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel)
 		print_summary(&source_line, dso__long_name(dso));
 	}
 
-	symbol__annotate_printf(ms, evsel);
+	hist_entry__annotate_printf(he, evsel);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 98db1b88daf43e13..4fba7cde4968db74 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -455,7 +455,6 @@ enum symbol_disassemble_errno {
 
 int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen);
 
-int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel);
 void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel);
 void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel);
 void annotated_source__purge(struct annotated_source *as);
@@ -464,9 +463,9 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
 
 bool ui__has_annotation(void);
 
-int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel);
-
-int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel);
+int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel);
+int hist_entry__tty_annotate(struct hist_entry *he, struct evsel *evsel);
+int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel);
 
 #ifdef HAVE_SLANG_SUPPORT
 int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
-- 
2.48.1.711.g2feabab25a-goog

