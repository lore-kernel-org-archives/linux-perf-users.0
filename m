Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576C1CD37
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jul 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720886090; cv=none; b=EbzFnKQEGOMm9Q/HXe4U/v6FTS3DnHA7S7LkJHFMVwoFURU3IiXle4GpiA0wzG0Weu9zC23hFLLhm10O2IMHecAegKf9imtqAUiNRrjbX/kK75U6G1cPBPgfzOYNFt7CT/UPu+wXPhHjxhUH7o8RT4zzgwgt1u7H5JFA9+Nbc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720886090; c=relaxed/simple;
	bh=7O+xd6KnGT7y4Osb/5tJ23WcCEVWY0aD/9jOrhAnUBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlf61WS7VT3+Qnud7G3kNrdIqLb3wVO3RQGYH6TTYMyZCGo+T3GjdamoiXKqdL0GV7twLUpCGl03wMCQMakWuJQB/XGznJe8S3KckdR0vgUVniwusuxqu37xXMt6A77hFYcrHvovIsAm3e8qCe5rEhvO2WUNzhqeBIIgmnIXgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S96C85Un; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S96C85Un"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720886089; x=1752422089;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7O+xd6KnGT7y4Osb/5tJ23WcCEVWY0aD/9jOrhAnUBo=;
  b=S96C85UnKdbsxFSwpCMvhnnx7rENvZSHRzbYsCIuci8qx93RlvfUD35L
   VKXJ30fCePBMeNM5OPssfTlwSthTFjJPpwGozGMUgi+rlZQ0Ms6AQRAXb
   Yzh1ene2YiJ1h18sb+7NPEg8KKYe6JCH56HoLDe7vNo7lnZ8wNPVl9cmh
   Ieo/AiNf4rGDuSqu1Gsxyu8MKQlr/5CU8RLRKxX9HqoAjhbAhimM7vrt6
   cSGqKlNGuoTzFIFDjAwm8P4mUE+a+sNE1P1pnjKlp4QRYJNKEixWze54J
   Za78znFzVQvaxnN7zgo5a1g6vwD2Qzw7i1ifrXtv+jIviWVRq1J3I85kp
   g==;
X-CSE-ConnectionGUID: Qe5Mg4W7QtOmHYQJT1sF0A==
X-CSE-MsgGUID: Hdun9SbLRemgsuEPdnNo/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="18130076"
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="18130076"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 08:54:49 -0700
X-CSE-ConnectionGUID: 41VwPxWmR7WoBUeT5gG9sg==
X-CSE-MsgGUID: qnCraGpFSxu/hroCvqeSDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="48920633"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 08:54:48 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 1/2] perf script: Fix perf script -F +metric
Date: Sat, 13 Jul 2024 08:54:42 -0700
Message-ID: <20240713155443.1665378-1-ak@linux.intel.com>
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
v3: Work around bogus warning
v4: Set up aggr map only for metrics case to keep perf stat record
working
---
 tools/perf/builtin-script.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..33b5c7af5071 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2127,23 +2127,29 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	};
 	struct evsel *ev2;
 	u64 val;
+	struct cpu_aggr_map *map;
 
 	if (!evsel->stats)
 		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
 	if (evsel_script(leader)->gnum++ == 0)
 		perf_stat__reset_shadow_stats();
 	val = sample->period * evsel->scale;
+	map = stat_config.aggr_map;
+	stat_config.aggr_map = &(struct cpu_aggr_map){ .nr = 1 };
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
 		evsel_script(leader)->gnum = 0;
 	}
+	stat_config.aggr_map = map;
 }
 
 static bool show_event(struct perf_sample *sample,
-- 
2.45.2

