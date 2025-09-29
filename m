Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD530CD84
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163902; cv=none; b=X9QPnw+Oh7CLRoF+uS05MTnf9ysCQuxTNiJZi5lB4Nen4G/2gFQJluazY6g5bQXJjQ7qM5eRf0LwEuYjDrO9H0zQ5CdU23EndmGXq+wafH2zBBIz9wIsDG6bHTbpjEc/3BfvIGlf+LW/FLX0rSP7I0S7zDeEF/KSI/VxNqElEpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163902; c=relaxed/simple;
	bh=Y3L/VF392QVL9CtDTEmkUKeUviRM6ntIKs+hRMb7LcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4LUnVoCJ8xJxdsB1DdmJsM4Bvn2MHwuUx2+YGr2x0EoVvOCNEF4bpy/ZBUvyqy6zd9EeyHDVaQdWUyj3JS/Iav37jbzxjSYJd0p4U9iyxiKq74PGBW/LLry/TZ8RwtXLr94iZrAovO2pQxQvX7wUrqWGJrtsuqQrmu3UtLqcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 353E3150C;
	Mon, 29 Sep 2025 09:38:12 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D01CC3F66E;
	Mon, 29 Sep 2025 09:38:18 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:52 +0100
Subject: [PATCH 16/25] perf arm_spe: Expose SIMD information in other
 operations
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-16-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=2851;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Y3L/VF392QVL9CtDTEmkUKeUviRM6ntIKs+hRMb7LcU=;
 b=0GCLgKg5pWYkSo2WO9eu4QGlur6KItjUaMu4WgJjuWLBZw0rx4khjvkuOdAuQYDMZqHLl2Syp
 YpxepF/6EdWAPNS6OXtq+5EaLYpZjNI16trIu40JdL0Y0MIR+E1ajSl
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
index 40d734f284eb8d742de9c53e55a9a541d6d462b2..d4574268cf793efe154f252b3e2af9c721bada97 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -47,6 +47,8 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_MEMSET		= 1 << 14,
 	ARM_SPE_OP_GCS			= 1 << 15,
 	ARM_SPE_OP_SVE			= 1 << 16,
+	ARM_SPE_OP_SME			= 1 << 17,
+	ARM_SPE_OP_ASE			= 1 << 18,
 
 	/* Assisted information for memory / SIMD */
 	ARM_SPE_OP_LD			= 1 << 20,
@@ -58,6 +60,8 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_PRED			= 1 << 26,	/* Predicated */
 	ARM_SPE_OP_SG			= 1 << 27,	/* Gather/Scatter */
 	ARM_SPE_OP_COMM			= 1 << 28,	/* Common */
+	ARM_SPE_OP_FP			= 1 << 29,	/* Floating-point */
+	ARM_SPE_OP_COND			= 1 << 30,	/* Conditional */
 
 	/* Second level operation type for BRANCH_ERET */
 	ARM_SPE_OP_BR_COND		= 1 << 8,

-- 
2.34.1

