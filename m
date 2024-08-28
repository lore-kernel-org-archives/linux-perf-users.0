Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5C189510
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854132; cv=none; b=Vns5NTgIuwUg1RF+ayP/ctnN1D/8oRupCQpslxUZjHmBsTSrPPm9HEMl0mk1+esmKkL4cGBYKMmN5aeT3NE/F0ZzMkNy7r4NCYWzxuvBF72VaYb9SDf/0Fw3RTFY3DnGzdDPBLDeel+Kv98m5lAtleohDJ0Qd1hBm5trPOipyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854132; c=relaxed/simple;
	bh=qZjJWKTXqP22rv4+encmubS6YbkGxJ+2aIt1km55QZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIcaihMqRdC6fhAqieXmyfmmTvLNgA6Hl3avyxivNQp7SsgZobhh5OFMWf/to/jRqd9BjOBCh9lkKFBQngoeeWK2VIX+SnYuhx/HNjNbchQ5PFoUaM8T3c0IQfjMfaUrxb3SLFUyawpw6CjZrDyOAeFg6oLLxYAq5Y/pMrPePwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kv0R6KOS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kv0R6KOS"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8679f534c3so725939166b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854127; x=1725458927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8N9eg0Pqdedb96m/WJTlFS6jdEhFM45+GMUMjdQmx0=;
        b=Kv0R6KOS12QkDnX7XUYMtlDHf/E44Nn6o+QF83BVv+Oq5LUMlLIjQAyJdN8Drbg5he
         X8uWwHtixj4qiT3Pr9sv8e9LVHqLByY6C1xoKrIRAj+yGKqBmU+eIHtM51C98SZMZDiF
         cPEXJs12x4LuByvxz8TNe6K323kHVhrzLpMqIEGo3HU/L0GfmmhuB+TuHdlD5N9nxXeZ
         WjSG6P7Y9raihMhGJ7qgDhxgcOAARMY6XTKCLMxGovtH1M6fe9jQC7oW4T0mv9JQmwAw
         wzpjtP2gkAAj6lNyA3pvDuJO7dW4sSsJ4W8B6Z/J9iPFGi0MACqFZLDqVf344aEPBvIX
         csVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854127; x=1725458927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8N9eg0Pqdedb96m/WJTlFS6jdEhFM45+GMUMjdQmx0=;
        b=gE3PBGgjD3lFhU0EGpMr6dGP1RvqHNiyIHjNghCfg8OOduNWCAOWT/aHjL9HT0QasQ
         XU7Bc7gcvr/hIs2fhaPkL/orbPWjaoI04duUr+PRws3b0KxsbRRcB7015uLS7hgKByL8
         fkwajYSMjnveeggru13P7b0QErhPlq65Sr+da34q0xSjtA0WjdSBUfLlFPkQSNIvXzf2
         Q3z/dpn5ILpdCr2Kx9Q4d9ZJMa5qfR8nLlAqAQXq6rXvMAb6hNvuiApP/FBg91an5h/2
         +mrk2Ox3SIglu4AjajqBmHzQOvXH/rXrbB2YeLYswsxdmyW7yvwb6fk6RqCtmHFO0Hyo
         AHBw==
X-Forwarded-Encrypted: i=1; AJvYcCWLPAb17U7LHTjnxiC5fl5pp/sE9gvP3J3rtv63c3JDLC+47wwz1JgT2yKk5yGsNgDcmwHh59JM83ch9dMBB4af@vger.kernel.org
X-Gm-Message-State: AOJu0YznxcASNAoTVZJOZo6UkEC3iNl467pTs5q/0+qA3CPYjUBV9d+n
	zX+1OV7WIo+pNaGtuuYLz5UBhDe02A8EOPrZudbDyN0kG2+24tUb36ZxdEWuSFI=
X-Google-Smtp-Source: AGHT+IGcaHss6mArx7CS/ex+e0mrOrpjBtfR8KZoLn/D2e7rYog+RtkX2U4t7HyhgBxCBSgORKt8AQ==
X-Received: by 2002:a17:907:6095:b0:a6f:392d:51a9 with SMTP id a640c23a62f3a-a86a5178cd2mr1267419466b.14.1724854126756;
        Wed, 28 Aug 2024 07:08:46 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm251302666b.130.2024.08.28.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:08:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/7] perf stat: Remove evlist__add_default_attrs use strings
