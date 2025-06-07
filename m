Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8C2192FA;
	Sat,  7 Jun 2025 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749338742; cv=none; b=OqQOSYKcEFk5iJDcd3zNixRNBabPNgxNOplHkRqDKJu8NEqQ18U+pK0+O4qrGmI56ugpC3yW+qdT/my+PXrE7/S0Vx2M/9Qpt6yuSFjkvIMsMOt5u4d9yBNBt2juozLITqlHanLNXnoAFa8blercXv3OW0E6ry4zDvoKzCjZbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749338742; c=relaxed/simple;
	bh=liYp8n1KXK/hxafeALqTC/1jlvCB11uSi6ZO28RNPFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2hVMwjWr8dM9IVKfMShB3MndglCKzUvJ6tAgz6NFPB7Ji9h7MBskSbeR5hVYsAYE3Jjla1thqggFtq1+6L8fHfrLS5HvaxF6e/ZC87LQuNDzYWN7c0MSf+UCwoZSLCgxYkikzWZamnpvlSnQVuNOFvSqbDsl539cpCmrNpGWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSSP2s0w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSSP2s0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751BFC4CEF2;
	Sat,  7 Jun 2025 23:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749338741;
	bh=liYp8n1KXK/hxafeALqTC/1jlvCB11uSi6ZO28RNPFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSSP2s0w7mctp5B0DYIGGlH4L/VI1WY4qVOnQHgksOsv4aEtZpYE9eCeOrgHLLrkp
	 zrDAH4JlMxhF1XKU0nPbaNsYit8jZ1tYFOOXEP41oILbXwfd51wscM2KW/aZqDytyU
	 RLkiQXlGzwsUJ99xuNOfRqnDEQnd+ZLJ4mMRLHDKBFA1bVHfro22BSIibka24jyJb6
	 zjcl3n2C3LWWPhAIEMUQ3fzCU4sS7mDp3/ONpgeQv9pYH2Zm1DxhedkM4lyhDHeb94
	 3TaZ+T0S8RJsU3r66EK4tfNURS4yA7+YhpGibZTvHfqRiPonQkNXTrZuqMsseea6Pa
	 5dcvxWnfkF6rA==
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
Subject: [PATCH v2 1/7] perf annotate: Rename to __hist_entry__tui_annotate()
Date: Sat,  7 Jun 2025 16:25:34 -0700
Message-ID: <20250607232540.89488-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607232540.89488-1-namhyung@kernel.org>
References: <20250607232540.89488-1-namhyung@kernel.org>
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
index ab776b1ed2d5b4ba..af3e52ce4da62eb9 100644
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
@@ -483,7 +484,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	annotation__unlock(notes);
-	symbol__tui_annotate(&target_ms, evsel, hbt);
+	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
 	sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
 	ui_browser__show_title(&browser->b, title);
 	return true;
@@ -958,12 +959,6 @@ static int annotate_browser__run(struct annotate_browser *browser,
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
@@ -972,11 +967,12 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
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
@@ -990,6 +986,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 			.priv	 = ms,
 			.use_navkeypressed = true,
 		},
+		.he = he,
 	};
 	struct dso *dso;
 	int ret = -1, err;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d26b925e3d7f46af..55455c49faf01891 100644
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
index bbb89b32f398b3c9..9cd723b8b987db1a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -470,18 +470,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel);
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
index c64254088fc77246..11ae738772ca4f61 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -712,8 +712,9 @@ struct block_hist {
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
 
-int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
-			     struct hist_browser_timer *hbt);
+int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
+			       struct evsel *evsel,
+			       struct hist_browser_timer *hbt);
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
 			     struct hist_browser_timer *hbt);
@@ -741,9 +742,10 @@ int evlist__tui_browse_hists(struct evlist *evlist __maybe_unused,
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
2.49.0

