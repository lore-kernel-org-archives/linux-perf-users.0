Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE7822E413;
	Wed,  5 Feb 2025 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757793; cv=none; b=O2IHQWspOcUJwy4XI8CPXSLgmmRJatv6zO+DYex+dkIJEcanORw8CqItKFPHeEuYfkd00dXYSXfP/C3ogUPsYEaNszQPjGNu5UEs8XnHx+ucsmDwyw1+wEGTijKPXyOcOF94VDSPtvTMm6O/AcOKKGkSvMZkaPfHuNN6jRGleLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757793; c=relaxed/simple;
	bh=5s23RwRKBWSs/Bnj2bah4JQzkhQfDeuh/E9O7F1TU6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qntYqvFcttyA+DoS5UC5bCWTfzcUM68/CyyU/Mzl/bdDH+ilE3wQfVe5+DD6GsMcEuBzE+S1v0Tk12NWgYRBcfQg67FPjlwFWJfGkgITKMqHwh6Vx4F5+rlPaWYmOHkAEDumLi/N3hi2qn/gw/QcqOiqamiyLwdwF39xwNbAPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52A9A1007;
	Wed,  5 Feb 2025 04:16:55 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B1933F63F;
	Wed,  5 Feb 2025 04:16:29 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Graham Woodward <graham.woodward@arm.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 08/11] perf arm-spe: Fill branch operations and events to record
Date: Wed,  5 Feb 2025 12:15:52 +0000
Message-Id: <20250205121555.180606-9-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205121555.180606-1-leo.yan@arm.com>
References: <20250205121555.180606-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new added branch operations and events are filled into record, the
information will be consumed when synthesizing samples.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c     | 18 ++++++++++++++++++
 .../util/arm-spe-decoder/arm-spe-decoder.h     | 10 ++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index ba807071d3c1..52bd0a4ea96d 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -207,6 +207,18 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 				break;
 			case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 				decoder->record.op |= ARM_SPE_OP_BRANCH_ERET;
+				if (payload & SPE_OP_PKT_COND)
+					decoder->record.op |= ARM_SPE_OP_BR_COND;
+				if (payload & SPE_OP_PKT_INDIRECT_BRANCH)
+					decoder->record.op |= ARM_SPE_OP_BR_INDIRECT;
+				if (payload & SPE_OP_PKT_GCS)
+					decoder->record.op |= ARM_SPE_OP_BR_GCS;
+				if (SPE_OP_PKT_CR_BL(payload))
+					decoder->record.op |= ARM_SPE_OP_BR_CR_BL;
+				if (SPE_OP_PKT_CR_RET(payload))
+					decoder->record.op |= ARM_SPE_OP_BR_CR_RET;
+				if (SPE_OP_PKT_CR_NON_BL_RET(payload))
+					decoder->record.op |= ARM_SPE_OP_BR_CR_NON_BL_RET;
 				break;
 			default:
 				pr_err("Get packet error!\n");
@@ -238,6 +250,12 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			if (payload & BIT(EV_MISPRED))
 				decoder->record.type |= ARM_SPE_BRANCH_MISS;
 
+			if (payload & BIT(EV_NOT_TAKEN))
+				decoder->record.type |= ARM_SPE_BRANCH_NOT_TAKEN;
+
+			if (payload & BIT(EV_TRANSACTIONAL))
+				decoder->record.type |= ARM_SPE_IN_TXN;
+
 			if (payload & BIT(EV_PARTIAL_PREDICATE))
 				decoder->record.type |= ARM_SPE_SVE_PARTIAL_PRED;
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 4bcd627e859f..85b688a97436 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -24,6 +24,8 @@ enum arm_spe_sample_type {
 	ARM_SPE_REMOTE_ACCESS		= 1 << 7,
 	ARM_SPE_SVE_PARTIAL_PRED	= 1 << 8,
 	ARM_SPE_SVE_EMPTY_PRED		= 1 << 9,
+	ARM_SPE_BRANCH_NOT_TAKEN	= 1 << 10,
+	ARM_SPE_IN_TXN			= 1 << 11,
 };
 
 enum arm_spe_op_type {
@@ -52,8 +54,12 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_SVE_SG		= 1 << 27,
 
 	/* Second level operation type for BRANCH_ERET */
-	ARM_SPE_OP_BR_COND	= 1 << 16,
-	ARM_SPE_OP_BR_INDIRECT	= 1 << 17,
+	ARM_SPE_OP_BR_COND		= 1 << 16,
+	ARM_SPE_OP_BR_INDIRECT		= 1 << 17,
+	ARM_SPE_OP_BR_GCS		= 1 << 18,
+	ARM_SPE_OP_BR_CR_BL		= 1 << 19,
+	ARM_SPE_OP_BR_CR_RET		= 1 << 20,
+	ARM_SPE_OP_BR_CR_NON_BL_RET	= 1 << 21,
 };
 
 enum arm_spe_common_data_source {
-- 
2.34.1

