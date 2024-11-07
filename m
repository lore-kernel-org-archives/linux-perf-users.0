Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D201E0B84
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963781; cv=none; b=i5Nh1MlcD2Mjrtpc6RR3CON/TkFDOW5seAT/JtU+2Xgj8M50expYcIJ+HK6inLrV8VVhwat6Rddj7tJrNkz/rFTTZB32yBzg9aJlsGJwKXXUX89b2vezHDJRm7npl6WY0LEWyQMpzMSZa94m4xFWrNi8lvVEkSLJKSL5mdfYLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963781; c=relaxed/simple;
	bh=OJtFDkIMQi0LcKS0fHYAu+cobbS1tUIrksHvLlNZMRU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Qdc0WeCRpQmE3ZgPNtf89i/r6f0KFS/b8WjXgWW7TvoILklZbrhdVZVIdlKmfhAYEykU3fLXP8PfqqWIFyldH9PxqQ5oMZRdrAM7KBE0o7ytf4XJUhiIzc6DKXgvRqbyb6XN5cx6clE9UJLye8LA0Zcpuz+yPdO1h5iAN+yV5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tx3QsW1W; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tx3QsW1W"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea863ecfe9so12795347b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 23:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730963779; x=1731568579; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jp6Q6rsYTy2pkFfmFp9hLJ/9ui9ITiVOsHTsdSSP0vY=;
        b=Tx3QsW1WjCSPWu7aFGkSiMS05Dh8AJ+/usChlT91x2Q5MN1zHd150mbzNCd6w+nOtv
         REFzR2CxFyEoiXXa81XnshVEzXcWVBPuO0t/qKRBO/ja8OcibuaQurWV77Gxw9TNJHLl
         91WDDuyb8UZ+rRayiMfQzVduqCrJ6iE0y4g3r9hjiiA+dhhfCb/pTbpPjhZjx4icw87u
         SosTXIP6HSXOhGBUza4o/SeCJPhkh7sHOAnXYJCBHc1rkPGiiFbkaNdHCtfStoOHc8e+
         C437Xr0Yq08NdnbI9jQfTraVhgBpfPYU7X1sBQsz8Rdvv4QGBsJabcFhIu9khHZXQfIt
         ntrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963779; x=1731568579;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp6Q6rsYTy2pkFfmFp9hLJ/9ui9ITiVOsHTsdSSP0vY=;
        b=Z/ISi86yue314UpDC2Ll00zffNBVQZ8bMIeYevxSNYGlgZPR1ewwC1bXLoSb0w0dri
         wETmUopF11Yy3Q6pjOLIVU/AS40kaueODLml62i357CyYRwUXNTDcQ4qu6Vypk0ZTEfG
         zJMik94mD4bXPrBqT/JB9nzpjujK8SmW0+Pvbu048+t4D9MZfQCmvduY54rP3q3UJJUs
         Jf3vUqgbuYnTFLpteVuIja7P7Q8t2sNtCwCXI7Aexh33Qa8foPuJk19LIqvbY5HVVCqS
         7dbbF6mxCAEuKDi6Ns4iRbDJLoJeZQivj24IwTgR4O69UmMrw1Dkr7F+LtpJsJwGkTXq
         FJww==
X-Forwarded-Encrypted: i=1; AJvYcCU4aniNptZmqkWsmAnw/gw/Cc4TNvnPqmoItPsroej9txSMXSdNEWmhRolwsLlqVs3WU/IW6EK53jRui8/m691J@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvjm3fHgpuYMYyU/28P3i2lvVj4gspWPeuwKgkRDqSzIjWklWc
	95N7pcb7I1Z4AkFTacrjUMEJY+tS7i8d3YbtxxBNYActLcNjKNLgh9b3aOcdblfTdI1CKonjiaX
	s2ZwDtw==
X-Google-Smtp-Source: AGHT+IFjJTkBX3Ww5U3GdP9ImzIAFri1PsUtkuPx9cggbPAOvXg0q9D0jMn+HqGO7HRg6a+gW1C87/H1x3x6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a81:a8c3:0:b0:6e3:d670:f603 with SMTP id
 00721157ae682-6e9d8aada53mr4568187b3.3.1730963779222; Wed, 06 Nov 2024
 23:16:19 -0800 (PST)
