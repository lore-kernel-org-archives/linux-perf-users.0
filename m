Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64462345722
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163186; cv=none; b=Q5eqbUJzXlSU3xl1RpMZtqphRx+yygxKCloI6IhJbt+fL+GLZX8Fa2oXnB42T+KzLBhLXz8FFfT2XUA7QV4oeqI2fYzZiVEzCNd1S4Wy1PElgWCqIK5qbT7P22coGQBg9848iQiRC4mPmjZ950U4s07NP0WlB28liL+SJVWKDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163186; c=relaxed/simple;
	bh=a7wOyMvWrq4Ig+LN/eM9EA9fjmQHlLUoFGik5G+ml+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TA+7jJ/32ewgf+HFN2Ut5bpB4q0Q6PvxMZr85h6GNlJp64XcsKJGKUO//pyoGExEe89D39O+goBnQ65f5hZb5E2LD7tASdpHxU9YXc2OKTWGnWOiAmFMZs97dntXiAdnAOl3XMa+o7UjCKG9UDc831YQ90/u2Rf5xqO+iMaoCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1lbU7fs; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1lbU7fs"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so1909763c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775163183; x=1775767983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=apN9Yb0xT2EOL/8vOyj1Pmw7mf6No7ghyB3CEvy3Wdk=;
        b=q1lbU7fs7FM6VUT19rInobXhl4lG0NbW+sA8aP56/ALTjhoO75jwO0MAzruzKA5ITp
         /e8y2Nb9vcApOP7+wMEhKPRssT9ZaLGVrmY/2R/2Qfa5epA9F3nZ+C5MfU2TFYt/726U
         RYCw8ttI5Afja3xsWy43KtuJ3dSuNapZaIKmNZZrAez8sXFY5J2cjmosvD9YMuCwpwvq
         QCUrgktcsLOXbmuqRJtpZm/EkPBAZP9hyG/fgejDDiTzaS4mIUYvNNWHG2Sy0LU9kR2g
         wMo6IY7NzSX5YSOKuWfOz/ABkVa9grQwQ4s3UquAClm5K/MYpaSYYPZ9U1fyZk+5zxVm
         tgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163183; x=1775767983;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apN9Yb0xT2EOL/8vOyj1Pmw7mf6No7ghyB3CEvy3Wdk=;
        b=D2ISyLdSIL1a9Bw8AM+ig+idLWL0bWUGbolBFK3AQfyZJHHIoXW69qS1TB7d752Ajb
         tvRRuaKagP8DRt6CNN523tQCZrqHyQ0JsembgDnJhybjfaGOrouVW1rIMuDZv2Ylp07S
         rB7fNDagyDYgOStloiKwKV3Pn5tVSaZmkYpYjXoCr602lyV+UgZmc1tAbO/MJR4JNR+7
         b7X75jM3T/PaHzoFYVxdpnft6PMXu5qLnMlUgYgqDRK8Ccu9JhKG01uEftx//iWD7G2j
         L7osmLK4vKL/6r0UeqK10E3srQ4U5sVrRJjdconiKZRYqg8WpXoC+Gevj2tM9x9jEFYA
         HQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqvik4nSbgb9AVpm8sBIaEZzQ0CBFp7AMkgIcJ9wmOUQ9y57k/H5HZoy1OOxpjiVPskx2BpWFWDQ609hzxyGcr@vger.kernel.org
X-Gm-Message-State: AOJu0Yziahvq9MAC+jwj9t+brKRpt6lBFVFyJo6EwjyslDw+18dtDLAk
	2wYhMLoRgyr6Ky/YjjCZ9Ysoh4cF7wxQzsr3hgzmXcqcRzesROIO9k2v3rEboSwOD42qkmH1Oeq
	6GctlKw==
X-Received: from dlbrn6.prod.google.com ([2002:a05:7022:1506:b0:128:ebd8:625d])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fe04:b0:122:2f4:b251
 with SMTP id a92af1059eb24-12bfb760ef4mr275984c88.21.1775163183125; Thu, 02
 Apr 2026 13:53:03 -0700 (PDT)
Date: Thu,  2 Apr 2026 13:52:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402205300.1953706-1-ctshao@google.com>
Subject: [PATCH v4] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on Emeraldrapids
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Zide Chen <zide.chen@intel.com>, 
	Ian Rogers <irogers@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
Adjust cpumasks as the logic for GNR in [1].

Tested on Emeraldrapids with SNC2 enabled:
  $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a -- sleep 1

   Performance counter stats for 'system wide':

  N0       30        72125876670      UNC_CHA_CLOCKTICKS
  N0        4         8815163648      UNC_M_CLOCKTICKS
  N1       30        72124958844      UNC_CHA_CLOCKTICKS
  N1        4         8815014974      UNC_M_CLOCKTICKS
  N2       30        72121049022      UNC_CHA_CLOCKTICKS
  N2        4         8814592626      UNC_M_CLOCKTICKS
  N3       30        72117133854      UNC_CHA_CLOCKTICKS
  N3        4         8814012840      UNC_M_CLOCKTICKS

         1.001574118 seconds time elapsed

[1] lore.kernel.org/20250515181417.491401-1-irogers@google.com

Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v4:
  Rebase.

