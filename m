Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF2B30CB4E
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163890; cv=none; b=DI2hG2xB3DoCJFB5fI6FMSOmwbXZFzJuWdvLb/XfPatyqiLa381eVD7kJSmxxsLuHmtYg47wES5KZak26l0Nhzh76uO0266dxO4867ATWegkTzuHAvqAksKHijnUTz1dN7VXrPfF5IrKwqAdaK/fPbHdyX78LsNuvhMwBRFYbY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163890; c=relaxed/simple;
	bh=BDvNWzvAemz4zeXitbhL3OSHHvaF961tMe2hrc+3uqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NPjLv+5IpvKDt6hkXrDJu9KQUnJIUYtR1KjG1HRXln2lT3KtEfkuHvfBPKFFoUdJVVXuCete4dWE0EXI5n2Z4LhJMSXASu/EuEZKJOIqtqjW+K9Hhoe3Ve2QT2UQVzoVL6SKe1wdHl1FN+GXg0e6mOj95etZeh2Edi86h5RcBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5C341CC4;
	Mon, 29 Sep 2025 09:38:00 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FCB13F66E;
	Mon, 29 Sep 2025 09:38:07 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:45 +0100
Subject: [PATCH 09/25] perf arm_spe: Introduce data processing macro for
 SVE operations
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-9-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=3177;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=BDvNWzvAemz4zeXitbhL3OSHHvaF961tMe2hrc+3uqY=;
 b=OngcnRo3BtVkZ4ZjfIHnCd7sfuUZ0WNuzwY2YwTo1D0L2YE+JRpOI4p9Wxyqun0+L6jKszTV1
 YRqR4sHU/sjBq+C723p3up1fcrILP4i9wA7C8GY0+o5GwWBY/6Qjihl
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
index 8156aa04f82e59ce345fb44223d3d22ecbc149a7..08ef83cb8bf00be75459c78b9ee8a6cbf1971986 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -42,8 +42,7 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_UNSPEC_REG		= 1 << 9,
 	ARM_SPE_OP_NV_SYSREG		= 1 << 10,
 	ARM_SPE_OP_SIMD_FP		= 1 << 11,
-	ARM_SPE_OP_SVE_OTHER		= 1 << 12,
-	ARM_SPE_OP_SVE_LDST		= 1 << 13,
+	ARM_SPE_OP_SVE			= 1 << 12,
 
 	/* Assisted information for memory / SIMD */
 	ARM_SPE_OP_LD			= 1 << 20,
@@ -51,6 +50,7 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_ATOMIC		= 1 << 22,
 	ARM_SPE_OP_EXCL			= 1 << 23,
 	ARM_SPE_OP_AR			= 1 << 24,
+	ARM_SPE_OP_DP			= 1 << 25,	/* Data processing */
 
 	/* Second level operation type for BRANCH_ERET */
 	ARM_SPE_OP_BR_COND		= 1 << 8,
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

