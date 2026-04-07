Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93D330B07
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594366; cv=none; b=T7O9+xjqzBFdIAfC8UGwZbhKpd4tn/Cjr+o0QA/pJhfQ2GLwBahmn3UZlHD1+J+8r1PYzIqGL0/ghIkMxQSFoLYqZxLzFwZ+KMYeeeFZUJ4/8WfwEzj6tSZRDnQUpu81se+B889nqVjfjGsTBAnRDNsE7L2I6ZBtSBvechDk1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594366; c=relaxed/simple;
	bh=k2dWZ5MmlOHrByZ5QuXRkVEPzeUFfjmbKffgSXPD5hQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YR7YdAkOv6MlpI+GQyfFhgXCq1Mi3XahZtVroOmFhcbVzHzklp83XCvxZgg7qA8tlDAYnmWIQ+sJB4RPHlnsDD9rZxS7fHgixNZtWUVwTg7BgsHhCJwUL+YKIngiLrFmLXsuTXNcvCfX53/uYTI0MNcZl67Mgt1UScyTgcjD4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RymiN9m6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RymiN9m6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so257000eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 13:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775594364; x=1776199164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ylz388L31ZKflHmIpZiFslLLaKeYzQOnrVutCauvK4=;
        b=RymiN9m6BOkijroLJ1kcDMtsifljIL4fMhXdPcnpDhk5eF6lY7pfe3H3zBj7YpJcn9
         zB6uoIU8JYmFHsPb0Py8FYN4U+bohDJWAnCrOpOGIShtv2Gh3E0VECeSg7+VWHP2n4UK
         3ruRXK7TWCoTH8AsbQpewJa6DI+3c8f2htfpQ4UUGYSISIfP2ViNxL/fCjuqZ9PketKI
         SDyDnrdvWl+RnUHu3d+8JW3R6L/BzUj8CMlsGI5VNWY34NEMTHc3gWkw+RUwR4h/zKpQ
         dfSJCGq5MPHzcju4YtdK4/SQrAsu0WumicPU8Zh5r1bxWN/beAXOqikZyhxIp1pAoLoj
         Q75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775594364; x=1776199164;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ylz388L31ZKflHmIpZiFslLLaKeYzQOnrVutCauvK4=;
        b=b4j6Pm9jL/xfrUSe/7WipSBBmK5aU8RXHeStTuaHxMDnSvCVxqDQSeVgBvIR03UqmS
         btcu9qiSxWptGUithcmFzick13WqbQa9QXMidtL0ZV1eATEGIQNZDLGdQ5L2NlETSqol
         1mHwh81ocvX0aaP9R76UZOfQ2hZeeD64gxJaAbLKcfTdvnhsIpBUnQlWLHCoUMRQc5iv
         cg6fNCkWSPkswnTTC/F4RgduHT0L4PHtcQoi10VpMLMmOZRBicQF6biU40zpMPQntw0d
         bXVRUoYRD8LLyaZ5LL+0A3lwDhK4rcVTJXZyESNdhCARDB0/LJyPIDwZZjrVC1wgZrvm
         mj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbpBYu3EuTjpNkt9nBGMWg8VPzU/WYqz782NM5BiMzqv4bvwkizEDvSeyYBfdBQ6KXXQ/D/fW9YJpRujj0MLJk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3t9eQKM0WxvHycXd5FP1c9QGenO6rjfOOLkO+oGe5CL5Typ3y
	nBPrmZWG4Br/ly0lZIgJieIor8qrRZdj5YRwg4DHjyCuHGjPiV46y9JocfIG4DmWV448SVrdi/5
	oT53kZg==
X-Received: from dycuf4.prod.google.com ([2002:a05:7300:104:b0:2cc:b61:4c8b])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:730d:b0:2d1:9b35:4edb
 with SMTP id 5a478bee46e88-2d19b4501aemr1379596eec.0.1775594364299; Tue, 07
 Apr 2026 13:39:24 -0700 (PDT)
Date: Tue,  7 Apr 2026 13:38:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407203918.3178481-1-ctshao@google.com>
Subject: [PATCH v5 1/2] perf pmu intel: Generalize SNC cpumask adjustment for
 multiple platforms
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, zide.chen@intel.com, 
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prepare for supporting more Intel platforms with sub-NUMA clustering by
generalizing the GNR specific logic.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v5:
  Split patch.

v4: lore.kernel.org/20260402205300.1953706-1-ctshao@google.com
  Rebase.

v3: lore.kernel.org/20260212223942.3832857-1-ctshao@google.com
  Fix a typo.

v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
  Split EMR and GNR in the SNC2 IMC cpu map.

v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com

 tools/perf/arch/x86/util/pmu.c | 44 +++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 0661e0f0b02d..938be36ec0f7 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -23,20 +23,28 @@
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
+		/* Graniterapids supports SNC configuration. */
+		static const char *const supported_cpuids[] = {
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
@@ -133,8 +141,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
 	// Compute the IMC SNC using lookup tables.
 	unsigned int imc_num;
 	int snc_nodes = snc_nodes_per_l3_cache();
-	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
-	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
+	const u8 snc2_map[] = {1, 1, 0, 0};
+	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
 	const u8 *snc_map;
 	size_t snc_map_len;

@@ -157,11 +165,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
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
@@ -201,7 +210,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
 	return cpu_adjust[pmu_snc];
 }

-static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
+static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
 {
 	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
 	// topology. For example, a two socket graniterapids machine may be set
@@ -301,11 +310,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
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

