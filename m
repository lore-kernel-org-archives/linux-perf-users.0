Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21A1BFDE1
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167849; cv=none; b=dXnXqa4yqPpFJGgDQQykg9EsUPITgTilk+ffjZhzr2CB8p4iPNdKMwvPajpEJzEPpfFWzk8Gb5lga09HPMRREUbzSC7odB9bu+DVfS31OIeftjImh7M2djBNTvncqH8y1laIlkSMlYmAGxjWSDMY4lTWdG6xxUFqC+bXREANgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167849; c=relaxed/simple;
	bh=TTIjCYxP53lHBDp2SF08jsCX5D/qc73CFDZaIm095c0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uObZ2h3CUWJBQb5FmygNMjh45YdO7JaCOuOxRvrSh78Xol4h9hvwtTehCgYStoQGTQxXD+TMxnSirIeRO41SE+T7wgcEjJOfPVDmyfV0EmUogitziyv02D28YAsDjKDAJ+0tA1F0Z5FlDlGwfPPhtbqH72QtePDdwt2icAhp7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fi7HFSmT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fi7HFSmT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d5fccc3548so18874477b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167846; x=1726772646; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jIvOGb3G7M9uAjA6lvLhCc81s2AI2IMSCiiBY2eqtE=;
        b=fi7HFSmTKr8LuDk62bYTv5aLmMPIZdaxABmeVBHYLexh38vYXRrJACkZSFQery5X7W
         kZrQLKrzZZ0CeiJ2lYZ8GfQgUefBJmlzSO/9Dokyu2qNwEkktySbWkSQ12S0q05DL0bQ
         Hrj1Rj7H3XPi0IlgqgQdpzQ0u4wLYeaVI+iv56ULVMm115NtEX3hg9e4BVye5j3aTA2E
         ocvaLkYc58Mxjdd2o9MhliidSAUjQ8t00NQtbk/P+nGiVa6ZU92sEsbO3rKAvtXAjqpD
         f+AAeg/pBtOdn6ZEOq00nJvgMnh/mzWhIzDNavVi+PC7XEwmnshMTjUtTivf0PfEKZkR
         w+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167846; x=1726772646;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jIvOGb3G7M9uAjA6lvLhCc81s2AI2IMSCiiBY2eqtE=;
        b=GL0E+IeKOJUmK7m0u4p33WvW6F8QP2e702k7E/9DVIFQ/9KlXmeyysGbENDfJewkhx
         muAj0aIvyBr9+d5g5eYuo1lswXyquo2EwTYr7342XfGvu05W6pBAEtBjFlbFDtzhy47/
         S4809wgj67A6DxIbOv7yLJ1OsNjKSckoul7mlv9cGoN7gQ6SXm7iPJm1A/nCzisY7ZTa
         tdilSfIkbCWEexdEp9dL83sXoxC1vsf/9RmttZiOHu3dW57v1/cphh3QnCkNaeZgVakh
         hJXbh1/S7AqD4wyzZYYK7noASgNbg0jwBDFnZ5xCFA1opmiqo4Bptn2Db1gi8mrtPGTZ
         dUOw==
X-Forwarded-Encrypted: i=1; AJvYcCUHX2hem0onD4fiflCTPs0yOzDPqnxFwgaCiAOBHymCvqZKWzPOo0BVKEKJWCuJDychFH6E08Monlnui2KwJOJc@vger.kernel.org
X-Gm-Message-State: AOJu0YyITtWYxSzxQII3I+CUOO69yuCdkzw2IjvWb/Hon1SsflS83Ti4
	3/ANTZSKxfOWETApxD7n2hSsLhsBU34KSEmJzb0CyeDbBzUUq3gLZOh2Ia5oZqgmDt27AFSDj0W
	Ls4tIGQ==
