Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130B3C1404
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920051; cv=none; b=IE4yAA3pm1FN3KYX1qNzhHy/2vxK/+q3IO3uKanH4K/SPERpb5ZpTZMAxwWSvboEYoziIz/0D5SSJaOC78pY3M+y/Set8qJFcVDzYSoN+/NifcIi6pZ5rGGHVQzhP+iUFajKFhCLc/6cYWh7M1cMqlw5lfoeKC2n7wjSN5pSfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920051; c=relaxed/simple;
	bh=2Jk5fRSULfvYk+mtLx5H9oX875TOse89IoK+mPpFwqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sKUbT5+UYYKxIgiNYtDtgwbQCsBr02GsRsyX5LA12SJDyIbA6rmiMMIYjgNrHoKcTBzfuiSCwDU+yqyTowJXLy8o8QFGEsz4mMpUd+iSva83oh47DOCBbOEqIboAe5sI4n5KHBp952x6nSCmfyXZ/TRekMgxYev72ix4fIUNH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLRrpEZY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLRrpEZY"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8279604464so15059217a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920049; x=1780524849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBsjA3AHRyUbFULXATZ+Zu7TE63aKqXVkwUoCp3uCnU=;
        b=kLRrpEZYGMJDCM5vIfBmsoWxdRlySfA3RZZMECXcVtV8E3o2UyCphhnn6b8bg/MgXY
         sdtsa+hFjiCzdEPZduJXPScC/piID2eCn9SOZpVrj0FMH8+KWQRwd8gXR7G/89Qiy8Ja
         eztQriBE7i4B4ovR2X+eYxACubIzNd8rNciI2lAzYp20sa09T+MgVEl6Oo267aBotz2a
         Kx33GFkbEUP/4SzIr0xkNSyP4hAccCNYj4ZaNBri9m0uWZiOMeneP40rlGHz38TpwEVm
         BrqvIRAssVimv+VKXyWinMAtZbLVTn0nq1r2YJAxwyES/fKQVrnrjQRJbuCfjaGef4Gc
         azZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920049; x=1780524849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBsjA3AHRyUbFULXATZ+Zu7TE63aKqXVkwUoCp3uCnU=;
        b=hd/nQt8g2oU2xf1zqCJvt8WuDjhGGaw69zwWlGukI/UFm7V4hm5/oRy3ghLFUwI+/p
         qzdcO2ZAm1Eu1n2+gdTdUUi+QdraxTmTN8FBRxjuoUtr2IxhsaaFF5wlZ2vDlVZdPTBG
         1qmOwLbGx00q6gL287fIamiN5WaIp9Kr0VByq7pr/RFw4lEspGjpxxscDBN4CmlS6IWX
         R7k82qKub2YTuz5zp5k40w2uHk77P+kq/TaJTA8CQ9qn0/9Fv3Go6uLLgDGk5R0WA6Lf
         R5OiZ0tStmoS9lMfSv5m7mnpNStIAYovdcJz4NqIrajiJkq54i4Pda+iMVY6PNkiHXfY
         dnxA==
X-Forwarded-Encrypted: i=1; AFNElJ+v/bAv9AOZRk+M//83F3QyGCUdCFMCaqpZEYMl53TnGvpfM9dcMzvJrP5mnEC6pEjHL6d8/PwKlt4ZcmEESlDo@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkv+f0LfnKKrXsbWtuuUEj/HQVnjhggsTVJeca9SGDzI/TkqBV
	kA5XvA+gw40UnKNp2FPAuzcT/JgCg6cqGdOkep7INaqc104nZHHlmedIOEAh/p1yRxeHRsPL7qX
	kST87zQ==
X-Received: from pgkn21.prod.google.com ([2002:a63:ee55:0:b0:c85:a9c:435f])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9996:b0:3a0:c285:e51f
 with SMTP id adf61e73a8af0-3b328f8463fmr27132106637.52.1779920048435; Wed, 27
 May 2026 15:14:08 -0700 (PDT)
