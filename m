Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E243F23BB;
	Fri, 10 Jul 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672981; cv=none; b=ov/UZIPgmH1XTtrl1OJ8oro3tkyKNS7Ft7KoCXTuLiKltulWn26rNQD6w669D+wdUu503b3WNPLDvcLtx7RJQIb4GPUjAZHhY94oJhzVdvJWEG4+oGo6yXD6gdbgx07hJqnh+Y4OGfyttShHR/DAEhvIVFg8QaGLk/95V/IzccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672981; c=relaxed/simple;
	bh=lkOjkGYo60jE1HJmYzh6LLi8IAJ+IpegQZfi94hNH2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKJ4O4yeJxtwbQlh2iLgW1l1lc/1Ksjx7IuU1sXes7Ah9QPBrt5RteOoDHjB18v5YJU0OzFNn4V2X3tfJkk55EitzacUb30yksMHisnKPzW6oSnazqRXwGvm3uYb3w1Zi8J1mMvUryhTW07yDq8jfKLI5y0F0a6dAQ5CwO4T4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiqr+XJ/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiqr+XJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672977; x=1815208977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lkOjkGYo60jE1HJmYzh6LLi8IAJ+IpegQZfi94hNH2w=;
  b=kiqr+XJ/jRRZlKBS1N8LWHUldZ0nj4c2zXIef5egGsxEh4RTVBQ3tG5g
   xq3hwMEdlb+VeNncUDn6F1+JeyN7nYOVphVd1DP88zYLDok6LHCpX8zfC
   xMM8kylZ290fGQIZ5/DiaAQut71N+qsyS0LTcSiI5kBGg2kLRTEmvCPKB
   NpzVWeSj3fuA3EurMFIfYOre2gfe1tZdZSelMiDzCqhDZKn2CkcWK/NJb
   2YQ1Hniv78dHT6UyhU5t0Hk2CTwZKs9Qmv1ZD5tcQAyWI9hnVC2cy7+yt
   wqwhuu3mRtUjcPAqrLObLWgdEJk0FE4msiwBMNo76Jk5Ad9AgMa1h6sRA
   w==;
X-CSE-ConnectionGUID: gd6IqRH5R1C1yu4H5o8+7g==
X-CSE-MsgGUID: O+ziC59XSVCcirX5VEU3LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390822"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390822"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:42:56 -0700
X-CSE-ConnectionGUID: yPXsC8CWTeGswzqV25U1pA==
X-CSE-MsgGUID: lfJyzT3NRJiSLHEkjFUzCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435350"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:42:52 -0700
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
Subject: [PATCH v2 05/14] perf c2c: add column entry functions for function view
Date: Fri, 10 Jul 2026 16:42:38 +0800
Message-ID: <20260710084247.3576706-6-jiebin.sun@intel.com>
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

Add rendering functions for each column in the function view:

- total_stores_entry(): render store count, summing children for L1
- cacheline_symbol_entry(): render cacheline address for L3 entries
- iaddr_symbol_entry(): render code address with fold indicators
- symbol_view_entry(): render symbol name with fold indicators
- cycles_percent_entry(): render estimated load-cycle percentage for L1
  (HITM, peer-snoop and other-load cycles)

Each entry function handles the 3-level hierarchy by checking
parent_he depth to decide what to display.

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
 tools/perf/ui/browsers/c2c-function.c | 148 ++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 10 deletions(-)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index d718cab6537d..0ee5fd571e48 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -167,20 +167,148 @@ static __maybe_unused u64 c2c_ext__total_cycles(void)
 	return total;
 }
 