X-Google-Smtp-Source: AGHT+IF7haVn28lDdEjpyTvp9F1KQfVVD/Td0eI6oNlSn0fEyOoqG3BkKHLDOsvbaLbXpHgiZ78n2sjns68N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a81:a883:0:b0:6d3:e7e6:8462 with SMTP id
 00721157ae682-6db952f5ee5mr2188327b3.1.1726167845806; Thu, 12 Sep 2024
 12:04:05 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:34 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 07/13] perf tool_pmu: Move expr literals to tool_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Add the expr literals like "#smt_on" as tool events, this allows stat
events to give the values. On my laptop with hyperthreading enabled:

```
$ perf stat -e "has_pmem,num_cores,num_cpus,num_cpus_online,num_dies,num_packages,smt_on,system_tsc_freq" true

 Performance counter stats for 'true':

                 0      has_pmem
                 8      num_cores
                16      num_cpus
                16      num_cpus_online
                 1      num_dies
                 1      num_packages
                 1      smt_on
     2,496,000,000      system_tsc_freq

       0.001113637 seconds time elapsed

       0.001218000 seconds user
       0.000000000 seconds sys
```

And with hyperthreading disabled:
```
$ perf stat -e "has_pmem,num_cores,num_cpus,num_cpus_online,num_dies,num_packages,smt_on,system_tsc_freq" true

 Performance counter stats for 'true':

                 0      has_pmem
                 8      num_cores
                16      num_cpus
                 8      num_cpus_online
                 1      num_dies
                 1      num_packages
                 0      smt_on
     2,496,000,000      system_tsc_freq

       0.000802115 seconds time elapsed

       0.000000000 seconds user
       0.000806000 seconds sys
```

As zero matters for these values, in stat-display
should_skip_zero_counter only skip the zero value if it is not the
first aggregation index.

The tool event implementations are used in expr but not evaluated as
events for simplicity. Also core_wide isn't made a tool event as it
requires command line parameters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/pmu.c |   5 +-
 tools/perf/arch/x86/util/tsc.c   |  18 ++--
 tools/perf/util/expr.c           |  93 +++-----------------
 tools/perf/util/pmu.c            |   5 --
 tools/perf/util/pmu.h            |   1 -
 tools/perf/util/stat-display.c   |   8 +-
 tools/perf/util/stat-shadow.c    |  11 ++-
 tools/perf/util/tool_pmu.c       | 146 ++++++++++++++++++++++++++++++-
 tools/perf/util/tool_pmu.h       |  19 +++-
 tools/perf/util/tsc.h            |   2 +-
 10 files changed, 201 insertions(+), 107 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 2a4eab2d160e..a0964b191fcb 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -5,6 +5,7 @@
 #include "../../../util/header.h"
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
+#include "../../../util/tool_pmu.h"
 #include <api/fs/fs.h>
 #include <math.h>
 
@@ -24,7 +25,7 @@ const struct pmu_metrics_table *pmu_metrics_table__find(void)
 	return NULL;
 }
 
-double perf_pmu__cpu_slots_per_cycle(void)
+u64 tool_pmu__cpu_slots_per_cycle(void)
 {
 	char path[PATH_MAX];
 	unsigned long long slots = 0;
@@ -41,5 +42,5 @@ double perf_pmu__cpu_slots_per_cycle(void)
 		filename__read_ull(path, &slots);
 	}
 
-	return slots ? (double)slots : NAN;
+	return slots;
 }
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index e2d6cfe21057..3a439e4b12d2 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -24,9 +24,9 @@ u64 rdtsc(void)
  * ...
  * will return 3000000000.
  */
