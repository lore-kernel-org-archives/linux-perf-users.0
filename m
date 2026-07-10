Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156523F20FC;
	Fri, 10 Jul 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672969; cv=none; b=Y464KdXgMWtEQGazL8meu24FkZHZnF2rgSwwwyt5bANOPoyGpW3vZfNxJOdD3IuLt3tHLcfQPllBympXyWg+U17/1miygOQD16SEkOR8mbKmPNQGHz2O2Knd8Y76RKkAvS+TCe/a930tUOx/Es9gYbSrV0H5oRu3HU892PXB3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672969; c=relaxed/simple;
	bh=ACA+l2tFRTl838fEEpWhN9TkeLd2KYYm60b5EBAW6rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKVtdtiQ6WfwDT+gWHmEW1BOttBWtwbUdTGa58Z4NU0G6PbbLfWgaEpmjB1nVgPgZ6YTIq9JySHxKJ2NQkTtO2AwXhQzw2fcN7MfPYzThZPeeeYETHDSSyrE4xZFChtTvHVvEM6Cuiyc7y5D0gcUZL+GWMtZRM2rQcRiQsIbYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfw8FBrB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfw8FBrB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672967; x=1815208967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ACA+l2tFRTl838fEEpWhN9TkeLd2KYYm60b5EBAW6rk=;
  b=nfw8FBrB6VhWVA9ByyQRUNDSiHBCH3b7Qnbi8pR1/qYDHTwAXZ4At+cs
   mkvIbUSspV+Lf2rdIEucBMIhhcLHL0E0k6t8ZtXZvu7yctdH6FY2wk3FZ
   Iut9FrZeeU/7G6DBm1dqzxedyJQbnvR/Y/BiClaCVUClfWNzCQ3OKcxG5
   617alkZgbA7vG7NPSis+rolspHKH63xD0SPIWuL/H/CeqO2dQm+Nq9NZ7
   riOo656faMTOPHOtuK4HlujBXYIheGCN/44koRUcqg8kon27p9v7Y7OTW
   qBRpYlBco0HXDAEbm6X9xyNOuDCTxuJyAPzTrVI/mcA/ssRclFDLnTiIo
   g==;
X-CSE-ConnectionGUID: 8H4YBsnuQTmOxsCHe5gzfA==
X-CSE-MsgGUID: Zet7kLnkQxyl0rHjX3LuLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390807"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390807"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:42:47 -0700
X-CSE-ConnectionGUID: iTYJQ43STIOCBgKdamcSZw==
X-CSE-MsgGUID: kczTEktATPOdHIdgyMpRVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258435328"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2026 01:42:43 -0700
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
Subject: [PATCH v2 03/14] perf c2c: add function view type definitions and helpers
Date: Fri, 10 Jul 2026 16:42:36 +0800
Message-ID: <20260710084247.3576706-4-jiebin.sun@intel.com>
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

Add the foundational type definitions and helper functions for the
function view browser:

- perf_c2c_ext: extended context holding function-grouped histograms
- c2c_function_browser: browser state wrapping hist_browser
- symbol_name_equal(): symbol comparison by name
- hist_entry__iaddr(): instruction address extraction helper
- c2c_hitm_count(): inline accessor for a c2c_stats HITM total

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
 tools/perf/ui/browsers/c2c-function.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browsers/c2c-function.c
index 040266288be3..dbc912a4a242 100644
--- a/tools/perf/ui/browsers/c2c-function.c
+++ b/tools/perf/ui/browsers/c2c-function.c
@@ -37,6 +37,35 @@
 #include "../../c2c.h"
 #include "hists.h"
 
+struct perf_c2c_ext {
+	struct c2c_hists	function_hists;
+	/* Cached across all level-1 entries; 0 means "not yet computed". */
+	u64			total_cycles;
+};
+
+static struct perf_c2c_ext c2c_ext __maybe_unused;
+
+struct c2c_function_browser {
+	struct hist_browser	hb;
+};
+
+static __maybe_unused inline u64 c2c_hitm_count(const struct c2c_stats *stats)
+{
+	return stats->tot_hitm;
+}
+
+static __maybe_unused inline bool symbol_name_equal(struct symbol *a, struct symbol *b)
+{
+	return a && b && arch__compare_symbol_names(a->name, b->name) == 0;
+}
+
+static __maybe_unused inline u64 hist_entry__iaddr(struct hist_entry *he)
+{
+	if (he->mem_info)
+		return mem_info__iaddr(he->mem_info)->addr;
+	return he->ip;
+}
+
 int perf_c2c__browse_function_view(struct hists *hists __maybe_unused)
 {
 	ui__warning("C2C function view is not implemented yet.\n");
-- 
2.52.0

