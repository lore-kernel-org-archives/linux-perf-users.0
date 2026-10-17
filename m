Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424D3E3166
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263298; cv=none; b=CA85bbe/WUzhCVs8/4YZUDZ/zGYFi2zmYhJrSGliPk6fEAbfAcOTD9YuQSWYrZlCTq0z4qnPbfinh6LQKC7/SIMUQmn2y9bw1QeHTvi81Emiu9mCP1Qrm6tR4G1SeKvtCFK9+e7qQmlmckbrtOlyK34Wi5JBVBY4ddlcD3HvHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263298; c=relaxed/simple;
	bh=2iG9qrny+KoIlpAFRv6xeuc+w21c6I9wzUfbS2VLbL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Racrbv8cTAp2sdr8hnx2X4wPO+apnGkTccw/egy92Msc13gtXcEcbsEcyJKYVHKBrHCnGsh/i6vXDYG1gDjK1PJ0T4jzOuQi9dbKOwtypcanE/UKWGohkgdQY+LnljD5YBei6Rog/XcHhSlh/6sJpMFj8+YbbypXAZkEcTy6+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZAsPT5r; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZAsPT5r"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1383723dfddso1967485c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792263295; x=1792868095; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4aE4aQQKNGeSMlyVXoPPRv4gsVIcD/jNJLltN1DGPw=;
        b=aZAsPT5rpELvIl/0HIejJF7owBYzlx949xeLupuWZoPSI2Lf82M3S8fnV8cGH5b9qx
         VySpWH9D9wTk8Z5o8nNYu0C3l7d5RpEFSKr+dUwv2QwFNpPd7/EV0qxrxMYzVOdNj/ux
         qSkdLO/JLJywxPejwMm9w5qPdUpNTNRI1STHTxesWNRny+T2KpESaOu8hV3Trk6DEOoV
         tQTY+YFBerAcJU7cL3P2sNTBi3Rc1/C4NWpL1/wKT6O3S4Do190Vxoq3c6SKxDQlNHj4
         MRoQkQRW5FB/fhKhVNqdYrVOQTtS80u8mBmisB/d7qmcfAKdqzI7dD+2s/EAYCfgPhfq
         dzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792263295; x=1792868095;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i4aE4aQQKNGeSMlyVXoPPRv4gsVIcD/jNJLltN1DGPw=;
        b=JqHSCFZC957akdKy72ajfNj5T3m2a9XvIvIi4trqp4CeJ2I031XcQnzMcB57EeHsBM
         uh0ZbUW6wunW4HAbOMI1xDQCVTsaHqg6U6RGop+XyShr+TpcvfvIyZMLcHlTXXQUaCiT
         3rFTwS/LIYJL1nM2ugbN+QkekM1OkLgjYCSqLBEg2rUWuV79MMzMLXc/KoLQF98c8+qX
         YfuKy/uDNV6nr+20sY4jBfHYs6tH7kk/UTQHOpKE6eqtMBS2RgZgnSkbg1M7vc6TfgYm
         vTwOINeOYevIyz6ao/rag5yl1R0V7t5gAPF6pVa9r2PQr5u8DThMZjVEc1l3IfBesZk7
         dEfA==
X-Forwarded-Encrypted: i=1; AKwUvBz6nkDGsRHBbnAsgc4zhsLRJCbYjHCTvZZbB99tcKsXAxZhZki4wp7z9gQkrnbiGuSecc5Wt1q/YD/Icybuykvt@vger.kernel.org
X-Gm-Message-State: AFq9FYKTVVixaNxL7VJJgzlTYLmPw0JjfBS1rARjWRUW7QsH6PtGMBL7
	Ipvp5WiF1yF9yUXm1YDpD/O4W1UKRfCzkkhfwCABR6PB3hydc8QxpmXJrjPbWSHE2zbaL/lFZq6
	6WisVwTZF/g==
X-Received: from dlbsn1.prod.google.com ([2002:a05:7022:b901:b0:181:6f48:4d38])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:28b:10b0:16f:c9db:c5af
 with SMTP id a92af1059eb24-185118eded7mr5129420c88.11.1792263294933; Sat, 17
 Oct 2026 11:54:54 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:54:35 -0700
In-Reply-To: <20261017185442.2137623-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016213258.945737-1-irogers@google.com> <20261017185442.2137623-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017185442.2137623-3-irogers@google.com>
Subject: [RFC PATCH v2 2/9] perf pmus: Add perf_pmus__read_from_env()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, eranian@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Add perf_pmus__read_from_env() and perf_pmu__add_cap() to reconstruct
core_pmus and other_pmus lists and their capabilities from
HEADER_PMU_MAPPINGS, HEADER_HYBRID_TOPOLOGY, HEADER_CPU_PMU_CAPS, and
HEADER_PMU_CAPS in a perf.data header environment.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  |  31 +++++++
 tools/perf/util/pmu.h  |   1 +
 tools/perf/util/pmus.c | 205 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmus.h |   2 +
 4 files changed, 239 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bb2e79802def..cd8211f87291 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2565,6 +2565,37 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
 	return -ENOMEM;
 }
 