-static double cpuinfo_tsc_freq(void)
+static u64 cpuinfo_tsc_freq(void)
 {
-	double result = 0;
+	u64 result = 0;
 	FILE *cpuinfo;
 	char *line = NULL;
 	size_t len = 0;
@@ -34,20 +34,22 @@ static double cpuinfo_tsc_freq(void)
 	cpuinfo = fopen("/proc/cpuinfo", "r");
 	if (!cpuinfo) {
 		pr_err("Failed to read /proc/cpuinfo for TSC frequency\n");
-		return NAN;
+		return 0;
 	}
 	while (getline(&line, &len, cpuinfo) > 0) {
 		if (!strncmp(line, "model name", 10)) {
 			char *pos = strstr(line + 11, " @ ");
+			double float_result;
 
-			if (pos && sscanf(pos, " @ %lfGHz", &result) == 1) {
-				result *= 1000000000;
+			if (pos && sscanf(pos, " @ %lfGHz", &float_result) == 1) {
+				float_result *= 1000000000;
+				result = (u64)float_result;
 				goto out;
 			}
 		}
 	}
 out:
-	if (fpclassify(result) == FP_ZERO)
+	if (result == 0)
 		pr_err("Failed to find TSC frequency in /proc/cpuinfo\n");
 
 	free(line);
@@ -55,7 +57,7 @@ static double cpuinfo_tsc_freq(void)
 	return result;
 }
 
-double arch_get_tsc_freq(void)
+u64 arch_get_tsc_freq(void)
 {
 	unsigned int a, b, c, d, lvl;
 	static bool cached;
@@ -86,6 +88,6 @@ double arch_get_tsc_freq(void)
 		return tsc;
 	}
 
-	tsc = (double)c * (double)b / (double)a;
+	tsc = (u64)c * (u64)b / (u64)a;
 	return tsc;
 }
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index b2536a59c44e..5e3732bc2fa5 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -5,25 +5,22 @@
 #include <stdlib.h>
 #include <string.h>
 #include "metricgroup.h"
-#include "cpumap.h"
-#include "cputopo.h"
 #include "debug.h"
 #include "evlist.h"
 #include "expr.h"
+#include "pmu.h"
+#include "smt.h"
+#include "tool_pmu.h"
 #include <util/expr-bison.h>
 #include <util/expr-flex.h>
 #include "util/hashmap.h"
 #include "util/header.h"
 #include "util/pmu.h"
-#include "smt.h"
-#include "tsc.h"
-#include <api/fs/fs.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <ctype.h>
 #include <math.h>
-#include "pmu.h"
 
 struct expr_id_data {
 	union {
@@ -393,90 +390,26 @@ double expr_id_data__source_count(const struct expr_id_data *data)
 	return data->val.source_count;
 }
 
-#if !defined(__i386__) && !defined(__x86_64__)
-double arch_get_tsc_freq(void)
-{
-	return 0.0;
-}
-#endif
-
-static double has_pmem(void)
-{
-	static bool has_pmem, cached;
-	const char *sysfs = sysfs__mountpoint();
-	char path[PATH_MAX];
-
-	if (!cached) {
-		snprintf(path, sizeof(path), "%s/firmware/acpi/tables/NFIT", sysfs);
-		has_pmem = access(path, F_OK) == 0;
-		cached = true;
-	}
-	return has_pmem ? 1.0 : 0.0;
-}
-
 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx)
 {
-	const struct cpu_topology *topology;
 	double result = NAN;
+	enum tool_pmu_event ev = tool_pmu__str_to_event(literal + 1);
 
-	if (!strcmp("#num_cpus", literal)) {
-		result = cpu__max_present_cpu().cpu;
-		goto out;
-	}
-	if (!strcmp("#num_cpus_online", literal)) {
-		struct perf_cpu_map *online = cpu_map__online();
-
-		if (online)
-			result = perf_cpu_map__nr(online);
-		goto out;
-	}
+	if (ev != TOOL_PMU__EVENT_NONE) {
+		u64 count;
 
-	if (!strcasecmp("#system_tsc_freq", literal)) {
-		result = arch_get_tsc_freq();
-		goto out;
-	}
+		if (tool_pmu__read_event(ev, &count))
+			result = count;
+		else
+			pr_err("Failure to read '%s'", literal);
 
-	/*
-	 * Assume that topology strings are consistent, such as CPUs "0-1"
-	 * wouldn't be listed as "0,1", and so after deduplication the number of
-	 * these strings gives an indication of the number of packages, dies,
-	 * etc.
-	 */
-	if (!strcasecmp("#smt_on", literal)) {
-		result = smt_on() ? 1.0 : 0.0;
-		goto out;
-	}
-	if (!strcmp("#core_wide", literal)) {
+	} else if (!strcmp("#core_wide", literal)) {
 		result = core_wide(ctx->system_wide, ctx->user_requested_cpu_list)
 			? 1.0 : 0.0;
-		goto out;
-	}
-	if (!strcmp("#num_packages", literal)) {
-		topology = online_topology();
-		result = topology->package_cpus_lists;
-		goto out;
-	}
-	if (!strcmp("#num_dies", literal)) {
-		topology = online_topology();
-		result = topology->die_cpus_lists;
-		goto out;
-	}
-	if (!strcmp("#num_cores", literal)) {
-		topology = online_topology();
-		result = topology->core_cpus_lists;
-		goto out;
-	}
-	if (!strcmp("#slots", literal)) {
-		result = perf_pmu__cpu_slots_per_cycle();
-		goto out;
-	}
-	if (!strcmp("#has_pmem", literal)) {
-		result = has_pmem();
-		goto out;
+	} else {
+		pr_err("Unrecognized literal '%s'", literal);
 	}
 
-	pr_err("Unrecognized literal '%s'", literal);
-out:
 	pr_debug2("literal: %s = %f\n", literal, result);
 	return result;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d6310fa1b8bd..9cb7a4e5e7d4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2250,11 +2250,6 @@ bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok)
 		(need_fnmatch && !fnmatch(tok, name, 0));
 }
 
