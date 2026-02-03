Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC2378806
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159104; cv=none; b=lAWpbodWTMp5fHzPcAqFkLXEkSYrPLs6rHz4H9L2XQXdNIwSzE3FBnC3kn2chjAOwejYVPs9Prh2/mEWr+Yn6we9Qrl5sAa2US5SN1QS+qPlSiwVPvCwZXaP1hoIQWP7LM/vuResk0IOzUqv3/08qij2XtdpkKmRT+P6Sf+jt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159104; c=relaxed/simple;
	bh=Lszd0UdRB8GQidhdx5Z+Lj/C2pK9X74pxC+as6fOUOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MZbT0eUduxlKlTQEt17k0RPZQHnDXZ9OjQ50QrnCCqhWrTg2Epsxof4dZPlqoDJHNQD/4c31NIhs4q9Lb7IMewh0RQSrR/8HBOvTl7XRhrdrx4wAPAP3kozxa0+//s8dIbqJvGaaYLk7t2shYu3H4xgbihtjxncm/Z2Jx5Fve44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMTVSE8O; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMTVSE8O"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1233b91de6bso10752195c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 14:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770159102; x=1770763902; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trHHoM5lxs3R3c1XXOrfjjzTr20GXbuQCFUGYGyaPS8=;
        b=UMTVSE8Opdysybw1ciMXZ2wQe9F62QqECocfQ81UuYxdFiyUJ0PmFwNrjHSufpKzjW
         XRHxdN/SedmLi0HYPMVx4ScqL6I8Ng6aybjJV1H8tmwksoVMIrZisEDoBGHh86Z7qW8U
         XC3Y1h3H6sHFJC+lUU01vxNCS5Q5/SJ16HxFlwNP8R0vTpB9+7+izqlHy76QSvVvM+rw
         ZAtXk5LLAuM/2sTlnSZN/mzYAsVW13+737qa3XjIuf7HiYawUoLZSqaBizdUgGfoxVVi
         UAyLMlnCIUsUu1MdOOqfTA4864qiTZMWcWENk63C0cSj4bLkzwbuDCZtQ4KpX97VSq2W
         wYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770159102; x=1770763902;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trHHoM5lxs3R3c1XXOrfjjzTr20GXbuQCFUGYGyaPS8=;
        b=N5/3E2bTvGHtbw/FiXMkuPXMInY3odvB4HjWh0tybRY/5WnSl6/UTdpzi02rN0yj9p
         hqn5ZAJIbVLncLZk9E9Pjty0yOPQZv2BiAqRpI01k2PkbrLts04FFZMhsYl3I6LrPphD
         F8z2on0xHiUFRmDaK67cclVF48LhA1guT8MXFfT9psdyU77SQwwb8HBVmokFnNLj5wyE
         sPbO9IEwKEHHALDxaly26S0UdSSwV9S5gWPdcwAri1/ohv85OJsvtGcHrWpPFfzhCCPp
         rqrdyYBuUcgVQ2JxYJ+rGJ2TpkHq/u6/iKXp4m1PvrEFMgjyHaFe0wRgLBBXSgkc/yJb
         FrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAYMctsVLvCfCNuiKXnxJtrs/Qp8SNpGNmv2ewHCTD/X63bRZZ1Fk8t9VOweYl8+1xZ9ltLme0JGATSDz9Jd/l@vger.kernel.org
X-Gm-Message-State: AOJu0YzA65fQcau70TbNAdTpI2MIg+mY++OrXI2DbMA72DoK2PrUW7a3
	ng4QunQ24fVVHBo31PDvSWcMEfqD1Yh6hmzj05YIWU7fLVQDPo9GHFEQAygnZm20ww7OUMRAygj
	FR28gphbzDw==
X-Received: from dlbbt22.prod.google.com ([2002:a05:7022:996:b0:11b:d8a1:4048])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4a1:b0:11b:1c6d:98bd
 with SMTP id a92af1059eb24-126f47822a3mr457703c88.9.1770159102548; Tue, 03
 Feb 2026 14:51:42 -0800 (PST)
