Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A23126DD
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695525; cv=none; b=G0CHGug0mzz56rJAWIvqMF4TqxMYMPEiuzdEIgYtlMIsgif/ZN1WHKpe8Q4kSsRuKgn9gM19ZM45avqfyQdHG6vW8Eio56qZaQI5QKzRGq9y1kn5jNzwaO1GLFwUqSGOJwd3vyvsSxIBDqnBXNhoYG1OiuX9Q/Rg0BHOyeAcqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695525; c=relaxed/simple;
	bh=RC7Nnz+lvGFP3PKcTdDtsZy5IynUGVeFkTpF1XhbYQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6qcjr8s487ePf+/kw34v9Q57D7I7fxi0ghByhrb24hiIgnkv7MqP02e9kQUjIPU1rRl4n3fjWdWFqmvy0MzdQbwPh3k80J6NchglrpjUrPCIksCZgYwm3kTVjh848bs8LfBUc+lGUUB30mJHlIOvspKCLguhko3+5CSojFniTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D29C41596;
	Fri, 17 Oct 2025 03:05:15 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E6E33F59E;
	Fri, 17 Oct 2025 03:05:22 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:04:58 +0100
Subject: [PATCH v2 09/25] perf arm_spe: Introduce data processing macro for
 SVE operations
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-9-2d41e4746e1b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=3135;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=RC7Nnz+lvGFP3PKcTdDtsZy5IynUGVeFkTpF1XhbYQ8=;
 b=qs7p9m5Ov5pZJF7HKCmw2fsDDW0v0VtKUdPjTpdEZmJy8XUEEcgeKB80qOKR17GgfZFyx8RsO
 yxqktUUwJh+D7NA6/MhloScBrkT81NakwPT5awFbppXJYkw2GHP6688
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Introduce the ARM_SPE_OP_DP (data processing) macro as associated
information for SVE operations. For SVE register access, only
ARM_SPE_OP_SVE is set; for SVE data processing, both ARM_SPE_OP_SVE and
ARM_SPE_OP_DP are set together.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 4 ++--
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 4 ++--
 tools/perf/util/arm-spe.c                         | 5 +----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 847c29385bea8618e14b2eb21a08896041890d89..6974f594f37c9916fff591ced1e9c2d60cf84f14 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -201,12 +201,12 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 				else
 					decoder->record.op |= ARM_SPE_OP_LD;
 				if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload))
-					decoder->record.op |= ARM_SPE_OP_SVE_LDST;
+					decoder->record.op |= ARM_SPE_OP_SVE;
 				break;
 			case SPE_OP_PKT_HDR_CLASS_OTHER:
 				decoder->record.op |= ARM_SPE_OP_OTHER;
 				if (SPE_OP_PKT_OTHER_SUBCLASS_SVE(payload))
-					decoder->record.op |= ARM_SPE_OP_SVE_OTHER;
+					decoder->record.op |= ARM_SPE_OP_SVE | ARM_SPE_OP_DP;
 				break;
 			case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 				decoder->record.op |= ARM_SPE_OP_BRANCH_ERET;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index b555e2cc1dc36f209c23b0d84378da0ee65c1ab3..acab6d11096b19b1d31a553c83cba9732ecf5ddb 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -43,8 +43,7 @@ enum arm_spe_2nd_op_ldst {
 	ARM_SPE_OP_UNSPEC_REG		= 1 << 9,
 	ARM_SPE_OP_NV_SYSREG		= 1 << 10,
 	ARM_SPE_OP_SIMD_FP		= 1 << 11,
-	ARM_SPE_OP_SVE_OTHER		= 1 << 12,
-	ARM_SPE_OP_SVE_LDST		= 1 << 13,
+	ARM_SPE_OP_SVE			= 1 << 12,
 
 	/* Assisted information for memory / SIMD */
 	ARM_SPE_OP_LD			= 1 << 20,
@@ -52,6 +51,7 @@ enum arm_spe_2nd_op_ldst {
 	ARM_SPE_OP_ATOMIC		= 1 << 22,
 	ARM_SPE_OP_EXCL			= 1 << 23,
 	ARM_SPE_OP_AR			= 1 << 24,
+	ARM_SPE_OP_DP			= 1 << 25,	/* Data processing */
 };
 
 enum arm_spe_2nd_op_branch {
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 71be979f507718caadc091714c40bcee073c1d60..88f24a8626861393defc89540e4126a124479699 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -346,10 +346,7 @@ static struct simd_flags arm_spe__synth_simd_flags(const struct arm_spe_record *
 {
 	struct simd_flags simd_flags = {};
 
-	if ((record->op & ARM_SPE_OP_LDST) && (record->op & ARM_SPE_OP_SVE_LDST))
-		simd_flags.arch |= SIMD_OP_FLAGS_ARCH_SVE;
-
-	if ((record->op & ARM_SPE_OP_OTHER) && (record->op & ARM_SPE_OP_SVE_OTHER))
+	if (record->op & ARM_SPE_OP_SVE)
 		simd_flags.arch |= SIMD_OP_FLAGS_ARCH_SVE;
 
 	if (record->type & ARM_SPE_SVE_PARTIAL_PRED)

-- 
2.34.1

