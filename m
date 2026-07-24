Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B63F8248;
	Fri, 24 Jul 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886756; cv=none; b=N/3jGSeKZ0Q5zJ6EZ1QXSeyuqjVnzwQ6JXHjB/SeVS0kITL2AyQDx7yTD0AbiFnJ8AdCERnAmIQxB/1I/ozPDN0HRYSo9cZODC/BcpJCJmT9lm/VeSzKQWDEn/7Xmm+ifkXJ5A2xE7odpD2FjR0CZWA8KEKOSrsoG+LXpvkz8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886756; c=relaxed/simple;
	bh=aVr1jbZLBlxYPBAEW0MZeDEQwl7T+0VvTdqCh30dOEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLjxOLgJBbMa5RE8YcFhkA0FD3winBuKapE9wLcl8D8P2M30xO/bCChSnHLTdv/Xs9nOFUrCGfP796j1rgsyK/OupawAKvXuVu2CnWIZSzS+jND6nHChWaz92U1yVj78xBwQhzHmo/uwpQateFXcLNYQEIW9Mb1WSgiOm3K9Y4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g11S+5Bo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g11S+5Bo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784886756; x=1816422756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aVr1jbZLBlxYPBAEW0MZeDEQwl7T+0VvTdqCh30dOEY=;
  b=g11S+5BoUb3rJal1jVUVlFzZnPELzS+/Zl8HaylVRvU8l5UEe6uPqnVa
   438DiZq8i4CDhbAUZs7+WvHGopojEyjrhq8boFuu9pEIggvJ2E4WAVnon
   U1QJRV2Ei/Fz7pC+pMVI7vcOil7ruLCaZY8muI92qXRnwy0pGLkOGIZy+
   KJag/KNr92TXzm0TeQV+WoqkCmWj9J8Y5yCu3gSxJ4NnNJzyoY28rBIZP
   XyPCQzpNrLgaprQ6uUeHn1vl5U1LwAsiN58iXHOSvkpbuXtu56eOjLA0G
   tLDR6Ekmz1Oba7GTn036iioPcOv2Ht9xTYmUxtjtDe4sklkRdYNZk8sVA
   A==;
X-CSE-ConnectionGUID: 6mCG/hwVRjKaiB5Kc8VPbQ==
X-CSE-MsgGUID: LREmuT8/Qdegd3RhN18O6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95907656"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="95907656"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 02:52:35 -0700
X-CSE-ConnectionGUID: 878LD6W1TImov2QnN4ISnQ==
X-CSE-MsgGUID: Skf7mjZMS5Wlsh8PWy7i+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="256018496"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jul 2026 02:52:30 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v4 8/9] perf c2c: add function view browser UI and cacheline detail
Date: Fri, 24 Jul 2026 17:58:41 +0800
Message-ID: <20260724095842.995920-9-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724095842.995920-1-jiebin.sun@intel.com>
References: <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260724095842.995920-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the browser front end: create/run/delete the hist_browser, the title,
and the 'd' shortcut that opens the existing per-cacheline detail view for
the selected entry. Wire the builder into perf_c2c__browse_function_view()
and refuse to run under report_hierarchy, whose hist_entry__delete()
recursion would put the children's borrowed references.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
---
 tools/perf/ui/browsers/c2c-function.c | 211 +++++++++++++++++++++++++-
 1 file changed, 207 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index bb7f967ab904..46b3ff854833 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -40,7 +40,6 @@
 #include "../../c2c.h"
 #include "hists.h"
 
-
 struct perf_c2c_ext {
 	struct c2c_hists	function_hists;
 	/* Cached across all level-1 entries; 0 means "not yet computed". */
@@ -95,6 +94,10 @@ static inline u64 hist_entry__iaddr(struct hist_entry *he)
 	return he->ip;
 }
 
+/*
+ * Hierarchy levels (by depth): L1 = read-side function, L2 = the writing
+ * function it contends with, L3 = the specific shared cacheline.
+ */
 static inline bool hist_entry__is_cacheline(struct hist_entry *he)
 {
 	return he->parent_he && he->parent_he->parent_he;	/* level 3: cacheline */
@@ -694,6 +697,7 @@ c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
 	return function_hpp_list__parse(&c2c_hists->list, output, sort, env);
 }
 
