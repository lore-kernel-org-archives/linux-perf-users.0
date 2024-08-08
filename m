Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E28433AD;
	Thu,  8 Aug 2024 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145573; cv=none; b=Pw4a7wC9lYbfaRhW5BL+AI79g7oIwnZpyXyWppyRvNn7hTsWJGGezxjAMawIe5UB9X4jCjVwKeS/YAUBpgkNO5zYzUUmTe6oTDIu529UYmDm5YNgJRsUDFsOKXpB1ToJ1BRPhRt/PTpojHyB7o5R8ei2BcLuRZKzdqVIN8vRIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145573; c=relaxed/simple;
	bh=M8Vdlx5v0f5GYQrlo4Op0nn8DVxOwbbRblzNGEktKEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyLVhCCgiBawtH6n1jb0Pty+0TSV0XF7NJ/59hU28RK7U5+2bN+OsUDyRljro/KcjyozFW6CbAQ+nZgmgXeIp19q7BEQnXX64bgoZQ1jvUjDNblcW93/lchjeKHw0sUZRCzoaDPsJu4G8pX9MYOVx0yxYkHs3sWA10PWRegTQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6aCJgv1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6aCJgv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723145571; x=1754681571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M8Vdlx5v0f5GYQrlo4Op0nn8DVxOwbbRblzNGEktKEI=;
  b=R6aCJgv1KnPZH5d3X/DZGR2svFqd0ZQdiOuByJAhSt4ORrIef1hHU0sS
   F/qlZySEEfebR6O5x3SC1iBy733iEsizUfTAbcoh78ByBp9ucSiUxOp8m
   IeNaX31xKTEGI86wGwiF/o4nnrXKXwaxcYrC7prb6LX1R8aHcoIIFmvfV
   Q+64vGF2QZ7/ARn+sHl9HnR2kx7mEz1b2RUHaiXcBsZ0YIgo9AdodYHbs
   mOdoLTehO93VSI64Qgj65qLLwdz04yDHoNLCuHXv6C2Nn3Ir/XKl8W7Lf
   ZYNYDKW8nErSwcmgecqXB9UEvqd3G0FRnKSJo5JG0RiB22w9retCwjLhW
   w==;
X-CSE-ConnectionGUID: jflJORPWR6urotAVy1hO8g==
X-CSE-MsgGUID: KUYr0sgJSeKn4Pmw2whKLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25091691"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25091691"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 12:32:51 -0700
X-CSE-ConnectionGUID: C5hUPoGETKeTrk2+DrZrLw==
X-CSE-MsgGUID: jjja2Mt/QOqwnkbycOdGzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57402577"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 12:32:50 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/9] perf report: Fix --total-cycles --stdio output error
Date: Thu,  8 Aug 2024 12:33:16 -0700
Message-Id: <20240808193324.2027665-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240808193324.2027665-1-kan.liang@linux.intel.com>
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The --total-cycles may output wrong information with the --stdio.

For example,
  perf record -e "{cycles,instructions}",cache-misses -b sleep 1
  perf report --total-cycles --stdio

The total cycles output of {cycles,instructions} and cache-misses are
almost the same.

 # Samples: 938  of events 'anon group { cycles, instructions }'
 # Event count (approx.): 938
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
 # ...............  ..............  ...........  ..........
  ..................................................>
 #
           11.19%            2.6K        0.10%          21
                          [perf_iterate_ctx+48 -> >
            5.79%            1.4K        0.45%          97
            [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
            5.11%            1.2K        0.33%          71
                             [native_write_msr+0 ->>

 # Samples: 293  of event 'cache-misses'
 # Event count (approx.): 293
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
                                                  [>
 # ...............  ..............  ...........  ..........
   ..................................................>
 #
           11.19%            2.6K        0.13%          21
                          [perf_iterate_ctx+48 -> >
            5.79%            1.4K        0.59%          97
[__intel_pmu_enable_all.constprop.0+80 -> __intel_>
            5.11%            1.2K        0.43%          71
                             [native_write_msr+0 ->>

With the symbol_conf.event_group, the perf report should only report the
block information of the leader event in a group.
However, the current implementation retrieves the next event's block
information, rather than the next group leader's block information.

Make sure the index is updated even if the event is skipped.

With the patch,

 # Samples: 293  of event 'cache-misses'
 # Event count (approx.): 293
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
                                                  [>
 # ...............  ..............  ...........  ..........
   ..................................................>
 #
           37.98%            9.0K        4.05%         299
   [perf_event_addr_filters_exec+0 -> perf_event_a>
           11.19%            2.6K        0.28%          21
                          [perf_iterate_ctx+48 -> >
            5.79%            1.4K        1.32%          97
[__intel_pmu_enable_all.constprop.0+80 -> __intel_>

Fixes: 6f7164fa231a ("perf report: Sort by sampled cycles percent per block for stdio")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 930052961c1a..312396b52468 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -565,6 +565,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
 		struct hists *hists = evsel__hists(pos);
 		const char *evname = evsel__name(pos);
 
+		i++;
 		if (symbol_conf.event_group && !evsel__is_group_leader(pos))
 			continue;
 
@@ -574,7 +575,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
 		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
 
 		if (rep->total_cycles_mode) {
-			report__browse_block_hists(&rep->block_reports[i++].hist,
+			report__browse_block_hists(&rep->block_reports[i - 1].hist,
 						   rep->min_percent, pos, NULL);
 			continue;
 		}
-- 
2.38.1

