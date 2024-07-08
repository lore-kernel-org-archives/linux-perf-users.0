Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DD28E0F;
	Mon,  8 Jul 2024 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424442; cv=none; b=rzBxRP+KI8nnbNTwtViL1+25o8F1SVcYPOOUQJr9CWGCOuaXKWefAGmjed3wPW5Z7ypyP+YZWMjPcujAA8bwTGnj0dkqciZn4zK35urBaSAbcCn3XaI7L/SMOOmw54YaiOoL4cHURkkrIo9fEts+3ToDDCcFQScBMqOroz6rpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424442; c=relaxed/simple;
	bh=Jf9uNwduiPkFyLlEt8F+nEZMiB61bDwWBttgmoIpVdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udjUaSVZ8vr9VBBYt/M5pMEqgCOefYO1XaaqBlX5kn6Wg2K+f2hQj+3IwCNzbich4PZWwAwTNySFODwHPHraxCeUo9fp2UdBgId+70ALbAkkda8EgQElraOy4uWWJXAOBPmYerAxU3Bvc+GEgJ2OV5aQa8IUJpZj2WemQb9NH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPA+Dfzj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPA+Dfzj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720424441; x=1751960441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jf9uNwduiPkFyLlEt8F+nEZMiB61bDwWBttgmoIpVdc=;
  b=fPA+Dfzj3nwXziJKvEbIm8cCJQsmTFAGkG++Po56Agtkp0OAFd1sZAXX
   pRTKnvQ8oU72D4SdodqcM24fdFY7u9dhONAhBCF9TH+1hsZ4Nnb/T/W63
   sFdlUITxSJmkt9ojb1eJH/BK0KiFkndxZt3IIGFzi68QPv2jMND0enaUc
   jWWQ44PqPxaXbDHH4kM27F6K6UiARJUo9TTewVrqqN6b2BdRBiCL8nkOU
   KZ/kfJg1TPtTbs+Kj9KPI2za+zu1yS7Pvueuqz06AHVCDvgmHJJ60EqDB
   /aEQinp2tmG+uYLnqYPe8He2vWJk81nLZ5DXhDLrFv2akTMJL/TvJNfJb
   Q==;
X-CSE-ConnectionGUID: Tm1Wc7erTUu24QhWypNMSw==
X-CSE-MsgGUID: 9g3bnN7WTnm1wL59ggBT8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17819213"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17819213"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:40:41 -0700
X-CSE-ConnectionGUID: of7PyLS0QTaXWjv1znmftA==
X-CSE-MsgGUID: SrxYT8R0TBSooUaj+1MsUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51774081"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa003.fm.intel.com with ESMTP; 08 Jul 2024 00:40:37 -0700
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
Subject: [Patch v2 1/5] perf x86/topdown: Complete topdown slots/metrics events check
Date: Mon,  8 Jul 2024 14:42:00 +0000
Message-Id: <20240708144204.839486-2-dapeng1.mi@linux.intel.com>
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

It's not complete to check whether an event is a topdown slots or
topdown metrics event by only comparing the event name since user
may assign the event by RAW format, e.g.

perf stat -e '{instructions,cpu/r400/,cpu/r8300/}' sleep 1

 Performance counter stats for 'sleep 1':

     <not counted>      instructions
     <not counted>      cpu/r400/
   <not supported>      cpu/r8300/

       1.002917796 seconds time elapsed

       0.002955000 seconds user
       0.000000000 seconds sys

The RAW format slots and topdown-be-bound events are not recognized and
not regroup the events, and eventually cause error.

Thus add two helpers arch_is_topdown_slots()/arch_is_topdown_metrics()
to detect whether an event is topdown slots/metrics event by comparing
the event config directly, and use these two helpers to replace the
original event name comparisons.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c  |  8 +++---
 tools/perf/arch/x86/util/evsel.c   |  3 ++-
 tools/perf/arch/x86/util/topdown.c | 43 +++++++++++++++++++++++++++++-
 tools/perf/arch/x86/util/topdown.h |  2 ++
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index b1ce0c52d88d..332e8907f43e 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -78,14 +78,14 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 	if (topdown_sys_has_perf_metrics() &&
 	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
 		/* Ensure the topdown slots comes first. */
-		if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
+		if (arch_is_topdown_slots(lhs))
 			return -1;
-		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
+		if (arch_is_topdown_slots(rhs))
 			return 1;
 		/* Followed by topdown events. */
-		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
+		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
 			return -1;
-		if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->name, "topdown"))
+		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
 			return 1;
 	}
 
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 090d0f371891..181f2ba0bb2a 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -6,6 +6,7 @@
 #include "util/pmu.h"
 #include "util/pmus.h"
 #include "linux/string.h"
+#include "topdown.h"
 #include "evsel.h"
 #include "util/debug.h"
 #include "env.h"
@@ -44,7 +45,7 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 	    strcasestr(evsel->name, "uops_retired.slots"))
 		return false;
 
-	return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
+	return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(evsel);
 }
 
 int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 3f9a267d4501..e805065bb7e1 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -32,6 +32,47 @@ bool topdown_sys_has_perf_metrics(void)
 }
 
 #define TOPDOWN_SLOTS		0x0400
+bool arch_is_topdown_slots(const struct evsel *evsel)
+{
+	if (evsel->core.attr.config == TOPDOWN_SLOTS)
+		return true;
+
+	return false;
+}
+
+static int compare_topdown_event(void *vstate, struct pmu_event_info *info)
+{
+	int *config = vstate;
+	int event = 0;
+	int umask = 0;
+	char *str;
+
+	str = strcasestr(info->str, "event=");
+	if (str)
+		sscanf(str, "event=%x", &event);
+
+	str = strcasestr(info->str, "umask=");
+	if (str)
+		sscanf(str, "umask=%x", &umask);
+
+	if (strcasestr(info->name, "topdown") && event == 0 &&
+	    *config == (event | umask << 8))
+		return 1;
+
+	return 0;
+}
+
+bool arch_is_topdown_metrics(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+	int config = evsel->core.attr.config;
+
+	if (pmu && perf_pmu__for_each_event(pmu, false, &config,
+					    compare_topdown_event))
+		return true;
+
+	return false;
+}
 
 /*
  * Check whether a topdown group supports sample-read.
@@ -44,7 +85,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
 	if (!evsel__sys_has_perf_metrics(leader))
 		return false;
 
-	if (leader->core.attr.config == TOPDOWN_SLOTS)
+	if (arch_is_topdown_slots(leader))
 		return true;
 
 	return false;
diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
index 46bf9273e572..1bae9b1822d7 100644
--- a/tools/perf/arch/x86/util/topdown.h
+++ b/tools/perf/arch/x86/util/topdown.h
@@ -3,5 +3,7 @@
 #define _TOPDOWN_H 1
 
 bool topdown_sys_has_perf_metrics(void);
+bool arch_is_topdown_slots(const struct evsel *evsel);
+bool arch_is_topdown_metrics(const struct evsel *evsel);
 
 #endif
-- 
2.40.1