+/* Welford online merge of two "stats" (from util/stat.h) accumulators. */
 static void c2c_stats_merge(struct stats *dest, const struct stats *src)
 {
 	double delta;
@@ -1427,6 +1431,37 @@ static void c2c_function__update_symbol_width(struct hist_entry *he)
 		hists__set_col_len(hists, HISTC_SYMBOL, need);
 }
 
+/*
+ * Count visible entries in @root, descending only through visible, unfolded
+ * parents. Match hists__filter_entries(), which drives generic browser
+ * navigation, so the count cannot include rows the browser skips.
+ */
+static u64
+c2c_function__nr_visible_rows(struct rb_root_cached *root, float min_pcnt)
+{
+	struct rb_node *nd;
+	u64 rows = 0;
+
+	for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
+
+		/*
+		 * The generic refresh folds filtered parents and therefore hides
+		 * their subtree. A percentage-rejected parent is merely skipped;
+		 * if it is unfolded, qualifying descendants are still rendered.
+		 */
+		if (he->filtered)
+			continue;
+
+		if (hist_entry__get_percent_limit(he) >= min_pcnt)
+			rows++;
+		if (he->has_children && he->unfolded)
+			rows += c2c_function__nr_visible_rows(&he->hroot_out,
+							     min_pcnt);
+	}
+	return rows;
+}
+
 /*
  * Prune writers with no stores, drop functions left with no contending
  * writer, sort the survivors by store count, then compute the global total.
@@ -1499,7 +1534,7 @@ static void c2c_function_hists__reset(void)
  *   L2: writing functions contending with each level-1 function
  *   L3: shared cachelines for each function pair
  */
-static int __maybe_unused build_function_view_hierarchy(void)
+static int build_function_view_hierarchy(void)
 {
 	static const char output_fields[] =
 		"cycles_percent,total_stores,symbol_view";
@@ -1579,8 +1614,176 @@ static int __maybe_unused build_function_view_hierarchy(void)
 	return ret;
 }
 
-int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
+static int c2c_function_browser__title(struct hist_browser *browser,
+				       char *bf, size_t size)
 {
-	ui__warning("C2C function view is not implemented yet.\n");
+	scnprintf(bf, size,
+		  "Shared Data Functions Table     (%" PRIu64 " entries, sorted on Cycles %%)",
+		  browser->hists->nr_non_filtered_entries);
 	return 0;
 }
