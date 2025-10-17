Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C530F30FC01
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695545; cv=none; b=fV6ELhW/2/ETc5xYRaJFultUhg7Qi0+abs6w+SNSO+4PGeB577cElSOe2weUKj9qKysvASI2y3rfIMNCRBb/DrsVw9O5hbNiKGtespPAz6FNW8f8Ac0MN4lnlqJ4q2ztMS0qinIb/nUCZyowtCte57UX87dbOHlEW424WllYotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695545; c=relaxed/simple;
	bh=Gl8sMrXBxSEgl/nsvEXTwEfycViHJAGMKyre6BGVRlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6kh/5sKBoo3b9aydQ+2J36IKqWxkIpXM27osuqHSrgnL4sDsKflXYpRm1Tpfkt0QoAzPerKVkGlWeRVQPKhZwiU7fPP6VLFjcb7DSJGt8dS7HdeNG5OdpbwjfrBb2Wx1XUZXv33R9r8E8H5M84xwGVUvCXnrIsI8hAN7eT+ZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A42501596;
	Fri, 17 Oct 2025 03:05:35 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3311B3F59E;
	Fri, 17 Oct 2025 03:05:42 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:05:10 +0100
Subject: [PATCH v2 21/25] perf arm_spe: Set extended fields in data source
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-21-2d41e4746e1b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=3016;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Gl8sMrXBxSEgl/nsvEXTwEfycViHJAGMKyre6BGVRlU=;
 b=N+iiXEdWxmI0/bdl9ooOdjk1ThvD4mPBaFd3QR3hlmPSieJl5QX2Cm03bYacxSqhx3yiPxrnj
 d/0gqq+VJnnDNdAu4ePVI+pMwzvmyo25dCFqnypawfWz1FEBCnUyOQk
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
index bc233a5007d20e4dec11eeb1554adc1580f43718..e9df50b2cb807185c939f6712e9d65a41aacce87 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1000,6 +1000,36 @@ arm_spe__synth_data_source(struct arm_spe_queue *speq,
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

