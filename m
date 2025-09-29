Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAB530CD8F
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163910; cv=none; b=my1SaLSqUeI1DNknhs1KulKLMFEHnTXbLOG/VpRym+54yTjUbqpZBpk/GlYczppJ8THiLJ8Ld72CFWVA3BLWPmNSWZ4L7J52EekDNGYxBYtgtObeRosi93i/Px4GN0lhwAg2/V4UsPLGlX2oigDrJIp0wLryK29YxC6I/nPVldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163910; c=relaxed/simple;
	bh=gTHiDHw3pvrWPKm1NepqNycFJ5f2dr2RUOowvflQb1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AUIdfe54Ry1hy2HCcx5KS9kRJXoJ9/1RheaTdM2I61v1jk36XGl5SBm3mftJib3g+ucLD1d+SGX+Nzn/Bkm6g9vg8xEWRPW+CtoUyNg8RVNm9ocEKQxa149JcJEV+pHunmaT9FwKbg8e5VHWogQ1eMe1qz+oOF/0lj1v2nWyJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69638150C;
	Mon, 29 Sep 2025 09:38:20 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 140853F66E;
	Mon, 29 Sep 2025 09:38:26 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:57 +0100
Subject: [PATCH 21/25] perf arm_spe: Set extended fields in data source
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-21-1150b3c83857@arm.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=3190;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=gTHiDHw3pvrWPKm1NepqNycFJ5f2dr2RUOowvflQb1U=;
 b=DyKmy4kTu2vPkTdDe6ltyj6ZfTv/k3+unq9fhPJZpAiq4JvSi5rGby0dSmvUgZXaWo1IXmURx
 UencLEpvwoOAzWA+Pk1/9gdvV8NuhG6Rp8CGnY6vBL6Lnug0u6YDQ6V
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Set extended operation type and affiliate info in the data source.

Before:

  perf script -F,dso,sym,data_src | grep SIMD
  sve-test 6516696.714341:        288100144 |OP STORE|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF  N/A
  sve-test 6516696.714341:        288100144 |OP STORE|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF  N/A
  sve-test 6516696.714341:        288100144 |OP STORE|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF  N/A
  sve-test 6516696.714344:        288800142 |OP LOAD|LVL L1 hit|SNP HitM|TLB Walker hit|LCK No|BLK  N/A|AFF  N/A
  sve-test 6516696.714344:        288800142 |OP LOAD|LVL L1 hit|SNP HitM|TLB Walker hit|LCK No|BLK  N/A|AFF  N/A

After:

  perf script -F,dso,sym,data_src | grep SIMD
  sve-test 6516696.714341:  444000288100144 |OP STORE SIMD|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF  PRED SG
  sve-test 6516696.714341:  444000288100144 |OP STORE SIMD|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF  PRED SG
  sve-test 6516696.714341:  444000288100144 |OP STORE SIMD|LVL L1 hit|SNP None|TLB Walker hit|LCK No|BLK  N/A|AFF  PRED SG
  sve-test 6516696.714344:        288800142 |OP LOAD|LVL L1 hit|SNP HitM|TLB Walker hit|LCK No|BLK  N/A|AFF  N/A
  sve-test 6516696.714344:        288800142 |OP LOAD|LVL L1 hit|SNP HitM|TLB Walker hit|LCK No|BLK  N/A|AFF  N/A

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index bc233a5007d20e4dec11eeb1554adc1580f43718..5e920fe77ccda6f398cab13fa1e4269ddab12fd9 100644
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
+		data_src.mem_aff |= PERF_MEM_AFF_DP;
+	if (record->op & ARM_SPE_OP_FP)
+		data_src.mem_aff |= PERF_MEM_AFF_FP;
+	if (record->op & ARM_SPE_OP_PRED)
+		data_src.mem_aff |= PERF_MEM_AFF_PRED;
+	if (record->op & ARM_SPE_OP_ATOMIC)
+		data_src.mem_aff |= PERF_MEM_AFF_ATOMIC;
+	if (record->op & ARM_SPE_OP_EXCL)
+		data_src.mem_aff |= PERF_MEM_AFF_EXCLUSIVE;
+	if (record->op & ARM_SPE_OP_AR)
+		data_src.mem_aff |= PERF_MEM_AFF_AR;
+	if (record->op & ARM_SPE_OP_SG)
+		data_src.mem_aff |= PERF_MEM_AFF_SG;
+	if (record->op & ARM_SPE_OP_COND)
+		data_src.mem_aff |= PERF_MEM_AFF_CONDITIONAL;
+
 	arm_spe__synth_ds(speq, record, &data_src);
 	arm_spe__synth_memory_level(speq, record, &data_src);
 

-- 
2.34.1

