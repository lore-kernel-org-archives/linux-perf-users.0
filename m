Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1082890;
	Fri, 16 Aug 2024 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790744; cv=none; b=E4PIoOx+LuNyF2N9HL1GI27xDO/359/HoD9brSK7pxFBVyUfRqnuiDaIhx9Q6IfIcKOvFCA9qvzaugu/N289pJLxVrkQNftjx+Ltw3IsayLGdMzOG2ceghrufJJc4iMV1gmXwCjYaal9JhstGeWUyLZdZhJeZK7VDwh2cjv2Qes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790744; c=relaxed/simple;
	bh=RzanKec69OjpYow528ddx8RJu3FhJQBfxfE59UoUTMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzbbMAflpurpvCKbBwlaK5kp/hJJ1ZfwboyPbfvDcdfRQ0RtEccPsoWH+0adFiTkpToT2kb7tUNp1zthzWzdX0gktgEgYLU/lFj1RBw+v3mGWIxQcrRMML+CH6IvNsv7i6jzmBHs2T322SM9uzCPthXf9/ZROncZgxrtMPvyg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDkNyW2w; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDkNyW2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790742; x=1755326742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RzanKec69OjpYow528ddx8RJu3FhJQBfxfE59UoUTMc=;
  b=dDkNyW2wUZeDnYVhf8H6vXY8I+ITDWdCLq9+vLCrfCEj780KrHOyl35R
   MQCwJlXo6Qj0k1n5IIABd8i3WxFEVNr85lx8HBj8hePqG8nJ1TlFIwmFq
   2sdpZNxyXw00ZlljEcxpN0yYTLrZfuQTL7b4Szaapm50ZS78ihVtLeO/Q
   EyNxZk/Co9qgJIK21donRt8ngQLRDM2dU0jY6IW88mNuyS9KHjxJaQKyi
   d11RDYv1bZzJ5uqqLP5j5+AJy5tkWzjKpEDSno2F3WgYwQMF+azJyQk3d
   eXEW5FHXko/9cqwJu9pjv15dX40xc5SzMxXp7DrRM0SdqqOHUdBOUEYGo
   A==;
X-CSE-ConnectionGUID: cmBwPandTMGLPI7a9sK/RQ==
X-CSE-MsgGUID: JFHTefURTg2oO/UPnU/hLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39530744"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39530744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:45:42 -0700
X-CSE-ConnectionGUID: GfUBMuzHQZq+WIGu4OqQ/A==
X-CSE-MsgGUID: iUHa/864T5663tEUJS0gTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60150008"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2024 23:45:39 -0700
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
Subject: [Patch v4 1/6] perf x86/topdown: Complete topdown slots/metrics events check
Date: Fri, 16 Aug 2024 12:29:33 +0000
Message-Id: <20240816122938.32228-2-dapeng1.mi@linux.intel.com>
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

