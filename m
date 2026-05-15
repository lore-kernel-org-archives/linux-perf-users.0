Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E163DA7CF
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866055; cv=none; b=WLq5GWJVAfvO331CiQwfO+fL6nwbxLC3MmykA86OeRMuPv3MNfgmyGVx6KoBM/W3niWdN+rtEtyQ4jqT1Dnve1oclbAdMRzxbCJm9mOEYFBCPpBh75f8+LshDtKtAC4A57b7r74yFueIZiftTwdzMVq7pnmtFdocsRRPVKI0/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866055; c=relaxed/simple;
	bh=laRFLJalGEYI8tF5g8Dz5l1tulE/CKAnJQg6xnWWGkw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ktbsvMGzmBZiUdpjhJpZw8Wra7wt22fJ+rJ7uFdKFOJkGXg8YU6L+AF5IiRXHu9p0NeS1Nq82DV9hR0i2h1zcD7alAyg7gb2IpCWfShEa2W3tRN+NzKegaZRTZiPjq+ClDcrMNVC5p403fdWOpDffWNy6H+XUpdogg0YtVelT20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTMTYYH0; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTMTYYH0"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fded513994so390175eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866053; x=1779470853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZl6ePJfqpLYsD9PVjpb+29gAWAmH0cbW6eifkE4/zc=;
        b=OTMTYYH0kybPObvWAuandwe1Oq9vOSdNNcPmMvDbgdgsLIZZINuB489mm+roo3dNQ8
         /p3USC1YAHq0Ks0qXRn7oLIqdX76/w1uBvXgLRAI6N6fFMZ/W1jTYNug6bcUwxdcxwNS
         Jb8Wc525n+csNKN9K0LRoywI5wew5UCP4pzMrczpWtesQLcHA+2AXfTG8ygB+klCn//a
         BjgxHbvXSluu3P1zjwsSKFhk7oLLJg7OdahIU/zD3fcCk7yjCqPGibP+A7T4ihi2Lpsw
         agENVv6LsT5Qr0T37Ksv2YtVvTyqBTMjwM15sjHVeluNGmQQp8N23Bn4owyyQXRdoi6+
         2uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866053; x=1779470853;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZl6ePJfqpLYsD9PVjpb+29gAWAmH0cbW6eifkE4/zc=;
        b=XAMeJM6uxLZGfYzd4U9eAduYz8hkZ2Z72RtTPr2RbiAyb3eGJG0bbuW9oBIzk+5qTm
         tHNyBMCra5/xWliJ0gn4uBDSnKAwk/3QnaF0fRaI5uaC4x8mvQL1rNAbAvIWWtpSMiS+
         +398CRXP3ogd8FoFazw+xrHqaJnAXpDK2bYfaOksnI81ULd782MRSdv2mAGnE55j3B0S
         Vb9k6QwFQq9y/XrBShFp09jdzFexxaycIEIil4a7T4GViE3TtBB3bkufJLJ9OU73wnFe
         81TXTARY1giNCPtSgBSAckl9wbAzWc1mVQt1E2BJOT0VrG7xw+A/QQqORbA6/cu9Xavg
         UYNg==
X-Forwarded-Encrypted: i=1; AFNElJ9PxXu6nyZHbsEj54mWcm7xX8o0HRU0tPElYQHRlSzm1r71nm3y3urg5E5eaYfiYrGmPu6DsKGE0Asn19WKbLAR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4dZsg1ZPLboinyIvxYssJ6qLuJSOCxFQCSzSdRoMrqQWtTNX
	ki7OVvruU+/qISYQF8u7aQ9FULnd4K3WeL75C4XotkBd9lyQ1myBFFOC3YbUxAL7UymGgt5GSh1
	NlnP0pQ==
X-Received: from dybdf6.prod.google.com ([2002:a05:7300:b586:b0:2ea:c1bb:3a9c])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1001:b0:2e5:5bf4:8869
 with SMTP id 5a478bee46e88-303986771bcmr2505241eec.21.1778866052924; Fri, 15
 May 2026 10:27:32 -0700 (PDT)
Date: Fri, 15 May 2026 10:26:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260515172710.428474-1-ctshao@google.com>
Subject: [PATCH v6 1/2] perf pmu intel: Generalize SNC cpumask adjustment for
 multiple platforms
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prepare for supporting more Intel platforms with sub-NUMA clustering by
generalizing the GNR specific logic.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v6:
  Make string literal.
  Add SPR into SNC2.

v5: lore.kernel.org/20260407203918.3178481-1-ctshao@google.com/
  Split patch.

v4: lore.kernel.org/20260402205300.1953706-1-ctshao@google.com
  Rebase.

v3: lore.kernel.org/20260212223942.3832857-1-ctshao@google.com
  Fix a typo.

v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
  Split EMR and GNR in the SNC2 IMC cpu map.

v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com

 tools/perf/arch/x86/util/pmu.c | 46 +++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 7c9d238922a6..b8fab260c423 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -22,20 +22,30 @@
 #include "util/env.h"
 #include "util/header.h"

-static bool x86__is_intel_graniterapids(void)
+#define GENUINE_INTEL_GNR "GenuineIntel-6-A[DE]"
+
+static bool x86__is_snc_supported(void)
 {
-	static bool checked_if_graniterapids;
-	static bool is_graniterapids;
+	static bool checked_if_snc_supported;
+	static bool is_supported;
+
+	if (!checked_if_snc_supported) {

-	if (!checked_if_graniterapids) {
-		const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
+		/* Graniterapids supports SNC configuration. */
+		static const char *const supported_cpuids[] = {
+			GENUINE_INTEL_GNR, /* Graniterapids */
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
@@ -132,8 +142,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
 	// Compute the IMC SNC using lookup tables.
 	unsigned int imc_num;
 	int snc_nodes = snc_nodes_per_l3_cache();
-	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
-	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
+	const u8 snc2_map[] = {1, 1, 0, 0};
+	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
 	const u8 *snc_map;
 	size_t snc_map_len;

@@ -156,11 +166,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
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
@@ -200,7 +211,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
 	return cpu_adjust[pmu_snc];
 }

-static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
+static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
 {
 	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
 	// topology. For example, a two socket graniterapids machine may be set
@@ -300,11 +311,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
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
2.54.0.669.g59709faab0-goog

