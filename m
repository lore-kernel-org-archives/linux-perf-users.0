Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AC21ADCC;
	Mon, 10 Mar 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646969; cv=none; b=HTYkEpVZz97lNjGAA/g6sswBRgwujA+wUaHbe7Qzsg8qCLgsIGqml7cU/AkRnufVS6ljxkfjMjMtfnw/ZchdvUaqO7uBkxeFAvJ1c80r+9aROkCFWo9Vejet4tBXuZy9i4NMXxAWbKScf58Nu3i3Fpve4QGSERRFtXWwt1F3wcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646969; c=relaxed/simple;
	bh=M3HsrNuURILy6ovhYItEkb433ba3Fj/afsxb5W1iB3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdIFPOkvBy6JsCt2D3bsgGvEJKUOfVmOP+ALzXy2wr4zEwFjVImwYYM0jexhkjVeet3FRIp4kc8WpjQXlQVj05LXVxE2QLyve0nk1Lz3XXGbmG3m971V6zgYHwzKzlVVc6Y6uHZ1+lKMO6nTItnKyabLdefnz95FIEN47WRHRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h95WlioU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h95WlioU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C5BC4CEED;
	Mon, 10 Mar 2025 22:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741646968;
	bh=M3HsrNuURILy6ovhYItEkb433ba3Fj/afsxb5W1iB3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h95WlioUBkwWrUpY/aSqcxMJQvxLhy2CusrjV5V6PgUUSmpxrbM2VhkUOMleLQHPh
	 ox9LsD+0Bb5+HSdCpmUHN7bM9xtNHDK802xd4V3yZZ6jlwoPTmTRwBv8PDRfUXJJaQ
	 HEjGKoxyquwbAbyDKzNx00+kB185zWFFgJxSzRc5IW6QeKNWDquwMm3LEQeljMiknY
	 JVoCeRu5rv9nzvAN03IZJ690rSICJ6gmiVnnsRblzXjLIDJGW+KPu64ZKmNkvtbHnP
	 A/i9SWThXbpX5bMtM1Fk9IuXtq7LTJJhs3DZdwBrN3B2EqJ809M/k+OyHcoz1a64NC
	 EN0VpL0eOmmww==
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
Subject: [PATCH v2 4/7] perf annotate: Pass hist_entry to annotate functions
Date: Mon, 10 Mar 2025 15:49:22 -0700
Message-ID: <20250310224925.799005-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250310224925.799005-1-namhyung@kernel.org>
References: <20250310224925.799005-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
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
index 2c41d3aea46b204b..1061f4eebc3f6414 100644
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
index 30a344afd91a5865..4eda409bfe0ea859 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -456,7 +456,6 @@ enum symbol_disassemble_errno {
 
 int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen);
 
-int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel);
 void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel);
 void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel);
 void annotated_source__purge(struct annotated_source *as);
@@ -465,9 +464,9 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
 
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
2.49.0.rc0.332.g42c0ae87b1-goog