+
+static struct c2c_function_browser *c2c_function_browser__new(struct hists *hists)
+{
+	struct c2c_function_browser *browser;
+
+	if (!hists)
+		return NULL;
+
+	browser = zalloc(sizeof(*browser));
+	if (!browser)
+		return NULL;
+
+	hist_browser__init(&browser->hb, hists);
+
+	browser->hb.title = c2c_function_browser__title;
+	browser->hb.c2c_filter = true;
+	browser->hb.show_headers = true;
+	/* Keep title line count consistent with forcing headers on. */
+	browser->hb.b.extra_title_lines = hists->hpp_list->nr_header_lines;
+	browser->hb.min_pcnt = 0.0;
+
+	/*
+	 * Note: symbol_conf.report_hierarchy is deliberately left unset.
+	 * The generic browser still descends into hroot_out children via
+	 * rb_hierarchy_next()/can_goto_child(), which key off he->unfolded,
+	 * so 'e'/'+' expands L1 -> L2 -> L3 correctly. Setting the flag would
+	 * additionally make hist_entry__delete() recurse hroot_out and free
+	 * each child, but our children borrow thread/ms (see
+	 * c2c_child_entry__alloc()), so that would underflow their refcounts.
+	 * Teardown is handled by c2c_he__free_hierarchy() instead.
+	 */
+	return browser;
+}
+
+/*
+ * c2c_function_browser__delete - Free function browser
+ */
+static void c2c_function_browser__delete(struct c2c_function_browser *browser)
+{
+	free(browser);
+}
+
+static int c2c_function_browser__browse_cacheline_detail(struct hist_entry *he_selection,
+							 struct hists *hists)
+{
+	struct rb_node *nd;
+	u64 cl_addr;
+
+	if (!he_selection || !he_selection->parent_he ||
+	    !he_selection->parent_he->parent_he || !he_selection->mem_info)
+		return -1;
+
+	cl_addr = cl_address(mem_info__daddr(he_selection->mem_info)->addr, chk_double_cl);
+
+	for (nd = rb_first_cached(&hists->entries); nd; nd = rb_next(nd)) {
+		struct hist_entry *he_cl = rb_entry(nd, struct hist_entry, rb_node);
+		u64 this_cl;
+
+		if (!he_cl->mem_info)
+			continue;
+
+		this_cl = cl_address(mem_info__daddr(he_cl->mem_info)->addr, chk_double_cl);
+		if (this_cl == cl_addr)
+			return perf_c2c__browse_cacheline(he_cl);
+	}
+
+	return -1;
+}
+
+/*
+ * perf_c2c__browse_function_view - Browse function view with TAB key support
+ * @hists: Main cacheline histograms
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int perf_c2c__browse_function_view(struct hists *hists)
+{
+	struct c2c_function_browser *sym_browser;
+	bool saved_use_callchain = symbol_conf.use_callchain;
+	int key, ret;
+	static const char help[] =
+	" d             Display cacheline details for the selected entry\n"
+	" e/+           Expand/collapse the selected entry\n"
+	" TAB/ESC/q     Return to the cacheline view\n";
+
+	if (!hists)
+		return -EINVAL;
+
+	/*
+	 * The level-2/3 children borrow thread/ms (see c2c_child_entry__alloc())
+	 * and are torn down by c2c_he__free_hierarchy(). report_hierarchy would
+	 * make hist_entry__delete() recurse into hroot_out and put those borrowed
+	 * refs (and call a NULL ops->free), so refuse to run if it is ever set.
+	 */
+	if (WARN_ON_ONCE(symbol_conf.report_hierarchy))
+		return -EINVAL;
+
+	/* Disable callchain before building so no callchain structs are allocated. */
+	symbol_conf.use_callchain = false;
+
+	ret = build_function_view_hierarchy();
+	if (ret) {
+		ui__error("Failed to build function view hierarchy (ret=%d)\n", ret);
+		goto out;
+	}
+
+
+	sym_browser = c2c_function_browser__new(&c2c_ext.function_hists.hists);
+	if (!sym_browser) {
+		ret = -ENOMEM;
+		goto out_reset;
+	}
+
+	/* Reset abort key so we can receive Ctrl-C as a key. */
+	SLang_reset_tty();
+	SLang_init_tty(0, 0, 0);
+	SLtty_set_suspend_state(true);
+
+	while (1) {
+		/*
+		 * hist_browser__run() resets b.nr_entries from
+		 * nr_non_filtered_entries on entry, so refresh the visible-row
+		 * count (which includes expanded L2/L3 children) here, before
+		 * each run, or the cursor cannot move onto the expanded rows
+		 * after returning from the 'd'/'?' windows.
+		 */
+		sym_browser->hb.nr_non_filtered_entries =
+			c2c_function__nr_visible_rows(
+				&c2c_ext.function_hists.hists.entries,
+				sym_browser->hb.min_pcnt);
+
+		key = hist_browser__run(&sym_browser->hb, "? - help", true, 0);
+
+		switch (key) {
+		case 'q':
+		case K_TAB:
+		case K_ESC:
+			goto browser_done;
+		case 'd':
+			/* Cacheline detail honors the user's callchain setting. */
+			symbol_conf.use_callchain = saved_use_callchain;
+			c2c_function_browser__browse_cacheline_detail(sym_browser->hb.he_selection,
+								      hists);
+			/* Preserve any toggle made in the detail view, then
+			 * re-disable callchain for the function view.
+			 */
+			saved_use_callchain = symbol_conf.use_callchain;
+			symbol_conf.use_callchain = false;
+			break;
+		case '?':
+			ui_browser__help_window(&sym_browser->hb.b, help);
+			break;
+		default:
+			break;
+		}
+	}
+
+browser_done:
+	c2c_function_browser__delete(sym_browser);
+out_reset:
+	c2c_function_hists__reset();
+out:
+	symbol_conf.use_callchain = saved_use_callchain;
+	return ret;
+}
-- 
2.52.0