-double __weak perf_pmu__cpu_slots_per_cycle(void)
-{
-	return NAN;
-}
-
 int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size)
 {
 	const char *sysfs = sysfs__mountpoint();
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 880a8dc661b7..c4ca359d4215 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -271,7 +271,6 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
 
 bool perf_pmu__match(const struct perf_pmu *pmu, const char *tok);
 
-double perf_pmu__cpu_slots_per_cycle(void);
 int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
 int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 				 const char *pmu_name, const char *filename);
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a82a8ec79b39..ad8baf33fdba 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -951,8 +951,12 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	 * Many tool events are only gathered on the first index, skip other
 	 * zero values.
 	 */
-	if (evsel__is_tool(counter))
-		return true;
+	if (evsel__is_tool(counter)) {
+		struct aggr_cpu_id own_id =
+			config->aggr_get_id(config, (struct perf_cpu){ .cpu = 0 });
+
+		return !aggr_cpu_id__equal(id, &own_id);
+	}
 
 	/*
 	 * Skip value 0 when it's an uncore event and the given aggr id
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e56969d1e39d..aa367c667926 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -400,8 +400,17 @@ static int prepare_metric(const struct metric_expr *mexp,
 			case TOOL_PMU__EVENT_MAX:
 				pr_err("Invalid tool event 'max'");
 				abort();
+			case TOOL_PMU__EVENT_HAS_PMEM:
+			case TOOL_PMU__EVENT_NUM_CORES:
+			case TOOL_PMU__EVENT_NUM_CPUS:
+			case TOOL_PMU__EVENT_NUM_CPUS_ONLINE:
+			case TOOL_PMU__EVENT_NUM_DIES:
+			case TOOL_PMU__EVENT_NUM_PACKAGES:
+			case TOOL_PMU__EVENT_SLOTS:
+			case TOOL_PMU__EVENT_SMT_ON:
+			case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
 			default:
-				pr_err("Unknown tool event '%s'", evsel__name(metric_events[i]));
+				pr_err("Unexpected tool event '%s'", evsel__name(metric_events[i]));
 				abort();
 			}
 			val = avg_stats(stats) * scale;
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index b8116c5c7250..3768c6a42ff6 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -1,11 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "cgroup.h"
 #include "counts.h"
+#include "cputopo.h"
 #include "evsel.h"
 #include "pmu.h"
 #include "print-events.h"
+#include "smt.h"
 #include "time-utils.h"
 #include "tool_pmu.h"
+#include "tsc.h"
+#include <api/fs/fs.h>
+#include <api/io.h>
 #include <api/io.h>
 #include <internal/threadmap.h>
 #include <perf/threadmap.h>
@@ -17,6 +22,15 @@ static const char *const tool_pmu__event_names[TOOL_PMU__EVENT_MAX] = {
 	"duration_time",
 	"user_time",
 	"system_time",
+	"has_pmem",
+	"num_cores",
+	"num_cpus",
+	"num_cpus_online",
+	"num_dies",
+	"num_packages",
+	"slots",
+	"smt_on",
+	"system_tsc_freq",
 };
 
 
@@ -33,8 +47,14 @@ enum tool_pmu_event tool_pmu__str_to_event(const char *str)
 	int i;
 
 	tool_pmu__for_each_event(i) {
-		if (!strcasecmp(str, tool_pmu__event_names[i]))
+		if (!strcasecmp(str, tool_pmu__event_names[i])) {
+#if !defined(__aarch64__)
+			/* The slots event should only appear on arm64. */
+			if (i == TOOL_PMU__EVENT_SLOTS)
+				return TOOL_PMU__EVENT_NONE;
+#endif
 			return i;
