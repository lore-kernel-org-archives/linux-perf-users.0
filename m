Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEA33AD9A;
	Fri, 17 Jul 2026 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253978; cv=none; b=CpuFsObtL6ZCe/EPFd8FCjdtcTynK5SQj+oPM4q/vtjVDlCkeWLxgA8YIwmcZI8q6mnTENc5rQlNKdNaa1wLxx4t+s/9rFTAmR5LWyQ2GGc+EF2uErri9ObWKvDbDtU4+I+GMaZ5hmeWcOniID5oQJMvsMBtjHuDoZnqPKnvoEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253978; c=relaxed/simple;
	bh=yh6XazmLhFMw3Cs/tgHrBl3t7OrSgwaIiTGyi9e5QMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZrFCyDaaNDviq2RaPjR1KhMsLb1WtPEWqrRyCcoBYeUyVi4fESrapJe+gQmhPJjjt+BbBYpy93e0D8wm95YTAK5A4tSx3xB1+Az8Bsi56I6Y6bMuCxw9LMx3ifTe5ijHRMohOSGeghTqi4SxlSngZ5//ioeZJuFikKk+qKpy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZO9ZqN3V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZO9ZqN3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784253977; x=1815789977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yh6XazmLhFMw3Cs/tgHrBl3t7OrSgwaIiTGyi9e5QMQ=;
  b=ZO9ZqN3VEmsDKJuCZfWCoyJCTAaY0jGA0HxsQFWbrCErkREn5SLGlnky
   B8QHBxxvcEPX4q+Kq1FhdXTEGldEHedXSduFVNxeOndwkPzB9zKrhu2Zj
   4lXgYO/U3kgD886ilTIhYDweiEQdcXu5qabpx+fGOnAT+fjJaSsY2+3yw
   zvpaT8bUTaxBHK/KaC6wmW6QiwTKPym5kXzjiEeTNzdWFLpz7lXuE0vOH
   W4FirVzD9pBEzkzKJbFZ3swDtAw4uYERI0vBbCt4bRCGGGj95Fnj6Ga+W
   xGKgOjNiELoY42bA/tgDmcRf8M+66NOy2OPVrwpQGh1oheJjxGGcGLPPF
   A==;
X-CSE-ConnectionGUID: ejjUusBaQgSa5tr+ZjST5A==
X-CSE-MsgGUID: 5QCOx7dcSjqSFrVJqzGhow==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107720084"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="107720084"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 19:06:17 -0700
X-CSE-ConnectionGUID: jaGeZ4XeTsy+1g9GHiB1Ug==
X-CSE-MsgGUID: zQNoNbLnQAyjAU7Iq5yjLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="279952885"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2026 19:06:12 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org,
	acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH v3 12/14] perf c2c: add function view browser UI
Date: Fri, 17 Jul 2026 10:05:28 +0800
Message-ID: <20260717020530.1645123-13-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717020530.1645123-1-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the stub perf_c2c__browse_function_view() with the full
interactive browser implementation:

- c2c_function_browser__new(): create browser with hierarchy support,
  disabling callchains for clean function-level display
- c2c_function_browser__browse_cacheline_detail(): drill into
  cacheline detail view via 'd' key
- c2c_function_browser__title(): display entry count in title bar
- c2c_function_browser__delete(): cleanup on exit

The browser saves/restores symbol_conf.use_callchain to avoid
corrupting the callchain display in the cacheline view after
returning from the function view.

The browser entry point perf_c2c__browse_function_view() is wired up by
the next patch, which adds the TAB key in the cacheline view to switch
into the function view.
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
 tools/perf/ui/browsers/c2c-function.c | 157 +++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 31f1626559cd..fb6673ab410e 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -2,7 +2,7 @@
 /*
  * C2C Function Browser - function-level cacheline sharing analysis
  *
- * Planned UI: 3-level hierarchy showing which functions share cachelines (not implemented yet):
+ * Displays a 3-level hierarchy showing which functions share cachelines:
  *   Level 1: Primary functions sorted by Cycles % (estimated load cycles)
  *   Level 2: Other functions sharing cachelines with the level-1 function
  *   Level 3: Specific shared cachelines between each pair of functions
@@ -44,7 +44,7 @@ struct perf_c2c_ext {
 	u64			total_cycles;
 };
 
-static struct perf_c2c_ext c2c_ext __maybe_unused;
+static struct perf_c2c_ext c2c_ext;
 
 struct c2c_function_browser {
 	struct hist_browser	hb;
@@ -1334,7 +1334,7 @@ static void c2c_function__finalize(void)
  *   L2: sharing functions referenced from each L1 function
  *   L3: cachelines that pair L1 with L2
  */
-static __maybe_unused int build_function_view_hierarchy(void)
+static int build_function_view_hierarchy(void)
 {
 	static const char output_fields[] =
 		"cycles_percent,total_stores,iaddr_symbol,symbol_view,cacheline_symbol";
@@ -1408,8 +1408,155 @@ static __maybe_unused int build_function_view_hierarchy(void)
 	return ret;
 }
 
-int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
+static int c2c_function_browser__title(struct hist_browser *browser,
+				       char *bf, size_t size)
 {
-	ui__warning("C2C function view is not implemented yet.\n");
+	scnprintf(bf, size,
+		  "Shared Data Functions Table     (%" PRIu64 " entries, sorted on Cycles %%)",
+		  browser->nr_non_filtered_entries);
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
+		goto out;
+	}
+
+	/* Reset abort key so we can receive Ctrl-C as a key. */
+	SLang_reset_tty();
+	SLang_init_tty(0, 0, 0);
+	SLtty_set_suspend_state(true);
+
+	sym_browser->hb.nr_non_filtered_entries =
+		c2c_ext.function_hists.hists.nr_non_filtered_entries;
+
+	while (1) {
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
+out:
+	symbol_conf.use_callchain = saved_use_callchain;
+	return ret;
+}
-- 
2.52.0