+int perf_pmu__add_cap(struct perf_pmu *pmu, const char *name, const char *value)
+{
+	struct perf_pmu_caps *caps;
+
+	if (!pmu || !name || !value)
+		return -EINVAL;
+	if (perf_pmu__get_cap(pmu, name))
+		return 0;
+
+	caps = zalloc(sizeof(*caps));
+	if (!caps)
+		return -ENOMEM;
+
+	caps->name = strdup(name);
+	if (!caps->name) {
+		free(caps);
+		return -ENOMEM;
+	}
+	caps->value = strdup(value);
+	if (!caps->value) {
+		zfree(&caps->name);
+		free(caps);
+		return -ENOMEM;
+	}
+	list_add_tail(&caps->list, &pmu->caps);
+	pmu->nr_caps++;
+	if (!strcmp(name, "max_precise"))
+		pmu->max_precise = atoi(value);
+	return 0;
+}
+
 static void perf_pmu__del_caps(struct perf_pmu *pmu)
 {
 	struct perf_pmu_caps *caps, *tmp;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 44212f6361c7..adb33a9fc94b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -331,6 +331,7 @@ bool pmu_uncore_identifier_match(const char *compat, const char *id);
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name);
+int perf_pmu__add_cap(struct perf_pmu *pmu, const char *name, const char *value);
 
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 1355b317f3ed..ea727d577c89 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -7,13 +7,16 @@
 #include <subcmd/pager.h>
 #include <sys/types.h>
 #include <ctype.h>
+#include <errno.h>
 #include <pthread.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include "cpumap.h"
 #include "debug.h"
 #include "drm_pmu.h"
+#include "env.h"
 #include "evsel.h"
 #include "pmus.h"
 #include "pmu.h"
@@ -916,3 +919,205 @@ struct perf_pmu *perf_pmus__fake_pmu(void)
 
 	return &fake;
 }
