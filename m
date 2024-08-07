Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D03250EC
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072716; cv=none; b=iS1p/BWlcNUxM4KpWjvU3qIRQomm1Lpow6Q/VZ3V9htVAC9YR+tiKb4Akq2J7knXy6DjRQtFRvDiqAU5aDsIwuuVJiXkdeQmkh0xnrEkqhpJauCFRF4UgDzjJzatwKsezZZ2smHlRI/MZmXKNSgSfYMicSK5JbeoJWSNRkroU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072716; c=relaxed/simple;
	bh=VIVzFXCGly/jRSXp55yscYkbnMptL5Ve9RoIovdTrAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eemxaJh5cWbdkCGLYF6/AVVRf4jwGgttH3VGg5woqcBQk46/XsdVCEsTTEV/XivbGYNPrVSxPk18Hfu+YdHrWDN+AbRUSRli7258Ns9LPUoWkPY+eT3Gv9TA0wTAMlM7oFDi+I4ipeF0U/6hguupFlqc3/k/AymAL1R5+b/JL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXvo9vTg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXvo9vTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723072715; x=1754608715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VIVzFXCGly/jRSXp55yscYkbnMptL5Ve9RoIovdTrAc=;
  b=IXvo9vTgs9CvnJljAn1hz0Vk7FJeQj2eDOCSLv1NqdGEdzrL/rJyxRkF
   LnJLdjTEStHB7o8chJe59Dbjs7jUTtIh2N+uJikRymEs0QutgkBUd9cpX
   xhJAEVi/pPiqLPTl53L/B5DBjTUYe9Ek9SF+wigt+AH4/IWPmNrLkQivS
   /sUTNdpL1Tyc16dVd13DgsJak/Cd+YKcegjScrMzf2Ezx2l5v71D8Hzx8
   zRWVnz/Q1WQLXUsgb96GEIEJYdQwA4858wYWMOkfMmGnbP3aAxGvIDOWo
   NknHWHhg66tzozqerQusBmBnghiIsVgqjTkclqd9R++VKXhZfAM5Dw5Sx
   g==;
X-CSE-ConnectionGUID: iZUHGF7yRTCRfVrhcQROvQ==
X-CSE-MsgGUID: fHqkAJnvRiOoyRdI9+E7Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32577982"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="32577982"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:18:33 -0700
X-CSE-ConnectionGUID: 0llS4y8HRK6hFnzHrfID/Q==
X-CSE-MsgGUID: XKZysWO/QgCDNiqheT0Vww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="87935093"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 16:18:33 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v9 3/4] perf script: Fix perf script -F +metric
Date: Wed,  7 Aug 2024 16:18:22 -0700
Message-ID: <20240807231823.898979-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807231823.898979-1-ak@linux.intel.com>
References: <20240807231823.898979-1-ak@linux.intel.com>
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
v3: Work around bogus warning
v4: Set up aggr map only for metrics case to keep perf stat record
working
v5: Broken version
v6: Only set up limited aggregation mode with -F +metric. Add conflict
checks with perf stat record files.
v7: Remove some unnecessary conflict checks. Fix buffer overflow. Minor cleanups.
v8: Add check for leader sampling. Update some comments.
v9: Correct check for leader sampling (Namhyung)
v10: Check for PERF_FORMAT_GROUP and PERF_SAMPLE_READ (Namhyung)
---
 tools/perf/builtin-script.c | 51 +++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..cb63507af839 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -335,7 +335,6 @@ struct evsel_script {
        FILE *fp;
        u64  samples;
        /* For metric output */
-       u64  val;
        int  gnum;
 };
 
@@ -2127,18 +2126,31 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	};
 	struct evsel *ev2;
 	u64 val;
+	static int printed;
 
 	if (!evsel->stats)
 		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
 	if (evsel_script(leader)->gnum++ == 0)
 		perf_stat__reset_shadow_stats();
-	val = sample->period * evsel->scale;
-	evsel_script(evsel)->val = val;
+	val = sample->period;
+	if (!(leader->core.attr.read_format & PERF_FORMAT_GROUP) ||
+	    !(leader->core.attr.sample_type & PERF_SAMPLE_READ)) {
+		if (!printed)
+			fprintf(stderr, "perf script: -F metric requires {}:S for groups leader sampling\n");
+		printed = 1;
+		return;
+	}
+	/*
+	 * Always use the first entry as storage because the leader sampling
+	 * groups are contiguous and there's no need to handle multiple indexes
+	 * for anything.
+	 */
+	evsel->stats->aggr[0].counts.val = val;
 	if (evsel_script(leader)->gnum == leader->core.nr_members) {
 		for_each_group_member (ev2, leader) {
 			perf_stat__print_shadow_stats(&stat_config, ev2,
-						      evsel_script(ev2)->val,
-						      sample->cpu,
+						      evsel->stats->aggr[0].counts.val,
+						      0,
 						      &ctx,
 						      NULL);
 		}
@@ -2325,6 +2337,20 @@ static void process_event(struct perf_script *script,
 		fflush(fp);
 }
 
+static void check_metric_conflict(void)
+{
+	int i;
+	/*
+	 * Avoid conflict with the aggregation mode used for the metric printing.
+	 */
+	for (i = 0; i < OUTPUT_TYPE_MAX; i++) {
+		if (output[i].fields & PERF_OUTPUT_METRIC) {
+			fprintf(stderr, "perf stat record files are not supported with -F metric\n");
+			exit(1);
+		}
+	}
+}
+
 static struct scripting_ops	*scripting_ops;
 
 static void __process_stat(struct evsel *counter, u64 tstamp)
@@ -2334,6 +2360,8 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 	struct perf_cpu cpu;
 	static int header_printed;
 
+	check_metric_conflict();
+
 	if (!header_printed) {
 		printf("%3s %8s %15s %15s %15s %15s %s\n",
 		       "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVENT");
@@ -3725,6 +3753,8 @@ static int process_stat_config_event(struct perf_session *session __maybe_unused
 {
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
 
+	check_metric_conflict();
+
 	/*
 	 * Aggregation modes are not used since post-processing scripts are
 	 * supposed to take care of such requirements
@@ -4088,6 +4118,17 @@ int cmd_script(int argc, const char **argv)
 
 	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	for (i = 0; i < OUTPUT_TYPE_MAX; i++) {
+		if (output[i].fields & PERF_OUTPUT_METRIC) {
+			stat_config.aggr_map = cpu_aggr_map__empty_new(1);
+			err = -ENOMEM;
+			if (!stat_config.aggr_map)
+				goto out;
+			err = 0;
+			stat_config.aggr_map->nr = 1;
+			break;
+		}
+	}
 
 	if (symbol_conf.guestmount ||
 	    symbol_conf.default_guest_vmlinux_name ||
-- 
2.45.2

