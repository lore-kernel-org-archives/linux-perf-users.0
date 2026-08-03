Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323DA386443;
	Mon,  3 Aug 2026 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728765; cv=none; b=S6bBhkFY7Qj9OgG4fP/8dIfuKEfy+QlnhgliS4ubs3P7SsSiH7PqLXgi7e/yfOVliMSRwFNwQq+e2S4MxazJNXJYWG/1zyplKw3mAnhp22geHtoM4CJb1W9OW0fjkq2ApgUaTmUdO/0DalWgBp9zUshp+a+uUgCmVja+I3MLu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728765; c=relaxed/simple;
	bh=Gkozl1pRf/c02//Ed6r6D7fpYeg5FOzpJBEI3Vwf1Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwxqnulFy/fK2Oon5fya4LFGR52zWXLJUmNVjUblu93+joWkZ8ps37kFO+Gg/u1H+yml/lcJBJlLTYoIN+6fWCTM48HhBoNx6xVF5JeGup2yCikAIqTP3bQFjfXTiJmhylD6OEv7RmxghIRpmV7t26DTc+xdf5NvtgZQMnG1fYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBel0tIY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBel0tIY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785728763; x=1817264763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gkozl1pRf/c02//Ed6r6D7fpYeg5FOzpJBEI3Vwf1Pg=;
  b=RBel0tIYWfI3uA3puM81G6r1UFggMwb4Q7SlIVEHJc1T2ojiUrQZBqpX
   CPLEOU+gB2+LJW1Q+4U6feXSjGPWo+XF2Xsq9vsEkwESGq/2W6YC6aDLj
   L5CegASM64Xr93siuP8TrWhYt6IF9Ki0T/V6qFlGlKW+nKUEug+MdGCPe
   kfwYw5+y7pGEk/Gn4CXS9yOU7p9nUdbLuZOCy+7hM7YhnucffQrr9CFwx
   mAbkOMGkRG90jMvjbXCjM64aQlDx2BnN4zhAg01M5+XgoJXJ6DEsdeDfQ
   BGWMP3Djd6Uije9TET3/dQ0T8c06lnzN6EyYxrQ68N/mh/JEgpOaJtrNl
   g==;
X-CSE-ConnectionGUID: tUd95k4uTsuO8iWJj7Yxeg==
X-CSE-MsgGUID: URi4kuMKSBeax7MDzui2Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86210281"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="86210281"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 20:46:03 -0700
X-CSE-ConnectionGUID: Nw/A3eZAQmiUVzj6JC+M/Q==
X-CSE-MsgGUID: 8CgsHz3JSEWNll5Q1m04TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="261719215"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa009.jf.intel.com with ESMTP; 02 Aug 2026 20:45:59 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	adrian.hunter@intel.com,
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
Subject: [PATCH v6 8/9] perf c2c: add function view browser UI and cacheline detail
Date: Mon,  3 Aug 2026 11:52:19 +0800
Message-ID: <20260803035220.172022-9-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260803035220.172022-1-jiebin.sun@intel.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the browser front end: create/run/delete the hist_browser and add the
title. The d shortcut opens the existing per-cacheline detail view for the
selected level-3 cacheline. Level-3 entries retain the source cacheline
index, so the shortcut can locate the original entry without relying on a
potentially ambiguous virtual address.

Require `iaddr` in the cacheline coalescing fields before building the
view. Without it, the detail histograms may already have merged samples
from different functions and cannot support reliable function attribution.

Keep visible-row accounting local to the function view by wrapping the
generic browser refresh callback and recounting the currently reachable
hierarchy before each redraw. This keeps navigation correct when a level-1
row is collapsed while level-3 descendants remain expanded, without adding
C2C-specific hooks to the shared hist_browser. Also handle Ctrl-C like the
other function-view exit keys.

Wire the builder into perf_c2c__browse_function_view().

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
 tools/perf/ui/browsers/c2c-function.c | 221 +++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 7438ec852590..67586052283a 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -15,8 +15,8 @@
 #include <inttypes.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/ttydefaults.h>
 #include <tools/libc_compat.h> /* reallocarray */
-#include <asm/bug.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <linux/zalloc.h>
@@ -49,6 +49,7 @@ static struct perf_c2c_ext c2c_ext;
 
 struct c2c_function_browser {
 	struct hist_browser	hb;
+	unsigned int		(*orig_refresh)(struct ui_browser *browser);
 };
 
 static inline u64 c2c_hitm_count(const struct c2c_stats *stats)
@@ -93,6 +94,10 @@ static inline u64 hist_entry__iaddr(struct hist_entry *he)
 	return he->ip;
 }
 
