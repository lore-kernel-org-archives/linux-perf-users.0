Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD7184E
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969666; cv=none; b=ptJ24Xqkrb65sz4VfYC6Q9+uwy7SNz2Kf4AeHIuRhxBKynUmgKL0V5LM4xBDRzi5u8aEPG4G1QBhwXav9P2kk/ezLS8xqNeMPT2/5rszx3fDLqBtM2CekzPJ8pmqT1vhTBEndRPLQDq6+gbZ53G3li4w/Er/MaVzOhxdSO7Zncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969666; c=relaxed/simple;
	bh=8tVm6/8TfieCzYqDQdMF0XFWpNtUQtw9cxeIbq1pt3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+PakAzxbvByPDjHEjwZzMYdH05wPur5MZHuQpvwSJjn3Z1Kj8ue67/EQzucdbEulP3r+XVPYjZETragaYMHGG3Y8N0E6+vQjZeM7NA6cnmOzDNznfDW7M7jN7psoes8meLaeT47p6qxXwFlyz+DVpgXY7/zfOIR+dUQ4nuYnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyMWRB1N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyMWRB1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719969661; x=1751505661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8tVm6/8TfieCzYqDQdMF0XFWpNtUQtw9cxeIbq1pt3I=;
  b=fyMWRB1N55UbU33wh3YxEhtwpHRSr0FyoLCAlmGdkPARKJGd6wqqT2uj
   o+6W8BwJ1qTcYp7ZyAVHpsx0ITqmNhG82gX4R5tch5lF2ZN/7PWjmiyXY
   jIsfEI6hPgV19M/moI2CQfEUT1VgwYSrzVvUzsEIksJ9PA7mAFeWK/ZEq
   X7Z/K/2VaRpGYSOelgkHNvpk/9Lv1woTqSFGcM7r17jXXFikU7h05J5im
   faQ2FdjmMM3d5OqXeFKu4xN+cYLGiZRBJpWJ+5BLndG6pkLqMsIpfNJF9
   PcEFcl3NXiz/rgEA6p/8/Rv15Ipgi88fp9BKEGa33rJ3+jyzEldXiRUBM
   Q==;
X-CSE-ConnectionGUID: 7ujJBo6CSXmiwO7xqGED6Q==
X-CSE-MsgGUID: kUX2ZfaXT+aBPDvPa/bKgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20942435"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="20942435"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 18:21:01 -0700
X-CSE-ConnectionGUID: jY5nHIGAR/Oi+zVKcRkRsw==
X-CSE-MsgGUID: CuxXEtauREqafsLc7VNQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="46065672"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 18:21:00 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 1/2] perf script: Fix perf script -F +metric
Date: Tue,  2 Jul 2024 18:20:46 -0700
Message-ID: <20240703012047.178561-1-ak@linux.intel.com>
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

----

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

