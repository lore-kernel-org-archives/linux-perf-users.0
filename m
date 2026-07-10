Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA383F39E9;
	Fri, 10 Jul 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673016; cv=none; b=WQiggOjCbXN8Ew6nfZVZvkzKL8Dt+RjovMceO47P1AoX3NPSOZhOuLx8HHW/vmDgF09A57PeQvlwEaHZxXPk+F+YbzzKaFMwWj5385f6tu84vWZwAEr6WKXcsO5Cqt3cJe/ug0xNCdfhOQKvWJIBr0Vkbtcvv2GG94eYXGXAtg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673016; c=relaxed/simple;
	bh=R5NEIwYZSgdrWu8wKRE5gn3sFWfLGw/F3DJGjMofMCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLUDb8q4UXfLjwhU0n2JKI6MX+1F/LKQxpi5nlOodVvs/TztMIhem3xYAQQKMsixYXi6FvYeBAgcqVum99JtGYGfDN8FWNemXbr3L7Os/zjPB5KJdwFJhfEXHA4cQgrTulpiOoL2gKVRJwc6uvGnscJfe/lStvsSBQN/iRUEYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0vk3SGF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0vk3SGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783673012; x=1815209012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R5NEIwYZSgdrWu8wKRE5gn3sFWfLGw/F3DJGjMofMCw=;
  b=T0vk3SGFfRPTYH27qt7ZX7ZKBhgMLNMgFKtBC8yyl071jpPwA+UuXzvj
   ztf1uqd5e7OvSKtBhCMalzVpeEFiO+xmYbwhegj37YjfZwZ5p2OntZtLN
   bTHZE3X+BZrLP1UJP8hTod7wuDH7LCSct7+PIZvZV1+cFsy+2lwYSKX75
   +Cl+rI0wFHDajz+CoDUPpG85a/laSXlz8s8yEJplhWZG5VBXPjs3IO4+m
   j+Mn3YT85EjyZ5U5WZuyH+Z7CApv9Dp9ifSV/fMZJYUPrhZb3a31MZBBH
   FRjcLp2dFUeq6fquWPVCVv5WRKUTij1eUuKugWGVKD2by5Sd359UUcMEg
   w==;
X-CSE-ConnectionGUID: UKr+ScjsR+K8MbCBvGV34A==
X-CSE-MsgGUID: worGNcExTL6PBMGqG6Sd2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390899"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390899"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:43:31 -0700
X-CSE-ConnectionGUID: yYdJpvf0RbaICg6wVRuoiA==
X-CSE-MsgGUID: EHre6RuQR0id7FpeGZYuTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435462"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:43:26 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>
Subject: [PATCH v2 12/14] perf c2c: add function view browser UI
Date: Fri, 10 Jul 2026 16:42:45 +0800
Message-ID: <20260710084247.3576706-13-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260710084247.3576706-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
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
 tools/perf/ui/browsers/c2c-function.c | 159 +++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 80e032d5e31c..e23f90ec282c 100644
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
@@ -1335,7 +1335,7 @@ static void c2c_function__finalize(void)
  *   L2: sharing functions referenced from each L1 function
  *   L3: cachelines that pair L1 with L2
  */
-static __maybe_unused int build_function_view_hierarchy(void)
+static int build_function_view_hierarchy(void)
 {
 	static const char output_fields[] =
 		"cycles_percent,total_stores,iaddr_symbol,symbol_view,cacheline_symbol";
@@ -1409,8 +1409,155 @@ static __maybe_unused int build_function_view_hierarchy(void)
 	return ret;
 }
 
-int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
+static int c2c_function_browser__title(struct hist_browser *browser,
+				       char *bf, size_t size)
 {
-	ui__warning("C2C function view is not implemented yet.\n");
-	return -ENOSYS;
+	scnprintf(bf, size,
+		  "Shared Data Functions Table     (%" PRIu64 " entries, sorted on Cycles %%)",
+		  browser->nr_non_filtered_entries);
+	return 0;
+}
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
 }
-- 
2.52.0