+/*
+ * Hierarchy levels (by depth): L1 = read-side function, L2 = the writing
+ * function it contends with, L3 = the specific shared cacheline.
+ */
 static inline bool hist_entry__is_cacheline(struct hist_entry *he)
 {
 	return he->parent_he && he->parent_he->parent_he;	/* level 3: cacheline */
@@ -706,6 +711,7 @@ c2c_function_hists__reinit(struct c2c_hists *c2c_hists,
 	return function_hpp_list__parse(&c2c_hists->list, output, sort, env);
 }
 
+/* Welford online merge of two "stats" (from util/stat.h) accumulators. */
 static void c2c_stats_merge(struct stats *dest, const struct stats *src)
 {
 	double delta;
@@ -1412,6 +1418,58 @@ static void c2c_function__update_symbol_width(struct hist_entry *he)
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
+static void
+c2c_function_browser__update_nr_entries(struct c2c_function_browser *browser)
+{
+	u64 nr_entries;
+
+	nr_entries = c2c_function__nr_visible_rows(&browser->hb.hists->entries,
+						   browser->hb.min_pcnt);
+	browser->hb.nr_non_filtered_entries = nr_entries;
+	browser->hb.b.nr_entries = nr_entries;
+}
+
+static unsigned int c2c_function_browser__refresh(struct ui_browser *ui_browser)
+{
+	struct hist_browser *hist_browser = container_of(ui_browser, struct hist_browser, b);
+	struct c2c_function_browser *browser;
+
+	browser = container_of(hist_browser, struct c2c_function_browser, hb);
+	c2c_function_browser__update_nr_entries(browser);
+	return browser->orig_refresh(ui_browser);
+}
+
 /*
  * Prune writers with no stores, drop functions left with no contending
  * writer, sort the survivors by store count, then compute the global total.
@@ -1484,7 +1542,7 @@ static void c2c_function_hists__reset(void)
  *   L2: writing functions contending with each level-1 function
  *   L3: shared cachelines for each function pair
  */
-static int __maybe_unused build_function_view_hierarchy(void)
+static int build_function_view_hierarchy(void)
 {
 	static const char output_fields[] =
 		"cycles_percent,total_stores,symbol_view";
@@ -1563,8 +1621,163 @@ static int __maybe_unused build_function_view_hierarchy(void)
 	return ret;
 }
 
-int perf_c2c__browse_function_view(void)
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
+	browser->orig_refresh = browser->hb.b.refresh;
+	browser->hb.b.refresh = c2c_function_browser__refresh;
+
+	browser->hb.title = c2c_function_browser__title;
+	browser->hb.c2c_filter = true;
+	browser->hb.show_headers = true;
+	/* Keep title line count consistent with forcing headers on. */
+	browser->hb.b.extra_title_lines = hists->hpp_list->nr_header_lines;
+	browser->hb.min_pcnt = 0.0;
+
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
+static int c2c_function_browser__browse_cacheline_detail(struct hist_entry *he_selection)
+{
+	struct c2c_hist_entry *c2c_he;
+	struct rb_node *nd;
+
+	if (!he_selection || !he_selection->parent_he ||
+	    !he_selection->parent_he->parent_he)
+		return -1;
+
+	c2c_he = container_of(he_selection, struct c2c_hist_entry, he);
+
+	for (nd = rb_first_cached(&c2c.hists.hists.entries); nd; nd = rb_next(nd)) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
+		struct c2c_hist_entry *cacheline_he;
+
+		if (he->filtered)
+			continue;
+
+		cacheline_he = container_of(he, struct c2c_hist_entry, he);
+		if (cacheline_he->hists &&
+		    cacheline_he->cacheline_idx == c2c_he->cacheline_idx)
+			return perf_c2c__browse_cacheline(he);
+	}
+
+	return -1;
+}
+
+static bool c2c_function__has_iaddr(void)
+{
+	const char *field = c2c.cl_sort;
+
+	while (field && *field) {
+		const char *end = strchr(field, ',');
+		size_t len = end ? (size_t)(end - field) : strlen(field);
+
+		if (len == sizeof("iaddr") - 1 && !strncmp(field, "iaddr", len))
+			return true;
+		field = end ? end + 1 : NULL;
+	}
+	return false;
+}
+
+/*
+ * perf_c2c__browse_function_view - Browse function view with TAB key support
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int perf_c2c__browse_function_view(void)
+{
+	struct c2c_function_browser *sym_browser;
+	bool saved_use_callchain = symbol_conf.use_callchain;
+	int key, ret;
+	static const char help[] =
+	" d             Display details for the selected level-3 cacheline\n"
+	" e/+           Expand/collapse the selected entry\n"
+	" TAB/ESC/q/^C  Return to the cacheline view\n";
+
+	if (!c2c_function__has_iaddr()) {
+		ui__warning("The function view requires iaddr in --coalesce.\n");
+		return -EINVAL;
+	}
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
+		c2c_function_browser__update_nr_entries(sym_browser);
+		key = hist_browser__run(&sym_browser->hb, "? - help", true, 0);
+
+		switch (key) {
+		case 'q':
+		case K_TAB:
+		case K_ESC:
+		case CTRL('c'):
+			goto browser_done;
+		case 'd':
+			/* Cacheline detail honors the user's callchain setting. */
+			symbol_conf.use_callchain = saved_use_callchain;
+			c2c_function_browser__browse_cacheline_detail(sym_browser->hb.he_selection);
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

