Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FF1A08B2;
	Tue, 13 Aug 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564900; cv=none; b=ZlaYAxP9kbffz3AlBts1l9SEvfUQ3qQzeoXs03tQmcNuNMf9xpmxeFWYLXGGYVJpEGttSFrBh6PXvGQd+ICfpFkhL3QzNrrrhzLSI72T3T0K6+kTldb4c5Eya62jFPPbxBIkSzwAYZsu6nPJwxQTqLM5ZmRbliNxaM1ktXVQlx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564900; c=relaxed/simple;
	bh=uaqPUDHCk+yLcH1dAcO1xohze5+IXSI+7YEmes/BJck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qj/phGuKDy6r7AkTj2JO84HxRu/DAeeU1NqS0ThvTYtcLNaa47g7txUqZte0L6TWvYXNZlkwMVBy8F3ntot0MMssrnX7ik1+CVCoRWZK6HSDENihLSKKoMbnJ5FKsGhbBGb/MZVgFfy5LZlTp9OeY5bziwExUIpB4veImkAREgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FB7K8sCv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FB7K8sCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723564898; x=1755100898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uaqPUDHCk+yLcH1dAcO1xohze5+IXSI+7YEmes/BJck=;
  b=FB7K8sCvXT4ekeclUBAHTzmZbaxYxCqpz6G+s2G49b9AmKyij617AzMd
   1pzPeEyo0i6YQz4jYwAcWDWriU4/Zc0UoVx/pU9k5yWT7On28YBjZvQ9b
   N0hT3N5s3fgc6e2dVZd02k6nRG6svB6sTOAQeMujdT6MKZp0dZJLr+aj1
   lWqa/jUAEwaX0tIt12flC3yCQhQTy/bRtVx/LBNZEvER71d70MCFwy73T
   q335R89GGni/AuQxHrbIIr8Pyig95lgM0bKBDRMcgHxOiPyXWV3v8p37A
   IoaUYlv3gJiCPE2tu8Dxoob/mh77VmrNXNP5Azu25wiRYzUiAhFaVz/e/
   w==;
X-CSE-ConnectionGUID: OfKD106ORguMj4BrzroJeQ==
X-CSE-MsgGUID: x4aTjU0EQs+5/6mIKj1HCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21383200"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21383200"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:01:36 -0700
X-CSE-ConnectionGUID: fyigixwAQKaBfC8Dz9wKhQ==
X-CSE-MsgGUID: 3FVWG5zCQbyunyVueRDEQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="59479739"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2024 09:01:36 -0700
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
Subject: [PATCH V3 1/9] perf report: Fix --total-cycles --stdio output error
Date: Tue, 13 Aug 2024 09:02:00 -0700
Message-Id: <20240813160208.2493643-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240813160208.2493643-1-kan.liang@linux.intel.com>
References: <20240813160208.2493643-1-kan.liang@linux.intel.com>
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
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index dfb47fa85e5c..04b9a5c1bc7e 100644
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