+
+static bool env_is_pmu_core(const char *name, struct perf_env *env)
+{
+	if (!strcmp(name, "cpu") || !strcmp(name, "cpum_cf") ||
+	    !strcmp(name, "default_core") || strstarts(name, "cpu_") ||
+	    strstarts(name, "armv") ||
+	    (strstarts(name, "apple_") && strstr(name, "_pmu")))
+		return true;
+
+	if (env && env->hybrid_nodes) {
+		for (int i = 0; i < env->nr_hybrid_nodes; i++) {
+			const char *pmu_name = env->hybrid_nodes[i].pmu_name;
+
+			if (pmu_name && !strcmp(name, pmu_name))
+				return true;
+		}
+		return false;
+	}
+
+	if (!env || !strcmp(perf_env__arch(env), perf_env__arch(NULL)))
+		return is_pmu_core(name);
+
+	return false;
+}
+
+static struct perf_pmu *env_pmu_find_or_add(const char *name, __u32 type,
+					    struct perf_env *env,
+					    const struct pmu_events_table *core_table)
+{
+	struct perf_pmu *pmu = pmu_find(name);
+
+	if (pmu) {
+		if (pmu->type == PERF_PMU_TYPE_FAKE && type != PERF_PMU_TYPE_FAKE)
+			pmu->type = type;
+		return pmu;
+	}
+
+	pmu = zalloc(sizeof(*pmu));
+	if (!pmu)
+		return NULL;
+
+	if (perf_pmu__init(pmu, type, name, /*from_env=*/true) != 0) {
+		perf_pmu__delete(pmu);
+		return NULL;
+	}
+
+	pmu->sysfs_aliases_loaded = true;
+	pmu->caps_initialized = true;
+	pmu->max_precise = -1;
+	pmu->is_core = env_is_pmu_core(name, env);
+	pmu->is_uncore = strstarts(name, "uncore_");
+
+	if (!strcmp(name, "software") || !strcmp(name, "tool"))
+		pmu->events_table = perf_pmu__default_core_events_table();
+	else if (core_table && (pmu->is_core || pmu->is_uncore))
+		pmu->events_table = core_table;
+
+	list_add_tail(&pmu->list, pmu->is_core ? &core_pmus : &other_pmus);
+	return pmu;
+}
+
+static void env_pmu_add_caps_strings(struct perf_pmu *pmu, int nr_caps, char **caps)
+{
+	if (!pmu || nr_caps <= 0 || !caps)
+		return;
+
+	for (int i = 0; i < nr_caps; i++) {
+		const char *eq;
+
+		if (!caps[i])
+			continue;
+		eq = strchr(caps[i], '=');
+
+		if (eq) {
+			char *key = strndup(caps[i], eq - caps[i]);
+
+			if (key) {
+				perf_pmu__add_cap(pmu, key, eq + 1);
+				free(key);
+			}
+		} else {
+			perf_pmu__add_cap(pmu, caps[i], "");
+		}
+	}
+}
+
+int perf_pmus__read_from_env(struct perf_env *env)
+{
+	const struct pmu_events_table *core_table = NULL;
+	struct perf_pmu *pmu;
+
+	if (!env)
+		return -EINVAL;
+
+	perf_pmus__destroy();
+	read_pmu_types = PERF_TOOL_PMU_TYPE_ALL_MASK;
+
+	if (env->cpuid) {
+		const char *arch = perf_env__arch(env);
+		char cpuid_str[128];
+		char vendor[32];
+		unsigned int family, model, step;
+		char extra;
+
+		core_table = find_core_events_table(arch, env->cpuid);
+		/*
+		 * x86 HEADER_CPUID stores "vendor,family,model,step" in decimal
+		 * while pmu-events tables match "vendor-family-HEXMODEL[-HEXSTEP]".
+		 */
+		if (!core_table && !strcmp(arch, "x86") &&
+		    sscanf(env->cpuid, "%31[^,],%u,%u,%u%c",
+			   vendor, &family, &model, &step, &extra) == 4) {
+			snprintf(cpuid_str, sizeof(cpuid_str), "%s-%u-%X-%X",
+				 vendor, family, model, step);
+			core_table = find_core_events_table(arch, cpuid_str);
+			if (!core_table) {
+				snprintf(cpuid_str, sizeof(cpuid_str), "%s-%u-%X",
+					 vendor, family, model);
+				core_table = find_core_events_table(arch, cpuid_str);
+			}
+		}
+	}
+
+	/* 1. Populate from HEADER_PMU_MAPPINGS */
+	if (env->nr_pmu_mappings > 0 && env->pmu_mappings) {
+		char *str = env->pmu_mappings;
+
+		for (int i = 0; i < env->nr_pmu_mappings; i++) {
+			char *colon = NULL;
+			unsigned long type = strtoul(str, &colon, 0);
+
+			if (!colon || *colon != ':')
+				break;
+			str = colon + 1;
+			env_pmu_find_or_add(str, (__u32)type, env, core_table);
+			str += strlen(str) + 1;
+		}
+	}
+
+	/* 2. Populate/enrich from HEADER_HYBRID_TOPOLOGY */
+	for (int i = 0; i < env->nr_hybrid_nodes; i++) {
+		struct hybrid_node *hn = &env->hybrid_nodes[i];
+
+		if (!hn->pmu_name)
+			continue;
+		pmu = env_pmu_find_or_add(hn->pmu_name, PERF_PMU_TYPE_FAKE,
+					  env, core_table);
+		if (!pmu)
+			continue;
+		if (!pmu->is_core) {
+			pmu->is_core = true;
+			if (!pmu->events_table && core_table)
+				pmu->events_table = core_table;
+			list_move_tail(&pmu->list, &core_pmus);
+		}
+		if (hn->cpus && !pmu->cpus)
+			pmu->cpus = perf_cpu_map__new(hn->cpus);
+	}
+
+	/*
+	 * 3. Populate/enrich from HEADER_CPU_PMU_CAPS.
+	 * On hybrid systems HEADER_CPU_PMU_CAPS duplicates the first core PMU
+	 * while HEADER_PMU_CAPS has the per-PMU capabilities, so only create a
+	 * "cpu" PMU entry if no core PMUs exist yet.
+	 */
+	if (env->nr_cpu_pmu_caps > 0 && env->cpu_pmu_caps) {
+		pmu = pmu_find("cpu");
+		if (!pmu && list_empty(&core_pmus)) {
+			pmu = env_pmu_find_or_add("cpu", PERF_TYPE_RAW,
+						  env, core_table);
+		}
+		if (pmu)
+			env_pmu_add_caps_strings(pmu, env->nr_cpu_pmu_caps, env->cpu_pmu_caps);
+	}
+
+	/* 4. Populate/enrich from HEADER_PMU_CAPS */
+	for (int i = 0; i < env->nr_pmus_with_caps; i++) {
+		struct pmu_caps *pc = &env->pmu_caps[i];
+
+		if (!pc->pmu_name)
+			continue;
+		pmu = env_pmu_find_or_add(pc->pmu_name, PERF_PMU_TYPE_FAKE,
+					  env, core_table);
+		if (pmu)
+			env_pmu_add_caps_strings(pmu, pc->nr_caps, pc->caps);
+	}
+
+	/* 5. Set default core CPUs on non-hybrid systems */
+	if (env->nr_cpus_avail > 0 && env->nr_hybrid_nodes == 0) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "0-%d", env->nr_cpus_avail - 1);
+		list_for_each_entry(pmu, &core_pmus, list) {
+			if (!pmu->cpus)
+				pmu->cpus = perf_cpu_map__new(buf);
+		}
+	}
+
+	list_sort(NULL, &core_pmus, pmus_cmp);
+	list_sort(NULL, &other_pmus, pmus_cmp);
+	return 0;
+}
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 0d55edb3f2fc..d1646f91036e 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -6,6 +6,7 @@
 #include <stddef.h>
 
 struct perf_event_attr;
+struct perf_env;
 struct perf_pmu;
 struct print_callbacks;
 
@@ -14,6 +15,7 @@ size_t pmu_name_len_no_suffix(const char *str);
 int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
 
 void perf_pmus__destroy(void);
+int perf_pmus__read_from_env(struct perf_env *env);
 
 struct perf_pmu *perf_pmus__find(const char *name);
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
-- 
2.56.0.212.g129ede20d9-goog

