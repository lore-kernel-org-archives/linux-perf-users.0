Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC62248F74;
	Fri, 25 Jul 2025 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472282; cv=none; b=Qng3DiiUUcW9azUoiQxOQ0FqG9QyHpO81ernGJVLpLNUh6GkFJo+7SOpLMsW1P+dnDpKyUsQ1n0ROBgQDefU7B70H04YNvrdoKXg3/D0ntZPJGrn5PdMA5D7Eg/siZqLKx8UpYatfJwUWq9vKQkV5un4Ws1YOXO/WnCAKPNVVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472282; c=relaxed/simple;
	bh=1oEn/noJpop/kPy31O4iVBmwGzWGx3I0ATp1Neb7mZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxTJ2N/GPM8bHptw8x13Vq8gvSSLkThI03rh0/STKjqTyPhKOvIJX2tuuVf406WFvx1PjojupJlCydAoI4i9+g7ZXWphWaDBKpKaYSSCvJUXpSTcZ0eyD7T51uF9cUBAt9nFKkk/gEXSW/P7gZeozs8ohgSaGTeXIlYeb6dvbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Opj1V112; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Opj1V112"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19BFC4CEF4;
	Fri, 25 Jul 2025 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472282;
	bh=1oEn/noJpop/kPy31O4iVBmwGzWGx3I0ATp1Neb7mZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Opj1V1128nLYLEi95UyBThmmO7ziS3crsacmIwJbNjj1+O7p8RBBhTbq4hZ8f/q+l
	 Joy15bqitC7Ag3r/IRzPxUJZ2K5bME9Y0W4Fy07kvmP72xPDH+s+LucKYKxJYRylxm
	 QmWVB87755UPOdZ/tG8oafE6UIq6SybXfxe9otyXh/Gh75kNFyerCmrKhur0yI2EZN
	 eaKScNcpbaxiz1U2iQg4ucGrb9zjCWxxXykWwQYyFw+APeoCK++zEYnxtqfQA4rEYU
	 Ga2s5+VKF1kmhlBM6nydtClkrFM7e5Lr7tVYJ1njbqcg9dFKa7LVbKdvwx5d5YzcnV
	 m3OYZBEaG3itA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v4 1/9] perf annotate: Rename to __hist_entry__tui_annotate()
Date: Fri, 25 Jul 2025 12:37:47 -0700
Message-ID: <20250725193755.12276-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250725193755.12276-1-namhyung@kernel.org>
References: <20250725193755.12276-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three different but similar functions for annotation on TUI.
Rename it to __hist_entry__tui_annotate() and make sure it passes 'he'.
It's not used for now but it'll be needed for later use.

Also remove map_symbol__tui_annotate() which was a simple wrapper.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 17 +++++++----------
 tools/perf/ui/browsers/hists.c    |  2 +-
 tools/perf/util/annotate.h        | 12 ------------
 tools/perf/util/hist.h            | 12 +++++++-----
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 183902dac042ecb0..28ef146f29e8e742 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -27,6 +27,7 @@ struct annotate_browser {
 	struct rb_node		   *curr_hot;
 	struct annotation_line	   *selection;
 	struct arch		   *arch;
+	struct hist_entry	   *he;
 	bool			    searching_backwards;
 	char			    search_bf[128];
 };
@@ -557,7 +558,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	annotation__unlock(notes);
-	symbol__tui_annotate(&target_ms, evsel, hbt);
+	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
 	sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
 	ui_browser__show_title(&browser->b, title);
 	return true;
@@ -1032,12 +1033,6 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	return key;
 }
 
-int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
-			     struct hist_browser_timer *hbt)
-{
-	return symbol__tui_annotate(ms, evsel, hbt);
-}
-
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
 			     struct hist_browser_timer *hbt)
 {
@@ -1046,11 +1041,12 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
 	SLang_init_tty(0, 0, 0);
 	SLtty_set_suspend_state(true);
 
-	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
+	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
 }
 
-int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
-			 struct hist_browser_timer *hbt)
+int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
+			       struct evsel *evsel,
+			       struct hist_browser_timer *hbt)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
@@ -1064,6 +1060,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 			.priv	 = ms,
 			.use_navkeypressed = true,
 		},
+		.he = he,
 	};
 	struct dso *dso;
 	int ret = -1, err;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d9d3fb44477ac6d5..487c0b08c0038710 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2484,8 +2484,8 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	else
 		evsel = hists_to_evsel(browser->hists);
 
-	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt);
 	he = hist_browser__selected_entry(browser);
+	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
 	/*
 	 * offer option to annotate the other branch source or target
 	 * (if they exists) when returning from annotate
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 8b5131d257b01e3e..0f640e4871744262 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -471,18 +471,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel);
 int hist_entry__tty_annotate(struct hist_entry *he, struct evsel *evsel);
 int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel);
 
-#ifdef HAVE_SLANG_SUPPORT
-int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
-			 struct hist_browser_timer *hbt);
-#else
-static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
-				struct evsel *evsel  __maybe_unused,
-				struct hist_browser_timer *hbt __maybe_unused)
-{
-	return 0;
-}
-#endif
-
 void annotation_options__init(void);
 void annotation_options__exit(void);
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 70438d03ca9c33b1..c64005278687cb02 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -713,8 +713,9 @@ struct block_hist {
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
 
-int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
-			     struct hist_browser_timer *hbt);
+int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
+			       struct evsel *evsel,
+			       struct hist_browser_timer *hbt);
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
 			     struct hist_browser_timer *hbt);
@@ -742,9 +743,10 @@ int evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
 {
 	return 0;
 }
-static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
-					   struct evsel *evsel __maybe_unused,
-					   struct hist_browser_timer *hbt __maybe_unused)
+static inline int __hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
+					     struct map_symbol *ms __maybe_unused,
+					     struct evsel *evsel __maybe_unused,
+					     struct hist_browser_timer *hbt __maybe_unused)
 {
 	return 0;
 }
-- 
2.50.1

