Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84715B107;
	Fri, 12 Jul 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779697; cv=none; b=XoCAo339Wkt6lqae5THvDee4gDe7+VeQF76m0YPD0NXwye8hdHlVqofezGdT4R50fEs5kDEQ4ADDt+DWPNvskSna45BA2VSM0Kz8AI41aeUHeRa6usAfhzZEIe80Cg8PNXLadUWnHL1LJpQ4GHAkqmmjfluZxqtKMNx249JW4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779697; c=relaxed/simple;
	bh=6BwyhI1ygNz4RFIi5YJoddlQb3Ig5C1L4xGiisWXOeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=keUhovM9R9iTwqWG/Nv14hWO97yYsRxAxnFrvZQc3+QJDBJ4QzPXKGqkrkTL6v4pu/usIWu99b0wORrzfKZvu4VuxsHZ/lHROIxzEtEAxxIcTmw88EcWHfYSnt7Y0wUkuvP4s0BhMtgzk4hxMZKMEVTeMtnEdoGCmd7JUtDxjSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQFq3kg+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQFq3kg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720779696; x=1752315696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6BwyhI1ygNz4RFIi5YJoddlQb3Ig5C1L4xGiisWXOeM=;
  b=UQFq3kg+AHrDTWUBQXXW7obJd7YAzIg4CVnv4zW2SnytZAVH0Lkg07iu
   6Vze72xvMe9IrdhwyoIDyPMTymFi3HPk7FDE5ku7176iV4EoFkyizN62p
   NuxkdMaIj98FRKnOc2DFmQJC3VSdI48k9pvPciMThI2chaNmfXuTct2z6
   Gav/rg5Qf0l3/MRfsd4wQSg0TVdlmcCLaJtro0ScJSlaFpOt0YBjTPlYF
   op7N8FM1QOlB67wo36AmLdeAebjMmfS34YPBHPhlduyYRkAIRpG9GvWCk
   1zoiM9bt4Y/vnpAazXjfEUDEBkHgPZShCBzDD4zXv8GvUmIJ16DDQefCV
   w==;
X-CSE-ConnectionGUID: TqSU1s5RS3CFytsZiYkqKQ==
X-CSE-MsgGUID: H6Obaw8ES+21NtuLWds5Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="35756766"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="35756766"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 03:21:36 -0700
X-CSE-ConnectionGUID: z/Pl6ZbHQZqYAynHkgxdKw==
X-CSE-MsgGUID: AqkJ88znShq8914jn9P6VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="79576231"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 12 Jul 2024 03:21:32 -0700
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
Subject: [Patch v3 2/5] perf x86/topdown: Correct leader selection with sample_read enabled
Date: Fri, 12 Jul 2024 17:03:36 +0000
Message-Id: <20240712170339.185824-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
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
index 49f25d67ed77..857e00cf579f 100644
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
@@ -87,11 +88,22 @@ bool arch_is_topdown_metrics(const struct evsel *evsel)
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
+		if (evsel != leader && arch_is_topdown_metrics(evsel))
+			return true;
+	}
 
 	return false;
 }
-- 
2.40.1

