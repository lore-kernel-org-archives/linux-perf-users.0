Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2AD12E1C7;
	Tue,  2 Jul 2024 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902385; cv=none; b=P/EGnt3Dfhj6OJs0FFU/Du9IMda6EwX0xUnexXc/i58+1xroj28MJbeJMcnmQxzabSCyblgKV2Kz5oaQTeXFvSKEC2Ca1paSHMLjvAhVskJkTX4qDOOfPJhpA62nNB3f99wjgRSpbGSpBetv/zbiTWxaJuJUFCq0oH9CiPCFIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902385; c=relaxed/simple;
	bh=ZClm0i5H0Il54cRWuWGyDTiX2aGbpAZRjtMpNeIqxLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIS2S9TTKzUQnZAMTpDJUM1m39PbnarUg0HZ4kEz7fRY5mzMWMuiw04sPavT3TmpYRWcf+p3+Wi+EwR7QjvwR65DUbVA1e5wG9/kkUMRFtUdB/oeTuvU+xiqT1izs5QtEbH51R+BxnFPeRpMV4w4om1KSHLYKL1xWTvGjpWjyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfdxGojK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfdxGojK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902384; x=1751438384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZClm0i5H0Il54cRWuWGyDTiX2aGbpAZRjtMpNeIqxLM=;
  b=nfdxGojKfXeIh1KziKu5TDLFQxrnS7V59xBMUTn6nXURIW4XgqHqGvjc
   k3Rp1bptiQK7GkD602FKF8ThoijoOdkgAl+jwZj3r2OwSvgf9qZyEGaQ6
   IOxXlFdFV1Tv84NkwhorUcpR+pof6eP+Gif4v6nA27zA1gGPHf8Zsahf5
   L+9fDaAc63BXRTgfGnKQ4ixBYjiivN6CmV1G6nRjRX8KIOcsedj1eP2fW
   ayt6q7Q4LFjChJrSeIaGNtcvR1rCvEMELtubPOD8JyKuJivfQSLkGMbn+
   JPgghUzYEeGsGv65T2M8CoeCwwmxnRCxqlHg8vJJTRLHWddjS1yHGtBKJ
   A==;
X-CSE-ConnectionGUID: ArXHdOayS4yz6PpPZpgyCw==
X-CSE-MsgGUID: Nshp4690RniwlQqpi3Jnog==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20868287"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20868287"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:39:44 -0700
X-CSE-ConnectionGUID: z09Xz4fLQrymbBuPBA8HpA==
X-CSE-MsgGUID: ulAMclR3Saero1o9YjqWXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45926345"
Received: from unknown (HELO dell-3650.sh.intel.com) ([10.239.159.147])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2024 23:39:40 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanfei Xu <yanfei.xu@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/4] perf topdown: Correct leader selection with sample_read enabled
Date: Wed,  3 Jul 2024 06:40:34 +0800
Message-Id: <20240702224037.343958-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
References: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Addresses an issue where, in the absence of a topdown metrics event
within a sampling group, the slots event was incorrectly bypassed as
the sampling leader when sample_read was enabled.

perf record -e '{slots,branches}:S' -c 10000 -vv sleep 1

In this case, the slots event should be sampled as leader but the
branches event is sampled in fact like the verbose output shows.

perf_event_attr:
  type                             4 (cpu)
  size                             168
  config                           0x400 (slots)
  sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
  read_format                      ID|GROUP|LOST
  disabled                         1
  sample_id_all                    1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             168
  config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
  { sample_period, sample_freq }   10000
  sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
  read_format                      ID|GROUP|LOST
  sample_id_all                    1
  exclude_guest                    1

The sample period of slots event instead of branches event is reset to
0.

This fix ensures the slots event remains the leader under these
conditions.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/topdown.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 3f9a267d4501..5d7b78eb7516 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "api/fs/fs.h"
 #include "util/evsel.h"
+#include "util/evlist.h"
 #include "util/pmu.h"
 #include "util/pmus.h"
 #include "util/topdown.h"
@@ -41,11 +42,22 @@ bool topdown_sys_has_perf_metrics(void)
  */
 bool arch_topdown_sample_read(struct evsel *leader)
 {
+	struct evsel *event;
+
 	if (!evsel__sys_has_perf_metrics(leader))
 		return false;
 
-	if (leader->core.attr.config == TOPDOWN_SLOTS)
-		return true;
+	if (leader->core.attr.config != TOPDOWN_SLOTS)
+		return false;
+
+	/*
+	 * If slots event as leader event but no topdown metric events in group,
+	 * slots event should still sample as leader.
+	 */
+	evlist__for_each_entry(leader->evlist, event) {
+		if (event != leader && strcasestr(event->name, "topdown"))
+			return true;
+	}
 
 	return false;
 }
-- 
2.40.1

