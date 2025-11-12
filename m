Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B0A354ACC;
	Wed, 12 Nov 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971940; cv=none; b=VmNDnrtWkXlszYYwQbmvW1/3llb7lca9eyJ8FizeOBVq+as0q24VnzAjEq2QtVKlTsiTAwBXGXVxnOy/k6ZPGdFRHUBZ2R63du9xNTLDUsWcnu8Qse6nL7qlO1KBwirF353Xim1vZrLd2it4S33yQ1Y5jAuKMeavIJELD8ze4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971940; c=relaxed/simple;
	bh=5YDWSHCp308PlRgo20hzfdD6cFsvcCrwa62qo3vSJIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Re67zgjF70qb49qS/6hd5m3I1qL8W5+SW5x0yguHj4QzfCBxpDXXkz5DBapD6riQbjrawBIW/XVsHAfZJvLABv5IBfXaVMA66GEUn7kaygCqRmZafDqVd8Cr/3psA6+QWuZLopkm5RsG/zgIhyoERdihs8cpywFLA2raCiIjo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8FB91595;
	Wed, 12 Nov 2025 10:25:30 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5F5D3F63F;
	Wed, 12 Nov 2025 10:25:36 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:47 +0000
Subject: [PATCH v3 21/25] perf arm_spe: Set extended fields in data source
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-21-e63c9829f9d9@arm.com>
References: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
In-Reply-To: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971891; l=3016;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=5YDWSHCp308PlRgo20hzfdD6cFsvcCrwa62qo3vSJIE=;
 b=olJm9R98i3DP4S/SpCZ95NvsafPl0pz5q3tYTwzmeJpaxr2SnOooiu+0hOiVmCfadWy2b8W60
 xO+aZWQ2MEDDKHsWZzR+xTFmEtNqkUws9Ej6znG2i7z7nHeF2GLS963
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
index 6a9c61d4aeeb2283a426d0a00ff7072eb5049c31..3b2d767f7a3e156594a69e7b546f3156cceb4951 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1001,6 +1001,36 @@ arm_spe__synth_data_source(struct arm_spe_queue *speq,
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

