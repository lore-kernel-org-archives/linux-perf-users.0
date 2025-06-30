Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090228FFEC
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297075; cv=none; b=Ddh/sX6rpCli738I6qXKvzL5YNxgAN6wjAZ7mjN067qiO+EA2KZn0LcFGpdAzX6Hnx3oY02UnZe5qoPDgQ93IjpTNJRu2BJKxKvSKSFcmF4pEdJs+abwwPEdmc3yfmGoAbM3ie9BGUUuxMVLNnPtRgTQgUJFriw6Asy4lrMfpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297075; c=relaxed/simple;
	bh=/rBTPEEjSMTKfZXh44B/N7IEPmeqGhWCK9qoF52zWCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMH+tGM7aapuu2F/EAP17I44C/7PM6jv1Nfbo85cyXcxxKYpEcyEKjqFHbKRNggFULOxSgG6CijEtbSw41zZ2+6n5HRP1aHzkKRcUhGFqLLKMiUAz+DBSyNOcQBxQs89SNz/2t9FMlgQGD8yiZw8k8YEjF6YfzLrtDvX1Wnr5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A421AC1;
	Mon, 30 Jun 2025 08:24:17 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7DA13F6A8;
	Mon, 30 Jun 2025 08:24:30 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 30 Jun 2025 16:23:42 +0100
Subject: [PATCH v2 10/13] perf arm_spe: Fill memory levels for FEAT_SPEv1p4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-10-2e1afab313b9@arm.com>
References: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-0-2e1afab313b9@arm.com>
In-Reply-To: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-0-2e1afab313b9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751297044; l=3747;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=/rBTPEEjSMTKfZXh44B/N7IEPmeqGhWCK9qoF52zWCI=;
 b=N+Nill9cl0J8gy51CEpPtDRRnYHEFJutpqMYMVYRbrJlcUk+hftP57Fz42uNxZ66KwOMl7lHt
 RCtnfRSrgHaDdQt/efpQo5vgl0Snbw8pd5lDuxCZ3aCzmg5U4mXus3n
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

