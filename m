Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6838184554;
	Fri, 13 Sep 2024 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204879; cv=none; b=FFg33ihEKV6iW1wOKaWhBsle4DoQLqGK39LO/kKdwG5SR2kw0RlcXmTwVZd2c67dne6jJ4X/7QPaDyN1T+L/vlvIRiePQgElcVqUS9yeam7Yp1ELosRMQPAFdQ/PpJh+vGZ91uY0UIOUg+cpedX6VCBq4unCD1zt192SgUcGue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204879; c=relaxed/simple;
	bh=tRBWtr+Ykv1pX7SwVvMQenMWtsUgyxfpeNeMo8gPmPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/pVVe+AYU8pLpcbILu5/O/FbNwlWFxJqB5fPTmm8S3N7HZBtFtIgD80qM3D8J2ytqbv4CuDdfWIOH5gnx+cwUpOtPJJVcIqXc1AmwQOhp5kdNU70hvTzPkwq8/jtJnsNDCZ9C30cXl34duXA4OiFEKNL/2mQdYlmuJJyiplh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrJJJyeM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrJJJyeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726204878; x=1757740878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tRBWtr+Ykv1pX7SwVvMQenMWtsUgyxfpeNeMo8gPmPA=;
  b=GrJJJyeMVeBoJnz1vAeKKZ+9ZEzxGIrp7A5TllfYUR9NSLZFR4ZQ/sUm
   53fBllXezgE0D3n1G7CKUh5cShKkBBQngE0QaiOIWTlRGQOQbM+b0N/zo
   v3ArJKtTZqtbCFQKqWeR6pusAgq3Oru2Gz3KpuRWB1jcRG/zQTMoGWejM
   cwnJ+8eBdFwVUmTj66bxFa7r60iAYr2g0o5W+frf7e79R2/XkiBHk3Aje
   uqN/JimRvyp0Tr+JW8H9ANW8vTu38FuDXEBkVnGlJWuUegOngEEzjoZdT
   pmrt37ORHg9JfdbOngqssIMwtxUMkV+qKzWUBMfwQ9twKPFtvkBPmJ4a5
   Q==;
X-CSE-ConnectionGUID: 7Ti/b/7oQ3GTRRS2asJJWw==
X-CSE-MsgGUID: 5OXTcTWETw+dLqgMVkFGFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24967768"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24967768"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 22:21:16 -0700
X-CSE-ConnectionGUID: LNljV9ZKQkyH1lGI5wtrXQ==
X-CSE-MsgGUID: wB6f+7XjSxKFSkn+QIzOFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67900608"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2024 22:21:13 -0700
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
Subject: [Patch v5 2/6] perf x86/topdown: Correct leader selection with sample_read enabled
Date: Fri, 13 Sep 2024 08:47:08 +0000
Message-Id: <20240913084712.13861-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
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

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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

