Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70C352953;
	Wed, 12 Nov 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971929; cv=none; b=SK7U+mdef9LdY1y71leT3lLdp+7hi7KLNPmByBVJ8bJHty/9d8RgIpvaLdkiI5BkJtnx8A62AoiqnEyhEC2U69oCpStPYSMcgL7eLTxsABHl/yXe5FCUCQOLCvtRrLcD0+UuKxaF79Kj9mWCd+kr4Hj2Dz3/YYm+JlW2irXkZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971929; c=relaxed/simple;
	bh=0Rj939NM3iG/pLeQmRL25+gYfRynCaxeME2R2V47qeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLzaFN+bKPv2BpDGmuCL/w+XnGqMso6CVaIS3hBXDb2pRHYmDq3fsww5gJTvIuVaivQM1fubovp6btPwxrHuplKMGP2wsO6UrXitcyJGq7HEvQcmfQ1iSzt5HMCGafHs3n60avu2sYI5UT09/cmcgma7LIpen+sNLDNqLd5YI78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2668C1691;
	Wed, 12 Nov 2025 10:25:20 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA4263F63F;
	Wed, 12 Nov 2025 10:25:25 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:42 +0000
Subject: [PATCH v3 16/25] perf arm_spe: Expose SIMD information in other
 operations
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-16-e63c9829f9d9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971891; l=2811;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=0Rj939NM3iG/pLeQmRL25+gYfRynCaxeME2R2V47qeU=;
 b=Oc7qUCOmiaiKupNirHlVKXVXwWl0ZW+v/KEntXWEpEAH5cRKCXUfVQOPcAVGRB4W+OLGuc8/x
 LYOsi1C6OEYAlF69iV8Nhi5Dut2JRbFA6h7scRa4i64mGX+N9rBnsa+
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The other operations contain SME data processing, ASE (Advanced SIMD)
and floating-point operations. Expose these info in the records.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 18 +++++++++++++++++-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h |  4 ++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 649471abef6a4386e1b250a19cda4f4caeb0a2ff..9e02b2bdd1177193996d071dd88f969e25b1ad86 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -237,8 +237,24 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 				break;
 			case SPE_OP_PKT_HDR_CLASS_OTHER:
 				decoder->record.op |= ARM_SPE_OP_OTHER;
-				if (SPE_OP_PKT_OTHER_SUBCLASS_SVE(payload))
+				if (SPE_OP_PKT_OTHER_SUBCLASS_SVE(payload)) {
 					decoder->record.op |= ARM_SPE_OP_SVE | ARM_SPE_OP_DP;
+					if (payload & SPE_OP_PKT_OTHER_FP)
+						decoder->record.op |= ARM_SPE_OP_FP;
+					if (payload & SPE_OP_PKT_SVE_PRED)
+						decoder->record.op |= ARM_SPE_OP_PRED;
+				} else if (SPE_OP_PKT_OTHER_SUBCLASS_SME(payload)) {
+					decoder->record.op |= ARM_SPE_OP_SME;
+					if (payload & SPE_OP_PKT_OTHER_FP)
+						decoder->record.op |= ARM_SPE_OP_FP;
+				} else if (SPE_OP_PKT_OTHER_SUBCLASS_OTHER(payload)) {
+					if (payload & SPE_OP_PKT_OTHER_ASE)
+						decoder->record.op |= ARM_SPE_OP_ASE;
+					if (payload & SPE_OP_PKT_OTHER_FP)
+						decoder->record.op |= ARM_SPE_OP_FP;
+					if (payload & SPE_OP_PKT_COND)
+						decoder->record.op |= ARM_SPE_OP_COND;
+				}
 				break;
 			case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 				decoder->record.op |= ARM_SPE_OP_BRANCH_ERET;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index b838e9c6168c6b7c20bb63b8e7c9d27c35f416dc..3310e05122f02e8ef32f79f8ed3c6932cc43eecc 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -48,6 +48,8 @@ enum arm_spe_2nd_op_ldst {
 	ARM_SPE_OP_MEMCPY		= 1 << 14,
 	ARM_SPE_OP_MEMSET		= 1 << 15,
 	ARM_SPE_OP_GCS			= 1 << 16,
+	ARM_SPE_OP_SME			= 1 << 17,
+	ARM_SPE_OP_ASE			= 1 << 18,
 
 	/* Assisted information for memory / SIMD */
 	ARM_SPE_OP_LD			= 1 << 20,
@@ -59,6 +61,8 @@ enum arm_spe_2nd_op_ldst {
 	ARM_SPE_OP_PRED			= 1 << 26,	/* Predicated */
 	ARM_SPE_OP_SG			= 1 << 27,	/* Gather/Scatter */
 	ARM_SPE_OP_COMM			= 1 << 28,	/* Common */
+	ARM_SPE_OP_FP			= 1 << 29,	/* Floating-point */
+	ARM_SPE_OP_COND			= 1 << 30,	/* Conditional */
 };
 
 enum arm_spe_2nd_op_branch {

-- 
2.34.1

