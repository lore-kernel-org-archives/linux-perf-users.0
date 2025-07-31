Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3D2D0C80
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968456; cv=none; b=VpHorx/t9A3gv0nFEODu9aSQI54Qs5JvrutoBAechkFAX+6+KnQLPgjdN7WUBUgNrqKu3JN7NfFbm6BM9rb8aK+NGjNt1HG/mVXWYKnxFqL0lOvBuEfBVpGHUeC51vTpdIGyWWatwX9AbDmRwd9qc8NR+uBlWIzGtzMw3jRtffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968456; c=relaxed/simple;
	bh=YKDREJ2DvafeKbzLBrBJa3j7Z6tX7ahxmNCW+oN7a5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jr3pHlCNbcWGDXwOmvk68mdQVa9z0PsDycO0UUD8NUcKoDmcV90UvRnjoFS3AOtPBjgyjR0ngU4ZUPfpouNweKf4l6F/Q/ta0nleb6UZHvwdydrYrlFSCwWFpCGuCY+GU3l63RcRqPUge7XqlzKraNlIF9KuX8pBorFj9aVhECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BCD22BC3;
	Thu, 31 Jul 2025 06:27:26 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5874C3F66E;
	Thu, 31 Jul 2025 06:27:32 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 14:25:48 +0100
Subject: [PATCH v4 13/15] perf arm_spe: Refactor
 arm_spe__get_metadata_by_cpu()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-13-58e5677a412b@arm.com>
References: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
In-Reply-To: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753968422; l=2936;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=YKDREJ2DvafeKbzLBrBJa3j7Z6tX7ahxmNCW+oN7a5k=;
 b=yi1vW3T12d3fd1AzoxpEUYSqx1CXXkS0fi4PfZ1UzEnilSebqySMU5+/KZRscgtnx1MuuJ3+x
 6whRDEwwZiAC3pD/APlcG6pJBaFX2vjZ7rrJHyIASJFcJhDCY3AhFgl
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
index 2ac10b8008527a066c9b2f67a22eb8511af9239a..3c32b9bc9c983370e37d871adeaa610bf5905c1d 100644
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
 		cpuid = perf_env__cpuid(perf_session__env(spe->session));
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

