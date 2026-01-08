Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBCF32570D
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897925; cv=none; b=mATtNYY+97U1OwN2oVLDJlbrr1ll8+40ZJh7kUs9QZzjnfm5Euqo98+3T50tuMjxuw0bQeaLnJKJ9H0Ri5ZYDoeQkPltCStpBvLMbK7TkfoybnkcqvgdarkzTFskdaTSRzDA2yFdAjnWc+EPSnvkg7rWE/e3ejFUYvwB+bVkw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897925; c=relaxed/simple;
	bh=jHBck8OCCffzRvLVeNWDyD5Fw4G6ji5w4mXdVDMbAlU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FqFTe0aPrykE+1Bk1W+I+jvtjjG5TTI/NZ+kmXCMED2L2Irzg/A2rPzeFI9J8daqnytmQHT9avvr6oZfHgm2oG3HwgI8RV7O5Iv8tW1JZ+Vnra4a80AyD0Sjd6igcOmrOLYS+XtgTvrwJfMnBmg2rHmnYtvN/zbj5KTHjAdHspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfCQyLHL; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfCQyLHL"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12175e560b3so4243759c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767897923; x=1768502723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vSiVPS3YJKL8s5fjggz5cgGVEIyUqvXn1TkVzzOCuew=;
        b=pfCQyLHLe5lfPYdq6dmkCJPFqLZvGsRVogkI1KSTFU09eCv2/43Kl+7kAMcyc/mcFg
         tHfFB+IaMkUmuawqg7IgeyepNDA8xld41beIS4CnUqPFqzXnrVFQR1Py607CNESGnz9h
         MfrlxLohs1ZRTnvvBbnx6hSkfR4LoerLq41K45vC21KF045Iyzk3iasj+H5NaUYDGWzd
         /+tPdnflklNjdVN23R1yc13KLXcr88LsL5JgZgexv7/LJCvaz+NoF3eILKHltWq6pK9u
         Abig05SMA1OwdbiHROBOFkQuS6RkjMp3rCjS3D3RAbxaCvVXU1/atdAtJ86bu0N+J4D5
         MCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897923; x=1768502723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSiVPS3YJKL8s5fjggz5cgGVEIyUqvXn1TkVzzOCuew=;
        b=PXCKorVY9RC+oQM8GgL+9dLzlrgYObPM8PXlG+tUJFfmw9RYcWyPzjJ9n4nsd/rF3F
         f62VHCAPLMrbNT53y+V+BeD2FkrjuyLE0tRBAxUDXMQxs7W3ejYcY7AFkEQfZTumr5TM
         IKDjq9jqw4WqqV4H3ztFc3fvRYLWKxNYILigAuLfP1e0/IhjCoHxwpuw1yi7/ITXKpzO
         3CKpOpcnn6LGbOORlZNcJh1N0OqRp/7iSqOiAtDyVhf/AzNtiF3a8bv/BWEOwpDoyF5n
         z+GrWK1aAakg1TEk+lJTKRnfShvehscC1QrpFLgyszn29gLqG17oS0kM/LrUjfCmHm7i
         jYQA==
X-Forwarded-Encrypted: i=1; AJvYcCUyy4v1oFuIbcu6wapwiU370mWOmaeCHvMu+iD5THiA7eUuZpyYDMTWn3OsEXMb0iQemApHyl66sxy8hAy+ld3t@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnujti78kPS0ZEcGi9knSiPRZWs3pz9lZnogj0zW2pbDgNKI11
	YtjDZlTgqpgvoT4m8biSE+Hrtti+qg7JzSl016FKqHfwYhKe2pFLzs5TRXgVj2V9WeHb8MWYr2R
	CGKv4qg==
X-Google-Smtp-Source: AGHT+IF80rqUwBwJ9emoh0khkp+7jAWxjHRyXRmOFYLN7XFSPk0DHgOvDSD7HrQKz20OQq5meH+JI7+S1mQ=
X-Received: from dlbtk10.prod.google.com ([2002:a05:7022:fb0a:b0:11f:4501:52c4])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:791:b0:119:e56b:91ea
 with SMTP id a92af1059eb24-121f8b45fa0mr5052559c88.27.1767897922597; Thu, 08
 Jan 2026 10:45:22 -0800 (PST)
Date: Thu,  8 Jan 2026 10:44:01 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108184430.1210223-1-ctshao@google.com>
Subject: [PATCH] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on Emeraldrapids
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
 tools/perf/arch/x86/util/pmu.c | 45 +++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index a3f96221758d..fad68a0f7b5d 100644
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
@@ -137,8 +147,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
 	// Compute the IMC SNC using lookup tables.
 	unsigned int imc_num;
 	int snc_nodes = snc_nodes_per_l3_cache();
-	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
-	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
+	const u8 snc2_map[] = {0, 0, 1, 1};
+	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
 	const u8 *snc_map;
 	size_t snc_map_len;
 
@@ -161,11 +171,11 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
 		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
 		return 0;
 	}
-	if (imc_num >= snc_map_len) {
+	if (imc_num >= snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
 		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
 		return 0;
 	}
-	return snc_map[imc_num];
+	return snc_map[imc_num % snc_map_len];
 }
 
 static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
@@ -205,7 +215,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
 	return cpu_adjust[pmu_snc];
 }
 
-static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
+static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
 {
 	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
 	// topology. For example, a two socket graniterapids machine may be set
@@ -304,11 +314,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
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
2.52.0.457.g6b5491de43-goog

