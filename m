Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEC82890;
	Fri, 16 Aug 2024 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790749; cv=none; b=JGHGJ0NTK8JHxbHJlZf0usb088SuiMfUuTZUepBnsd4OghVf6FaNbSeFikrmJwrM/RONhKlhamWJrJrq6yaC8mkVfMPIW0Q/oEzNeePkdqA195ByN/oLDdSmaO2y4pXul3/+rdhYHhiqYwTh3fJno7ScQd3MIiCwBZpF5pMBOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790749; c=relaxed/simple;
	bh=n1IW3cJiQOA07ZWVTOc4/XAvaItKxA0tfFMoaRScEHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFGvr3ZCr1owdWex4wrXOsdoeN4Q93Lkz23U3U4SGTlbxQ24aM7qjVM6o7z4IGuPxxjIwr2VJ7keQUtw6AtA53tSpUT45uCSqA50qpwA+KMMn7L7H4qcAujruF3MVhjDnLvnyZ0aREEHpQ7ex51C7fVcn+7EtNHyPYbzpzRP8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdUVUk1p; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdUVUk1p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790748; x=1755326748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n1IW3cJiQOA07ZWVTOc4/XAvaItKxA0tfFMoaRScEHg=;
  b=hdUVUk1p6nyZ7vE6OL0jaLeANGpMK9lbiIXBrDcRZnHVe9Zq/ajR6YAT
   eQ8jf8fZfkNg1/CZBOPkGhENVMXnwG0yJGXuTzAa2q14L7fCv5OcK5NH1
   devEEFaii9gQ3fewd4o2KJPpxXSDPq68jsijTFisys2bfWENSWxkju/c6
   GbnebJtYBjrS+NwXJ20ptXEPWmEk83/SW5daW75cktAysCWDpYm8fUPVY
   1gU1AifDYhFXVvDai0k6Rvrk2/vFIZ+64bnU2PUYL4ZeF9N/oFkXwc4qn
   +I+Dcu4/b+H57RdnCQqS2Lwo+BjDW2Bz2LxEy3FfdZHJpB4om1odNKE+Q
   g==;
X-CSE-ConnectionGUID: qf/8q4WhRqK1HyuAvsmXZw==
X-CSE-MsgGUID: Z7eLSL2oQCigxBuUH7OJKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39530751"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39530751"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:45:47 -0700
X-CSE-ConnectionGUID: eDbwGywRQTKdtsdoLIze7w==
X-CSE-MsgGUID: drOt/agRRMi3kMekqACZbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60150019"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2024 23:45:43 -0700
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
Subject: [Patch v4 2/6] perf x86/topdown: Correct leader selection with sample_read enabled
Date: Fri, 16 Aug 2024 12:29:34 +0000
Message-Id: <20240816122938.32228-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
References: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
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
 tools/perf/arch/x86/util/topdown.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 49f25d67ed77..cb2c64928bc4 100644
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
@@ -87,11 +88,24 @@ bool arch_is_topdown_metrics(const struct evsel *evsel)
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
+	 * If slots event as leader event but no topdown metric events
+	 * in group, slots event should still sample as leader.
+	 */
+	evlist__for_each_entry(leader->evlist, evsel) {
+		if (evsel->core.leader != leader->core.leader)
+			return false;
+		if (evsel != leader && arch_is_topdown_metrics(evsel))
+			return true;
+	}
 
 	return false;
 }
-- 
2.40.1

