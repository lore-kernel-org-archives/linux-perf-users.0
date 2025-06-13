Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBFF211A3D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830071; cv=none; b=dV/mMa1hyD03usTzZOFMA01kss+MdBzIaptoPJyzHDBgLQHfE9FxTzS3OQsMSdKnhRpmjFKdDkSZuNjfM6ddLT4Wx/OznAT61s9YDg9338tGBbkPBDninE2KOfMycYx7tTl+NvJzIs4B1JHGXnK10hXYH36Rrasq4UXHl71rd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830071; c=relaxed/simple;
	bh=rGSFEExjt4/lB4am1fZuddbKPPJBjhhSs9NWtJBIe2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIBCMmqUlnTTAQX7O9UyMe75dUhdv3/eVC4PeDvHBvJwRxwkfH5ydtiVjXOKNF0qsjDvqxRWgamOF4Fkjn2+JPSqKOU9em3P2okAKXdlvs7xeN7IHIYABn7myPjBH3ABEuPZMOkJSnssNzatwdBTLkrA1PnMjjP2bGuZhl/2yRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DEAB20E3;
	Fri, 13 Jun 2025 08:54:09 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE5733F59E;
	Fri, 13 Jun 2025 08:54:27 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 13 Jun 2025 16:53:40 +0100
Subject: [PATCH 07/12] perf arm_spe: Refine memory level filling
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-7-6faecf0a8775@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749830053; l=2430;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=rGSFEExjt4/lB4am1fZuddbKPPJBjhhSs9NWtJBIe2k=;
 b=+pfWFGNBCS+xZWbGNOAz1WLjICXSN1sIi2piPZNF+G9APCPWijkZa7cImiNafOdL5ZASkXuXz
 DEb4jWnfXjiCPYXGvuEMoYq000l4PPwfbQPYV27CsVXpjFGFA4Ggf+i
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This commit introduces macros for detecting cache level and cache miss.

Populates the 'mem_lvl_num' field which is a later added attribute for
representing memory level. Set NA ("not available") to memory levels if
memory hierarchy info is absent.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 55b8391990467c8b7818bb63de3545d94d021bb7..b2296cd025382ea36820641164ec71b13a4e7a0e 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -39,6 +39,15 @@
 
 #define is_ldst_op(op)		(!!((op) & ARM_SPE_OP_LDST))
 
+#define ARM_SPE_CACHE_EVENT(lvl) \
+	(ARM_SPE_##lvl##_ACCESS | ARM_SPE_##lvl##_MISS)
+
+#define arm_spe_is_cache_level(type, lvl) \
+	((type) & ARM_SPE_CACHE_EVENT(lvl))
+
+#define arm_spe_is_cache_miss(type, lvl) \
+	((type) & ARM_SPE_##lvl##_MISS)
+
 struct arm_spe {
 	struct auxtrace			auxtrace;
 	struct auxtrace_queues		queues;
@@ -822,20 +831,21 @@ static const struct data_source_handle data_source_handles[] = {
 static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 					union perf_mem_data_src *data_src)
 {
-	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
+	if (arm_spe_is_cache_level(record->type, LLC)) {
 		data_src->mem_lvl = PERF_MEM_LVL_L3;
-
-		if (record->type & ARM_SPE_LLC_MISS)
-			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
-		else
-			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
-	} else if (record->type & (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS)) {
+		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, LLC) ?
+				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+	} else if (arm_spe_is_cache_level(record->type, L1D)) {
 		data_src->mem_lvl = PERF_MEM_LVL_L1;
+		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, L1D) ?
+				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
+	}
 
-		if (record->type & ARM_SPE_L1D_MISS)
-			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
-		else
-			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
+	if (!data_src->mem_lvl) {
+		data_src->mem_lvl = PERF_MEM_LVL_NA;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
 	}
 
 	if (record->type & ARM_SPE_REMOTE_ACCESS)

-- 
2.34.1