Date: Wed, 28 Aug 2024 15:07:17 +0100
Message-Id: <20240828140736.156703-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828140736.156703-1-james.clark@linaro.org>
References: <20240828140736.156703-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

add_default_atttributes would add evsels by having pre-created
perf_event_attr, however, this needed fixing for hybrid as the
extended PMU type was necessary for each core PMU. The logic for this
was in an arch specific x86 function and wasn't present for ARM,
meaning that default events weren't being opened on all PMUs on
ARM. Change the creation of the default events to use parse_events and
strings as that will open the events on all PMUs.

Rather than try to detect events on PMUs before parsing, parse the
event but skip its output in stat-display.

The previous order of hardware events was: cycles,
stalled-cycles-frontend, stalled-cycles-backend, instructions. As
instructions is a more fundamental concept the order is changed to:
instructions, cycles, stalled-cycles-frontend, stalled-cycles-backend.

Closes: https://lore.kernel.org/lkml/CAP-5=fVABSBZnsmtRn1uF-k-G1GWM-L5SgiinhPTfHbQsKXb_g@mail.gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
[Don't display unsupported default events]
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/x86/util/evlist.c |  74 +-------
 tools/perf/builtin-stat.c         | 291 ++++++++++++------------------
 tools/perf/util/evlist.c          |  43 -----
 tools/perf/util/evlist.h          |  12 --
 tools/perf/util/stat-display.c    |   8 +
 tools/perf/util/stat-shadow.c     |   4 +-
 6 files changed, 125 insertions(+), 307 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index cebdd483149e..3a4bf13b1759 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -1,78 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include "util/pmu.h"
-#include "util/pmus.h"
-#include "util/evlist.h"
-#include "util/parse-events.h"
-#include "util/event.h"
+#include <string.h>
+#include "../../../util/evlist.h"
+#include "../../../util/evsel.h"
 #include "topdown.h"
 #include "evsel.h"
 
-static int ___evlist__add_default_attrs(struct evlist *evlist,
-					struct perf_event_attr *attrs,
-					size_t nr_attrs)
-{
-	LIST_HEAD(head);
-	size_t i = 0;
-
-	for (i = 0; i < nr_attrs; i++)
-		event_attr_init(attrs + i);
-
-	if (perf_pmus__num_core_pmus() == 1)
-		return evlist__add_attrs(evlist, attrs, nr_attrs);
-
-	for (i = 0; i < nr_attrs; i++) {
-		struct perf_pmu *pmu = NULL;
-
-		if (attrs[i].type == PERF_TYPE_SOFTWARE) {
-			struct evsel *evsel = evsel__new(attrs + i);
-
-			if (evsel == NULL)
-				goto out_delete_partial_list;
-			list_add_tail(&evsel->core.node, &head);
-			continue;
-		}
-
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-			struct perf_cpu_map *cpus;
-			struct evsel *evsel;
-
-			evsel = evsel__new(attrs + i);
-			if (evsel == NULL)
-				goto out_delete_partial_list;
-			evsel->core.attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
-			cpus = perf_cpu_map__get(pmu->cpus);
-			evsel->core.cpus = cpus;
-			evsel->core.own_cpus = perf_cpu_map__get(cpus);
-			evsel->pmu_name = strdup(pmu->name);
-			list_add_tail(&evsel->core.node, &head);
-		}
-	}
-
-	evlist__splice_list_tail(evlist, &head);
-
-	return 0;
-
-out_delete_partial_list:
-	{
-		struct evsel *evsel, *n;
-
-		__evlist__for_each_entry_safe(&head, n, evsel)
-			evsel__delete(evsel);
-	}
-	return -1;
-}
-
-int arch_evlist__add_default_attrs(struct evlist *evlist,
-				   struct perf_event_attr *attrs,
-				   size_t nr_attrs)
-{
-	if (!nr_attrs)
-		return 0;
-
-	return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
-}
-
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
 	if (topdown_sys_has_perf_metrics() &&
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cf985cdb9a6e..6302822853b0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1814,130 +1814,25 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 }
 
 /*
- * Add default attributes, if there were no attributes specified or
+ * Add default events, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
  */