Date: Wed, 27 May 2026 15:14:05 -0700
In-Reply-To: <20260515172710.428474-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515172710.428474-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527221406.3826216-1-ctshao@google.com>
Subject: [PATCH v7 1/2] perf pmu intel: Generalize SNC cpumask adjustment for
 multiple platforms
From: Chun-Tse Shao <ctshao@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Zide Chen <zide.chen@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Prepare for supporting more Intel platforms with sub-NUMA clustering by
generalizing the GNR specific logic.

Reviewed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
v7:
  Fixed based on Sashiko review:
  - Refactor PMU initialization to be fully thread-safe using
    pthread_once and pthread_mutex locks.
  - Fix a critical bounds check bug on single-socket systems.
  - Fix potential divide-by-zero crash in uncore_cha_snc.
  - Avoid spurious warnings on non-SNC systems.
  - Avoid silent and inconsistent uncore mappings on unsupported SNC
    configurations.
  - Resolve checkpatch linter warnings.

v6: lore.kernel.org/20260515172710.428474-1-ctshao@google.com
  Make string literal.
  Add SPR into SNC2.

v5: lore.kernel.org/20260407203918.3178481-1-ctshao@google.com
  Split patch.

v4: lore.kernel.org/20260402205300.1953706-1-ctshao@google.com
  Rebase.

v3: lore.kernel.org/20260212223942.3832857-1-ctshao@google.com
  Fix a typo.

v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
  Split EMR and GNR in the SNC2 IMC cpu map.

v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com

 tools/perf/arch/x86/util/pmu.c | 199 +++++++++++++++++++++------------
 1 file changed, 130 insertions(+), 69 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 7c9d238922a6..9b00d5720fb7 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
 #include <string.h>
 #include <stdio.h>
 #include <sys/types.h>
@@ -22,20 +23,31 @@
 #include "util/env.h"
 #include "util/header.h"

