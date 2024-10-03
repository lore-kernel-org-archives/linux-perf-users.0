Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850A1ABEDC;
	Thu,  3 Oct 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981621; cv=none; b=b6qne6WJca8v+326QXx+QGp6B/oFy11euRJ2KW+u12nh0Do98GGrHDGBE+3mpEFDlweDfOjfDyuNF89KNRmQI6N00l+TbNwJIr2FNK7NcZXcFCJuBRX23dv9H202Z5SBoQEE4eMysnFiBHY+g6ZsLInIfYZ4d/9mFtjfzTag1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981621; c=relaxed/simple;
	bh=C7B5n1nOPQE81aD+pGzA8ZYM6Ae8XlpriN2qRcMtntg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rd53RfmRxkcIH0hQRQxVcZ+R/TxdphW0mewjvx6dOxTNOqt6Z4mge5VckuqYZmgbW3IwBY6GIgVRu714Xr8Hx7fMc2MRlASVEhnfk9MdjpRV9ZhT9BUV5xKdhPxyO/3b+jNehrgClbHrratZ+TcOlJOFmUFKDRvEMS8oR4o433w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C551339;
	Thu,  3 Oct 2024 11:54:09 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AA3E3F836;
	Thu,  3 Oct 2024 11:53:37 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 2/7] perf arm-spe: Rename the common data source encoding
Date: Thu,  3 Oct 2024 19:53:17 +0100
Message-Id: <20241003185322.192357-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003185322.192357-1-leo.yan@arm.com>
References: <20241003185322.192357-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Neoverse CPUs follow the common data source encoding, and other
CPU variants can share the same format.

Rename the CPU list and data source definitions as common data source
names. This change prepares for appending more CPU variants.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 18 ++++++------
 tools/perf/util/arm-spe.c                     | 28 +++++++++----------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 1443c28545a9..358c611eeddb 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -56,15 +56,15 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_BR_INDIRECT	= 1 << 17,
 };
 
-enum arm_spe_neoverse_data_source {
-	ARM_SPE_NV_L1D		 = 0x0,
-	ARM_SPE_NV_L2		 = 0x8,
-	ARM_SPE_NV_PEER_CORE	 = 0x9,
-	ARM_SPE_NV_LOCAL_CLUSTER = 0xa,
-	ARM_SPE_NV_SYS_CACHE	 = 0xb,
-	ARM_SPE_NV_PEER_CLUSTER	 = 0xc,
-	ARM_SPE_NV_REMOTE	 = 0xd,
-	ARM_SPE_NV_DRAM		 = 0xe,
+enum arm_spe_common_data_source {
+	ARM_SPE_COMMON_DS_L1D		= 0x0,
+	ARM_SPE_COMMON_DS_L2		= 0x8,
+	ARM_SPE_COMMON_DS_PEER_CORE	= 0x9,
+	ARM_SPE_COMMON_DS_LOCAL_CLUSTER = 0xa,
+	ARM_SPE_COMMON_DS_SYS_CACHE	= 0xb,
+	ARM_SPE_COMMON_DS_PEER_CLUSTER	= 0xc,
+	ARM_SPE_COMMON_DS_REMOTE	= 0xd,
+	ARM_SPE_COMMON_DS_DRAM		= 0xe,
 };
 
 struct arm_spe_record {
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 34e147e8a963..b0e9eb6057c3 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -413,15 +413,15 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
-static const struct midr_range neoverse_spe[] = {
+static const struct midr_range common_ds_encoding_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	{},
 };
 
-static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
-						union perf_mem_data_src *data_src)
+static void arm_spe__synth_data_source_common(const struct arm_spe_record *record,
+					      union perf_mem_data_src *data_src)
 {
 	/*
 	 * Even though four levels of cache hierarchy are possible, no known
@@ -443,17 +443,17 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	}
 
 	switch (record->source) {
-	case ARM_SPE_NV_L1D:
+	case ARM_SPE_COMMON_DS_L1D:
 		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
 		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
 		break;
-	case ARM_SPE_NV_L2:
+	case ARM_SPE_COMMON_DS_L2:
 		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
 		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
 		break;
-	case ARM_SPE_NV_PEER_CORE:
+	case ARM_SPE_COMMON_DS_PEER_CORE:
 		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
 		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
@@ -462,8 +462,8 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
 	 * transfer, so set SNOOPX_PEER
 	 */
-	case ARM_SPE_NV_LOCAL_CLUSTER:
-	case ARM_SPE_NV_PEER_CLUSTER:
+	case ARM_SPE_COMMON_DS_LOCAL_CLUSTER:
+	case ARM_SPE_COMMON_DS_PEER_CLUSTER:
 		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
 		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
@@ -471,7 +471,7 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	/*
 	 * System cache is assumed to be L3
 	 */
-	case ARM_SPE_NV_SYS_CACHE:
+	case ARM_SPE_COMMON_DS_SYS_CACHE:
 		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
 		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
@@ -480,13 +480,13 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	 * We don't know what level it hit in, except it came from the other
 	 * socket
 	 */
-	case ARM_SPE_NV_REMOTE:
+	case ARM_SPE_COMMON_DS_REMOTE:
 		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
 		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
 		break;
-	case ARM_SPE_NV_DRAM:
+	case ARM_SPE_COMMON_DS_DRAM:
 		data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
 		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
@@ -522,7 +522,7 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
 {
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
-	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
+	bool is_common = is_midr_in_range_list(midr, common_ds_encoding_cpus);
 
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
@@ -531,8 +531,8 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 m
 	else
 		return 0;
 
-	if (is_neoverse)
-		arm_spe__synth_data_source_neoverse(record, &data_src);
+	if (is_common)
+		arm_spe__synth_data_source_common(record, &data_src);
 	else
 		arm_spe__synth_memory_level(record, &data_src);
 
-- 
2.34.1

