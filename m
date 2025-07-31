Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9465D2C08DF
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968461; cv=none; b=CV/HU3v6ll2cPVZ0PqPwb6Pa0qdVuL3WnUPTUdlVg1XecKg4DmPYujN1wGwpkVZFeiRrl+BXzbeA7G7Yh/K4npmuLkO+VGDWUUamZudix08Qx41DIOhJKRPanhzMuqoW1SxGmcWsdug4kdMrpjBTHUeI+nYRjhDXYcj9H0we3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968461; c=relaxed/simple;
	bh=DwDknRz+M+PM0kRQxaVsn+FUh1ULlnp1rQaeTIs9xco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbhaphNwqEmOC5fsKYrKhgdDZFwA2nFvcZULpmplAsr6DZa6XZMxKL0NE+zKyEUIweOF655E+ixOUaKXYGU3psoQNnHLUFgTc0eYcntOYTOxTx1PBlHnQak6nUwrr9aR4z1eBXC2J2ckwc3OihLcG60MnjI0FPst4/7hD9Kbg9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E93B92BC3;
	Thu, 31 Jul 2025 06:27:30 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4C7B3F66E;
	Thu, 31 Jul 2025 06:27:36 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 14:25:50 +0100
Subject: [PATCH v4 15/15] perf arm_spe: Allow parsing both data source and
 events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-15-58e5677a412b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753968422; l=4722;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=DwDknRz+M+PM0kRQxaVsn+FUh1ULlnp1rQaeTIs9xco=;
 b=OOKeWz+A9vVgpnRs33Uf4YarurcS1VAbmxuSDBLoawWkqgWvCZT9h7b1bJtYBgLGbU/EGR98i
 bkSymMQU/RTCp4qzAh5HVsYF1TeFvbFNEUXHWcdXe/uLnlTfTCsAjAF
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Current code skips to parse events after generating data source. The
reason is the data source packets have cache and snooping related info,
the afterwards event packets might contain duplicate info.

This commit changes to continue parsing the events after data source
analysis. If data source does not give out memory level and snooping
types, then the event info is used to synthesize the related fields.

As a result, both the peer snoop option ('-d peer') and hitm options
('-d tot/lcl/rmt') are supported by Arm SPE in the perf c2c.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 75 ++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 17d12bfa812c86a796dd79624a3d283f0cbac237..a2925a5cfe980f1c72a8748b02fbe238cc7b8e00 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -921,40 +921,56 @@ static void arm_spe__synth_memory_level(struct arm_spe_queue *speq,
 {
 	struct arm_spe *spe = speq->spe;
 
-	if (data_src->mem_op == PERF_MEM_OP_LOAD)
-		arm_spe__synth_ld_memory_level(record, data_src);
-	if (data_src->mem_op == PERF_MEM_OP_STORE)
-		arm_spe__synth_st_memory_level(record, data_src);
+	/*
+	 * The data source packet contains more info for cache levels for
+	 * peer snooping. So respect the memory level if has been set by
+	 * data source parsing.
+	 */
+	if (!data_src->mem_lvl) {
+		if (data_src->mem_op == PERF_MEM_OP_LOAD)
+			arm_spe__synth_ld_memory_level(record, data_src);
+		if (data_src->mem_op == PERF_MEM_OP_STORE)
+			arm_spe__synth_st_memory_level(record, data_src);
+	}
 
 	if (!data_src->mem_lvl) {
 		data_src->mem_lvl = PERF_MEM_LVL_NA;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
 	}
 
-	if (record->type & ARM_SPE_DATA_SNOOPED) {
-		if (record->type & ARM_SPE_HITM)
-			data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
-		else
-			data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
-	} else {
-		u64 *metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
-
-		/*
-		 * Set NA ("Not available") mode if no meta data or the
-		 * SNOOPED event is not supported.
-		 */
-		if (!metadata ||
-		    !(metadata[ARM_SPE_CAP_EVENT_FILTER] & ARM_SPE_DATA_SNOOPED))
-			data_src->mem_snoop = PERF_MEM_SNOOP_NA;
-		else
-			data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+	/*
+	 * If 'mem_snoop' has been set by data source packet, skip to set
+	 * it at here.
+	 */
+	if (!data_src->mem_snoop) {
+		if (record->type & ARM_SPE_DATA_SNOOPED) {
+			if (record->type & ARM_SPE_HITM)
+				data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+			else
+				data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
+		} else {
+			u64 *metadata =
+				arm_spe__get_metadata_by_cpu(spe, speq->cpu);
+
+			/*
+			 * Set NA ("Not available") mode if no meta data or the
+			 * SNOOPED event is not supported.
+			 */
+			if (!metadata ||
+			    !(metadata[ARM_SPE_CAP_EVENT_FILTER] & ARM_SPE_DATA_SNOOPED))
+				data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+			else
+				data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		}
 	}
 
-	if (record->type & ARM_SPE_REMOTE_ACCESS)
-		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+	if (!data_src->mem_remote) {
+		if (record->type & ARM_SPE_REMOTE_ACCESS)
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+	}
 }
 
-static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
+static void arm_spe__synth_ds(struct arm_spe_queue *speq,
 			      const struct arm_spe_record *record,
 			      union perf_mem_data_src *data_src)
 {
@@ -973,19 +989,18 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 	} else {
 		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
 		if (!metadata)
-			return false;
+			return;
 
 		midr = metadata[ARM_SPE_CPU_MIDR];
 	}
 
 	for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
 		if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
-			data_source_handles[i].ds_synth(record, data_src);
-			return true;
+			return data_source_handles[i].ds_synth(record, data_src);
 		}
 	}
 
-	return false;
+	return;
 }
 
 static union perf_mem_data_src
@@ -1005,8 +1020,8 @@ arm_spe__synth_data_source(struct arm_spe_queue *speq,
 	else
 		return data_src;
 
-	if (!arm_spe__synth_ds(speq, record, &data_src))
-		arm_spe__synth_memory_level(speq, record, &data_src);
+	arm_spe__synth_ds(speq, record, &data_src);
+	arm_spe__synth_memory_level(speq, record, &data_src);
 
 	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
 		data_src.mem_dtlb = PERF_MEM_TLB_WK;

-- 
2.34.1

