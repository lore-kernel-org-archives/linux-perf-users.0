Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332C719E7E2
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830066; cv=none; b=sjj23H27Rl94rI9qQTE5Xb96j+xqDQYLYkfeid5hHoiNjdc64UZ7vLINVxKGqMqDVDzFUaWb5wq/AO0aQERtTAikKUiC7nboj8voAf3BvMIbXg3vUrY2w9kIFLU+t/WJWC4YkucTbs8m+TG/u81zgE5i+1805jC5VdkKoSq8+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830066; c=relaxed/simple;
	bh=hNKCJUuA7tD8SSahADGDVPenIcupK7PTT1vUf0+s7HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOnZ7hDBwkbk60qMxxWIUSwmRJbp1gjEK0BY+MecDjaoA3Ua8iNFBIL5e52F69gJWpAEOS8sV+jFkMjF9TywAgFkszDjJuWP40NSJGqjD6wASIQC/Xt8Um1KyEt8chdEBmKnUf0hCdajlcJ8knyPDcQ/vhzgWpsewbepPPn5QMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EAC7202C;
	Fri, 13 Jun 2025 08:54:03 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA5F93F59E;
	Fri, 13 Jun 2025 08:54:21 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 13 Jun 2025 16:53:37 +0100
Subject: [PATCH 04/12] perf arm_spe: Directly propagate raw event
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-4-6faecf0a8775@arm.com>
References: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749830053; l=3952;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=hNKCJUuA7tD8SSahADGDVPenIcupK7PTT1vUf0+s7HE=;
 b=9YzyF5Um1RwHfUT+4u852wO5DpnD4FZTK3Qjwu/n6Y+4VOmj0AhlHwsO5Kq3t2G8UObL8TW9x
 p7XnmQ8w6NbCsFR5gUiBkJUH83VsP5IVV3dvIPpz4XypoNga1UaPFnz
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Two separate sets of event bits are defined: one for used in the code
for generating samples and another for the backend decoder. Reduce
the redundancy by using the raw event bits directly in the frontend
code.

To avoid overflow issues, change the type of the event variable from
enum to u64.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 37 +----------------------
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 28 ++++++++---------
 2 files changed, 14 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 688fe6d7524416420a7c18d5f8a268492ce7c3b8..96eb7cced6fd1574f5d823e4c67b9051dcf183ed 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -229,42 +229,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			}
 			break;
 		case ARM_SPE_EVENTS:
-			if (payload & BIT(EV_L1D_REFILL))
-				decoder->record.type |= ARM_SPE_L1D_MISS;
-
-			if (payload & BIT(EV_L1D_ACCESS))
-				decoder->record.type |= ARM_SPE_L1D_ACCESS;
-
-			if (payload & BIT(EV_TLB_WALK))
-				decoder->record.type |= ARM_SPE_TLB_MISS;
-
-			if (payload & BIT(EV_TLB_ACCESS))
-				decoder->record.type |= ARM_SPE_TLB_ACCESS;
-
-			if (payload & BIT(EV_LLC_MISS))
-				decoder->record.type |= ARM_SPE_LLC_MISS;
-
-			if (payload & BIT(EV_LLC_ACCESS))
-				decoder->record.type |= ARM_SPE_LLC_ACCESS;
-
-			if (payload & BIT(EV_REMOTE_ACCESS))
-				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
-
-			if (payload & BIT(EV_MISPRED))
-				decoder->record.type |= ARM_SPE_BRANCH_MISS;
-
-			if (payload & BIT(EV_NOT_TAKEN))
-				decoder->record.type |= ARM_SPE_BRANCH_NOT_TAKEN;
-
-			if (payload & BIT(EV_TRANSACTIONAL))
-				decoder->record.type |= ARM_SPE_IN_TXN;
-
-			if (payload & BIT(EV_PARTIAL_PREDICATE))
-				decoder->record.type |= ARM_SPE_SVE_PARTIAL_PRED;
-
-			if (payload & BIT(EV_EMPTY_PREDICATE))
-				decoder->record.type |= ARM_SPE_SVE_EMPTY_PRED;
-
+			decoder->record.type = payload;
 			break;
 		case ARM_SPE_DATA_SOURCE:
 			decoder->record.source = payload;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 881d9f29c1380b62486f0cd81498750ba06c4b50..03da55453da8fd2e7b9e2dcba3ddcf5243599e1c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -13,20 +13,18 @@
 
 #include "arm-spe-pkt-decoder.h"
 
-enum arm_spe_sample_type {
-	ARM_SPE_L1D_ACCESS		= 1 << 0,
-	ARM_SPE_L1D_MISS		= 1 << 1,
-	ARM_SPE_LLC_ACCESS		= 1 << 2,
-	ARM_SPE_LLC_MISS		= 1 << 3,
-	ARM_SPE_TLB_ACCESS		= 1 << 4,
-	ARM_SPE_TLB_MISS		= 1 << 5,
-	ARM_SPE_BRANCH_MISS		= 1 << 6,
-	ARM_SPE_REMOTE_ACCESS		= 1 << 7,
-	ARM_SPE_SVE_PARTIAL_PRED	= 1 << 8,
-	ARM_SPE_SVE_EMPTY_PRED		= 1 << 9,
-	ARM_SPE_BRANCH_NOT_TAKEN	= 1 << 10,
-	ARM_SPE_IN_TXN			= 1 << 11,
-};
+#define ARM_SPE_L1D_ACCESS		BIT(EV_L1D_ACCESS)
+#define ARM_SPE_L1D_MISS		BIT(EV_L1D_REFILL)
+#define ARM_SPE_LLC_ACCESS		BIT(EV_LLC_ACCESS)
+#define ARM_SPE_LLC_MISS		BIT(EV_LLC_MISS)
+#define ARM_SPE_TLB_ACCESS		BIT(EV_TLB_ACCESS)
+#define ARM_SPE_TLB_MISS		BIT(EV_TLB_WALK)
+#define ARM_SPE_BRANCH_MISS		BIT(EV_MISPRED)
+#define ARM_SPE_BRANCH_NOT_TAKEN	BIT(EV_NOT_TAKEN)
+#define ARM_SPE_REMOTE_ACCESS		BIT(EV_REMOTE_ACCESS)
+#define ARM_SPE_SVE_PARTIAL_PRED	BIT(EV_PARTIAL_PREDICATE)
+#define ARM_SPE_SVE_EMPTY_PRED		BIT(EV_EMPTY_PREDICATE)
+#define ARM_SPE_IN_TXN			BIT(EV_TRANSACTIONAL)
 
 enum arm_spe_op_type {
 	/* First level operation type */
@@ -100,7 +98,7 @@ enum arm_spe_hisi_hip_data_source {
 };
 
 struct arm_spe_record {
-	enum arm_spe_sample_type type;
+	u64 type;
 	int err;
 	u32 op;
 	u32 latency;

-- 
2.34.1

