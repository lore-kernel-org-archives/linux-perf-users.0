Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD92135DE
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830079; cv=none; b=qFuiOGNBrfh1/vg5xYK0qoD3vVxfre+5e/QOEdYIin/sl/PvQFnMOMtBjrVmvWOf0ndZa2bf3H3F6k6+lg4WeOb2roPdzrNCn6jN7c6+CucZ3MJ1ImQtRvR4e5obxCO3T3kT/dR50Ab0ETeLe8M+28EodN4GP147heFGnkF7jHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830079; c=relaxed/simple;
	bh=d1N/WHh732injNOSlj16LMhSg88WhZRcmg5mEbJ8L/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuSXQyVqWUvlChT3qMmqof+wiLKQVIyI6m21lQUvZWDAOFPgvPKMqOs5Nyk1qhu4yomqwt8PMzCDP3Vo31zy5lN2qlUEGd2BvixZajBAUSCyAQxfJbHmwJ6dBX12Zi50X8PTNoB/Audl1WWkx1WVjCPc5sMRsflTunx2eWKEMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69DDD22D9;
	Fri, 13 Jun 2025 08:54:17 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155973F59E;
	Fri, 13 Jun 2025 08:54:35 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 13 Jun 2025 16:53:44 +0100
Subject: [PATCH 11/12] perf arm_spe: Set HITM flag
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-11-6faecf0a8775@arm.com>
References: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749830053; l=3644;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=d1N/WHh732injNOSlj16LMhSg88WhZRcmg5mEbJ8L/M=;
 b=LwZ+aZ+fFeedkCwiOoWxxMThSuNAZH6ScrRYSqXo+PTe6K6hbA1NCsqWs6UwmI5vlKRxOKuVi
 b/FvWH9VWEaDfBWYE9gq4fhJcmW8ntzmwTSxIytppOnZ/ySAbKtuv3O
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since FEAT_SPEv1p4, Arm SPE provides extra two events "Cache data
modified" and "Data snooped".

Set the snoop mode as:

- If both the "Cache data modified" event and the "Data snooped" event
  are set, which indicates a load operation that snooped from a outside
  cache and hit a modified copy, set the HITM flag to inspect false
  sharing.
- If the snooped event bit is not set, and the snooped event has been
  supported by the hardware, set as NONE mode (no snoop operation).
- If the snooped event bit is not set, and the event is not supported or
  absent the events info in the meta data, set as NA mode (not
  available).

Don't set any mode for only "Cache data modified" event, as it hits a
local modified copy.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h |  2 ++
 tools/perf/util/arm-spe.c                         | 26 +++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 90c76928c7bf1b35cec538abdb0e88d6083fe81b..a2b48b0c87712f232587023eeaa66a9b83aed382 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -28,6 +28,8 @@
 #define ARM_SPE_L2D_ACCESS		BIT(EV_L2D_ACCESS)
 #define ARM_SPE_L2D_MISS		BIT(EV_L2D_MISS)
 #define ARM_SPE_RECENTLY_FETCH		BIT(EV_RECENTLY_FETCHED)
+#define ARM_SPE_DATA_SNOOPED		BIT(EV_DATA_SNOOPED)
+#define ARM_SPE_HITM			BIT(EV_CACHE_DATA_MODIFIED)
 
 enum arm_spe_op_type {
 	/* First level operation type */
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8e93b0d151a98714d0c5e5f6ceec386a2aa63ad0..8a889f727f9cd5351b4ca027935112eddd16ea6c 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -903,9 +903,12 @@ static void arm_spe__synth_st_memory_level(const struct arm_spe_record *record,
 	}
 }
 
-static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
+static void arm_spe__synth_memory_level(struct arm_spe_queue *speq,
+					const struct arm_spe_record *record,
 					union perf_mem_data_src *data_src)
 {
+	struct arm_spe *spe = speq->spe;
+
 	if (data_src->mem_op == PERF_MEM_OP_LOAD)
 		arm_spe__synth_ld_memory_level(record, data_src);
 	if (data_src->mem_op == PERF_MEM_OP_STORE)
@@ -916,6 +919,25 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
 	}
 
+	if (record->type & ARM_SPE_DATA_SNOOPED) {
+		if (record->type & ARM_SPE_HITM)
+			data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+		else
+			data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
+	} else {
+		u64 *metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
+
+		/*
+		 * Set NA ("Not available") mode if no meta data or the
+		 * SNOOPED event is not supported.
+		 */
+		if (!metadata ||
+		    !(metadata[ARM_SPE_CAP_EVENTS] & ARM_SPE_DATA_SNOOPED))
+			data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+		else
+			data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+	}
+
 	if (record->type & ARM_SPE_REMOTE_ACCESS)
 		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 }
@@ -971,7 +993,7 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
 		return 0;
 
 	if (!arm_spe__synth_ds(speq, record, &data_src))
-		arm_spe__synth_memory_level(record, &data_src);
+		arm_spe__synth_memory_level(speq, record, &data_src);
 
 	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
 		data_src.mem_dtlb = PERF_MEM_TLB_WK;

-- 
2.34.1

