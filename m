Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD1275B18;
	Fri, 10 Oct 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082014; cv=none; b=KMaNfC3v5l/U2VAJ3SGJ7eSCfgNRJ0W57hE1Vp7X9ICQ03SiKVMiYxFOWl89zYQ+Q6s7dRR8V/bp8vkic45KxAyZ2CYhpcjccnU2oTKMv09auUMYsizr5BRLFNaN7Oh0+eCfLxb5n810PiMlYdVXmapEi8aG8K87S42TpolB+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082014; c=relaxed/simple;
	bh=dcWzwCdPQaT7WWNvDAARccriDzRzjEvBcrFIeOdQ2pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBPMHgVDGdjizTP7bYK13/c7kFzjTNkdhvv4r/fFhmbgEs65XnkqmLAoak3UuS3CkmvqmadHeHF2n52d1JQ2BVusH3VVvRsJlMznbp48L2e1wH6vQFUuyZG/85GSVfpYUNVTr70qL6LXhbtWhrhW1BF/D1hxeQTXDCkNAPX+m50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnibHJSt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnibHJSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760082013; x=1791618013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dcWzwCdPQaT7WWNvDAARccriDzRzjEvBcrFIeOdQ2pc=;
  b=FnibHJStrj+kSVXXsa+CxqWy/QmoMMIZzpEMBCTIgZOeCgqU6FeVvvzU
   +X39mHvuoOpkJ4mBQdG9MCCPfYIKtBUxEkMTNI6ue7e5RbYHnkWe7wkjV
   qqdacqnWMVMvfR2+FvyABGWw9ilpQ4K7FMiGtgTJaGMzrCTK2kVNSeAzb
   CSWbWYlmWh87ePkudqWLv4COyNlCIdfEISDRLsNWJcFgUcHOKhMA4YkB8
   dT9zhMaobmgJGTCVC9Ap7yeo3OwffsbNMhQzPgl86Ze508/lSqBakjUyo
   ihHASAf8RK+M6yvDfeceNp0Mxrobj6gPZLDp+1EPwoOC0cBK/+cANwPMn
   g==;
