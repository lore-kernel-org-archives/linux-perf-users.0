Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089F30DECE
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416716; cv=none; b=m+7g3LKlCxUdnWX8mCpYGY9gn8fbhTIWpLsRH76qqkeg06idsMWS9jaw5Z3LXdigoJlbha9in4mLgNveC259cQvW/TdX8oCfkNVIJTyV4cJ3M9T2QUIFWvceTctBqHWKmkZxF9fj8AKfOyOXw9aXgXOAMUgjOpATOCz7H1AC3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416716; c=relaxed/simple;
	bh=Lszd0UdRB8GQidhdx5Z+Lj/C2pK9X74pxC+as6fOUOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+alVJXDI6J7zeSGmYnqWPiRFGFNWMWCEe/7suf4dWFxfjURiuvnM4BJmKInLHJjFmdoCaq1IPKN6ZiTZLx2pbk1/1fdSEVoNujM1XjKNgbMhh5EyvLbO6gajEngLENlANCXMABDw/Wms0bmnk0aLKRiz9nIH8L+G1+wnbl3y98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vn+jGuor; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vn+jGuor"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270e3704d6so2046117c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 14:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770416716; x=1771021516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=trHHoM5lxs3R3c1XXOrfjjzTr20GXbuQCFUGYGyaPS8=;
        b=vn+jGuordLEz5m/xRJC+r4wB1k9fTsiXaW+BGr/X8+FU6ks5SHLg9I60/GDCduF2Bq
         7nTvn/aA1FYGParjRgIc1n7KB4qVSlXlzE3GPt69MwNlI1w1de/+VAGOX9wF+jqVE6Gy
         vXy9Qp7yVLoZtWDRd0FLOM53HNxRSiTH+1uZviqypKYNU3RKLBoMy1qGTRzP3u6srztW
         JJmdCkZdpW+8PCg81u+aMJF//yD/jAfgJDXHCmHk3qor+pdKamsWfNPm7Z8wdkqYjVwz
         bKhVi2/rPpprFQJrSjRNS8i6sq8mEjKGuCWtGCx1loLCuP9MPHhkCwTlQHxiIfkrXoyy
         DL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770416716; x=1771021516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trHHoM5lxs3R3c1XXOrfjjzTr20GXbuQCFUGYGyaPS8=;
        b=oasIB2yuF2ySnReEpNkbhHQdRzFyYVToVhQ11xKtJYW6O/zxgZ/9hOaIOzczKUj6OZ
         ZlOhUkHCmz/I2nhRSr0qcQcejQNfHCCPNgVVw0gIXgDtBjLnmzE/aCUSUh2xh5HCSPyJ
         HazTnKjPHSQ4yDvFcstLNey0+SdO+VwdiS9KBucks6uYUM5QGTOdp//nIehASwpPTXy2
         NqpkiX2yAHgRjpKzhbsXaRvbr6Mm6ncGXd8jcnWDzAZQiiaNrJ0KDbTTxTa8yitZSf5h
         xE1ngYMyonqMAUHDapxZKnWnwu4ymKAUr3TKBVV8x4YehvFyhkte2ZQwStMRt9NmwvCM
         jpnA==
X-Forwarded-Encrypted: i=1; AJvYcCXoe3Gv1JbITFD0jVWqIiPEyjuE6sABsf/xNjV+33srfsfxxRZJnPvhR6e18sS1vyxRjJ0zckPNuHYagcxhCJBH@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZUQX9YkisdwGGedwrF2kZH5XQfei3pODZfApc0M2AHg6LtdA
	EtZm7dMlp934EHvlBHbAoW9Gjss4skd68FNr7wZOwProG0qeQFaFrr4WxALP1GDKKxffPcUooEH
	9a223SrE11w==
X-Received: from dlbrb7.prod.google.com ([2002:a05:7022:f007:b0:123:12b9:c4e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6186:b0:124:8d84:1d8f
 with SMTP id a92af1059eb24-127041695a8mr1587889c88.23.1770416715668; Fri, 06
 Feb 2026 14:25:15 -0800 (PST)
Date: Fri,  6 Feb 2026 14:25:04 -0800
In-Reply-To: <20260206222509.982489-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aYZnkYqWXnKpHd3h@x1> <20260206222509.982489-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206222509.982489-2-irogers@google.com>
Subject: [PATCH v8 1/6] Revert "perf tool_pmu: More accurately set the cpus
 for tool events"
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, andres@anarazel.de, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, thomas.falcon@intel.com, 
	tmricht@linux.ibm.com, yang.lee@linux.alibaba.com
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

