Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAD514A635;
	Sat, 14 Sep 2024 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726351771; cv=none; b=szCqKLJXegue0PUrv2OValzDs+tnO7QxokTagNfy0gPjelJI4zM+TlVEtJ7+v/YAbTgO+pHlRDAVC+W2HvT2tBrK+7gYFZafxWN7arDcJhJFmWkketcynvKnAcH/qS2B0aKng/xaxNs1pqSj2i7lPflQ0CsbsgcBG6XlVJyY5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726351771; c=relaxed/simple;
	bh=NwwNJvy+fcK/CH3YXIVH4JS1QYTSlfC+fphTw2X/Y3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWg6XB8sI2eisulZNUEG5gsl3vMVqfp1MnvHHNJe1tw7zySoKQz5daSAvEW1CxWQ03aItZWtGMhMfM+XJdKp9TR1/mVw6OTSxe1V+iE4q4csRSLZn9CXrvOyAPVj/KLhMUNRnCWNGdEa0iipvZA6pRZxj18eQsP0t3LOMx1MCvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B79C8169C;
	Sat, 14 Sep 2024 15:09:58 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8326D3F66E;
	Sat, 14 Sep 2024 15:09:27 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 4/7] perf arm-spe: Use metadata to decide the data source feature
Date: Sat, 14 Sep 2024 23:08:58 +0100
Message-Id: <20240914220901.756177-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914220901.756177-1-leo.yan@arm.com>
References: <20240914220901.756177-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the info in the metadata to decide if the data source feature is
supported. The CPU MIDR must be in the CPU list for the common data
source encoding.

For the metadata version 1, it doesn't include info for MIDR. In this
case, due to absent info for making decision, print out warning to
remind users to upgrade tool and returns false.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 67 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 7e00cf1c287c..e263df079c14 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -278,6 +278,20 @@ static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
 	return 0;
 }
 
+static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, u64 cpu)
+{
+	u64 i;
+
+	if (!spe->metadata)
+		return NULL;
+
+	for (i = 0; i < spe->metadata_nr_cpu; i++)
+		if (spe->metadata[i][ARM_SPE_CPU] == cpu)
+			return spe->metadata[i];
+
+	return NULL;
+}
+
 static struct simd_flags arm_spe__synth_simd_flags(const struct arm_spe_record *record)
 {
 	struct simd_flags simd_flags = {};
@@ -520,10 +534,57 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
 }
 
-static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
+static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
+{
+	struct arm_spe *spe = speq->spe;
+	bool is_in_cpu_list;
+	u64 *metadata = NULL;
+	u64 midr = 0;
+
+	/*
+	 * Metadata version 1 doesn't contain any info for MIDR.
+	 * Simply return false in this case.
+	 */
+	if (spe->metadata_ver == 1) {
+		pr_warning_once("The data file contains metadata version 1, "
+				"which is absent the info for data source. "
+				"Please upgrade the tool to record data.\n");
+		return false;
+	}
+
+	/* CPU ID is -1 for per-thread mode */
+	if (speq->cpu < 0) {
+		/*
+		 * On the heterogeneous system, due to CPU ID is -1,
+		 * cannot confirm the data source packet is supported.
+		 */
+		if (!spe->is_homogeneous)
+			return false;
+
+		/* In homogeneous system, simply use CPU0's metadata */
+		if (spe->metadata)
+			metadata = spe->metadata[0];
+	} else {
+		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
+	}
+
+	if (!metadata)
+		return false;
+
+	midr = metadata[ARM_SPE_CPU_MIDR];
+
+	is_in_cpu_list = is_midr_in_range_list(midr, common_ds_encoding_cpus);
+	if (is_in_cpu_list)
+		return true;
+	else
+		return false;
+}
+
+static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
+				      const struct arm_spe_record *record)
 {
 	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
-	bool is_common = is_midr_in_range_list(midr, common_ds_encoding_cpus);
+	bool is_common = arm_spe__is_common_ds_encoding(speq);
 
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
@@ -556,7 +617,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 	u64 data_src;
 	int err;
 
-	data_src = arm_spe__synth_data_source(record, spe->midr);
+	data_src = arm_spe__synth_data_source(speq, record);
 
 	if (spe->sample_flc) {
 		if (record->type & ARM_SPE_L1D_MISS) {
-- 
2.34.1

