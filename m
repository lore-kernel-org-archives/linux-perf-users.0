Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36AA2327A3;
	Mon, 13 Oct 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363765; cv=none; b=WruHO0C5Ce++pwV5sG/c+mMd4s9x5ep8MPvfnF95LWgTusWBO6ivvdOEA1sRGYPhSpwht3hQqytJCJZgB666opdMHN9J1Kx5jtIFu11Nu7wtLrSVHyhUV6fhPotfVz2LDO2snN82b/MLU/hhJPYcmLa9FNf3CGnUwRWLIG1wH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363765; c=relaxed/simple;
	bh=NQQQb26G66+hLsFaQm4txM0W98DV26W3zBXUHTnLYKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0oe4KGASBoPd7VcGiTKOMLvog1K9tAAIBk8DkW/xZX7YAPlue3nH18gjN9sMMn5gJmTL40DzJEbu18YvaaiRLsYJMlhvaVIq1HCO0YT6v0arKucXDOYanqVJ//ots54NuLPcMQaDEznH28yQjaxPQbJ/5QLCZDgcavusiUGgcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C198P33o; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C198P33o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760363763; x=1791899763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQQQb26G66+hLsFaQm4txM0W98DV26W3zBXUHTnLYKs=;
  b=C198P33oFSl/PPfSp+66V8lHtDhpU3P2tTdHNl5pRR2dfKtHUk4RHkhD
   7E+hhM85EZR8DNMrbKxSynZ1d4Yv5J2roDzxzjVPOhtk7peiboo07Rqg/
   cml3ay+p+GpartdzogigA9+qnPVqjkr2S2p9SRzxJ3kj43rGJcTBxJcGs
   BYAmjmw7ZXVbX2wqZc7vWIyMZiPXx4+/RHpumTWuvfooKwP3BXbgDJTHF
   lWxv2PgH9S7XKjG8P5OvaU1TT+W1tXgLpR05A1R06nAySmESU3YT+LyCZ
   wTFNIKGFUR6e+QB3qcsJk32KnLtyV/cZJUuXrKStOol2E4nubblMu1bnW
   A==;
X-CSE-ConnectionGUID: 8tsQ5oL7RAaC/95aLH3FUg==
X-CSE-MsgGUID: Pcaf4v7JQlq4mh7vI3T4xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="66156265"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="66156265"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 06:56:03 -0700
X-CSE-ConnectionGUID: pPEiKuRgQp2aJcOr4rHvrg==
X-CSE-MsgGUID: g2aH4JyUSEW8PMpKSCr+VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="181613463"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by orviesa008.jf.intel.com with ESMTP; 13 Oct 2025 06:55:58 -0700
From: Tianyou Li <tianyou.li@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	pan.deng@intel.com,
	zhiguo.zhou@intel.com,
	jiebin.sun@intel.com,
	thomas.falcon@intel.com,
	dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] perf tools c2c: Highlight the contention line in the annotate browser
Date: Mon, 13 Oct 2025 22:48:11 +0800
Message-ID: <20251013144811.2021337-2-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <660c8ba1-635b-4acc-8824-d195f1b133a0@amd.com>
References: <660c8ba1-635b-4acc-8824-d195f1b133a0@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to highlight the contention line in the annotate browser,
use 'TAB'/'UNTAB' to refocus to the contention line.

Signed-off-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
Reviewed-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/builtin-annotate.c     |  2 +-
 tools/perf/builtin-c2c.c          |  6 +++-
 tools/perf/ui/browsers/annotate.c | 48 ++++++++++++++++++++++++++++---
 tools/perf/ui/browsers/hists.c    |  2 +-
 tools/perf/util/hist.h            |  6 ++--
 5 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 646f43b0f7c4..112b15952016 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
 			/* skip missing symbols */
 			nd = rb_next(nd);
 		} else if (use_browser == 1) {
-			key = hist_entry__tui_annotate(he, evsel, NULL);
+			key = hist_entry__tui_annotate(he, evsel, NULL, NO_ADDR);
 
 			switch (key) {
 			case -1:
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a37e886ff3d7..14c3823f8fed 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2604,6 +2604,7 @@ static int perf_c2c__toggle_annotation(struct hist_browser *browser)
 	struct symbol *sym = NULL;
 	struct annotated_source *src = NULL;
 	struct c2c_hist_entry *c2c_he = NULL;
+	u64 al_addr = NO_ADDR;
 
 	if (!perf_c2c__has_annotation(he->hists->hpp_list)) {
 		ui_browser__help_window(&browser->b, "No annotation support");
@@ -2627,8 +2628,11 @@ static int perf_c2c__toggle_annotation(struct hist_browser *browser)
 		return 0;
 	}
 
+	if (he->mem_info)
+		al_addr = mem_info__iaddr(he->mem_info)->al_addr;
+
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
-	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL);
+	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, al_addr);
 }
 
 static void c2c_browser__update_nr_entries(struct hist_browser *hb)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8fe699f98542..112fe6ad112e 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -605,7 +605,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	annotation__unlock(notes);
