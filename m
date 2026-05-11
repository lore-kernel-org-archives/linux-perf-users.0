Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9134C040D;
	Mon, 11 May 2026 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533729; cv=none; b=V2Nx/tLlcZsFKXYIXH0pLMWBrlN0E1DwpIxoJeudlyFfwwFq7Lk+ZQZrCDwQ+Ix8i/h3dQSXWwVh1pDHg1lJk7MJprAuaoLwuu7xv/j34Qe9gr/4W45BA3DU69qOH4dtIFWTIpAxLAbqw56qKrugGfybd/YJBeE2gwZuhQfG/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533729; c=relaxed/simple;
	bh=Ryidmgfi5UibYzSzCfY1nuZuGSpsz7iWemtK0KgeSTs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sP7hODQ9X4I0SO9wIbMkUKPdDIxL6qlnBB7QasIvIOadKr/kSgOIMp77r6GRptSbvZBzDUQWCn3QA5uMSynPGwMShq4bHSwFw68DvMx7yIeYZqa3gTQOw63gf7mJj7OoDmmVnYRlo61dRlnpPABx9CpGXYn43JHURVZ2lgpgCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=RDvQ0SGI; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="RDvQ0SGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778533727; x=1810069727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eNzCvmyPoJHv7GjfeNnSCdb6x1DDoviVPDF8/asFCi4=;
  b=RDvQ0SGIkCF1/ZYUFWJjoHTux/Rp1oP5Bwon9rP3y78MZ5cntuanxJ5X
   VwlNKC9XVhBTBJnpE9hlUgvZo3u561SZFNdrNt9yBHd4H4Gw6ZnT/k4c7
   0iuAT8reMgFQkh3ALtc6OT3H6z6bb7ygesQ6IlcZK9eaudqHmiIDPqSES
   AyAzrnzL74brxj+NSqlWL0LVE1dnNpSqDnjfqk3q1xVq/fOIvff/6ee7I
   qE5/osSDqy1l8oHib48G3VkJRZxYyPlr8ZFn4fGF88Yq8zO+hFMg22Omf
   ufhvVj695V2EVoqc5T70JmFx5uKZKWTyLdxGpBiSTFujE8GUeWysWSO2c
   Q==;
X-CSE-ConnectionGUID: w5o6Vl3FS+mX35RUhfE9Bg==
X-CSE-MsgGUID: 0Lt6xtzUS0q3P1iXi/JjmA==
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="19392228"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:08:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:1579]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.77:2525] with esmtp (Farcaster)
 id 33f22dde-e65e-459e-9e71-62964a26cef7; Mon, 11 May 2026 21:08:44 +0000 (UTC)
X-Farcaster-Flow-ID: 33f22dde-e65e-459e-9e71-62964a26cef7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 11 May 2026 21:08:43 +0000
Received: from dev-dsk-sauravsc-1a-8777b848.eu-west-1.amazon.com
 (172.19.118.34) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 11 May 2026
 21:08:41 +0000
From: Saurav Sachidanand <sauravsc@amazon.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Will Deacon <will@kernel.org>, Besar Wicaksono <bwicaksono@nvidia.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, Leo Yan
	<leo.yan@linux.dev>, <linux-perf-users@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<aghayev@amazon.com>, <juew@amazon.com>, Saurav Sachidanand
	<sauravsc@amazon.com>
Subject: [PATCH 1/3] perf vendor events arm64: fix swapped MetricGroup for Tegra410 L1 prefetcher metrics
Date: Mon, 11 May 2026 21:08:32 +0000
Message-ID: <20260511210832.91408-1-sauravsc@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The L1D prefetcher metrics (l1d_cache_rw_miss_ratio, l1d_demand_accesses,
etc.) were incorrectly assigned to MetricGroup "L1I_Prefetcher_Effectiveness"
and vice versa. This causes 'perf stat --metric-group L1D_Prefetcher_Effectiveness'
to display L1I metrics, which is misleading.

Swap the MetricGroup assignments so L1D metrics are in the L1D group and
L1I metrics are in the L1I group.

Fixes: 86ff690f45cc ("perf vendor events arm64: Add Tegra410 Olympus PMU events")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
---
 .../arch/arm64/nvidia/t410/metrics.json       | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
