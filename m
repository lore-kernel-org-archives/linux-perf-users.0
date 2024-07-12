Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10101581F5;
	Fri, 12 Jul 2024 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779694; cv=none; b=panIasGqYE1lNHPZsIQH5xY/ocd7gJItnhGKLemuEe22fhBlMbU/elRRVr9krsJwZZC2h+fw+UXBVqRT/CdLTfE8SoR+cV8kEWOxON2oGR3FbrUtEBgXvJfr49hsxc5IDD0s6/RRMQJMPAJGzHA3dtm6AFX46Ai71m/54pu18+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779694; c=relaxed/simple;
	bh=RzanKec69OjpYow528ddx8RJu3FhJQBfxfE59UoUTMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLyvOaIcDqJVY6p/AYtwiLYSHrSrMIsU/UcQSnnoje8cRUjgLfCgbBrGNQMQKyiCzfjqrAOY1fXisATj3kx6yY1tiaTweArdcVaXZZct1JZUaJ2hm/JI/osMAILSDzNgstidHfWRI/UKbSJ8CTKRITDEvOOUgTXi++1gu2dpETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uq5JbXuf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uq5JbXuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720779693; x=1752315693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RzanKec69OjpYow528ddx8RJu3FhJQBfxfE59UoUTMc=;
  b=Uq5JbXufjT0Cp4fat4CB0XctYrPjLtDZyFeTXmcNSGMqWJUJ78SBZC6+
   hHWqCxKdvCAw/ycB/oMaSyk858jf7E1IRIiyJaMAOzuTnBMu14U2CuIc4
   6LkMdemeFYK6NEGpSNpk49b5s5Tq2sP4jlqsBhWrk8PkXoMZyOzUN2QiY
   mzVh0Npwj6RLKVf8mfG5xNxKFxIFdm+MACfV7MthOr6W5SZlHOLOjuXUl
   epQHwtxDCYyhNpd1wclqh7Rm+3F3UamsDMdJDkeeEHyGoGFQZmWB4xTmF
   Sbobr4eHj1GaAyUp2vM6LFS1Fv6/c7MSIF83RqP/uq1mixhH0dbPxIz20
   g==;
X-CSE-ConnectionGUID: Pyfp6kX/SAuuwUy95UH05w==
X-CSE-MsgGUID: qV49YQSIQTixAe7Jw1kNCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="35756760"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="35756760"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 03:21:33 -0700
X-CSE-ConnectionGUID: RXnG3z4vSCqvE4syvjyznA==
X-CSE-MsgGUID: i1IF3qJiSrmoCZCD+Djcjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="79576227"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 12 Jul 2024 03:21:29 -0700
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
Subject: [Patch v3 1/5] perf x86/topdown: Complete topdown slots/metrics events check
Date: Fri, 12 Jul 2024 17:03:35 +0000
Message-Id: <20240712170339.185824-2-dapeng1.mi@linux.intel.com>
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
 tools/perf/arch/x86/util/evlist.c  |  8 ++---
 tools/perf/arch/x86/util/evsel.c   |  3 +-
 tools/perf/arch/x86/util/topdown.c | 48 +++++++++++++++++++++++++++++-
 tools/perf/arch/x86/util/topdown.h |  2 ++
 4 files changed, 55 insertions(+), 6 deletions(-)

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
index 3f9a267d4501..49f25d67ed77 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -32,6 +32,52 @@ bool topdown_sys_has_perf_metrics(void)
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
+	if (!strcasestr(info->name, "topdown"))
+		return 0;
+
+	str = strcasestr(info->str, "event=");
+	if (str)
+		sscanf(str, "event=%x", &event);
+
+	str = strcasestr(info->str, "umask=");
+	if (str)
+		sscanf(str, "umask=%x", &umask);
+
+	if (event == 0 && *config == (event | umask << 8))
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
+	if (!pmu || !pmu->is_core)
+		return false;
+
+	if (perf_pmu__for_each_event(pmu, false, &config,
+				     compare_topdown_event))
+		return true;
+
+	return false;
+}
 
 /*
  * Check whether a topdown group supports sample-read.
@@ -44,7 +90,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
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