-	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
+	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_ADDR);
 
 	/*
 	 * The annotate_browser above changed the title with the target function
@@ -852,6 +852,16 @@ static void annotate_browser__debuginfo_warning(struct annotate_browser *browser
 	}
 }
 
+static s64 annotate_browser__curr_hot_offset(struct annotate_browser *browser)
+{
+	struct annotation_line *al = NULL;
+
+	if (browser->curr_hot)
+		al = rb_entry(browser->curr_hot, struct annotation_line, rb_node);
+
+	return al ? al->offset : 0;
+}
+
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct evsel *evsel,
 				 struct hist_browser_timer *hbt)
@@ -873,6 +883,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
 
 	annotate_browser__calc_percent(browser, evsel);
 
+	if (browser->selection != NULL) {
+		browser->curr_hot = &browser->selection->rb_node;
+		browser->b.use_navkeypressed = false;
+	}
+
 	if (browser->curr_hot) {
 		annotate_browser__set_rb_top(browser, browser->curr_hot);
 		browser->b.navkeypressed = false;
@@ -969,8 +984,19 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			nd = browser->curr_hot;
 			break;
 		case 's':
+			struct annotation_line *al = NULL;
+			s64 offset = annotate_browser__curr_hot_offset(browser);
+
 			if (annotate_browser__toggle_source(browser, evsel))
 				ui_helpline__puts(help);
+
+			/* Update the annotation browser's rb_tree, and reset the nd */
+			annotate_browser__calc_percent(browser, evsel);
+			/* Try to find the same asm line as before */
+			al = annotated_source__get_line(notes->src, offset);
+			browser->curr_hot = al ? &al->rb_node : NULL;
+			nd = browser->curr_hot;
+
 			annotate__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(browser, title, help);
 			continue;
@@ -1106,19 +1132,19 @@ static int annotate_browser__run(struct annotate_browser *browser,
 }
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
-			     struct hist_browser_timer *hbt)
+			     struct hist_browser_timer *hbt, u64 al_addr)
 {
 	/* reset abort key so that it can get Ctrl-C as a key */
 	SLang_reset_tty();
 	SLang_init_tty(0, 0, 0);
 	SLtty_set_suspend_state(true);
 
-	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
+	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt, al_addr);
 }
 
 int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			       struct evsel *evsel,
-			       struct hist_browser_timer *hbt)
+			       struct hist_browser_timer *hbt, u64 al_addr)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
@@ -1188,6 +1214,20 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	if (annotate_opts.hide_src_code)
 		ui_browser__init_asm_mode(&browser.b);
 
+	/*
+	 * If al_addr is set, it means that there should be a line
+	 * intentionally selected, not based on the percentages
+	 * which caculated by the event sampling. In this case, we
+	 * convey this information into the browser selection, where
+	 * the selection in other cases should be empty.
+	 */
+	if (al_addr != NO_ADDR) {
+		struct annotation_line *al = annotated_source__get_line(notes->src,
+			al_addr - sym->start);
+
+		browser.selection = al;
+	}
+
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
 	debuginfo__delete(browser.dbg);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 487c0b08c003..08fecbe28a52 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 		evsel = hists_to_evsel(browser->hists);
 
 	he = hist_browser__selected_entry(browser);
-	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
+	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_ADDR);
 	/*
 	 * offer option to annotate the other branch source or target
 	 * (if they exists) when returning from annotate
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c64005278687..6795816eee85 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -713,12 +713,14 @@ struct block_hist {
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
 
+#define NO_ADDR 0
+
 int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			       struct evsel *evsel,
-			       struct hist_browser_timer *hbt);
+			       struct hist_browser_timer *hbt, u64 al_addr);
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt, u64 al_addr);
 
 int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
 			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
-- 
2.47.1

