Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9B15ECD7;
	Sat, 16 Aug 2025 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314206; cv=none; b=avHmSwUpYznRppp7zPd5uko/f5lGGM2zNV0hVOwztm42xSXhHOO8P3RwFoZZQ1on0uy8+Pxo9Oo6VMMg9KY7hf6WOevY9nTpewBAHRK83ercY+kgmjlRXZWEigCIIXDi5su7HiUoPQoxUnNmx2e23FG+wSSuSujhNuwaf3r6fmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314206; c=relaxed/simple;
	bh=8viBihXr7IdSkuQAI4GVNdT91S4WOOZlsIbBjgSb8IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKlL2iA+bmEbPlv1osl0+idJjRUrSQiQWF2diaRd0XVilRI7p+0SvxA0sywdcxCmRsKUrhYwD8Iz+6nwsRbY3syzcHq9t9dGSSuNckiR30aioXwx3xmvdCXlsYS3nDa4NFpRnTCFQfZVD7buaA2FD6nP+jkv9uZtT8tSQTX8Zlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DghwMxa9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DghwMxa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60915C4CEF4;
	Sat, 16 Aug 2025 03:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314205;
	bh=8viBihXr7IdSkuQAI4GVNdT91S4WOOZlsIbBjgSb8IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DghwMxa9HOLeFuGGQAenP0f+oONpwyWX7LWpZyQ191gi6K8h7qf/YtrROApUPnSfx
	 wrPejDrghsj5iwhfKe4s8teMRSL/jxjCZU2zz4P+acYi0ss2fh51q6fT72IanknUHb
	 b3fX3ULCoPVFkZJfFr8P+UVdkzh8wTUqERe6lRbxrD9sKq53YheeGU0+I1QZzrLmGe
	 hMAqD6DlMJl0XtMoTMDJdGdXJElEMeNMnm5iu/PY44YJwsXcnlDMLc4NZZCMsLcb6T
	 zIEB494WmDX2Eax/5Bigg/k5eXpbWluVAOuTtf/+DFYVlO68Or/O4hhIj1MWrgCsks
	 yw7wx+btpN+5A==
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
Subject: [PATCH v5 01/12] perf annotate: Rename to __hist_entry__tui_annotate()
Date: Fri, 15 Aug 2025 20:16:24 -0700
Message-ID: <20250816031635.25318-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816031635.25318-1-namhyung@kernel.org>
References: <20250816031635.25318-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 40 +++++++++++++++++++++++--------
 tools/perf/ui/browsers/hists.c    |  2 +-
 tools/perf/util/annotate.h        | 12 ----------
 tools/perf/util/hist.h            | 12 ++++++----
 4 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 183902dac042ecb0..4d5cbb86cbb6d506 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -12,6 +12,7 @@
 #include "../../util/symbol.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
+#include "../../util/thread.h"
 #include <inttypes.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -27,10 +28,18 @@ struct annotate_browser {
 	struct rb_node		   *curr_hot;
 	struct annotation_line	   *selection;
 	struct arch		   *arch;
+	/*
+	 * perf top can delete hist_entry anytime.  Callers should make sure
+	 * its lifetime.
+	 */
+	struct hist_entry	   *he;
 	bool			    searching_backwards;
 	char			    search_bf[128];
 };
 
+/* A copy of target hist_entry for perf top. */
+static struct hist_entry annotate_he;
+
 static inline struct annotation *browser__annotation(struct ui_browser *browser)
 {
 	struct map_symbol *ms = browser->priv;
@@ -557,7 +566,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	annotation__unlock(notes);
-	symbol__tui_annotate(&target_ms, evsel, hbt);
+	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
 	sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
 	ui_browser__show_title(&browser->b, title);
 	return true;
@@ -1032,12 +1041,6 @@ static int annotate_browser__run(struct annotate_browser *browser,
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
@@ -1046,11 +1049,12 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
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
@@ -1064,6 +1068,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 			.priv	 = ms,
 			.use_navkeypressed = true,
 		},
+		.he = he,
 	};
 	struct dso *dso;
 	int ret = -1, err;
@@ -1093,6 +1098,16 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 		}
 	}
 
+	/* Copy necessary information when it's called from perf top */
+	if (hbt != NULL && he != &annotate_he) {
+		annotate_he.hists = he->hists;
+		annotate_he.thread = thread__get(he->thread);
+		annotate_he.cpumode = he->cpumode;
+		map_symbol__copy(&annotate_he.ms, ms);
+
+		browser.he = &annotate_he;
+	}
+
 	ui_helpline__push("Press ESC to exit");
 
 	browser.b.width = notes->src->widths.max_line_len;
@@ -1108,5 +1123,10 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (not_annotated && !notes->src->tried_source)
 		annotated_source__purge(notes->src);
 
+	if (hbt != NULL && he != &annotate_he) {
+		thread__zput(annotate_he.thread);
+		map_symbol__exit(&annotate_he.ms);
+	}
+
 	return ret;
 }
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

