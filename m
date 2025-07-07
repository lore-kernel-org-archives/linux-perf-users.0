Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513C29B792
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Jul 2025 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895614; cv=none; b=f7it4Ie8mJTwItXqCeMA8FWQ4du4k8nFepAjmj2Nt1FBedmCG3Ae6JkAMwSLpjG7O9IE6ZJ9GknbZITfrUNV6Rmfum6tTxvF6EOjFDqokXwgXRAIVtvrAlMjFerm0G0yYilw5mGqkE0M7S6Of8DiSd+blO71Kh3spePKld8Z4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895614; c=relaxed/simple;
	bh=XqqUZP7LTMl9UHCkLOBhIsiFA5xAVL26fIWUhaF2lXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FngVOwherMFbNK8axZRkjxL6GYfpsVFI8qmUSlqSZDur3inVHgc63i8neefQ4qlu1Q+wf+H5L1zV+5JPEdo3ekor8scczqFOauDf7kj8nFKu68XgEspaCuJXkR9uA0NpcCam5xcHHqbVemfUqoCif+TGCR98oS7uh+CJ7TFTqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FA1E1762;
	Mon,  7 Jul 2025 06:39:59 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E14A3F6A8;
	Mon,  7 Jul 2025 06:40:09 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 07 Jul 2025 14:39:31 +0100
Subject: [PATCH v3 09/14] perf arm_spe: Separate setting of memory levels
 for loads and stores
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-9-33ea82da3280@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751895589; l=3566;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=XqqUZP7LTMl9UHCkLOBhIsiFA5xAVL26fIWUhaF2lXk=;
 b=Aw1iKDAeBjiOHROzQ5odGGyhYFfZx5LIB+A8NmIv3qWwRgLRo/0Pvee1UfsQaWTf1JWXzO0Z2
 7/tNs+MijjUBMc7/ju2FvmLz2t8cpct0Y9gXWK0LYxv7+m0uukLGBDF
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

For a load hit, the lowest-level cache reflects the latency of fetching
a data. Otherwise, the highest-level cache involved in refilling
indicates the overhead caused by a load.

Store operations remain unchanged to keep the descending order when
iterating through cache levels.

Split into two functions: one is for setting memory levels for loads and
another for stores.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index eddd554c49bcd873f6095bb262090786b1db5355..688f6cd0f739e2b5f23a7776a7f2ebc97c12a2dd 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -45,6 +45,9 @@
 #define arm_spe_is_cache_level(type, lvl) \
 	((type) & ARM_SPE_CACHE_EVENT(lvl))
 
+#define arm_spe_is_cache_hit(type, lvl) \
+	(((type) & ARM_SPE_CACHE_EVENT(lvl)) == ARM_SPE_##lvl##_ACCESS)
+
 #define arm_spe_is_cache_miss(type, lvl) \
 	((type) & ARM_SPE_##lvl##_MISS)
 
@@ -830,9 +833,38 @@ static const struct data_source_handle data_source_handles[] = {
 	DS(hisi_hip_ds_encoding_cpus, data_source_hisi_hip),
 };
 
-static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
-					union perf_mem_data_src *data_src)
+static void arm_spe__synth_ld_memory_level(const struct arm_spe_record *record,
+					   union perf_mem_data_src *data_src)
+{
+	/*
+	 * To find a cache hit, search in ascending order from the lower level
+	 * caches to the higher level caches. This reflects the best scenario
+	 * for a cache hit.
+	 */
+	if (arm_spe_is_cache_hit(record->type, L1D)) {
+		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
+	} else if (arm_spe_is_cache_hit(record->type, LLC)) {
+		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+	/*
+	 * To find a cache miss, search in descending order from the higher
+	 * level cache to the lower level cache. This represents the worst
+	 * scenario for a cache miss.
+	 */
+	} else if (arm_spe_is_cache_miss(record->type, LLC)) {
+		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_MISS;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+	} else if (arm_spe_is_cache_miss(record->type, L1D)) {
+		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_MISS;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
+	}
+}
+
+static void arm_spe__synth_st_memory_level(const struct arm_spe_record *record,
+					   union perf_mem_data_src *data_src)
 {
+	/* Record the greatest level info for a store operation. */
 	if (arm_spe_is_cache_level(record->type, LLC)) {
 		data_src->mem_lvl = PERF_MEM_LVL_L3;
 		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, LLC) ?
@@ -844,6 +876,15 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
 	}
+}
+
+static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
+					union perf_mem_data_src *data_src)
+{
+	if (data_src->mem_op == PERF_MEM_OP_LOAD)
+		arm_spe__synth_ld_memory_level(record, data_src);
+	if (data_src->mem_op == PERF_MEM_OP_STORE)
+		arm_spe__synth_st_memory_level(record, data_src);
 
 	if (!data_src->mem_lvl) {
 		data_src->mem_lvl = PERF_MEM_LVL_NA;

-- 
2.34.1

