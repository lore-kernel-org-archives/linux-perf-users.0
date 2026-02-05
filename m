Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C52BE7CD
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333751; cv=none; b=hKChWt0yZQVzuqPzvFKvBh4zchypA82nY4xupADdIe2dAGeEtWXCGjLR18xqfczWw+JAK3cNSjeiQWPTEOKe0eHHKA0XDkcMvTYTdpcGEbx2nxuhX8oirKD6gn/IQGcNkegHmtG1MVP3zVo+eMeHT5ect+BCKSt+4i3TY88RiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333751; c=relaxed/simple;
	bh=2jVRN+9SAEgkWqRItLFggdWT/DICf75mh3jcx/EBOhM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AKoRsEVbmcId9D6ic2jZtX1ydXaQQ6WoIw/qNskG3jmDuBPBzTEdZXbTbQKh3ZuPVK/Z3EBYpuw+WiEq9AgVzyex8qaqOQwFCluCSMVRLqvHHt1il0yob8idvbnOb34TsFHk+QtkzrToicyXDSPww499ScH9zI1dJHEtEjzgvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzH38+B5; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzH38+B5"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso205444eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770333750; x=1770938550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6JRP+ONgL8h2DzadRmrt/AdG85INIGqNpNsrfSRjVYE=;
        b=CzH38+B58cTniR2YMQ7ShitKu/aYHGpXcJzVqTiUZvIEob5jQqpUrNqMJACNL2SPWL
         R9LozGZ8k2kqYRe1XfK+MVSeepFSu5ssYTyLHMffk3YOKkhaXoJAO3l50ZOhyITZrk0l
         0uO7Q5pDd9xJEjucXF45KAR9Ipa6nDl+DRs0O/1ohIYpF1vhASrMe2iqHGt6hRW0wMTJ
         Uh5ST+dO1psRNKFAngyMh+Ap592GH+UnnGkX3oJD1NqPT4a7mjiQw8g8PGesaEGjOIDy
         QEzh6oHdAH4kU9X00ihmb26ntsZgyjby27OMNN+hfDPSVD40jHlUvmSIyyvh48y71voA
         8aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333750; x=1770938550;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JRP+ONgL8h2DzadRmrt/AdG85INIGqNpNsrfSRjVYE=;
        b=v4flVYIxeKjgqa/aN8aY/u0q7zsN91B+OVWwnHYSOyWZrY9thcajgdNfOd4gldn58Z
         tZ4lOzsprcyEJIwzax+lItuW2WMivONU6mqzufXphhQNgn9jcaN412lXKIfhB5R91f8v
         S/8zXxnFOzEJ+wIhM09jN7+5OLwbAnVt1eA4b2GMI5LDycKRzkX84bU5NhbuNLBoqckT
         85uu1DLdDrXOPNN9XlQpIFvwfQamVq0C/2bFCeflMf6CQYys7d7uLrvo7GFArcVIuqqW
         JnfJ9FZNKbAouLTtSZ0erzh9Cz53bUxr7chC4q6BytfZn5Cly5YWmhIID8zLMjcj7w8b
         47Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUIcZfccF7hWqy81Xw29cfx/ekQHoC/voITR3aXEi9+CrmxdKDWTR5l3usng4iua1nTnMy52C6BkCxrg2GImtvm@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnjjLD+8gnXQEPO66W9CX7KHcb++WoeWRr+a33yH+ookjYAjy
	1us60LRWqq6Osr+rxk1lSYJ7KDu/gdf1UFXYg/hwr+GIG0UbNHdCicPu5HJeqTH9bONp1bkw5EX
	46PbnRQ==
X-Received: from dyclx4.prod.google.com ([2002:a05:693c:2184:b0:2b7:4bcf:315a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1284:b0:2a4:3593:c7e1
 with SMTP id 5a478bee46e88-2b85683fe9bmr316308eec.33.1770333750219; Thu, 05
 Feb 2026 15:22:30 -0800 (PST)
Date: Thu,  5 Feb 2026 15:21:55 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205232220.1980168-1-ctshao@google.com>
Subject: [PATCH v2] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on Emeraldrapids
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
v2:
  Split EMR and GNR in the SNC2 IMC cpu map.

v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com

 tools/perf/arch/x86/util/pmu.c | 95 ++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index a3f96221758d..dbe876cd1b08 100644
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
+	return checked_if_snc_supported;
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
+	static const u8 *snc_map = NULL;
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
2.53.0.rc2.204.g2597b5adb4-goog

