Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5261C30CB4E
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163888; cv=none; b=tHBwha0FszI0ZeN35zOYu3Ejeu/J3aneSEKaF/wAjZxDsWCUqhyXOmMtH/FtFg+ljY5e/I7KssUeIptjV/XRzP6D85Bogr+6Ydv0o7ZoMc1f3YcKPrHHrkyaTylpyKxnVUO+gJhtU4M9LqYtsBg5wd++4qyjKqhUdxEoQhxveOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163888; c=relaxed/simple;
	bh=4fmSaYM1PKsL+dCQbsXwRV5P+jrbcuNm7iLSefb7jjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riTAnPu6N6hWMYoU1Qv+N9NAiTYsd9BROsWcc5AcVC11MXR1EWHvOVlA5+Ev0TosIOxfGlb+QcfyRCioD5nekNnzox3nGtdyESwUc+oAI1lT/5LHWRiuppTU75/mRN0crUDNVAJ5ytJ6iDU+JFFVNTKQPc39bgh8x86dZL0rJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AB3E1758;
	Mon, 29 Sep 2025 09:37:59 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A59773F66E;
	Mon, 29 Sep 2025 09:38:05 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:44 +0100
Subject: [PATCH 08/25] perf arm_spe: Consolidate operation types
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-8-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=2552;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=4fmSaYM1PKsL+dCQbsXwRV5P+jrbcuNm7iLSefb7jjk=;
 b=DaZCp44K50FFnXqT4B8B7gR0EoM8UXb854aZbXFFj/NFbidxZ2amSnnEVxpyfpZ7bZTLIp8nn
 sbx9Hctsl7pB/P5TW/PzifejpKldSwBTnG7Mzo5N7/Lx4R01ZmjxNel
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Consolidate operation types in a way:

(a) The second-level types for memory and SIMD operations are classified
    by modules. E.g., an operation may relate to general register,
    SIMD/FP, SVE, etc.

(b) The associated information tells details. E.g., an operation is
    load or store, whether it is atomic operation, etc.

Start the enum items for the second-level types from 8 to accommodate
more entries within a 32-bit integer.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 40 +++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 1259cbadfdc8098019afcd4cf65e733475310392..8156aa04f82e59ce345fb44223d3d22ecbc149a7 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -37,28 +37,28 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_LDST		= 1 << 1,
 	ARM_SPE_OP_BRANCH_ERET	= 1 << 2,
 
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
+	/* Second level operation type for memory / SIMD */
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
 
 	/* Second level operation type for BRANCH_ERET */
-	ARM_SPE_OP_BR_COND		= 1 << 16,
-	ARM_SPE_OP_BR_INDIRECT		= 1 << 17,
-	ARM_SPE_OP_BR_GCS		= 1 << 18,
-	ARM_SPE_OP_BR_CR_BL		= 1 << 19,
-	ARM_SPE_OP_BR_CR_RET		= 1 << 20,
-	ARM_SPE_OP_BR_CR_NON_BL_RET	= 1 << 21,
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

