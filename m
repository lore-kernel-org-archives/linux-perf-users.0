Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248547EF
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533105; cv=none; b=uyhuPTzTatnCGFOhMb6+UhI6hODKmTx2nmV2/MNkJDbyr2ItFOeD12agveB7F88He4HLiip6JYguJip/VvfvhGcV+9zn8S1nDP39u8Vaair0cno8d/dJGasn83u3Zwn3P0sPyNTNrRnSqC3MVpvI6/A9MZG6rlmUd6MieIsuP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533105; c=relaxed/simple;
	bh=2S2eeAAyVC2kRrfOQfklRvIHNdC0Rf1Ion7XJavKtDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lwllXTjpgBiSwziJ7+B67A9BRyTmT/hQ9Jr37EvvaCYLymDyug+MSPS3XYeXSMl1szkN2Ggt6xZBTbYrTiSp3pRX0DD+Z0IBjxBS1OmrJNwrgT4t6JxWFI6pP4CLhjfwg7FBc023JV3Bl1sFt6VnptBvGbs2gcLCw6PnH+2Rug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBVJmAqy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBVJmAqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719533104; x=1751069104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2S2eeAAyVC2kRrfOQfklRvIHNdC0Rf1Ion7XJavKtDo=;
  b=oBVJmAqySv/nJtBKDQgycdqw6biRR1dgWeE5r2bxIwTH9GCe/REmG3E7
   UXyDH7nsJPSrtJKvBSdOD56UVlCNxHJk+E38MeDFUJvXaghpPFCBocVqm
   AsjvThtIVfe4MmjkqDG1NaIoq2+R7l4SIGh40pHzb8R20hCqmU6Ze8mhC
   4ZvDSl8cNCjjZ9fWXJx+QQ8ciFNvWzLyDd7iVkkiUftTUS1PRWN/dEP3s
   ZcfHBBR8uU/iLUMFF7AUE483kPR5TX8ij64IspoBijNCdHSgj0u0x49nY
   ivCHhILx9VEqjBsNpoonQ9yy01FKexRHl5qP3vemBS0zjUpyaMfci60Wh
   w==;
X-CSE-ConnectionGUID: zG3fkviMS+O4H8zckZmSdA==
X-CSE-MsgGUID: QoZPdzkLSwubOhp/bQwIcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16535363"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16535363"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 17:05:04 -0700
X-CSE-ConnectionGUID: yH2/Fq1/RLqgBgDc8NnfDg==
X-CSE-MsgGUID: xU1l6+m2RjG4Rvno0CNHqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="49148548"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 17:05:03 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/2] perf script: Fix perf script -F +metric
Date: Thu, 27 Jun 2024 17:04:54 -0700
Message-ID: <20240628000455.1890269-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a regression with perf script -F +metric originally caused by :

commit 37cc8ad77cf81f3ffd226856c367b0e15333a738
Author: Ian Rogers <irogers@google.com>
Date:   Sun Feb 19 01:28:46 2023 -0800

    perf metric: Directly use counts rather than saved_value

In the perf script environment the evsel wouldn't allocate an aggr
values array, which led to a -1 reference because the metric
evaluation would try to reference NULL - 1 (for aggr_idx)

Give the perf script evsels a single CPU aggr setup. That's
enough because the groups are always contiguous, so no need
to store more than one CPU's worth of values.

Before

% perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
% perf script -F +metric
Segmentation fault (core dumped)

After:

% perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.028 MB perf.data (90 samples) ]
% perf script -F +metric
       perf-exec 1847557 264658.180789:       3009       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
       perf-exec 1847557 264658.180789:        382 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
       perf-exec 1847557 264658.180789:         metric:    0.13  insn per cycle
...

Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather ...")
Signed-off-by: Andi Kleen <ak@linux.intel.com>

--

v2: Reformat code
---
 tools/perf/builtin-script.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..0aeff280fa55 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -84,7 +84,9 @@ static bool			system_wide;
 static bool			print_flags;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
-static struct perf_stat_config	stat_config;
+static struct perf_stat_config	stat_config = {
+	.aggr_map = &(struct cpu_aggr_map){ .nr = 1 }
+};
 static int			max_blocks;
 static bool			native_arch;
 static struct dlfilter		*dlfilter;
@@ -2133,12 +2135,14 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	if (evsel_script(leader)->gnum++ == 0)
 		perf_stat__reset_shadow_stats();
 	val = sample->period * evsel->scale;
+	/* Always use CPU 0 storage because the groups are contiguous. */
+	evsel->stats->aggr[0].counts.val = val;
 	evsel_script(evsel)->val = val;
 	if (evsel_script(leader)->gnum == leader->core.nr_members) {
 		for_each_group_member (ev2, leader) {
 			perf_stat__print_shadow_stats(&stat_config, ev2,
 						      evsel_script(ev2)->val,
-						      sample->cpu,
+						      0,
 						      &ctx,
 						      NULL);
 		}
-- 
2.45.2

