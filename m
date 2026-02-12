Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99756279329
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935994; cv=none; b=FapMb1VQG3z19exKDO1nqUbmvTsuugY/SQq2uQX7yqeWakuOcfTkGtfL9QYNGNqz++w0fV0kbEOmVh88yBevO3TFn14DQE8CBUx3GW/xm0gaSNdLTABDXf0OAt1um4RjouQZCHG8GhXzakhmq4k2Qo1aXejCBklQmR07sobvjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935994; c=relaxed/simple;
	bh=ecjzz6I4Lw0BCMwuQuFVqd7e/escSG5SYaB6KlqF0sg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=niPY02lV37JqQuUDbBwTvIyyPPN6zpe9SuRUr/barTtdSVQw3IDIEpfTg1VR1ol3wiMnyKOWIvlUD3bLGtuWnpSviYDaudSDc1zSKy9XIyS6HMzQOz/99TOinP8QUEX3e+uXQ7UovWF6mHnS/SYOUrBy+JSYpZT5Z70YLwuYfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcDQrOSa; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcDQrOSa"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so718263c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770935993; x=1771540793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Am93rCJpDM1uJWRf7agg50jsTOV712AErQ8IQoLENlY=;
        b=JcDQrOSa7jArMoXqq/l2Yi1PVFnHhzrkEzlrBRjODZLFO1cnk4aUb04wscQd9kqfrW
         P09ze2vr9boE6xIs5/9AQQGm2IjTBv2LAqpniG0sQVg1LVJ5+ehVtZd/QJWU1HyoM6Hy
         CdEylpHbV7rCfF0W/5h9y2vS0GYkh5GGGHCCNGAFb5Fvv357Sd973HWKKEC0yBEzA6aa
         OJtqGjm/ZLu4TaT1EvZuA/td1sIgxeBxq9/LbAX3sgXR/YcpkdJ9NJ7cFG9kLq2c7oq3
         RxcQP+fgY6RsyP1h86Vzi+CmL11bXrHqPivRGLu+pIlXemO1DHgt3acIu/kg96fspUsS
         tZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770935993; x=1771540793;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Am93rCJpDM1uJWRf7agg50jsTOV712AErQ8IQoLENlY=;
        b=SCD/bUtd1y5EwH50/yux78deXSkip9U148/FDWnxt5bdo00FRCL5Snk9w++djiyVPW
         UjEoYir8GVHimJgcT3bO4TGwHDkVLDM9NuH9B4hM5O1xUu/aYFGghNbYhyvV9jwcm/L1
         GB4/8uqKUvGtsh+xCaH6PpNvMaLkgNK/AvQhJiCr2GsAbBqVLxxTcYnW/H2rLs3NX8ia
         pz73uob2KvxmpdsVrUZ4PRWVXIbaYge6UMBttPIdNiJ7FYxYpBlG2ND2yqDrWLOXWANJ
         MeboBRcz9OEK24dm2yaynpdD6lELZu6LQGgErDKObnOZJ5K5kNZjlyUxjSqUrZxhYL0I
         HmyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt6JTS+druObWzAyAovLi1BkKp1ooAhNSMRwIR80q4ETTQr9My9stOfjPYilHGxxxJHYcYq196nyv9e1O1C0A6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/v0Gyed73W3V2FF4WlxieEbVScpComVDGgjS8XSFwzMmbyQzD
	5Jnm2unVdn01qg2iXWB8jD0J86Ca5igAjEraqmvo9KycuRApKu4UQF12fjNn/61iJHDSASUlWiI
	EQAbZWA==
X-Received: from dlbvg26.prod.google.com ([2002:a05:7022:7f1a:b0:119:78ff:fe10])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4596:b0:124:65f7:2c2e
 with SMTP id a92af1059eb24-127398443b8mr191569c88.43.1770935992463; Thu, 12
 Feb 2026 14:39:52 -0800 (PST)
Date: Thu, 12 Feb 2026 14:39:19 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260212223942.3832857-1-ctshao@google.com>
Subject: [PATCH v3] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on Emeraldrapids
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, ravi.bangoria@amd.com, 
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

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v3:
  Fix a typo.

v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
  Split EMR and GNR in the SNC2 IMC cpu map.

v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com

 tools/perf/arch/x86/util/pmu.c | 95 ++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index a3f96221758d..2215984349f5 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -22,20 +22,29 @@
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
@@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
 			read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");

 		snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
+
 		perf_cpu_map__put(cache_cpus);
 		perf_cpu_map__put(node_cpus);
 		checked_snc = true;
@@ -137,23 +147,42 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
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
@@ -161,11 +190,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
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
@@ -205,7 +235,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
 	return cpu_adjust[pmu_snc];
 }

-static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
+static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
 {
 	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
 	// topology. For example, a two socket graniterapids machine may be set
@@ -304,11 +334,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 				pmu->mem_events = perf_mem_events_intel_aux;
 			else
 				pmu->mem_events = perf_mem_events_intel;
-		} else if (x86__is_intel_graniterapids()) {
+		} else if (x86__is_snc_supported()) {
 			if (starts_with(pmu->name, "uncore_cha_"))
-				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
-			else if (starts_with(pmu->name, "uncore_imc_"))
-				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
+				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
+			else if (starts_with(pmu->name, "uncore_imc_") &&
+				 !starts_with(pmu->name, "uncore_imc_free_running"))
+				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
 		}
 	}
 }
--
2.53.0.273.g2a3d683680-goog

