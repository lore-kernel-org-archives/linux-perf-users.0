Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC78C2D0C84
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968454; cv=none; b=UPMcBzJJpcUrU6QKyvOzxKZAf9NSBXP0SXYix8zRE8BNuurj3lX6gQ1fqdGisPF3939iZf4D4ng/RVQjpq019MVouTl4h11p+xCYOPXzlfszwFImDqfghu6sorSLcddaw8oiulZCT0NGoekAqEkb13gC3NtKdjGAYIJVtGbohpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968454; c=relaxed/simple;
	bh=tSdX7nxAmbuhi7LmUY+XdoS5sBr1mFSU1t8XRmTC4u0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jchls+QXL6R3gqjj8Z7zUZkd3vR+o0Gb/2VmGWPv29Z70sFVBHcqU47vaHm27vVl3coZ3u1bZaRlh1slAaS1qbxTjUavJLe5+y4SRBgJ7Ca2z/4j938Uq9DdR1qfHqDAqJNOtq9M47/znYYBN+zu3XjWV6HjwDUs501JvL4wNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 174471D13;
	Thu, 31 Jul 2025 06:27:24 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 126273F66E;
	Thu, 31 Jul 2025 06:27:29 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 14:25:47 +0100
Subject: [PATCH v4 12/15] perf arm_spe: Improve CPU number retrieving in
 per-thread mode
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-12-58e5677a412b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753968422; l=1871;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=tSdX7nxAmbuhi7LmUY+XdoS5sBr1mFSU1t8XRmTC4u0=;
 b=lAnvN3WiHM9+BiqCID6b3MU9Q2ZSMHE+73s89Xx3tbYzS8mKh4uRJFqyaQFsK7JgzjjOTHBBT
 GjZPlycaFUyDccjP04yPvoDboJZfzUqubzs0/dUYh7ULme+FVwREsnN
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

In per-thread mode on a homogeneous system, the current code simply
picks the first metadata entry for data source parsing.

This change improves that by using the PMU type to find the matching PMU
event. From there, it reads the CPU map and uses the first CPU ID to
fetch the metadata.

Although this makes no difference when there's only one Arm SPE PMU, it
helps for future support of multiple SPE events.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index db681dd2aed205655e77f3dfcd7eb3c33f20277a..2ac10b8008527a066c9b2f67a22eb8511af9239a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -914,6 +914,9 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 			      union perf_mem_data_src *data_src)
 {
 	struct arm_spe *spe = speq->spe;
+	struct perf_cpu_map *cpus;
+	struct perf_cpu perf_cpu;
+	int16_t cpu_nr;
 	u64 *metadata = NULL;
 	u64 midr;
 	unsigned int i;
@@ -935,13 +938,21 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 			if (!spe->is_homogeneous)
 				return false;
 
-			/* In homogeneous system, simply use CPU0's metadata */
-			if (spe->metadata)
-				metadata = spe->metadata[0];
+			cpus = perf_pmus__find_by_type(spe->pmu_type)->cpus;
+			if (!cpus)
+				return false;
+
+			/* In a homogeneous system, fetch the first CPU in the map. */
+			perf_cpu = perf_cpu_map__cpu(cpus, 0);
+			if (perf_cpu.cpu == -1)
+				return false;
+
+			cpu_nr = perf_cpu.cpu;
 		} else {
-			metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
+			cpu_nr = speq->cpu;
 		}
 
+		metadata = arm_spe__get_metadata_by_cpu(spe, cpu_nr);
 		if (!metadata)
 			return false;
 

-- 
2.34.1