-static int add_default_attributes(void)
+static int add_default_events(void)
 {
-	struct perf_event_attr default_attrs0[] = {
-
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
-
-  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_CPU_CYCLES		},
-};
-	struct perf_event_attr frontend_attrs[] = {
-  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_FRONTEND	},
-};
-	struct perf_event_attr backend_attrs[] = {
-  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_BACKEND	},
-};
-	struct perf_event_attr default_attrs1[] = {
-  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_INSTRUCTIONS		},
-  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS	},
-  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_MISSES		},
-
-};
-
-/*
- * Detailed stats (-d), covering the L1 and last level data caches:
- */
-	struct perf_event_attr detailed_attrs[] = {
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_LL			<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_LL			<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
-};
-
-/*
- * Very detailed stats (-d -d), covering the instruction cache and the TLB caches:
- */
-	struct perf_event_attr very_detailed_attrs[] = {
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_L1I		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_L1I		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_DTLB		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_DTLB		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_ITLB		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_ITLB		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_READ		<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
-
-};
+	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
+	struct parse_events_error err;
+	struct evlist *evlist = evlist__new();
+	struct evsel *evsel;
+	int ret = 0;
 
-/*
- * Very, very detailed stats (-d -d -d), adding prefetch events:
- */
-	struct perf_event_attr very_very_detailed_attrs[] = {
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_ACCESS	<< 16)				},
-
-  { .type = PERF_TYPE_HW_CACHE,
-    .config =
-	 PERF_COUNT_HW_CACHE_L1D		<<  0  |
-	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
-	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
-};
+	if (!evlist)
+		return -ENOMEM;
 
-	struct perf_event_attr default_null_attrs[] = {};
-	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
+	parse_events_error__init(&err);
 
 	/* Set attrs if no event is selected and !null_run: */
 	if (stat_config.null_run)
