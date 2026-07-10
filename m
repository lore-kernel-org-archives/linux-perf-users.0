Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE83F1ACE;
	Fri, 10 Jul 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672985; cv=none; b=h7UOx3LgDxoT2LGXI9CTnHUCL8eggP0eDYH/rJbZmoxOoV31SwEY3SBDgFikfMFgl5PZXJMhReHNDA490ROiyKV3us+5cClOG6wv2Mxf4sJiK3avcFSjKzZhuWWNBArlB1yOgMTC5wp8AACfguboIhmQMr7aAoPzO3BTn1z8H0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672985; c=relaxed/simple;
	bh=dpE2CHpNbPNW2ZpnqkPf9m/RvQnsOyxkbBr/FIchIeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCzE0I2QHYe1Y/C62Qz3jU7pE53iar58JXKYvMvN0a0YjlIx4XmgAPAZHuxcN1Mc5bczJDz/7GgsEJ9+tVgUnkBOfvWcw5tMPa2lAoKpvMKNizb5Qmm7U57sdcJ+qsxaiMBU0XoxoUGsK9NkLIz/tlsSKtwQs41VYMi8hlJYAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwRun5jP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwRun5jP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672982; x=1815208982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpE2CHpNbPNW2ZpnqkPf9m/RvQnsOyxkbBr/FIchIeo=;
  b=HwRun5jPkhFJZyQLAMRoXrtZqZ5uFwLJTR5ycdU18gD3L10oC82A8zjZ
   CzsZB4jN81mOu7Yq+zYmqFDJkYZjHuBuDp1jREpABj7xAKLAXw7PvBWcV
   Kc4ZDafwEzUaBMXSO/nBsAox1bOQGqtowEM9e1NzkStmzUjd63QTagtie
   dQfwuPdgNt8hW5pWGyR9a5lBqgpkSofHBFvqUd0XxW05AB75ZH54uiNie
   tPfomIgVs8ObxyyvDVth+A4A1rejho8CjUsYZD2VQvzIaQPHJOAtSJask
   h6qfYDBPHThUnRvGjmfhyAeRJ7Kw+f62n4AxKXRptlYMBRV+In0F74EEu
   w==;
X-CSE-ConnectionGUID: otPQisXgTG2hfRZ20cH8uQ==
X-CSE-MsgGUID: 6sTv/w+jSJKheyF1S/SdsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390833"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390833"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:43:01 -0700
X-CSE-ConnectionGUID: IsCa2lYwQkms0b0JLT3lGg==
X-CSE-MsgGUID: 7ACnjceaS5KTcEa6Mb64sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435363"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:42:57 -0700
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
Subject: [PATCH v2 06/14] perf c2c: add comparison functions for function view sorting
Date: Fri, 10 Jul 2026 16:42:39 +0800
Message-ID: <20260710084247.3576706-7-jiebin.sun@intel.com>
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
index 0ee5fd571e48..d5763af307b6 100644
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

