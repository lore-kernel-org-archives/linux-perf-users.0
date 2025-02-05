Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFC522CBD2;
	Wed,  5 Feb 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757788; cv=none; b=VOKhO897U0Ur456bQlbu4dPg+wCF6iNsVWNoAJBXds5NX0Z/Py8ef2y2HuLD/5l+IEsiiUXJHbWwhp44NmV77mGi55fWKBBFkjw1YZiRRTLwZZaujJsidTTQqlqZ6ARgDFsyPH0EyTHcHd0Qce/R7JdYcItQeCpYM3pDv5RxCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757788; c=relaxed/simple;
	bh=BGLK+9w3IABtPCR5uUnIs+w/MxPa72WEXGwyX53M3uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4z5YbV3J1t/fH9E2EpCvwlAQ2Lkmqca8zl+4ZAg2jOKk3CnnTsfq7mOKjms5tVUWiEjchK0AtVa+2PoDoDedvqwjLtI2lqwZLWsFc2QusMY83RnI1oisz0MD3O1LWIIr30qWrtuV+60dWnQeDPqaxE+3KrxJ8RRG/42BYQLqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04E9B1007;
	Wed,  5 Feb 2025 04:16:50 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F12123F63F;
	Wed,  5 Feb 2025 04:16:23 -0800 (PST)
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
Subject: [PATCH v1 06/11] perf arm-spe: Extend branch operations
Date: Wed,  5 Feb 2025 12:15:50 +0000
Message-Id: <20250205121555.180606-7-leo.yan@arm.com>
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

In Arm ARM (ARM DDI 0487, L.a), the section "D18.2.7 Operation Type
packet", the branch subclass is extended for Call Return (CR), Guarded
control stack data access (GCS).

This commit adds support CR and GCS operations.  The IND (indirect)
operation is defined only in bit [1], its macro is updated accordingly.

Move the COND (Conditional) macro into the same group with other
operations for better maintenance.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c  | 12 +++++++++---
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h  | 11 ++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 4cef10a83962..625834da7e20 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -397,10 +397,16 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 		if (payload & SPE_OP_PKT_COND)
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " COND");
-
-		if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload))
+		if (payload & SPE_OP_PKT_INDIRECT_BRANCH)
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " IND");
-
+		if (payload & SPE_OP_PKT_GCS)
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " GCS");
+		if (SPE_OP_PKT_CR_BL(payload))
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " CR-BL");
+		if (SPE_OP_PKT_CR_RET(payload))
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " CR-RET");
+		if (SPE_OP_PKT_CR_NON_BL_RET(payload))
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " CR-NON-BL-RET");
 		break;
 	default:
 		/* Unknown index */
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 464a912b221c..32d760ede701 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -7,6 +7,7 @@
 #ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
 #define INCLUDE__ARM_SPE_PKT_DECODER_H__
 
+#include <linux/bitfield.h>
 #include <stddef.h>
 #include <stdint.h>
 
@@ -116,8 +117,6 @@ enum arm_spe_events {
 
 #define SPE_OP_PKT_IS_OTHER_SVE_OP(v)		(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
 
-#define SPE_OP_PKT_COND				BIT(0)
-
 #define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
 #define SPE_OP_PKT_LDST_SUBCLASS_GP_REG		0x0
 #define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	0x4
@@ -148,7 +147,13 @@ enum arm_spe_events {
 #define SPE_OP_PKT_SVE_PRED			BIT(2)
 #define SPE_OP_PKT_SVE_FP			BIT(1)
 
-#define SPE_OP_PKT_IS_INDIRECT_BRANCH(v)	(((v) & GENMASK_ULL(7, 1)) == 0x2)
+#define SPE_OP_PKT_CR_MASK			GENMASK_ULL(4, 3)
+#define SPE_OP_PKT_CR_BL(v)			(FIELD_GET(SPE_OP_PKT_CR_MASK, (v)) == 1)
+#define SPE_OP_PKT_CR_RET(v)			(FIELD_GET(SPE_OP_PKT_CR_MASK, (v)) == 2)
+#define SPE_OP_PKT_CR_NON_BL_RET(v)		(FIELD_GET(SPE_OP_PKT_CR_MASK, (v)) == 3)
+#define SPE_OP_PKT_GCS				BIT(2)
+#define SPE_OP_PKT_INDIRECT_BRANCH		BIT(1)
+#define SPE_OP_PKT_COND				BIT(0)
 
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
-- 
2.34.1