+		}
 	}
 	return TOOL_PMU__EVENT_NONE;
 }
@@ -252,6 +272,9 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 	enum tool_pmu_event ev = evsel__tool_event(evsel);
 	int pid = -1, idx = 0, thread = 0, nthreads, err = 0, old_errno;
 
+	if (ev == TOOL_PMU__EVENT_NUM_CPUS)
+		return 0;
+
 	if (ev == TOOL_PMU__EVENT_DURATION_TIME) {
 		if (evsel->core.attr.sample_period) /* no sampling */
 			return -EINVAL;
@@ -330,16 +353,133 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 	return err;
 }
 
+#if !defined(__i386__) && !defined(__x86_64__)
+u64 arch_get_tsc_freq(void)
+{
+	return 0;
+}
+#endif
+
+#if !defined(__aarch64__)
+u64 tool_pmu__cpu_slots_per_cycle(void)
+{
+	return 0;
+}
+#endif
+
+static bool has_pmem(void)
+{
+	static bool has_pmem, cached;
+	const char *sysfs = sysfs__mountpoint();
+	char path[PATH_MAX];
+
+	if (!cached) {
+		snprintf(path, sizeof(path), "%s/firmware/acpi/tables/NFIT", sysfs);
+		has_pmem = access(path, F_OK) == 0;
+		cached = true;
+	}
+	return has_pmem;
+}
+
+bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result)
+{
+	const struct cpu_topology *topology;
+
+	switch (ev) {
+	case TOOL_PMU__EVENT_HAS_PMEM:
+		*result = has_pmem() ? 1 : 0;
+		return true;
+
+	case TOOL_PMU__EVENT_NUM_CORES:
+		topology = online_topology();
+		*result = topology->core_cpus_lists;
+		return true;
+
+	case TOOL_PMU__EVENT_NUM_CPUS:
+		*result = cpu__max_present_cpu().cpu;
+		return true;
+
+	case TOOL_PMU__EVENT_NUM_CPUS_ONLINE: {
+		struct perf_cpu_map *online = cpu_map__online();
+
+		if (online) {
+			*result = perf_cpu_map__nr(online);
+			return true;
+		}
+		return false;
+	}
+	case TOOL_PMU__EVENT_NUM_DIES:
+		topology = online_topology();
+		*result = topology->die_cpus_lists;
+		return true;
+
+	case TOOL_PMU__EVENT_NUM_PACKAGES:
+		topology = online_topology();
+		*result = topology->package_cpus_lists;
+		return true;
+
+	case TOOL_PMU__EVENT_SLOTS:
+		*result = tool_pmu__cpu_slots_per_cycle();
+		return *result ? true : false;
+
+	case TOOL_PMU__EVENT_SMT_ON:
+		*result = smt_on() ? 1 : 0;
+		return true;
+
+	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
+		*result = arch_get_tsc_freq();
+		return true;
+
+	case TOOL_PMU__EVENT_NONE:
+	case TOOL_PMU__EVENT_DURATION_TIME:
+	case TOOL_PMU__EVENT_USER_TIME:
+	case TOOL_PMU__EVENT_SYSTEM_TIME:
+	case TOOL_PMU__EVENT_MAX:
+	default:
+		return false;
+	}
+}
+
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	__u64 *start_time, cur_time, delta_start;
+	unsigned long val;
 	int fd, err = 0;