-static bool x86__is_intel_graniterapids(void)
-{
-	static bool checked_if_graniterapids;
-	static bool is_graniterapids;
+#define GENUINE_INTEL_GNR "GenuineIntel-6-A[DE]"

-	if (!checked_if_graniterapids) {
-		const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
-		char *cpuid = get_cpuid_str((struct perf_cpu){0});
+static bool cached_snc_supported;
+static pthread_once_t snc_support_once = PTHREAD_ONCE_INIT;

-		is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
-		free(cpuid);
-		checked_if_graniterapids = true;
+static void init_snc_support(void)
+{
+	/* Graniterapids supports SNC configuration. */
+	static const char *const supported_cpuids[] = {
+		GENUINE_INTEL_GNR, /* Graniterapids */
+	};
+	char *cpuid = get_cpuid_str((struct perf_cpu){0});
+
+	for (size_t i = 0; i < ARRAY_SIZE(supported_cpuids); i++) {
+		cached_snc_supported = cpuid && strcmp_cpuid_str(supported_cpuids[i], cpuid) == 0;
+		if (cached_snc_supported)
+			break;
 	}
-	return is_graniterapids;
+	free(cpuid);
+}
+
+static bool x86__is_snc_supported(void)
+{
+	pthread_once(&snc_support_once, init_snc_support);
+	return cached_snc_supported;
 }

 static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
@@ -52,49 +64,58 @@ static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
 	return cpus;
 }

-static int snc_nodes_per_l3_cache(void)
+static int cached_snc_nodes;
+static pthread_once_t snc_nodes_once = PTHREAD_ONCE_INIT;
+
+static void init_snc_nodes(void)
 {
-	static bool checked_snc;
-	static int snc_nodes;
-
-	if (!checked_snc) {
-		struct perf_cpu_map *node_cpus =
-			read_sysfs_cpu_map("devices/system/node/node0/cpulist");
-		struct perf_cpu_map *cache_cpus =
-			read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");
-
-		snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
-		perf_cpu_map__put(cache_cpus);
-		perf_cpu_map__put(node_cpus);
-		checked_snc = true;
-	}
-	return snc_nodes;
+	struct perf_cpu_map *node_cpus =
+		read_sysfs_cpu_map("devices/system/node/node0/cpulist");
+	struct perf_cpu_map *cache_cpus =
+		read_sysfs_cpu_map("devices/system/cpu/cpu0/cache/index3/shared_cpu_list");
+
+	if (node_cpus && cache_cpus)
+		cached_snc_nodes = perf_cpu_map__nr(cache_cpus) / perf_cpu_map__nr(node_cpus);
+	else
+		cached_snc_nodes = 0;
+	perf_cpu_map__put(cache_cpus);
+	perf_cpu_map__put(node_cpus);
 }

-static int num_chas(void)
+static int snc_nodes_per_l3_cache(void)
 {
-	static bool checked_chas;
-	static int num_chas;
+	pthread_once(&snc_nodes_once, init_snc_nodes);
+	return cached_snc_nodes;
+}

-	if (!checked_chas) {
-		int fd = perf_pmu__event_source_devices_fd();
-		struct io_dir dir;
-		struct io_dirent64 *dent;
+static int cached_num_chas;
+static pthread_once_t num_chas_once = PTHREAD_ONCE_INIT;

-		if (fd < 0)
-			return -1;
+static void init_num_chas(void)
+{
+	int fd = perf_pmu__event_source_devices_fd();
+	struct io_dir dir;
+	struct io_dirent64 *dent;

-		io_dir__init(&dir, fd);
+	if (fd < 0) {
+		cached_num_chas = -1;
+		return;
+	}

-		while ((dent = io_dir__readdir(&dir)) != NULL) {
-			/* Note, dent->d_type will be DT_LNK and so isn't a useful filter. */
-			if (strstarts(dent->d_name, "uncore_cha_"))
-				num_chas++;
-		}
-		close(fd);
-		checked_chas = true;
+	io_dir__init(&dir, fd);
+
+	while ((dent = io_dir__readdir(&dir)) != NULL) {
+		/* Note, dent->d_type will be DT_LNK and so isn't a useful filter. */
+		if (strstarts(dent->d_name, "uncore_cha_"))
+			cached_num_chas++;
 	}
-	return num_chas;
+	close(fd);
+}
+
+static int num_chas(void)
+{
+	pthread_once(&num_chas_once, init_num_chas);
+	return cached_num_chas;
 }

 #define MAX_SNCS 6
@@ -121,46 +142,73 @@ static int uncore_cha_snc(struct perf_pmu *pmu)
 		return 0;
 	}
 	chas_per_node = num_cha / snc_nodes;
+	if (chas_per_node == 0) {
+		pr_warning("Unexpected: chas_per_node is 0 (num_cha=%d, snc_nodes=%d)\n",
+			   num_cha, snc_nodes);
+		return 0;
+	}
 	cha_snc = cha_num / chas_per_node;

 	/* Range check cha_snc. for unexpected out of bounds. */
 	return cha_snc >= MAX_SNCS ? 0 : cha_snc;
 }

