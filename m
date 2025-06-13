Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA593FB1B
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830074; cv=none; b=J6ZmJbgCY6Nv6WNaiom5LpdmGK3A6vZxwJaXHuxGs/HYbr6hdIIjOtiFwhhn5Lmp2vUeQwFrPxPDG+F0Ohx+5iPKVwZDi+EcfgVKh0ZXiq2ZfToR8n26+oGAaIEDOEBATTLHvGdf/xV7iJ7xrFeE9dGBibzL1VZjvRQES1Bs7uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830074; c=relaxed/simple;
	bh=ARwvkMB7rAJ14VZ7EnftKw97Kg42wc71l/czXpRXdK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmCe7jwRVYgnjlTQstx6YVODnmkli3Jc/OEYrbjlNyLx4dirHsTiPFtKLY6/IGa9mI57slgDasxANiul/wcyjAJEay8AAV+gR0w9n1SJWRBrsK6e8c844YC1pbWOMSNMoQxaEZmXyXOZr9tfXMx4QwYs7VJMBC2l5HoOQfYVSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C79E2103;
	Fri, 13 Jun 2025 08:54:11 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00FB73F59E;
	Fri, 13 Jun 2025 08:54:29 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 13 Jun 2025 16:53:41 +0100
Subject: [PATCH 08/12] perf arm_spe: Separate setting of memory levels for
 loads and stores
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-8-6faecf0a8775@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749830053; l=3515;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ARwvkMB7rAJ14VZ7EnftKw97Kg42wc71l/czXpRXdK4=;
 b=3SwXxq4idccs8IQXAlNDLdSaGtDEvq871ccWcE12aXbT7CCLtg9Pt8fe9Z9+Sv/ehJvxXu47v
 0wHUkJSWPTjDiDHj8xI+bE9hApbVz9h1vdu3NpPJ9QhHA5isq5p7hnh
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

For a load hit, the lowest-level cache reflects the latency of fetching
a data. Otherwise, the highest-level cache involved in refilling
indicates the overhead caused by a load.

Store operations remain unchanged to keep the descending order when
iterating through cache levels.

Split into two functions: one is for setting memory levels for loads and
another for stores.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index b2296cd025382ea36820641164ec71b13a4e7a0e..8f18af7336db53b00b450eb4299feee350d0ecb9 100644
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
 
@@ -828,9 +831,38 @@ static const struct data_source_handle data_source_handles[] = {
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
@@ -842,6 +874,15 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
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