-		return 0;
+		goto out;
 
 	if (transaction_run) {
 		/* Handle -T as -M transaction. Once platform specific metrics
@@ -1947,9 +1842,10 @@ static int add_default_attributes(void)
 		 */
 		if (!metricgroup__has_metric(pmu, "transaction")) {
 			pr_err("Missing transaction metrics\n");
-			return -1;
+			ret = -1;
+			goto out;
 		}
-		return metricgroup__parse_groups(evsel_list, pmu, "transaction",
+		ret = metricgroup__parse_groups(evlist, pmu, "transaction",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -1957,6 +1853,7 @@ static int add_default_attributes(void)
 						stat_config.system_wide,
 						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
+		goto out;
 	}
 
 	if (smi_cost) {
@@ -1964,26 +1861,29 @@ static int add_default_attributes(void)
 
 		if (sysfs__read_int(FREEZE_ON_SMI_PATH, &smi) < 0) {
 			pr_err("freeze_on_smi is not supported.\n");
-			return -1;
+			ret = -1;
+			goto out;
 		}
 
 		if (!smi) {
 			if (sysfs__write_int(FREEZE_ON_SMI_PATH, 1) < 0) {
-				fprintf(stderr, "Failed to set freeze_on_smi.\n");
-				return -1;
+				pr_err("Failed to set freeze_on_smi.\n");
+				ret = -1;
+				goto out;
 			}
 			smi_reset = true;
 		}
 
 		if (!metricgroup__has_metric(pmu, "smi")) {
 			pr_err("Missing smi metrics\n");
-			return -1;
+			ret = -1;
+			goto out;
 		}
 
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		return metricgroup__parse_groups(evsel_list, pmu, "smi",
+		ret = metricgroup__parse_groups(evlist, pmu, "smi",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -1991,6 +1891,7 @@ static int add_default_attributes(void)
 						stat_config.system_wide,
 						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
+		goto out;
 	}
 
 	if (topdown_run) {
@@ -2003,21 +1904,23 @@ static int add_default_attributes(void)
 		if (!max_level) {
 			pr_err("Topdown requested but the topdown metric groups aren't present.\n"
 				"(See perf list the metric groups have names like TopdownL1)\n");
-			return -1;
+			ret = -1;
+			goto out;
 		}
 		if (stat_config.topdown_level > max_level) {
 			pr_err("Invalid top-down metrics level. The max level is %u.\n", max_level);
-			return -1;
-		} else if (!stat_config.topdown_level)
+			ret = -1;
+			goto out;
+		} else if (!stat_config.topdown_level) {
 			stat_config.topdown_level = 1;
-
+		}
 		if (!stat_config.interval && !stat_config.metric_only) {
 			fprintf(stat_config.output,
 				"Topdown accuracy may decrease when measuring long periods.\n"
 				"Please print the result regularly, e.g. -I1000\n");
 		}
 		str[8] = stat_config.topdown_level + '0';
-		if (metricgroup__parse_groups(evsel_list,
+		if (metricgroup__parse_groups(evlist,
 						pmu, str,
 						/*metric_no_group=*/false,
 						/*metric_no_merge=*/false,
@@ -2025,41 +1928,49 @@ static int add_default_attributes(void)
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
 						stat_config.hardware_aware_grouping,
-						&stat_config.metric_events) < 0)
-			return -1;
+						&stat_config.metric_events) < 0) {
+			ret = -1;
+			goto out;
+		}
 	}
 
 	if (!stat_config.topdown_level)
 		stat_config.topdown_level = 1;
 
-	if (!evsel_list->core.nr_entries) {
+	if (!evlist->core.nr_entries && !evsel_list->core.nr_entries) {
 		/* No events so add defaults. */
 		if (target__has_cpu(&target))
-			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
+			ret = parse_events(evlist, "cpu-clock", &err);
+		else
+			ret = parse_events(evlist, "task-clock", &err);
+		if (ret)
+			goto out;
+
+		ret = parse_events(evlist,
+				"context-switches,"
+				"cpu-migrations,"
+				"page-faults,"
+				"instructions,"
+				"cycles,"
+				"stalled-cycles-frontend,"
+				"stalled-cycles-backend,"
+				"branches,"
+				"branch-misses",
+				&err);
+		if (ret)
+			goto out;
 
-		if (evlist__add_default_attrs(evsel_list, default_attrs0) < 0)
-			return -1;
-		if (perf_pmus__have_event("cpu", "stalled-cycles-frontend")) {
-			if (evlist__add_default_attrs(evsel_list, frontend_attrs) < 0)
-				return -1;
-		}
-		if (perf_pmus__have_event("cpu", "stalled-cycles-backend")) {
-			if (evlist__add_default_attrs(evsel_list, backend_attrs) < 0)
-				return -1;
-		}
-		if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
-			return -1;
 		/*
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
 		if (metricgroup__has_metric(pmu, "Default")) {
 			struct evlist *metric_evlist = evlist__new();
-			struct evsel *metric_evsel;
-
-			if (!metric_evlist)
-				return -1;
 
+			if (!metric_evlist) {
+				ret = -ENOMEM;
+				goto out;
+			}
 			if (metricgroup__parse_groups(metric_evlist, pmu, "Default",
 							/*metric_no_group=*/false,
 							/*metric_no_merge=*/false,
@@ -2067,43 +1978,65 @@ static int add_default_attributes(void)
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
 							stat_config.hardware_aware_grouping,
-							&stat_config.metric_events) < 0)
-				return -1;
-
-			evlist__for_each_entry(metric_evlist, metric_evsel) {
-				metric_evsel->skippable = true;
-				metric_evsel->default_metricgroup = true;
+							&stat_config.metric_events) < 0) {
+				ret = -1;
+				goto out;
 			}
-			evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
+
+			evlist__for_each_entry(metric_evlist, evsel)
+				evsel->default_metricgroup = true;
+
+			evlist__splice_list_tail(evlist, &metric_evlist->core.entries);
 			evlist__delete(metric_evlist);
 		}
-
-		/* Platform specific attrs */
-		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
-			return -1;
 	}
 
 	/* Detailed events get appended to the event list: */
 
-	if (detailed_run <  1)
-		return 0;
-
-	/* Append detailed run extra attributes: */
-	if (evlist__add_default_attrs(evsel_list, detailed_attrs) < 0)
-		return -1;
-
-	if (detailed_run < 2)
-		return 0;
-
-	/* Append very detailed run extra attributes: */
-	if (evlist__add_default_attrs(evsel_list, very_detailed_attrs) < 0)
-		return -1;
-
-	if (detailed_run < 3)
-		return 0;
-
-	/* Append very, very detailed run extra attributes: */
-	return evlist__add_default_attrs(evsel_list, very_very_detailed_attrs);
+	if (!ret && detailed_run >=  1) {
+		/*
+		 * Detailed stats (-d), covering the L1 and last level data
+		 * caches:
+		 */
+		ret = parse_events(evlist,
+				"L1-dcache-loads,"
+				"L1-dcache-load-misses,"
+				"LLC-loads,"
+				"LLC-load-misses",
+				&err);
+	}
+	if (!ret && detailed_run >=  2) {
+		/*
+		 * Very detailed stats (-d -d), covering the instruction cache
+		 * and the TLB caches:
+		 */
+		ret = parse_events(evlist,
+				"L1-icache-loads,"
+				"L1-icache-load-misses,"
+				"dTLB-loads,"
+				"dTLB-load-misses,"
+				"iTLB-loads,"
+				"iTLB-load-misses",
+				&err);
+	}
+	if (!ret && detailed_run >=  3) {
+		/*
+		 * Very, very detailed stats (-d -d -d), adding prefetch events:
+		 */
+		ret = parse_events(evlist,
+				"L1-dcache-prefetches,"
+				"L1-dcache-prefetch-misses",
+				&err);
+	}
+out:
+	if (!ret) {
+		evlist__for_each_entry(evlist, evsel)
+			evsel->skippable = true;
+	}
+	parse_events_error__exit(&err);
+	evlist__splice_list_tail(evsel_list, &evlist->core.entries);
+	evlist__delete(evlist);
+	return ret;
 }
 
 static const char * const stat_record_usage[] = {
@@ -2760,7 +2693,7 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
-	if (add_default_attributes())
+	if (add_default_events())
 		goto out;
 
 	if (stat_config.cgroup_list) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c0379fa1ccfe..a941f46c958d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -319,49 +319,6 @@ struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
 }
 #endif
 
