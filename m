Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5713B299
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jul 2024 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720293550; cv=none; b=KhHwbIOhvXF0rhN9f5v+bK9cYDu/neXKI9QUPvyUrhpOp4EaEfNHTB1wmH52NLhhV84lPd3+JYo7VeufCkzErio/F0cwCF85fx+z3ZsKQMBhotC8/6sWqWORyeT6rbiv3W8NtM1d6KEN3T4gC2576NGZdJdXfTSIFTobwt71P5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720293550; c=relaxed/simple;
	bh=CwcMWdZsT+Ihnz6vUVtHywUXMBgAVxNUzApIHUJLw2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMHIAdyn0QlrKuIN4EVx2pW/l64uteHahAMd4CFJzuvlNpV6pM09bLMEjU/ONHmPg44ArpWfDFiDXkIyWTpDxpvh/CWlT+NHhUSrVPPK3KjfxuakYUhP6SJDUyumf5XWURWrNlyt5cb7o45U61zHPoxmF0hEibAp3RTvkNk0f1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrJIqUbr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrJIqUbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720293549; x=1751829549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CwcMWdZsT+Ihnz6vUVtHywUXMBgAVxNUzApIHUJLw2o=;
  b=jrJIqUbr/JvW7BuO/Zzh85b9kG3kSwEcGqfHgqjICGxaJphp17O7PSON
   PyRdCxNWYneksi6Xikbwj8LSydQhq+WJ9f1Y55WC4VDQMOtKEYziq2J1k
   GhiuWCCGpXNLZ4wPji28GjrWmP2v19ETDhOog+86VGxp5P3ECQhElHqUM
   9jNikHxjgxV+C3UPs6BNY3F/3HfCxv9Gigf6aAtTFQJK3ocaeJT7N9xsB
   39WEcYLORLhnkm6qbWMNT4LMWrcsEdwGt0GMWTweR7liqDKbMy0DVkRGw
   CiVCjv4jBWaXvPiFczdORXXrXTj3pXokeqilBf45c9dwtRW2gV3ZAwl7/
   g==;
X-CSE-ConnectionGUID: rEhQb/ZLQmOsnJFWOhB5gA==
X-CSE-MsgGUID: cE+zWGjFRc6b/0qTpRhmjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="28696920"
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="28696920"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 12:19:04 -0700
X-CSE-ConnectionGUID: auqB3XhUTne2R6I2pb7Atw==
X-CSE-MsgGUID: ALltvu08T06+rd6ZEB0b+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,188,1716274800"; 
   d="scan'208";a="47785674"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 12:19:04 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 1/2] perf script: Fix perf script -F +metric
Date: Sat,  6 Jul 2024 12:18:56 -0700
Message-ID: <20240706191857.302450-1-ak@linux.intel.com>
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
v3: Avoid warning on some compilers
---
 tools/perf/builtin-script.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..95ba3f3cff60 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
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
@@ -4084,6 +4086,7 @@ int cmd_script(int argc, const char **argv)
 
 	perf_set_singlethreaded();
 
+	stat_config.aggr_map = &(struct cpu_aggr_map){ .nr = 1 };
 	setup_scripting();
 
 	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
-- 
2.45.2

