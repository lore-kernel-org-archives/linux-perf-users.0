Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7C134DB67;
	Wed, 12 Nov 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971912; cv=none; b=Id483lPRQu+8sXMq+sO5+hJ2LWmX9H7Gld0MRWTilaF0cm5MVTmQhCdR1BpqSDTmNHUKmEkZT39xTVyiVzOiqXQ8UngHZcIYI0bfOyp5trQ/dM6rRs5jxEUaT+0mx7YSHHQm2CzK4F9mWdALsd78XORX5V2kuwtir00aGD5hYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971912; c=relaxed/simple;
	bh=qKx9lN2m9B2LaNp9/BsuTsz4PMHucWRf4+sxupt4WJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FW05dHy1mPtb0VivG/lA8scvxGTgRs6Y5Iqfz3YgvMiijciV3lAf5VduILaTqCFyc3v2V6AyEeByhlNMyE1y1eG1MCsRe/IcLoyFT2vhXXjS7udokDeUs92HU57xwpUzoQDodpakR3eFeDh+DP6TPoLfh4eE6TEre74QApRmwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D96221515;
	Wed, 12 Nov 2025 10:25:02 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A42BC3F63F;
	Wed, 12 Nov 2025 10:25:08 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:34 +0000
Subject: [PATCH v3 08/25] perf arm_spe: Consolidate operation types
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-8-e63c9829f9d9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971891; l=2655;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=qKx9lN2m9B2LaNp9/BsuTsz4PMHucWRf4+sxupt4WJ8=;
 b=fgY3metDPsIJLUysLmv9P8Ko2c2ueKyZmcpqCJZwANpHcASyl8Ddv3fzJBegrpFNbfc14C+wZ
 vFEHiMJCYkDA63bMayyKDfv6c+wM/8GXcSZcYFJS9Z07qVHlMceTCLg
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Consolidate operation types in a way:

(a) Extract the second-level types into separate enums.
(b) The second-level types for memory and SIMD operations are classified
    by modules. E.g., an operation may relate to general register,
    SIMD/FP, SVE, etc.
(c) The associated information tells details. E.g., an operation is
    load or store, whether it is atomic operation, etc.

Start the enum items for the second-level types from 8 to accommodate
more entries within a 32-bit integer.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 46 ++++++++++++-----------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 1259cbadfdc8098019afcd4cf65e733475310392..b555e2cc1dc36f209c23b0d84378da0ee65c1ab3 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -36,29 +36,31 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_OTHER	= 1 << 0,
 	ARM_SPE_OP_LDST		= 1 << 1,
 	ARM_SPE_OP_BRANCH_ERET	= 1 << 2,
+};
+
+enum arm_spe_2nd_op_ldst {
+	ARM_SPE_OP_GP_REG		= 1 << 8,
+	ARM_SPE_OP_UNSPEC_REG		= 1 << 9,
+	ARM_SPE_OP_NV_SYSREG		= 1 << 10,
+	ARM_SPE_OP_SIMD_FP		= 1 << 11,
+	ARM_SPE_OP_SVE_OTHER		= 1 << 12,
+	ARM_SPE_OP_SVE_LDST		= 1 << 13,
+
+	/* Assisted information for memory / SIMD */
+	ARM_SPE_OP_LD			= 1 << 20,
+	ARM_SPE_OP_ST			= 1 << 21,
+	ARM_SPE_OP_ATOMIC		= 1 << 22,
+	ARM_SPE_OP_EXCL			= 1 << 23,
+	ARM_SPE_OP_AR			= 1 << 24,
+};
 
-	/* Second level operation type for OTHER */
-	ARM_SPE_OP_SVE_OTHER		= 1 << 16,
-
-	/* Second level operation type for LDST */
-	ARM_SPE_OP_LD			= 1 << 16,
-	ARM_SPE_OP_ST			= 1 << 17,
-	ARM_SPE_OP_ATOMIC		= 1 << 18,
-	ARM_SPE_OP_EXCL			= 1 << 19,
-	ARM_SPE_OP_AR			= 1 << 20,
-	ARM_SPE_OP_SIMD_FP		= 1 << 21,
-	ARM_SPE_OP_GP_REG		= 1 << 22,
-	ARM_SPE_OP_UNSPEC_REG		= 1 << 23,
-	ARM_SPE_OP_NV_SYSREG		= 1 << 24,
-	ARM_SPE_OP_SVE_LDST		= 1 << 25,
-
-	/* Second level operation type for BRANCH_ERET */
-	ARM_SPE_OP_BR_COND		= 1 << 16,
-	ARM_SPE_OP_BR_INDIRECT		= 1 << 17,
-	ARM_SPE_OP_BR_GCS		= 1 << 18,
-	ARM_SPE_OP_BR_CR_BL		= 1 << 19,
-	ARM_SPE_OP_BR_CR_RET		= 1 << 20,
-	ARM_SPE_OP_BR_CR_NON_BL_RET	= 1 << 21,
+enum arm_spe_2nd_op_branch {
+	ARM_SPE_OP_BR_COND		= 1 << 8,
+	ARM_SPE_OP_BR_INDIRECT		= 1 << 9,
+	ARM_SPE_OP_BR_GCS		= 1 << 10,
+	ARM_SPE_OP_BR_CR_BL		= 1 << 11,
+	ARM_SPE_OP_BR_CR_RET		= 1 << 12,
+	ARM_SPE_OP_BR_CR_NON_BL_RET	= 1 << 13,
 };
 
 enum arm_spe_common_data_source {

-- 
2.34.1