Date: Wed,  6 Nov 2024 23:16:00 -0800
In-Reply-To: <20241107071600.9082-1-irogers@google.com>
Message-Id: <20241107071600.9082-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107071600.9082-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 7/7] perf pmu: Move pmu_metrics_table__find and remove ARM override
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Move pmu_metrics_table__find to the jevents.py generated pmu-events.c
and remove indirection override for ARM. The movement removes
perf_pmu__find_metrics_table that exists to enable the ARM
override. The ARM override isn't necessary as just the CPUID, not PMU,
is used in the metric table lookup. On non-ARM the CPU argument is
just ignored for the CPUID, for ARM -1 is passed so that the CPUID for
the first logical CPU is read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/pmu.c         | 20 --------------------
 tools/perf/pmu-events/empty-pmu-events.c | 20 ++++----------------
 tools/perf/pmu-events/jevents.py         | 20 ++++----------------
 tools/perf/pmu-events/pmu-events.h       |  2 +-
 tools/perf/util/pmu.c                    |  5 -----
 tools/perf/util/pmu.h                    |  1 -
 6 files changed, 9 insertions(+), 59 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index a0964b191fcb..895fb0d0610c 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -1,29 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <internal/cpumap.h>
-#include "../../../util/cpumap.h"
-#include "../../../util/header.h"
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
 #include "../../../util/tool_pmu.h"
 #include <api/fs/fs.h>
-#include <math.h>
-
-const struct pmu_metrics_table *pmu_metrics_table__find(void)
-{
-	struct perf_pmu *pmu;
-
-	/* Metrics aren't currently supported on heterogeneous Arm systems */
-	if (perf_pmus__num_core_pmus() > 1)
-		return NULL;
-
-	/* Doesn't matter which one here because they'll all be the same */
-	pmu = perf_pmus__find_core_pmu();
-	if (pmu)
-		return perf_pmu__find_metrics_table(pmu);
-
-	return NULL;
-}
 
 u64 tool_pmu__cpu_slots_per_cycle(void)
 {
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 2151e8a43f16..1c7a2cfa321f 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -587,24 +587,12 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
-const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
+const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
-        const struct pmu_events_map *map = map_for_pmu(pmu);
-
-        if (!map)
-                return NULL;
-
-        if (!pmu)
-                return &map->metric_table;
-
-        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
-                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+        struct perf_cpu cpu = {-1};
+        const struct pmu_events_map *map = map_for_cpu(cpu);
 
-                if (pmu__name_match(pmu, pmu_name))
-                           return &map->metric_table;
-        }
-        return NULL;
+        return map ? &map->metric_table : NULL;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 6d6780ca0889..d781a377757a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1103,24 +1103,12 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
         return NULL;
 }
 
-const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
+const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
-        const struct pmu_events_map *map = map_for_pmu(pmu);
-
-        if (!map)
-                return NULL;
-
-        if (!pmu)
-                return &map->metric_table;
-
-        for (size_t i = 0; i < map->metric_table.num_pmus; i++) {
-                const struct pmu_table_entry *table_pmu = &map->metric_table.pmus[i];
-                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+        struct perf_cpu cpu = {-1};
+        const struct pmu_events_map *map = map_for_cpu(cpu);
 
-                if (pmu__name_match(pmu, pmu_name))
-                           return &map->metric_table;
-        }
-        return NULL;
+        return map ? &map->metric_table : NULL;
 }
 
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 5435ad92180c..675562e6f770 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -103,7 +103,7 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pm
 				     void *data);
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
-const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu);
+const struct pmu_metrics_table *pmu_metrics_table__find(void);
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 514cb865f57b..45838651b361 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -818,11 +818,6 @@ static int is_sysfs_pmu_core(const char *name)
 	return file_available(path);
 }
 
-__weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
-{
-	return perf_pmu__find_metrics_table(NULL);
-}
-
 /**
  * Return the length of the PMU name not including the suffix for uncore PMUs.
  *
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index fba3fc608b64..7b3e71194e49 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -260,7 +260,6 @@ void perf_pmu__arch_init(struct perf_pmu *pmu);
 void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
 			       const struct pmu_events_table *table);
 
-const struct pmu_metrics_table *pmu_metrics_table__find(void);
 bool pmu_uncore_identifier_match(const char *compat, const char *id);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
-- 
2.47.0.199.ga7371fff76-goog