X-CSE-ConnectionGUID: lrjHjEdJR6GtVOh6AMdd4A==
X-CSE-MsgGUID: SMUktMMUTGSuAJznVMmpxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79942315"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="79942315"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:40:12 -0700
X-CSE-ConnectionGUID: vkCOl+EFRSeLkwQbWcmvDg==
X-CSE-MsgGUID: +Ui8a5CgRRyYITxewOJ7TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180502362"
Received: from linux-pnp-server-27.sh.intel.com ([10.239.147.41])
  by orviesa009.jf.intel.com with ESMTP; 10 Oct 2025 00:40:07 -0700
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
Subject: [PATCH v6 3/3] perf tools c2c: Highlight the contention line in the annotate browser
Date: Fri, 10 Oct 2025 16:33:13 +0800
Message-ID: <20251010083313.1839179-3-tianyou.li@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aOTOEcNOiUiEJ9tz@google.com>
References: <aOTOEcNOiUiEJ9tz@google.com>
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
---
 tools/perf/builtin-annotate.c     |  2 +-
 tools/perf/builtin-c2c.c          |  6 +++-
 tools/perf/ui/browsers/annotate.c | 52 ++++++++++++++++++++++++++++---
 tools/perf/ui/browsers/hists.c    |  2 +-
 tools/perf/util/hist.h            |  6 ++--
 5 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 646f43b0f7c4..d89796648bec 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
 			/* skip missing symbols */
 			nd = rb_next(nd);
 		} else if (use_browser == 1) {
-			key = hist_entry__tui_annotate(he, evsel, NULL);
+			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_AL_ADDR);
 
 			switch (key) {
 			case -1:
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 878913115b45..7ee3c8a3f66c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2586,6 +2586,7 @@ static int perf_c2c__toggle_annotation(struct hist_browser *browser)
 	struct symbol *sym = NULL;
 	struct annotated_source *src = NULL;
 	struct c2c_hist_entry *c2c_he = NULL;
+	u64 al_addr = NO_INITIAL_AL_ADDR;
 
 	if (!perf_c2c__has_annotation(he->hists->hpp_list)) {
 		ui_browser__help_window(&browser->b, "No annotation support");
@@ -2609,8 +2610,11 @@ static int perf_c2c__toggle_annotation(struct hist_browser *browser)
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
index 32da310b3b62..1de9bb88c379 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -300,6 +300,13 @@ static void disasm_rb_tree__insert(struct annotate_browser *browser,
 	rb_insert_color(&al->rb_node, root);
 }
 
+static void disasm_rb_tree__insert_if_empty(struct annotate_browser *browser,
+				struct annotation_line *al)
+{
+	if (rb_first(&browser->entries) == NULL)
+		disasm_rb_tree__insert(browser, al);
+}
+
 static void annotate_browser__set_top(struct annotate_browser *browser,
 				      struct annotation_line *pos, u32 idx)
 {
@@ -396,6 +403,22 @@ static struct annotation_line *annotate_browser__find_new_asm_line(
 	return NULL;
 }
 
+static struct annotation_line *annotate_browser__find_al_addr(struct annotate_browser *browser,
+						     u64 al_addr)
+{
+	struct symbol *sym = browser->he->ms.sym;
+	struct list_head *head = browser->b.entries;
+	struct annotation_line *al;
+
+	/* find an annotation line in the new list with the same al_addr */
+	list_for_each_entry(al, head, node) {
+		if (sym->start + al->offset == al_addr)
+			return al;
+	}
+	/* There are no asm lines */
+	return NULL;
+}
+
 static struct annotation_line *annotate_browser__find_next_asm_line(
 					struct annotate_browser *browser,
 					struct annotation_line *al)
@@ -605,7 +628,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
 	annotation__unlock(notes);
-	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
+	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_AL_ADDR);
 
 	/*
 	 * The annotate_browser above changed the title with the target function
@@ -897,6 +920,12 @@ static int annotate_browser__run(struct annotate_browser *browser,
 
 	annotate_browser__calc_percent(browser, evsel);
 
+	if (browser->curr_hot == NULL && browser->selection != NULL) {
+		disasm_rb_tree__insert_if_empty(browser, browser->selection);
+		browser->curr_hot = rb_first(&browser->entries);
+		browser->b.use_navkeypressed = false;
+	}
+
 	if (browser->curr_hot) {
 		annotate_browser__set_rb_top(browser, browser->curr_hot);
 		browser->b.navkeypressed = false;
@@ -1003,6 +1032,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 				nd = annotate_browser__rb_node_by_idx_asm(browser, idx_asm_nd);
 				browser->curr_hot = annotate_browser__rb_node_by_idx_asm(browser,
 							idx_asm_curr_hot);
+				disasm_rb_tree__insert_if_empty(browser,
+					rb_entry(nd, struct annotation_line, rb_node));
 			}
 			annotate__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(browser, title, help);
@@ -1139,19 +1170,19 @@ static int annotate_browser__run(struct annotate_browser *browser,
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
@@ -1221,6 +1252,19 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	if (annotate_opts.hide_src_code)
 		ui_browser__init_asm_mode(&browser.b);
 
+	/*
+	 * If al_addr is set, it means that there should be a line
+	 * intentionally selected, not based on the percentages
+	 * which caculated by the event sampling. In this case, we
+	 * convey this information into the browser selection, where
+	 * the selection in other cases should be empty.
+	 */
+	if (al_addr != NO_INITIAL_AL_ADDR) {
+		struct annotation_line *al = annotate_browser__find_al_addr(&browser, al_addr);
+
+		browser.selection = al;
+	}
+
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
 	debuginfo__delete(browser.dbg);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 487c0b08c003..c34ddc4ca13f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 		evsel = hists_to_evsel(browser->hists);
 
 	he = hist_browser__selected_entry(browser);
-	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
+	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_INITIAL_AL_ADDR);
 	/*
 	 * offer option to annotate the other branch source or target
 	 * (if they exists) when returning from annotate
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c64005278687..9542cf43bd2a 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -713,12 +713,14 @@ struct block_hist {
 #include "../ui/keysyms.h"
 void attr_to_script(char *buf, struct perf_event_attr *attr);
 
+#define NO_INITIAL_AL_ADDR 0
+
 int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 			       struct evsel *evsel,
-			       struct hist_browser_timer *hbt);
+			       struct hist_browser_timer *hbt, u64 al_addr);
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt, u64 ad_addr);
 
 int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
 			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
-- 
2.47.1

