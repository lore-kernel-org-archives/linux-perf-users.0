Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A1B2BCF65
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Jul 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895622; cv=none; b=pg0xPJ8eCGdF1Rvv/hRS5qp+5RrRSUIPdV6qtXKzwAxuebXyDdN4pdD8puZaYnFWAvrlbu+3Utwow7y3/w0ZLE6vFXU9Beimrygin+oL45MRho0zdfHUrGTTE3oA9ezlDbgIPtFBmlFMU+46BO5VB+h4t5sYu1IIFvn9R6ZIYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895622; c=relaxed/simple;
	bh=I5RguSnrzI9C2Mua/gfwpAu8ZT3yNzuLFIDBxzDYqk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PqkL/KRxm6daDLt4adsFcFMyAaYlxAB7Zbq6zSq0C1Llhoa+AAO97+ZaumvQrHqNRZ1GzyOorDD9m2XRLjvl+Y+oTR5mTaGclj4Np4IU9o/I4keJ2IV8/pr+7ukeYHteRMrW0f1FkLB8056tMcicU99BISrxQvdSdhUQU+mQ8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C2AF168F;
	Mon,  7 Jul 2025 06:40:06 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF0BC3F6A8;
	Mon,  7 Jul 2025 06:40:16 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 07 Jul 2025 14:39:34 +0100
Subject: [PATCH v3 12/14] perf arm_spe: Refactor
 arm_spe__get_metadata_by_cpu()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-12-33ea82da3280@arm.com>
References: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
In-Reply-To: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 German Gomez <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751895589; l=2930;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=I5RguSnrzI9C2Mua/gfwpAu8ZT3yNzuLFIDBxzDYqk4=;
 b=RINMD7EknfrG0uZtJ7CxNY3YC8NCP6xjxgyD5hBuMSl9hTSFwISDXo3FXQ8g3g6Cm9lEiEwmD
 +2sykV0k02DAyH7dRsWHg/vddsqpyMb2wxu2t3kUk2yiro+b5QMeaEX
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Handle "CPU=-1" (per-thread mode) in the arm_spe__get_metadata_by_cpu()
function. As a result, the function is more general and will be invoked
by a sequential change.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 55 ++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 87cbba941d6f3066697ff430d6ce8e085b173032..e89182b6d27d3d00357db72d804f1d22d5765937 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -317,15 +317,38 @@ static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
 	return 0;
 }
 
-static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, u64 cpu)
+static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, int cpu)
 {
+	struct perf_cpu_map *cpus;
+	struct perf_cpu perf_cpu;
 	u64 i;
 
 	if (!spe->metadata)
 		return NULL;
 
+	/* CPU ID is -1 for per-thread mode */
+	if (cpu < 0) {
+		/*
+		 * On the heterogeneous system, due to CPU ID is -1,
+		 * cannot confirm the data source packet is supported.
+		 */
+		if (!spe->is_homogeneous)
+			return NULL;
+
+		cpus = perf_pmus__find_by_type(spe->pmu_type)->cpus;
+		if (!cpus)
+			return NULL;
+
+		/* In a homogeneous system, fetch the first CPU in the map. */
+		perf_cpu = perf_cpu_map__cpu(cpus, 0);
+		if (perf_cpu.cpu == -1)
+			return NULL;
+
+		cpu = perf_cpu.cpu;
+	}
+
 	for (i = 0; i < spe->metadata_nr_cpu; i++)
-		if (spe->metadata[i][ARM_SPE_CPU] == cpu)
+		if (spe->metadata[i][ARM_SPE_CPU] == (u64)cpu)
 			return spe->metadata[i];
 
 	return NULL;
@@ -914,9 +937,6 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 			      union perf_mem_data_src *data_src)
 {
 	struct arm_spe *spe = speq->spe;
-	struct perf_cpu_map *cpus;
-	struct perf_cpu perf_cpu;
-	int16_t cpu_nr;
 	u64 *metadata = NULL;
 	u64 midr;
 	unsigned int i;
@@ -929,30 +949,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 		cpuid = perf_env__cpuid(spe->session->evlist->env);
 		midr = strtol(cpuid, NULL, 16);
 	} else {
-		/* CPU ID is -1 for per-thread mode */
-		if (speq->cpu < 0) {
-			/*
-			 * On the heterogeneous system, due to CPU ID is -1,
-			 * cannot confirm the data source packet is supported.
-			 */
-			if (!spe->is_homogeneous)
-				return false;
-
-			cpus = perf_pmus__find_by_type(spe->pmu_type)->cpus;
-			if (!cpus)
-				return false;
-
-			/* In a homogeneous system, fetch the first CPU in the map. */
-			perf_cpu = perf_cpu_map__cpu(cpus, 0);
-			if (perf_cpu.cpu == -1)
-				return false;
-
-			cpu_nr = perf_cpu.cpu;
-		} else {
-			cpu_nr = speq->cpu;
-		}
-
-		metadata = arm_spe__get_metadata_by_cpu(spe, cpu_nr);
+		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
 		if (!metadata)
 			return false;
 

-- 
2.34.1

