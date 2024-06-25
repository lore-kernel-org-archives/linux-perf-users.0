Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73DD946F
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276162; cv=none; b=pzv6u9EHzoULaZNXRxwhHg5zO7y/uYc3ICjmFujDS1izQlD3EIWAxZaWuJ7RwaI7Rg7iEHD5BYvvBH7pw6lc2acXQnNpSGm+FoZI3sXZ9pnKeACHfatfVNKOyCwXraGJfbBpL2942c3sk1Ejdb7tRmJiiNSDHOBICqITU4UNYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276162; c=relaxed/simple;
	bh=i9C/s15/iV1aO9tsxvbeWKF+0zEzxt7Hy+keKzhqQd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDqB8FrdQzabXAmg/Cg47qJH1ciwa9yCqtssOCgXosEpq+qWseMwjiHW5WOM/1R6CI6wqIwpgnbnbzMI75n50DE8TBkz3y2KOq0EaIcnwuJhPQUuYPFZwa5InDt5NnLlAQO61RrHupUNYUA+5/uy+3mRlNoBeAqLitoQZx3tnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aW6bx3iQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aW6bx3iQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719276161; x=1750812161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i9C/s15/iV1aO9tsxvbeWKF+0zEzxt7Hy+keKzhqQd4=;
  b=aW6bx3iQoo6bITao77rfpUYfwAyQVyBu+39zTBxiMtAUHbv/FeuDpQ4b
   +uzXeKgdLgTVd0iUIAxe2lhHAprowi0gHeX9ubak2QabBxoKltsRYqnAD
   vBJkzrz67ItDRqoAVXi4fBqpzNjw7gj/N/ilu3j6lv3n4v9qRf91x+qgD
   S5zWAdpH7Pz0+U+dQToKuqRmGkOhgZZLcw11OeEuje0VvAQBvUIEjveT6
   mUD//8oakxILmYNQhmM3cmZLot5NHI5gcENty5ItA3SnLE9zkWL0lC1Yg
   5zKswUTIhW+YvkNrPb4NvTswmfXE3bCriqKMzjx+rOBXLWsXwpDE2zty+
   g==;
X-CSE-ConnectionGUID: DgYn2GzXTBSmJVZBkuBuzg==
X-CSE-MsgGUID: IEdoZ55SR5SeLQvvurCYxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="27680385"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="27680385"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:42:40 -0700
X-CSE-ConnectionGUID: 5MWwh2CqRvqh51uubK9ODw==
X-CSE-MsgGUID: LPKCeEJSTpuQH04aboEyDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43451505"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:42:40 -0700
From: Andi Kleen <ak@linux.intel.com>
To: linux-perf-users@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/2] perf script: Fix perf script -F +metric
Date: Mon, 24 Jun 2024 17:42:31 -0700
Message-ID: <20240625004232.1852705-1-ak@linux.intel.com>
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
---
 tools/perf/builtin-script.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..4aab194b4b1a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -84,7 +84,7 @@ static bool			system_wide;
 static bool			print_flags;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
-static struct perf_stat_config	stat_config;
+static struct perf_stat_config	stat_config = { .aggr_map = &(struct cpu_aggr_map){ .nr = 1 } };
 static int			max_blocks;
 static bool			native_arch;
 static struct dlfilter		*dlfilter;
@@ -2133,12 +2133,14 @@ static void perf_sample__fprint_metric(struct perf_script *script,
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

