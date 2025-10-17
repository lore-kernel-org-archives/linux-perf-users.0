Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8F430F920
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695538; cv=none; b=Y3PKYj/Z5hmL00L2B0GN13DPlXpLXCiR/+IB18ehVLc4pcVi6W7WSFR69jiWFAl6vX2r5NDV6oEA0OeybIo/MhH1M5n9yfbpC8MecPaEMfeAhIwZXzgUV/qPGdAQ59Gckx7l5coaB9ubijI4Epi/sjj1gUu+dq/A8pzfHssCV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695538; c=relaxed/simple;
	bh=+kFywxGXXe3sEzrQrjNrlVyuU8WPOraAOuMAItIboJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAgznI0xzPnRBKdeYvsd6j2HyFns3/SGjR+q7k/UhWYCLRx4YdDSFB2c7+SgYv2zaja/uzJM0PdpcOSaTASkqQySIbxPjKhPwxRIaeIGH8vmIAeiU6854h81fF+CFLh+bDW0Ujy7r0LSTWTmNSbOsCqywdxs1Ufs/Z6vGWgC8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 140A01596;
	Fri, 17 Oct 2025 03:05:29 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 939A43F59E;
	Fri, 17 Oct 2025 03:05:35 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:05:06 +0100
Subject: [PATCH v2 17/25] perf arm_spe: Synthesize memory samples for SIMD
 operations
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-17-2d41e4746e1b@arm.com>
References: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
In-Reply-To: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=2159;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=+kFywxGXXe3sEzrQrjNrlVyuU8WPOraAOuMAItIboJ0=;
 b=XfWB7Y/bzhJbqnjkQIJauOgYTs2ZKIANuuYIgcfiK4pjC1ADvS1ugjbEDY2qmqXHQVr5Vk34k
 7VXZRod44wuDplBYaxHZtDqalEHlJqBanvkHijeMWP1RUyi+3l0SquN
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Synthesize memory samples for SIMD operations (including Advanced SIMD,
SVE, and SME). To provide complete information, also generate data
source entries for SIMD operations.

Since memory operations are not limited to load and store, set
PERF_MEM_OP_STORE if the operation does not fall into these cases.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 88f24a8626861393defc89540e4126a124479699..bc233a5007d20e4dec11eeb1554adc1580f43718 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -39,6 +39,11 @@
 
 #define is_ldst_op(op)		(!!((op) & ARM_SPE_OP_LDST))
 
+#define is_simd_op(op)		(!!((op) & (ARM_SPE_OP_SIMD_FP | ARM_SPE_OP_SVE | \
+					    ARM_SPE_OP_SME | ARM_SPE_OP_ASE)))
+
+#define is_mem_op(op)		(is_ldst_op(op) || is_simd_op(op))
+
 #define ARM_SPE_CACHE_EVENT(lvl) \
 	(ARM_SPE_##lvl##_ACCESS | ARM_SPE_##lvl##_MISS)
 
@@ -985,8 +990,7 @@ arm_spe__synth_data_source(struct arm_spe_queue *speq,
 {
 	union perf_mem_data_src	data_src = {};
 
-	/* Only synthesize data source for LDST operations */
-	if (!is_ldst_op(record->op))
+	if (!is_mem_op(record->op))
 		return data_src;
 
 	if (record->op & ARM_SPE_OP_LD)
@@ -994,7 +998,7 @@ arm_spe__synth_data_source(struct arm_spe_queue *speq,
 	else if (record->op & ARM_SPE_OP_ST)
 		data_src.mem_op = PERF_MEM_OP_STORE;
 	else
-		return data_src;
+		data_src.mem_op = PERF_MEM_OP_NA;
 
 	arm_spe__synth_ds(speq, record, &data_src);
 	arm_spe__synth_memory_level(speq, record, &data_src);
@@ -1095,11 +1099,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 			return err;
 	}
 
-	/*
-	 * When data_src is zero it means the record is not a memory operation,
-	 * skip to synthesize memory sample for this case.
-	 */
-	if (spe->sample_memory && is_ldst_op(record->op)) {
+	if (spe->sample_memory && is_mem_op(record->op)) {
 		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
 		if (err)
 			return err;

-- 
2.34.1

