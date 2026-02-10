Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8164302750
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 06:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770703448; cv=none; b=jho3H0UoiPLL3ldJvEfrzU7m8tqqic/EnFaOo9T9hKo1PN84rZtJ+yIS/MxvcZE2TxajVIjv1BPLyi8kOrEDcjp/H4ASgKMHTXTnLDPHLMnRnknrIRlvrrP/CIzujob3MOE6g5Ca7tOZIC8R5niP6oAJ6mPE0lfJcGwRU7r7lHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770703448; c=relaxed/simple;
	bh=Lszd0UdRB8GQidhdx5Z+Lj/C2pK9X74pxC+as6fOUOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UvZpB9/KWf9KNDYbepuLC6S9ekIV+yBAe9xlB9mUBHtqTJbzjp/Jrd/PVo9K0w53lkB4qFjdiPGdpEcPnnXW1stBtES4+REKgPMNn9E61xf+iD2WfBjLx2tGAARuLixgEQ5gT87SiIdnk4T3T5rJ0rWNVNJdkHU6V3RWa59rnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KXY3/PT5; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXY3/PT5"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so469521c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 22:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770703447; x=1771308247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=trHHoM5lxs3R3c1XXOrfjjzTr20GXbuQCFUGYGyaPS8=;
        b=KXY3/PT5r7h0+AMXAo41op15xBxpWRPat2LMnkAuZpYPGOG+xjV9I0JPvH6v+Ff8Um
         LbwICjcLw2MIwIPBOobihM9sh8BrLnxHPsmuR0ssxBpkLh1K7m0i4NWO3MDOmWQt/0yK
         6iRHm2T9sySDtpF1krwYPdk+6RecFuQ3nEjfX26SfPAkFruopy9GT32UInaU2j+P9qkN
         Ng7oZO4IWh8c6zN5JNUDACkEdIgoAjvVkpNuoMaarZEFy0a5bjboql3uFukXwrxkUFzQ
         gkbQrdPkuGJu0/hDUcsXl2WZkRkohabyEmLOCx9rsISJHe+B6oND0pX+O6ygQ2ZchZxE
         zc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770703447; x=1771308247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trHHoM5lxs3R3c1XXOrfjjzTr20GXbuQCFUGYGyaPS8=;
        b=fBCBlZnJ+GPNde0+E0/zSLXazz3G+lraDnkMw0eifd3jzX+e7P6O2wnRS2yKl/jSOR
         ei/U+JiR7RjSEGa5g/NvxCfhaXRSlM2BVjblhP04NUmpjYrw1/ueZCF9mVC6xkAh2Sll
         RAG5J4pXP0BW0eCFjlUcIiSbidTAPJfU2Lybt1flO2XSt3d70eessnUyfNahJLAXXSL9
         Yy7r5xBXpjfhIkvvYTsfF3bcSx1DhrEF7R5JexoCs0Wsk5n9TwV/XJHVOoybrhfloY+y
         6yDrLin42zl5zZF+iTUSHfDPSOwLp4y5uklQ4kf78JVX0va6BKqllfjfI1GUD/5ZOmOo
         rC3g==
X-Forwarded-Encrypted: i=1; AJvYcCXhDhVgjyj9Q6vfnWHU7YQ8cgKUbo3whj3M4K20llz+kqof86RlKaSbNqHFCDVBkEaPc7pQAuA+Id6uz3Z4yMfM@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/OXT2f0lOCqd2hGworB/goWziwLgfoMRLHp7OEV6Z6T+gUHo
	KJZlzHVQC6z1ID4tZeyqm3eW+SqTCuG1NnUYlRZ73zWNaStThPa1ZIfMCFoDuCgh+WL3TF3nGeK
	fAhjtyukAjg==
X-Received: from dlbqq7.prod.google.com ([2002:a05:7022:ed07:b0:127:177b:bd24])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:404:b0:11b:9e5e:1a40
 with SMTP id a92af1059eb24-127040196f5mr4582022c88.15.1770703446829; Mon, 09
 Feb 2026 22:04:06 -0800 (PST)
Date: Mon,  9 Feb 2026 22:03:54 -0800
In-Reply-To: <20260210060359.2233425-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYqHTfCoW1bGmJF4@google.com> <20260210060359.2233425-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210060359.2233425-2-irogers@google.com>
Subject: [PATCH v9 1/6] Revert "perf tool_pmu: More accurately set the cpus
 for tool events"
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	peterz@infradead.org, thomas.falcon@intel.com, tmricht@linux.ibm.com, 
	yang.lee@linux.alibaba.com
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

