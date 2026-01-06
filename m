Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B85327BEE;
	Tue,  6 Jan 2026 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700649; cv=none; b=OmMYlgg9LzpmbsuCy8K3XfoGB/dyk+lSCojcJmTqO7gacN4zc5/LdqGarm2USXAvIwsByzlFjoP2e8Rw2YU5h/ZusnAuJsT+cmpkp+3XsNDephPUCspYOFFiYqZ1ok6XZdRYcqDI5Ndyswqofxw6ltgwtXXYEB1OP2Lh1wtD08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700649; c=relaxed/simple;
	bh=9P9P9ngjsu8nPxAdZLX3+nmmTdlw0sGE1/s7rLcP/ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zrz7bePIeR2X0TB2E1Bci761e+FBCHrkH6I/5gVXy0QGn/v2NXFEdo33Nt5ngw4uHdf7RN7rLEHNWcL5X14Gbwc32Sui5wfUT/J798Of638UPvXIzw49IwOWCbwGbM9gv8Jr9egA9cvsAwl0qoBnGZvxzTB1NaRMYCZY2c+u9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC34E497;
	Tue,  6 Jan 2026 03:57:19 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B8283F5A1;
	Tue,  6 Jan 2026 03:57:24 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 06 Jan 2026 11:56:49 +0000
Subject: [PATCH v4 4/8] perf arm_spe: Set extended fields in data source
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-perf_support_arm_spev1-3-v4-4-bb2d143b3860@arm.com>
References: <20260106-perf_support_arm_spev1-3-v4-0-bb2d143b3860@arm.com>
In-Reply-To: <20260106-perf_support_arm_spev1-3-v4-0-bb2d143b3860@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767700634; l=3016;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=9P9P9ngjsu8nPxAdZLX3+nmmTdlw0sGE1/s7rLcP/ao=;
 b=dfzg/6aqCk/ZHHYezdmF77x3soi/BjX0x0G80fUDP0CpPRnM+nULHFCC0QDhSaHiz5dUE/gJH
 bvIX23UgwH3CIKHzd29l9ixNLQ6SQFdHsVlkdMo5X0pGayuqAL22jUL
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Set extended operation type and affiliate info in the data source.

Before:

  perf script -F,dso,sym,data_src
  sve-test 6516696.714341:        288100144 |OP STORE|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF N/A
  sve-test 6516696.714341:        288100144 |OP STORE|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF N/A
  sve-test 6516696.714341:        288100144 |OP STORE|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF N/A
  sve-test 6516696.714344:        288800142 |OP LOAD|LVL L1 hit|SNP HitM|TLB Walker hit|LCK No|BLK  N/A|AFF N/A
  sve-test 6516696.714344:        288800142 |OP LOAD|LVL L1 hit|SNP HitM|TLB Walker hit|LCK No|BLK  N/A|AFF N/A

After:

  perf script -F,dso,sym,data_src
  sve-test 6516696.714341:  444000288100144 |OP STORE SIMD|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF PRED SG
  sve-test 6516696.714341:  444000288100144 |OP STORE SIMD|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF PRED SG
  sve-test 6516696.714341:  444000288100144 |OP STORE SIMD|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF PRED SG
  sve-test 6516696.714344:        288800142 |OP LOAD|LVL L1 hit|SNP HitM|TLB Walker hit|LCK No|BLK  N/A|AFF N/A
  sve-test 6516696.714344:        288800142 |OP LOAD|LVL L1 hit|SNP HitM|TLB Walker hit|LCK No|BLK  N/A|AFF N/A

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index dc19e72258f30dd6d89dafbb70cc5f7b5c485589..8e9004213e163a46fcacecb4ee32e199a0ec50b2 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1006,6 +1006,36 @@ arm_spe__synth_data_source(struct arm_spe_queue *speq,
 	else
 		data_src.mem_op = PERF_MEM_OP_NA;
 
+	if (record->op & ARM_SPE_OP_MTE_TAG)
+		data_src.mem_op_ext = PERF_MEM_EXT_OP_MTE_TAG;
+	else if (record->op & ARM_SPE_OP_NV_SYSREG)
+		data_src.mem_op_ext = PERF_MEM_EXT_OP_NESTED_VIRT;
+	else if (record->op & ARM_SPE_OP_MEMCPY)
+		data_src.mem_op_ext = PERF_MEM_EXT_OP_MEMCPY;
+	else if (record->op & ARM_SPE_OP_MEMSET)
+		data_src.mem_op_ext = PERF_MEM_EXT_OP_MEMSET;
+	else if (record->op & ARM_SPE_OP_GCS)
+		data_src.mem_op_ext = PERF_MEM_EXT_OP_GCS;
+	else if (is_simd_op(record->op))
+		data_src.mem_op_ext = PERF_MEM_EXT_OP_SIMD;
+
+	if (record->op & ARM_SPE_OP_DP)
+		data_src.mem_dp = 1;
+	if (record->op & ARM_SPE_OP_FP)
+		data_src.mem_fp = 1;
+	if (record->op & ARM_SPE_OP_PRED)
+		data_src.mem_pred = 1;
+	if (record->op & ARM_SPE_OP_ATOMIC)
+		data_src.mem_atomic = 1;
+	if (record->op & ARM_SPE_OP_EXCL)
+		data_src.mem_excl = 1;
+	if (record->op & ARM_SPE_OP_AR)
+		data_src.mem_ar = 1;
+	if (record->op & ARM_SPE_OP_SG)
+		data_src.mem_sg = 1;
+	if (record->op & ARM_SPE_OP_COND)
+		data_src.mem_cond = 1;
+
 	arm_spe__synth_ds(speq, record, &data_src);
 	arm_spe__synth_memory_level(speq, record, &data_src);
 

-- 
2.34.1

