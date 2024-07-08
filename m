Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B336AEC;
	Mon,  8 Jul 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424445; cv=none; b=Q85PXcfijWNQYmcOploZu7r3HkOrG2/iP4LIVl+DLJfFXbKqBdNK9xMiaNwH44nqTbcTe4LdF7EK4xRgcX/rwZIkuvCwCK3Rto/JSJsX/MhlnAduw+v0/LgSb7PfyJt9fS8pUoPm+rutxZR0PjnkgYWo987LRRNyNHsAzRMIOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424445; c=relaxed/simple;
	bh=7mAASb3q0AC2znNgA2IO5PLY0spJ6CZck3SPO0Z0fSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFSQENWn5GGh8dDcnBCHj7N39Idk7TKuKAgD/L6G26NEz1X99en7pGO5wJ9VesDo4YtktUoLlUhv9iiy75B9gNhkzSRp5Rj3mMDJSJ76a1dQ0BWtYYk/0yr64JjSdr0h6bXnfJ+RPzLXR0AyrmiZSGsdVU1RAEZHHFsdlWpzU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnG2ihLT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnG2ihLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720424444; x=1751960444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mAASb3q0AC2znNgA2IO5PLY0spJ6CZck3SPO0Z0fSA=;
  b=RnG2ihLTW6gfOwGGFrQRrNWQcKEGvbLfKywgHSxSXpBkLWQMv5hBYAhY
   V4uu5p4RNzwyomFHf3uS9RxdLpABBpCUM8zs7JwTCSSrCIu3qAASycorT
   YejXcbrYeqTg7ZCiSU/LhMwfzRrnafYL/HdIYZ9fJQf/urHRC0PNb+nZD
   e3Vr3/t0U5U3y6voZEgWqsbTz7R7PjZYj8ztapRdr1TN+LF5QY7/D6wrX
   ZzdOd7J4RXIunmAVrEoTSJ+9DtmO7pJbAsy++b6nvrkpNRMcQ75r8pf/q
   7+b1vCNfhN77lc0dRgE2wD2MfBRiKbhG+pXKtmoLU6CXupeXNkonNetXC
   Q==;
X-CSE-ConnectionGUID: qhojni5MRpujBgU+7dFBnQ==
X-CSE-MsgGUID: 1RXOK5/qRueSr8HJOuhnPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17819224"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17819224"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:40:44 -0700
X-CSE-ConnectionGUID: c3AdZ3cLStWo5N7dyCGgyg==
X-CSE-MsgGUID: i6kNOmSPQv6ja/3BjhPzGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51774095"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2024 00:40:41 -0700
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
	Yongwei Ma <yongwei.ma@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 2/5] perf x86/topdown: Correct leader selection with sample_read enabled
Date: Mon,  8 Jul 2024 14:42:01 +0000
Message-Id: <20240708144204.839486-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
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
index e805065bb7e1..b9210f6486fd 100644
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
@@ -82,11 +83,22 @@ bool arch_is_topdown_metrics(const struct evsel *evsel)
  */
 bool arch_topdown_sample_read(struct evsel *leader)
 {
+	struct evsel *evsel;
+
 	if (!evsel__sys_has_perf_metrics(leader))
 		return false;
 
-	if (arch_is_topdown_slots(leader))
-		return true;
+	if (!arch_is_topdown_slots(leader))
+		return false;
+
+	/*
+         * If slots event as leader event but no topdown metric events
+         * in group, slots event should still sample as leader.
+         */
+	evlist__for_each_entry(leader->evlist, evsel) {
+		if (evsel != leader && arch_is_topdown_metrics(evsel))
+			return true;
+	}
 
 	return false;
 }
-- 
2.40.1