-int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
-{
-	struct evsel *evsel, *n;
-	LIST_HEAD(head);
-	size_t i;
-
-	for (i = 0; i < nr_attrs; i++) {
-		evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries + i);
-		if (evsel == NULL)
-			goto out_delete_partial_list;
-		list_add_tail(&evsel->core.node, &head);
-	}
-
-	evlist__splice_list_tail(evlist, &head);
-
-	return 0;
-
-out_delete_partial_list:
-	__evlist__for_each_entry_safe(&head, n, evsel)
-		evsel__delete(evsel);
-	return -1;
-}
-
-int __evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
-{
-	size_t i;
-
-	for (i = 0; i < nr_attrs; i++)
-		event_attr_init(attrs + i);
-
-	return evlist__add_attrs(evlist, attrs, nr_attrs);
-}
-
-__weak int arch_evlist__add_default_attrs(struct evlist *evlist,
-					  struct perf_event_attr *attrs,
-					  size_t nr_attrs)
-{
-	if (!nr_attrs)
-		return 0;
-
-	return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
-}
-
 struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b46f1a320783..ca80c970bcd6 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -102,18 +102,6 @@ void evlist__delete(struct evlist *evlist);
 void evlist__add(struct evlist *evlist, struct evsel *entry);
 void evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
-int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs);
-
-int __evlist__add_default_attrs(struct evlist *evlist,
-				     struct perf_event_attr *attrs, size_t nr_attrs);
-
-int arch_evlist__add_default_attrs(struct evlist *evlist,
-				   struct perf_event_attr *attrs,
-				   size_t nr_attrs);
-
-#define evlist__add_default_attrs(evlist, array) \
-	arch_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
-
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
 
 int evlist__add_dummy(struct evlist *evlist);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index cbff43ff8d0f..5402998881c4 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -7,6 +7,7 @@
 #include <perf/cpumap.h>
 #include "color.h"
 #include "counts.h"
+#include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "stat.h"
@@ -967,6 +968,13 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	struct perf_cpu cpu;
 	int idx;
 
+	/*
+	 * Skip unsupported default events when not verbose. (default events
+	 * are all marked 'skippable').
+	 */
+	if (verbose == 0 && counter->skippable && !counter->supported)
+		return true;
+
 	/*
 	 * Skip value 0 when enabling --per-thread globally,
 	 * otherwise it will have too many 0 output.
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 6bb975e46de3..5548f751e56e 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -76,7 +76,7 @@ void perf_stat__reset_shadow_stats(void)
 	memset(&ru_stats, 0, sizeof(ru_stats));
 }
 
-static enum stat_type evsel__stat_type(const struct evsel *evsel)
+static enum stat_type evsel__stat_type(struct evsel *evsel)
 {
 	/* Fake perf_hw_cache_op_id values for use with evsel__match. */
 	u64 PERF_COUNT_hw_cache_l1d_miss = PERF_COUNT_HW_CACHE_L1D |
@@ -152,7 +152,7 @@ static const char *get_ratio_color(const double ratios[3], double val)
 
 static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type type)
 {
-	const struct evsel *cur;
+	struct evsel *cur;
 	int evsel_ctx = evsel_context(evsel);
 
 	evlist__for_each_entry(evsel->evlist, cur) {
-- 
2.34.1