-/* Sum child entries' store counts under a level-1 hist_entry. */
+/*
+ * Sum of the level-2 children's store counts under a level-1 hist_entry.
+ * Read from the cache populated by the hierarchy builder, so this is O(1)
+ * and safe to call from the sort comparator.
+ */
 static __maybe_unused u64 hist_entry__child_stores(struct hist_entry *he)
 {
-	struct rb_node *nd;
-	u64 sum = 0;
+	struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
 
-	for (nd = rb_first_cached(&he->hroot_out); nd; nd = rb_next(nd)) {
-		struct hist_entry *child = rb_entry(nd, struct hist_entry, rb_node);
-		struct c2c_hist_entry *c2c_child =
-			container_of(child, struct c2c_hist_entry, he);
+	return c2c_he->child_stores;
+}
 
-		sum += (u64)c2c_child->stats.store;
-	}
-	return sum;
+static __maybe_unused int
+total_stores_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		   struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he = container_of(he, struct c2c_hist_entry, he);
+	int width = c2c_width(fmt, hpp, he->hists);
+	u64 total;
+
+	/* L1 shows the sum of sharing-function stores; L2/L3 show their own. */
+	total = he->parent_he ? (u64)c2c_he->stats.store : hist_entry__child_stores(he);
+
+	return scnprintf(hpp->buf, hpp->size, "%*" PRIu64, width, total);
+}
+
+/*
+ * cacheline_symbol_entry - Render cacheline address for function view
+ */
+static __maybe_unused int
+cacheline_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	char buf[24];
+	u64 addr;
+
+	/* Only show the address on level-3 cacheline entries. */
+	if (!he->parent_he || !he->parent_he->parent_he || !he->mem_info)
+		return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
+
+	addr = cl_address(mem_info__daddr(he->mem_info)->addr, chk_double_cl);
+	scnprintf(buf, sizeof(buf), "0x%" PRIx64, addr);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
+/* Render the code (instruction) address for level-1 and level-2 entries. */
+static __maybe_unused int
+iaddr_symbol_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		   struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	int iaddr_width, ret;
+	char buf[24];
+	u64 addr;
+	char folded_sign;
+
+	/* Hide for cacheline (level-3) entries. */
+	if (he->parent_he && he->parent_he->parent_he)
+		return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
+
+	addr = hist_entry__iaddr(he);
+
+	folded_sign = he->has_children ? (he->unfolded ? '-' : '+') : ' ';
+	ret = scnprintf(hpp->buf, hpp->size, "%c ", folded_sign);
+
+	iaddr_width = width - ret;
+	if (iaddr_width <= 0)
+		return ret;
+
+	scnprintf(buf, sizeof(buf), "0x%" PRIx64, addr);
+	ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%*.*s", iaddr_width, iaddr_width, buf);
+	return ret;
+}
+
+/*
+ * symbol_view_entry - Render symbol name for function view with expansion indicators
+ */
+static __maybe_unused int
+symbol_view_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		  struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	int sym_width;
+	int ret;
+	char symbuf[512];
+	char folded_sign;
+
+	/* Hide Symbol for cacheline entries */
+	if (he->parent_he && he->parent_he->parent_he)
+		return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
+
+	folded_sign = he->has_children ? (he->unfolded ? '-' : '+') : ' ';
+
+	ret = scnprintf(hpp->buf, hpp->size, "%c ", folded_sign);
+
+	sym_width = width - ret;
+
+	if (sym_width <= 0)
+		return ret;
+
+	/* sort_sym.se_snprintf is statically set and never cleared. */
+	sort_sym.se_snprintf(he, symbuf, sizeof(symbuf), sym_width);
+
+	ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%-*.*s", sym_width, sym_width, symbuf);
+	return ret;
+}
+
+/*
+ * cycles_percent_entry - Render cycles percentage column
+ */
+static __maybe_unused int
+cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		     struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	u64 fn_cycles, total_cycles;
+	char folded_sign;
+	double pct;
+	int ret, pct_width;
+
+	/* Hide Cycles Percent for child functions and cachelines. */
+	if (he->parent_he)
+		return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	fn_cycles = c2c_hist_entry__cycles(c2c_he);
+	/* Populated by build_function_view_hierarchy() once the L1 tree is built. */
+	total_cycles = c2c_ext.total_cycles;
+	pct = total_cycles > 0 ? (double)fn_cycles / total_cycles * 100.0 : 0.0;
+
+	/* Add folded sign only for level-1 entries */
+	folded_sign = he->has_children ? (he->unfolded ? '-' : '+') : ' ';
+	ret = scnprintf(hpp->buf, hpp->size, "%c ", folded_sign);
+
+	pct_width = width - ret;
+	if (pct_width <= 0)
+		return ret;
+	ret += scnprintf(hpp->buf + ret, hpp->size - ret, "%*.2f%%", pct_width - 1, pct);
+	return ret;
 }
 
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
-- 
2.52.0