-static int uncore_imc_snc(struct perf_pmu *pmu)
+static const u8 *cached_imc_snc_map;
+static size_t cached_imc_snc_map_len;
+static pthread_once_t imc_snc_map_once = PTHREAD_ONCE_INIT;
+
+static void init_snc_map(void)
 {
-	// Compute the IMC SNC using lookup tables.
-	unsigned int imc_num;
 	int snc_nodes = snc_nodes_per_l3_cache();
-	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
-	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
-	const u8 *snc_map;
-	size_t snc_map_len;
+	char *cpuid;
+	static const u8 gnr_snc2_map[] = { 1, 1, 0, 0 };
+	static const u8 snc3_map[] = { 1, 1, 0, 0, 2, 2 };

 	switch (snc_nodes) {
 	case 2:
-		snc_map = snc2_map;
-		snc_map_len = ARRAY_SIZE(snc2_map);
+		cpuid = get_cpuid_str((struct perf_cpu){ 0 });
+		if (cpuid) {
+			if (strcmp_cpuid_str(GENUINE_INTEL_GNR, cpuid) == 0) {
+				cached_imc_snc_map = gnr_snc2_map;
+				cached_imc_snc_map_len = ARRAY_SIZE(gnr_snc2_map);
+			}
+			free(cpuid);
+		}
 		break;
 	case 3:
-		snc_map = snc3_map;
-		snc_map_len = ARRAY_SIZE(snc3_map);
+		cached_imc_snc_map = snc3_map;
+		cached_imc_snc_map_len = ARRAY_SIZE(snc3_map);
 		break;
 	default:
 		/* Error or no lookup support for SNC with >3 nodes. */
-		return 0;
+		break;
 	}

+	if (!cached_imc_snc_map)
+		pr_warning("Unexpected: can not find snc map config\n");
+}
+
+static int uncore_imc_snc(struct perf_pmu *pmu)
+{
+	// Compute the IMC SNC using lookup tables.
+	unsigned int imc_num;
+	int snc_nodes = snc_nodes_per_l3_cache();
+
+	if (snc_nodes <= 1)
+		return 0;
+
+	pthread_once(&imc_snc_map_once, init_snc_map);
+
 	/* Compute SNC for PMU. */
 	if (sscanf(pmu->name, "uncore_imc_%u", &imc_num) != 1) {
 		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
 		return 0;
 	}
-	if (imc_num >= snc_map_len) {
-		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
+
+	if (!cached_imc_snc_map)
 		return 0;
-	}
-	return snc_map[imc_num];
+
+	return cached_imc_snc_map[imc_num % cached_imc_snc_map_len];
 }

 static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
@@ -200,7 +248,9 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
 	return cpu_adjust[pmu_snc];
 }

-static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
+static pthread_mutex_t pmu_adjust_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
 {
 	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
 	// topology. For example, a two socket graniterapids machine may be set
@@ -231,9 +281,11 @@ static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool
 		return;
 	}

+	pthread_mutex_lock(&pmu_adjust_mutex);
+
 	pmu_snc = cha ? uncore_cha_snc(pmu) : uncore_imc_snc(pmu);
 	if (pmu_snc == 0) {
-		// No adjustment necessary for the first SNC.
+		pthread_mutex_unlock(&pmu_adjust_mutex);
 		return;
 	}

@@ -242,8 +294,10 @@ static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool
 		// Hold onto the perf_cpu_map globally to avoid recomputation.
 		cpu_adjust = uncore_cha_imc_compute_cpu_adjust(pmu_snc);
 		adjusted[pmu_snc] = perf_cpu_map__empty_new(perf_cpu_map__nr(pmu->cpus));
-		if (!adjusted[pmu_snc])
+		if (!adjusted[pmu_snc]) {
+			pthread_mutex_unlock(&pmu_adjust_mutex);
 			return;
+		}
 	}

 	perf_cpu_map__for_each_cpu(cpu, idx, pmu->cpus) {
@@ -263,6 +317,8 @@ static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool

 	perf_cpu_map__put(pmu->cpus);
 	pmu->cpus = perf_cpu_map__get(adjusted[pmu_snc]);
+
+	pthread_mutex_unlock(&pmu_adjust_mutex);
 }

 void perf_pmu__arch_init(struct perf_pmu *pmu)
@@ -300,11 +356,16 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 				pmu->mem_events = perf_mem_events_intel_aux;
 			else
 				pmu->mem_events = perf_mem_events_intel;
-		} else if (x86__is_intel_graniterapids()) {
-			if (strstarts(pmu->name, "uncore_cha_"))
-				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
-			else if (strstarts(pmu->name, "uncore_imc_"))
-				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
+		} else if (x86__is_snc_supported()) {
+			int snc_nodes = snc_nodes_per_l3_cache();
+
+			if (snc_nodes == 2 || snc_nodes == 3) {
+				if (strstarts(pmu->name, "uncore_cha_"))
+					uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
+				else if (strstarts(pmu->name, "uncore_imc_") &&
+					 !strstarts(pmu->name, "uncore_imc_free_running"))
+					uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
+			}
 		}
 	}
 }
--
2.54.0.823.g6e5bcc1fc9-goog