-	struct perf_counts_values *count;
+	struct perf_counts_values *count, *old_count = NULL;
 	bool adjust = false;
+	enum tool_pmu_event ev = evsel__tool_event(evsel);
 
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
 
-	switch (evsel__tool_event(evsel)) {
+	switch (ev) {
+	case TOOL_PMU__EVENT_HAS_PMEM:
+	case TOOL_PMU__EVENT_NUM_CORES:
+	case TOOL_PMU__EVENT_NUM_CPUS:
+	case TOOL_PMU__EVENT_NUM_CPUS_ONLINE:
+	case TOOL_PMU__EVENT_NUM_DIES:
+	case TOOL_PMU__EVENT_NUM_PACKAGES:
+	case TOOL_PMU__EVENT_SLOTS:
+	case TOOL_PMU__EVENT_SMT_ON:
+	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
+		if (evsel->prev_raw_counts)
+			old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
+		val = 0;
+		if (cpu_map_idx == 0 && thread == 0) {
+			if (!tool_pmu__read_event(ev, &val)) {
+				count->lost++;
+				val = 0;
+			}
+		}
+		if (old_count) {
+			count->val = old_count->val + val;
+			count->run = old_count->run + 1;
+			count->ena = old_count->ena + 1;
+		} else {
+			count->val = val;
+			count->run++;
+			count->ena++;
+		}
+		return 0;
 	case TOOL_PMU__EVENT_DURATION_TIME:
 		/*
 		 * Pretend duration_time is only on the first CPU and thread, or
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index b156645206c4..ecdf316525bb 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -10,9 +10,18 @@ struct print_callbacks;
 
 enum tool_pmu_event {
 	TOOL_PMU__EVENT_NONE = 0,
-	TOOL_PMU__EVENT_DURATION_TIME = 1,
-	TOOL_PMU__EVENT_USER_TIME = 2,
-	TOOL_PMU__EVENT_SYSTEM_TIME = 3,
+	TOOL_PMU__EVENT_DURATION_TIME,
+	TOOL_PMU__EVENT_USER_TIME,
+	TOOL_PMU__EVENT_SYSTEM_TIME,
+	TOOL_PMU__EVENT_HAS_PMEM,
+	TOOL_PMU__EVENT_NUM_CORES,
+	TOOL_PMU__EVENT_NUM_CPUS,
+	TOOL_PMU__EVENT_NUM_CPUS_ONLINE,
+	TOOL_PMU__EVENT_NUM_DIES,
+	TOOL_PMU__EVENT_NUM_PACKAGES,
+	TOOL_PMU__EVENT_SLOTS,
+	TOOL_PMU__EVENT_SMT_ON,
+	TOOL_PMU__EVENT_SYSTEM_TSC_FREQ,
 
 	TOOL_PMU__EVENT_MAX,
 };
@@ -31,9 +40,11 @@ int tool_pmu__config_terms(struct perf_event_attr *attr,
 			   struct parse_events_terms *terms,
 			   struct parse_events_error *err);
 int tool_pmu__for_each_event_cb(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result);
 
-bool perf_pmu__is_tool(const struct perf_pmu *pmu);
+u64 tool_pmu__cpu_slots_per_cycle(void);
 
+bool perf_pmu__is_tool(const struct perf_pmu *pmu);
 
 bool evsel__is_tool(const struct evsel *evsel);
 enum tool_pmu_event evsel__tool_event(const struct evsel *evsel);
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index 88fd1c4c1cb8..57ce8449647f 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -25,7 +25,7 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc);
 u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc);
 u64 rdtsc(void);
-double arch_get_tsc_freq(void);
+u64 arch_get_tsc_freq(void);
 
 size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp);
 
-- 
2.46.0.662.g92d0881bb0-goog