Date: Tue,  3 Feb 2026 14:51:24 -0800
In-Reply-To: <20260203225129.4077140-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203225129.4077140-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203225129.4077140-2-irogers@google.com>
Subject: [PATCH v7 1/6] Revert "perf tool_pmu: More accurately set the cpus
 for tool events"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Andres Freund <andres@anarazel.de>
Content-Type: text/plain; charset="UTF-8"

This reverts commit d8d8a0b3603a9a8fa207cf9e4f292e81dc5d1008.

The setting of a user CPU map can cause an empty intersection when
combined with CPU 0 and the event removed. This later triggers a segv
in the stat-shadow logic. Let's put back a full online CPU map for now
by reverting this patch.

Reported-by: Andres Freund <andres@anarazel.de>
Closes: https://lore.kernel.org/linux-perf-users/cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c |  9 ++-------
 tools/perf/util/tool_pmu.c     | 19 -------------------
 tools/perf/util/tool_pmu.h     |  1 -
 3 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d4647ded340f..f631bf7a919f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -30,7 +30,6 @@
 #include "util/event.h"
 #include "util/bpf-filter.h"
 #include "util/stat.h"
-#include "util/tool_pmu.h"
 #include "util/util.h"
 #include "tracepoint.h"
 #include <api/fs/tracing_path.h>
@@ -230,12 +229,8 @@ __add_event(struct list_head *list, int *idx,
 	if (pmu) {
 		is_pmu_core = pmu->is_core;
 		pmu_cpus = perf_cpu_map__get(pmu->cpus);
-		if (perf_cpu_map__is_empty(pmu_cpus)) {
-			if (perf_pmu__is_tool(pmu))
-				pmu_cpus = tool_pmu__cpus(attr);
-			else
-				pmu_cpus = cpu_map__online();
-		}
+		if (perf_cpu_map__is_empty(pmu_cpus))
+			pmu_cpus = cpu_map__online();
 	} else {
 		is_pmu_core = (attr->type == PERF_TYPE_HARDWARE ||
 			       attr->type == PERF_TYPE_HW_CACHE);
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 37c4eae0bef1..6a9df3dc0e07 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -2,7 +2,6 @@
 #include "cgroup.h"
 #include "counts.h"
 #include "cputopo.h"
-#include "debug.h"
 #include "evsel.h"
 #include "pmu.h"
 #include "print-events.h"
@@ -14,7 +13,6 @@
 #include <api/fs/fs.h>
 #include <api/io.h>
 #include <internal/threadmap.h>
-#include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <fcntl.h>
 #include <strings.h>
@@ -111,23 +109,6 @@ const char *evsel__tool_pmu_event_name(const struct evsel *evsel)
 	return tool_pmu__event_to_str(evsel->core.attr.config);
 }
 
-struct perf_cpu_map *tool_pmu__cpus(struct perf_event_attr *attr)
-{
-	static struct perf_cpu_map *cpu0_map;
-	enum tool_pmu_event event = (enum tool_pmu_event)attr->config;
-
-	if (event <= TOOL_PMU__EVENT_NONE || event >= TOOL_PMU__EVENT_MAX) {
-		pr_err("Invalid tool PMU event config %llx\n", attr->config);
-		return NULL;
-	}
-	if (event == TOOL_PMU__EVENT_USER_TIME || event == TOOL_PMU__EVENT_SYSTEM_TIME)
-		return cpu_map__online();
-
-	if (!cpu0_map)
-		cpu0_map = perf_cpu_map__new_int(0);
-	return perf_cpu_map__get(cpu0_map);
-}
-
 static bool read_until_char(struct io *io, char e)
 {
 	int c;
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index ea343d1983d3..f1714001bc1d 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -46,7 +46,6 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
 u64 tool_pmu__cpu_slots_per_cycle(void);
 
 bool perf_pmu__is_tool(const struct perf_pmu *pmu);
-struct perf_cpu_map *tool_pmu__cpus(struct perf_event_attr *attr);
 
 bool evsel__is_tool(const struct evsel *evsel);
 enum tool_pmu_event evsel__tool_event(const struct evsel *evsel);
-- 
2.53.0.rc2.204.g2597b5adb4-goog

