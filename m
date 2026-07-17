Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A948733D6F9;
	Fri, 17 Jul 2026 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784253956; cv=none; b=lFSyis9j1/0k9HPWipFA8HOpzjYcU4eSmjoXo9Ff2F0MMTS2wpOzwTzeuy8792MG2g18obfxE6vgPbDYAg/dGOQRZ7CehPX+eWasnXGrxreHFhLvhiR6bfFUepjekSlO3c80ptgPe8etuvQg1utHIxv9ef5gMAgirsM5qRr2cx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784253956; c=relaxed/simple;
	bh=oyPN9WrRcFZ0FqXaoaYkwU84/LrJt2ctmrX7oqWOoGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewCp+wOWfap0p92dwDhazNlNzbLpEWISDqspScoO3Ughz5cZILUSJIm5cnU8wXNODVb2eG4t0U3JaQRNIULE0rGkyznjZIsjUpJNM9iZyeTM9iN/QTPy3UP8bkYJ2kfekbh1B0pCYmy5ZPC1gD8PN04abec4d2nBWd4Wbb39YuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QH6LsH8f; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QH6LsH8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784253954; x=1815789954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oyPN9WrRcFZ0FqXaoaYkwU84/LrJt2ctmrX7oqWOoGM=;
  b=QH6LsH8fOq+CGpYzm8iWoLPxIjqkBtdmovfM9tBWkO2tpgWvXcRSnUQM
   IZtm1PXPqbglrEIaO5EMyFuovs+S4GbY13BASsgF1ljMh3zOLljbiC0md
   I++629VhZ/auQR3rmWgLH855UG5LSvpT8Pf3rltd83sbM7Piz2h31ReKN
   UjIi1bmYoqj2G/wRr9PSPfF5qfGOYdTyDLLlEVCBQJ+Ldvs0T2i+40iWn
   Yw9/l5KgcXFLmzg//MVFqX9YzlSdjNSWZF7iwd3lQhXsSuIreNE+HXQBg
   Uk/ysthoJZgO+BQP9tTyZ4Lj3fUTuubpU+FTsnBOb94FSdfPoCPzNS5zk
   A==;
X-CSE-ConnectionGUID: oJsEWL22QYSU/k2JhT8kfQ==
X-CSE-MsgGUID: j6Aiu4C1TYmC55ZSt/25bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="107720030"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="107720030"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 19:05:53 -0700
X-CSE-ConnectionGUID: DlKJrmLyT3ubOXexMrykkw==
X-CSE-MsgGUID: EgV28CCHTbCR7RGwrQbgpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="279952818"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 16 Jul 2026 19:05:48 -0700
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
Subject: [PATCH v3 06/14] perf c2c: add comparison functions for function view sorting
Date: Fri, 17 Jul 2026 10:05:22 +0800
Message-ID: <20260717020530.1645123-7-jiebin.sun@intel.com>
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
index a9add0ba4cda..75c0a390c283 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -311,6 +311,81 @@ cycles_percent_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
+	 * Order by instruction address, same direction as sort__iaddr_cmp()
+	 * (which returns r - l). Uses hist_entry__iaddr(), which falls back to
+	 * he->ip when mem_info is NULL, so it matches what iaddr_symbol_entry()
+	 * displays.
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