v3: lore.kernel.org/20260212223942.3832857-1-ctshao@google.com
  Fix a typo.

v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
  Split EMR and GNR in the SNC2 IMC cpu map.

v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com

 tools/perf/arch/x86/util/pmu.c | 95 ++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 0661e0f0b02d..ec3c5a368d67 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -23,20 +23,29 @@
 #include "util/env.h"
 #include "util/header.h"

-static bool x86__is_intel_graniterapids(void)
+static bool x86__is_snc_supported(void)
 {
-	static bool checked_if_graniterapids;
-	static bool is_graniterapids;
+	static bool checked_if_snc_supported;
+	static bool is_supported;

-	if (!checked_if_graniterapids) {
-		const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
+	if (!checked_if_snc_supported) {
+
+		/* Emeraldrapids and Graniterapids support SNC configuration. */
+		static const char *const supported_cpuids[] = {
+			"GenuineIntel-6-CF", /* Emeraldrapids */
+			"GenuineIntel-6-A[DE]", /* Graniterapids */
+		};
 		char *cpuid = get_cpuid_str((struct perf_cpu){0});

-		is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
+		for (size_t i = 0; i < ARRAY_SIZE(supported_cpuids); i++) {
+			is_supported = cpuid && strcmp_cpuid_str(supported_cpuids[i], cpuid) == 0;
+			if (is_supported)
+				break;
+		}
 		free(cpuid);
-		checked_if_graniterapids = true;
+		checked_if_snc_supported = true;
 	}
-	return is_graniterapids;
+	return is_supported;
 }

 static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
@@ -65,6 +74,7 @@ static int snc_nodes_per_l3_cache(void)
 			read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");

 		snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
+
 		perf_cpu_map__put(cache_cpus);
 		perf_cpu_map__put(node_cpus);
 		checked_snc = true;
@@ -133,23 +143,42 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
 	// Compute the IMC SNC using lookup tables.
 	unsigned int imc_num;
 	int snc_nodes = snc_nodes_per_l3_cache();
-	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
-	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
-	const u8 *snc_map;
-	size_t snc_map_len;
-
-	switch (snc_nodes) {
-	case 2:
-		snc_map = snc2_map;
-		snc_map_len = ARRAY_SIZE(snc2_map);
-		break;
-	case 3:
-		snc_map = snc3_map;
-		snc_map_len = ARRAY_SIZE(snc3_map);
-		break;
-	default:
-		/* Error or no lookup support for SNC with >3 nodes. */
-		return 0;
+	char *cpuid;
+	static const u8 emr_snc2_map[] = { 0, 0, 1, 1 };
+	static const u8 gnr_snc2_map[] = { 1, 1, 0, 0 };
+	static const u8 snc3_map[] = { 1, 1, 0, 0, 2, 2 };
+	static const u8 *snc_map;
+	static size_t snc_map_len;
+
+	/* snc_map is not inited yet. We only look up once to avoid expensive operations. */
+	if (!snc_map) {
+		switch (snc_nodes) {
+		case 2:
+			cpuid = get_cpuid_str((struct perf_cpu){ 0 });
+			if (cpuid) {
+				if (strcmp_cpuid_str("GenuineIntel-6-CF", cpuid) == 0) {
+					snc_map = emr_snc2_map;
+					snc_map_len = ARRAY_SIZE(emr_snc2_map);
+				} else if (strcmp_cpuid_str("GenuineIntel-6-A[DE]", cpuid) == 0) {
+					snc_map = gnr_snc2_map;
+					snc_map_len = ARRAY_SIZE(gnr_snc2_map);
+				}
+				free(cpuid);
+			}
+			break;
+		case 3:
+			snc_map = snc3_map;
+			snc_map_len = ARRAY_SIZE(snc3_map);
+			break;
+		default:
+			/* Error or no lookup support for SNC with >3 nodes. */
+			return 0;
+		}
+
+		if (!snc_map) {
+			pr_warning("Unexpected: can not find snc map config");
+			return 0;
+		}
 	}

 	/* Compute SNC for PMU. */
@@ -157,11 +186,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
 		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
 		return 0;
 	}
-	if (imc_num >= snc_map_len) {
+	if (imc_num >= snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
 		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
 		return 0;
 	}
-	return snc_map[imc_num];
+
+	return snc_map[imc_num % snc_map_len];
 }

 static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
@@ -201,7 +231,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
 	return cpu_adjust[pmu_snc];
 }

-static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
+static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
 {
 	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
 	// topology. For example, a two socket graniterapids machine may be set
@@ -301,11 +331,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 				pmu->mem_events = perf_mem_events_intel_aux;
 			else
 				pmu->mem_events = perf_mem_events_intel;
-		} else if (x86__is_intel_graniterapids()) {
+		} else if (x86__is_snc_supported()) {
 			if (strstarts(pmu->name, "uncore_cha_"))
-				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
-			else if (strstarts(pmu->name, "uncore_imc_"))
-				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
+				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
+			else if (strstarts(pmu->name, "uncore_imc_") &&
+				 !strstarts(pmu->name, "uncore_imc_free_running"))
+				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
 		}
 	}
 }
--
2.53.0.1213.gd9a14994de-goog

