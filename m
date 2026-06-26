Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15793DBD4E;
	Fri, 26 Jun 2026 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457422; cv=none; b=iKthSRSzXxbkLk/of6O9p6s3jLiGUhR3Ax99R9j3qbww9+I87i9yoV73YVOlUjkbcHwc+0mPdHNgkHyVf3qMLY3MjFexSi6aNNUbRGQDw5B4249IrPm7RkGfFelm7VZ6hPV3iMSL/W88Kqn0hj53op4hMV0ot7EQSq5fIGTp9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457422; c=relaxed/simple;
	bh=zSA0kWuZX2xNS8kzAvFpAFd3nbn0GHgMA9ewfWdSkRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zs0+2BB7T6Bmg+dAH0gna/dvWNzQiXzU5g6gnl9Eaamo+iK2BEM8HZqm0InVOGFB8wOb+hjGEW9kvyYvIEeFUCaznWchxFse0TQCraFbUeWcYUrdeIeVaDiPB4raabaRmkU4URW0b0OJs+CH6EP4ouzcNx8GpOBYT1K8/XdHFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Evz58u7g; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Evz58u7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782457419; x=1813993419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zSA0kWuZX2xNS8kzAvFpAFd3nbn0GHgMA9ewfWdSkRI=;
  b=Evz58u7gWGPZBZhIajRYgn50KlTlaSn5P7a9JPR7uLfnXGemhHUjMHXm
   GjVjQ+h4hpheeXOUc87k5BE/sNpnXVpXx5FWisD5o1cnzy76cH6wf9kwQ
   3D1ZD33u7ps49xJGs5FmlG8iQleeiUGshd8UYieOzPMCYU8ugC11KtlpY
   awEAq8wXsZryRFAOUBLKJN3ebx0IMpaBPnTVzTQ5DhJs3cuJ78PJYBnSP
   t0l8SwK8DPQUR/xnSDH+pWjRA5e87nf1lrkgD9R/9XF2ukJ0x9ZSxozQo
   qzm/xOtP7w/d2zsKtAAC2sl+7XrBKKvsyc4VpP15EpL5+R9Ar84d+DLWw
   g==;
X-CSE-ConnectionGUID: V7CA1hl4RQyvb0LKB8ZKBw==
X-CSE-MsgGUID: PyO2XNh2QtSTD4AwX4DmEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94397382"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="94397382"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:03:39 -0700
X-CSE-ConnectionGUID: kOSMKBJGTAGKyXbKziapwg==
X-CSE-MsgGUID: WfnISVfaTUOMO1PSfe6evw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="247893464"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jun 2026 00:03:33 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Wangyang Guo <wangyang.guo@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: [PATCH 06/14] perf c2c: add comparison functions for function view sorting
Date: Fri, 26 Jun 2026 15:03:47 +0800
Message-ID: <20260626070355.1556721-7-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626070355.1556721-1-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sort comparison functions for the function view columns:

- cycles_percent_cmp(): compare by weighted HITM cycle count
- iaddr_symbol_cmp(): compare by instruction address
- total_stores_cmp(): compare by store count
- empty_cmp(): no-op comparator for display-only columns

Use overflow-safe (a > b) - (a < b) pattern for unsigned
comparisons in cycles_percent_cmp() and total_stores_cmp().

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
 tools/perf/ui/browsers/c2c-function.c | 75 +++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 5393f603c864..172e1aa86eca 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -315,6 +315,81 @@ cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return ret;
 }
 
+/*
+ * cycles_percent_cmp - Comparison function for cycles percentage sorting
+ */
+static __maybe_unused int64_t
+cycles_percent_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		   struct hist_entry *left, struct hist_entry *right)
+{
+	struct c2c_hist_entry *c2c_left = container_of(left, struct c2c_hist_entry, he);
+	struct c2c_hist_entry *c2c_right = container_of(right, struct c2c_hist_entry, he);
+	u64 cycles_left, cycles_right;
+
+	/* Cycles Percent is only shown for level-1 entries; others compare equal. */
+	if (left->parent_he || right->parent_he)
+		return 0;
+
+	cycles_left = c2c_hist_entry__cycles(c2c_left);
+	cycles_right = c2c_hist_entry__cycles(c2c_right);
+
+	return (cycles_left > cycles_right) - (cycles_left < cycles_right);
+}
+
+/*
+ * iaddr_symbol_cmp - Comparison function for instruction address sorting
+ */
+static __maybe_unused int64_t
+iaddr_symbol_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		 struct hist_entry *left, struct hist_entry *right)
+{
+	u64 left_iaddr, right_iaddr;
+
+	/* IAddr is hidden for level-3 cacheline entries; they compare equal. */
+	if ((left->parent_he && left->parent_he->parent_he) ||
+	    (right->parent_he && right->parent_he->parent_he))
+		return 0;
+
+	left_iaddr = hist_entry__iaddr(left);
+	right_iaddr = hist_entry__iaddr(right);
+
+	/*
+	 * Descending by instruction address (same direction as sort__iaddr_cmp(),
+	 * which also returns r - l): the expression is +1 when left < right.
+	 * Uses hist_entry__iaddr(), which falls back to he->ip when mem_info is
+	 * NULL, so it matches what iaddr_symbol_entry() displays.
+	 */
+	return (left_iaddr < right_iaddr) - (left_iaddr > right_iaddr);
+}
+
+static __maybe_unused int64_t
+empty_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+	  struct hist_entry *left __maybe_unused,
+	  struct hist_entry *right __maybe_unused)
+{
+	return 0;
+}
+
+/*
+ * total_stores_cmp - Comparison function for total stores sorting
+ */
+static __maybe_unused int64_t
+total_stores_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		 struct hist_entry *left, struct hist_entry *right)
+{
+	struct c2c_hist_entry *c2c_left = container_of(left, struct c2c_hist_entry, he);
+	struct c2c_hist_entry *c2c_right = container_of(right, struct c2c_hist_entry, he);
+	u64 left_store, right_store;
+
+	/* Match total_stores_entry(): L1 sums child stores, L2/L3 use their own. */
+	left_store = left->parent_he ? (u64)c2c_left->stats.store :
+				       hist_entry__child_stores(left);
+	right_store = right->parent_he ? (u64)c2c_right->stats.store :
+					 hist_entry__child_stores(right);
+
+	return (left_store > right_store) - (left_store < right_store);
+}
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

