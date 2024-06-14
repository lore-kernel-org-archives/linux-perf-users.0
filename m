Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098F208B0;
	Wed, 19 Jun 2024 05:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775092; cv=none; b=ka1jwQCaU0yCI2i6d7HJLgIW4nh6xUvtc4J0rCqVn4OC3HK35Pebn/YDzUTnvtJDg4OYNhh9WrG3oyIHDu3mIm5coACRRgHse60oeEMWQ8WxDdwjPc2YLMk3uu1jUZeUpce+0hhBThRkQe5qU/tgWOPYuN0x4s5HA45+n4e7PmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775092; c=relaxed/simple;
	bh=GQxVK7xhvkTRBZa6IJz8H2zSbka2hCehdl+w/2JVAeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=losUBrhcGrFnAvN2GtKzsxm3bP70LAfEA3L8eSs/YypbLuoYbFhUxMepYDfE26LJPsPq1xdw5ZN0LhVR6+BUj+AnXTWgLaGJWCA2RIBdjTGd/plqYdMNzErfob1en866k85UbhYLoSbB+meOWhiaZnrrQTnnEbCby6dcNg5F/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/dnA5Ux; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/dnA5Ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718775090; x=1750311090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GQxVK7xhvkTRBZa6IJz8H2zSbka2hCehdl+w/2JVAeE=;
  b=B/dnA5UxHdpASiTj+aOHrF0lN9Y9IgWNy4heqy6zSlPSH6PsmfbubwwA
   24o4X6QiUPYswtULeqN3hLWlk6tyL6h45o2Ol/SN4yEM36n+/q470v3+7
   tLDvCGveFWbKtrcv74U+YiejloIAsgxTJGFcEUOBIgz8s1N86JAYB1OB5
   /EXiF1WO9eZaBDh5fB4rcctprMFJm6vW6LLcTW8zJQIw+3DuoaCaJA+I2
   mto8d636jl6gq2dHe4e5odG4R9W1ZMNXMni46Ltwpk1aIRlzB+2QDlnW+
   vH8UimCAM5WKcAZnOcNu5l8U2YTCCcQ0nFBNJp+4LdbyLyjPZv+eGYV/u
   w==;
X-CSE-ConnectionGUID: chv/hCkyQ7m/hnpBJ666Og==
X-CSE-MsgGUID: bQFzoGTnQhGmgZ/K/HZg8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15566607"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="15566607"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 22:31:29 -0700
X-CSE-ConnectionGUID: PcwLkGogQDmarWzLNp0YbA==
X-CSE-MsgGUID: 0Ue0FkGqRy2HyLotQ9YSaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="72539538"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Jun 2024 22:31:25 -0700
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH] perf topdown: Correct leader selection with sample_read enabled
Date: Fri, 14 Jun 2024 21:39:08 +0000
Message-Id: <20240614213908.352840-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
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
 tools/perf/arch/x86/util/topdown.c | 42 ++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 3f9a267d4501..aea6896bbb57 100644
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
@@ -31,6 +32,32 @@ bool topdown_sys_has_perf_metrics(void)
 	return has_perf_metrics;
 }
 
+static int perf_pmus__topdown_event(void *vstate, struct pmu_event_info *info)
+{
+	if (!strcmp(info->name, (char *)vstate))
+		return 1;
+
+	return 0;
+}
+
+static bool is_topdown_metric_event(struct evsel *event)
+{
+	struct perf_pmu *pmu;
+
+	if (!topdown_sys_has_perf_metrics())
+		return false;
+
+	if (event->core.attr.type != PERF_TYPE_RAW)
+		return false;
+
+	pmu = perf_pmus__find_by_type(PERF_TYPE_RAW);
+	if (pmu && perf_pmu__for_each_event(pmu, false, event->name,
+					    perf_pmus__topdown_event))
+		return true;
+
+	return false;
+}
+
 #define TOPDOWN_SLOTS		0x0400
 
 /*
@@ -41,11 +68,22 @@ bool topdown_sys_has_perf_metrics(void)
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
+		if (event != leader && is_topdown_metric_event(event))
+			return true;
+	}
 
 	return false;
 }

base-commit: 92e5605a199efbaee59fb19e15d6cc2103a04ec2
-- 
2.40.1