index b825ede03f544..59474ccb7417f 100644
--- a/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
@@ -346,42 +346,42 @@
         "MetricExpr": "l1d_demand_misses / l1d_demand_accesses",
         "BriefDescription": "This metric measures the ratio of L1 D-cache Read accesses missed to the total number of L1 D-cache accesses. This gives an indication of the effectiveness of the L1 D-cache for demand Load or Store traffic.",
         "ScaleUnit": "1per cache access",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_demand_accesses",
         "MetricExpr": "L1D_CACHE_RW",
         "BriefDescription": "This metric measures the count of L1 D-cache accesses incurred on Load or Store by the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_demand_misses",
         "MetricExpr": "L1D_CACHE_REFILL_RW",
         "BriefDescription": "This metric measures the count of L1 D-cache misses incurred on a Load or Store by the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_prf_accuracy",
         "MetricExpr": "100 * (l1d_useful_prf / l1d_refilled_prf)",
         "BriefDescription": "This metric measures the fraction of prefetched memory addresses that are used by the instruction stream.",
         "ScaleUnit": "1percent of prefetch",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_prf_coverage",
         "MetricExpr": "100 * (l1d_useful_prf / (l1d_demand_misses + l1d_refilled_prf))",
         "BriefDescription": "This metric measures the baseline demand cache misses which the prefetcher brings into the cache.",
         "ScaleUnit": "1percent of cache access",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_refilled_prf",
         "MetricExpr": "L1D_CACHE_REFILL_HWPRF + L1D_CACHE_REFILL_PRFM + L1D_LFB_HIT_RW_FHWPRF + L1D_LFB_HIT_RW_FPRFM",
         "BriefDescription": "This metric measures the count of cache lines refilled by L1 data prefetcher (hardware prefetches or software preload) into L1 D-cache.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_tlb_miss_ratio",
@@ -402,7 +402,7 @@
         "MetricExpr": "L1D_CACHE_HIT_RW_FPRF + L1D_LFB_HIT_RW_FHWPRF + L1D_LFB_HIT_RW_FPRFM",
         "BriefDescription": "This metric measures the count of cache lines refilled by L1 data prefetcher (hardware prefetches or software preload) into L1 D-cache which are further used by Load or Store from the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_cache_miss_ratio",
@@ -423,42 +423,42 @@
         "MetricExpr": "l1i_demand_misses / l1i_demand_accesses",
         "BriefDescription": "This metric measures the ratio of L1 I-cache Read accesses missed to the total number of L1 I-cache accesses. This gives an indication of the effectiveness of the L1 I-cache for demand instruction fetch traffic. Note that cache accesses in this cache are demand instruction fetch.",
         "ScaleUnit": "1per cache access",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_demand_accesses",
         "MetricExpr": "L1I_CACHE_RD",
         "BriefDescription": "This metric measures the count of L1 I-cache accesses caused by an instruction fetch by the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_demand_misses",
         "MetricExpr": "L1I_CACHE_REFILL_RD",
         "BriefDescription": "This metric measures the count of L1 I-cache misses caused by an instruction fetch by the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_prf_accuracy",
         "MetricExpr": "100 * (l1i_useful_prf / l1i_refilled_prf)",
         "BriefDescription": "This metric measures the fraction of prefetched memory addresses that are used by the instruction stream.",
         "ScaleUnit": "1percent of prefetch",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_prf_coverage",
         "MetricExpr": "100 * (l1i_useful_prf / (l1i_demand_misses + l1i_refilled_prf))",
         "BriefDescription": "This metric measures the baseline demand cache misses which the prefetcher brings into the cache.",
         "ScaleUnit": "1percent of cache access",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_refilled_prf",
         "MetricExpr": "L1I_CACHE_REFILL_HWPRF + L1I_CACHE_REFILL_PRFM",
         "BriefDescription": "This metric measures the count of cache lines refilled by L1 instruction prefetcher (hardware prefetches or software preload) into L1 I-cache.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_tlb_miss_ratio",
@@ -479,7 +479,7 @@
         "MetricExpr": "L1I_CACHE_HIT_RD_FPRF",
         "BriefDescription": "This metric measures the count of cache lines refilled by L1 instruction prefetcher (hardware prefetches or software preload) into L1 I-cache which are further used by instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l2_cache_miss_ratio",
-- 
2.47.3

