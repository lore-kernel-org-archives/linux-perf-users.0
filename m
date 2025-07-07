Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043C229B792
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Jul 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895618; cv=none; b=c+ujkBM1OucnrpgHWefrNBUauiTmxjs84Zopv74lxPFeVVbC8MyOir7rjaQEdu72pmn4hQzGpVyle/Ar/xH1aR3KQddh7NFqBMJ6n0VKFw99mdwc0AsZyD9W4rhL8KVdrwybZTzoHvXrZEuzG3b6OAaSOES6EEZsW4A4KNz4R3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895618; c=relaxed/simple;
	bh=/rBTPEEjSMTKfZXh44B/N7IEPmeqGhWCK9qoF52zWCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LM3Aryuke/vEb4cSvTTqKDfLiZr5saHvD31vrK2EJlhukJ+7D1AckVepqZTmZvUNw9MBvAXVihBMbGEhhaATMZfZAvqtWfszjRdlxlAcTyIoj1+iToaJ5VyJTNdUtenGU+gGOcQehtyxvffugtT2Lw4COF4I1vLLlphZ9Rqxycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6771168F;
	Mon,  7 Jul 2025 06:40:01 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 642873F6A8;
	Mon,  7 Jul 2025 06:40:12 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 07 Jul 2025 14:39:32 +0100
Subject: [PATCH v3 10/14] perf arm_spe: Fill memory levels for FEAT_SPEv1p4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-10-33ea82da3280@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751895589; l=3747;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=/rBTPEEjSMTKfZXh44B/N7IEPmeqGhWCK9qoF52zWCI=;
 b=lagJGbothySTZbD5b03wnwXhp+p9lxb7cu7KQR5fGI4+PAwTK5ekm669NifWCpKAtY5LfxydG
 ApcGQVvK2pFAl7Nk7IJ6tGnaqfDLm4q5LQeQ+8HOFtnGirv5YCIP+Zf
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Starting with FEAT_SPEv1p4, Arm SPE provides information on Level 2 data
cache and recently fetched events. This patch fills in the memory levels
for these new events.

The recently fetched events are matched to line-fill buffer (LFB). In
general, the latency for accessing LFB is higher than accessing L1 cache
but lower than accessing L2 cache. Thus, it locates in the memory
hierarchy information between L1 cache and L2 cache.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h |  3 +++
 tools/perf/util/arm-spe.c                         | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 03da55453da8fd2e7b9e2dcba3ddcf5243599e1c..3afa8703b21db9d231eef93fe981e0c20d562e83 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -25,6 +25,9 @@
 #define ARM_SPE_SVE_PARTIAL_PRED	BIT(EV_PARTIAL_PREDICATE)
 #define ARM_SPE_SVE_EMPTY_PRED		BIT(EV_EMPTY_PREDICATE)
 #define ARM_SPE_IN_TXN			BIT(EV_TRANSACTIONAL)
+#define ARM_SPE_L2D_ACCESS		BIT(EV_L2D_ACCESS)
+#define ARM_SPE_L2D_MISS		BIT(EV_L2D_MISS)
+#define ARM_SPE_RECENTLY_FETCHED	BIT(EV_RECENTLY_FETCHED)
 
 enum arm_spe_op_type {
 	/* First level operation type */
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 688f6cd0f739e2b5f23a7776a7f2ebc97c12a2dd..3715afbe1e4713b5eebb00afbcb3eaa56ff1c49c 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -844,6 +844,12 @@ static void arm_spe__synth_ld_memory_level(const struct arm_spe_record *record,
 	if (arm_spe_is_cache_hit(record->type, L1D)) {
 		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
+	} else if (record->type & ARM_SPE_RECENTLY_FETCHED) {
+		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_LFB;
+	} else if (arm_spe_is_cache_hit(record->type, L2D)) {
+		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
 	} else if (arm_spe_is_cache_hit(record->type, LLC)) {
 		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
@@ -855,6 +861,9 @@ static void arm_spe__synth_ld_memory_level(const struct arm_spe_record *record,
 	} else if (arm_spe_is_cache_miss(record->type, LLC)) {
 		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_MISS;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+	} else if (arm_spe_is_cache_miss(record->type, L2D)) {
+		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_MISS;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
 	} else if (arm_spe_is_cache_miss(record->type, L1D)) {
 		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_MISS;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
@@ -870,6 +879,11 @@ static void arm_spe__synth_st_memory_level(const struct arm_spe_record *record,
 		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, LLC) ?
 				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+	} else if (arm_spe_is_cache_level(record->type, L2D)) {
+		data_src->mem_lvl = PERF_MEM_LVL_L2;
+		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, L2D) ?
+				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
 	} else if (arm_spe_is_cache_level(record->type, L1D)) {
 		data_src->mem_lvl = PERF_MEM_LVL_L1;
 		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, L1D) ?

-- 
2.34.1

