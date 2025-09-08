Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323B21B199;
	Mon,  8 Sep 2025 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757311857; cv=none; b=HPulRo2/YemvzqAZkw3WtcrX3l0ItWd0QZENgQhZrNpDwT+T3O56XlRTllzSzjF5PzS9OprlYoUm0xcM5HTQbus/PdlifbR35gsg9FC/YVIqFK+65/lxMElyF0JU9ouSJVZjrxoP8CPqfm4aAM7/9sJ4/6K0vibNvpCZb1xlEns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757311857; c=relaxed/simple;
	bh=1thZV2Pc+/rIuED2jhR46ago4P89vFREkt1lyC2P3H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUyUgqx2b9e1wRgoZUx0t/3+PZxiGG5GKh62jt/Sc079OCzdUkiyiqgMFlShy8gyLJxfEpGw7HtSp7ihCmGnIQqCj29/3sTxHTIB3AbxhziJDHJGbWwdHA1h0f8Zcl7TbMu4lQQveVOM4SDXjv2P8Q/nCK/cbCjHcQ9mAeeIFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k37D3aRv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k37D3aRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212B0C4CEF5;
	Mon,  8 Sep 2025 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757311856;
	bh=1thZV2Pc+/rIuED2jhR46ago4P89vFREkt1lyC2P3H0=;
	h=From:To:Cc:Subject:Date:From;
	b=k37D3aRv0W8VMmELmNCABEr62RIcgQtIfiAfpPgY1LNceA9QD9j4GZe25zmfe+PJZ
	 7IxB6WzL0A7/II2TG/LfVHVt8wSGHMsPLyZ/aDSRC+fjGYCymbqOlcderFKwQIr4Yf
	 cwAesyiNmSwlOBEj18QXA7G95Jw+1CFZXeWsEFT41d0zkiR2fahBPBF1G7Jq+LB6aV
	 eYEpYhHThdkGChDRM/GnWLxPpyahxvW4Ve89wjsPuSlBbuEGz+KKaIIMhMWlEcW2DW
	 KI6rrwwZVFXkFt8RxWrLBggf1Ebo9PH72t5GjhmPs+O29zSKzhyRsnBw+b9WgNZ72+
	 P5OhGd0ruyG5w==
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
Subject: [PATCH 1/3] perf annotate: Fix signatue of annotate_browser__show()
Date: Sun,  7 Sep 2025 23:10:48 -0700
Message-ID: <20250908061050.27517-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the convention, the first argument should be
annotate_browser instead of ui_brwoser.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index b770a8d4623ef1fb..6fd4c3483c5068ae 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -766,20 +766,21 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 	return __annotate_browser__search_reverse(browser);
 }
 
-static int annotate_browser__show(struct ui_browser *browser, char *title, const char *help)
+static int annotate_browser__show(struct annotate_browser *browser, char *title, const char *help)
 {
-	struct map_symbol *ms = browser->priv;
+	struct ui_browser *b = &browser->b;
+	struct map_symbol *ms = b->priv;
 	struct symbol *sym = ms->sym;
 	char symbol_dso[SYM_TITLE_MAX_SIZE];
 
-	if (ui_browser__show(browser, title, help) < 0)
+	if (ui_browser__show(b, title, help) < 0)
 		return -1;
 
 	sym_title(sym, ms->map, symbol_dso, sizeof(symbol_dso), annotate_opts.percent_type);
 
-	ui_browser__gotorc_title(browser, 0, 0);
-	ui_browser__set_color(browser, HE_COLORSET_ROOT);
-	ui_browser__write_nstring(browser, symbol_dso, browser->width + 1);
+	ui_browser__gotorc_title(b, 0, 0);
+	ui_browser__set_color(b, HE_COLORSET_ROOT);
+	ui_browser__write_nstring(b, symbol_dso, b->width + 1);
 	return 0;
 }
 
@@ -858,7 +859,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	int key;
 
 	annotate__scnprintf_title(hists, title, sizeof(title));
-	if (annotate_browser__show(&browser->b, title, help) < 0)
+	if (annotate_browser__show(browser, title, help) < 0)
 		return -1;
 
 	annotate_browser__calc_percent(browser, evsel);
@@ -896,7 +897,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			if (delay_secs != 0) {
 				symbol__annotate_decay_histogram(sym, evsel);
 				annotate__scnprintf_title(hists, title, sizeof(title));
-				annotate_browser__show(&browser->b, title, help);
+				annotate_browser__show(browser, title, help);
 			}
 			continue;
 		case K_TAB:
@@ -947,7 +948,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		case 'r':
 			script_browse(NULL, NULL);
-			annotate_browser__show(&browser->b, title, help);
+			annotate_browser__show(browser, title, help);
 			continue;
 		case 'k':
 			annotate_opts.show_linenr = !annotate_opts.show_linenr;
@@ -962,7 +963,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			if (annotate_browser__toggle_source(browser, evsel))
 				ui_helpline__puts(help);
 			annotate__scnprintf_title(hists, title, sizeof(title));
-			annotate_browser__show(&browser->b, title, help);
+			annotate_browser__show(browser, title, help);
 			continue;
 		case 'o':
 			annotate_opts.use_offset = !annotate_opts.use_offset;
@@ -1050,7 +1051,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		case 'b':
 			switch_percent_type(&annotate_opts, key == 'b');
 			annotate__scnprintf_title(hists, title, sizeof(title));
-			annotate_browser__show(&browser->b, title, help);
+			annotate_browser__show(browser, title, help);
 			continue;
 		case 'B':
 			if (br_cntr_text)
@@ -1071,7 +1072,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				browser->type_hash = hashmap__new(type_hash, type_equal,
 								  /*ctx=*/NULL);
 			}
-			annotate_browser__show(&browser->b, title, help);
+			annotate_browser__show(browser, title, help);
 			annotate_browser__debuginfo_warning(browser);
 			continue;
 		case K_LEFT:
-- 
2.51.0

