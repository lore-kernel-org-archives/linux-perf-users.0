Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAD1D554
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Jul 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895604; cv=none; b=DCzxbKi2PKQyqThIjRwytZf6OjRZSD82T5AQvWN6cacY3HibfGBvj6nkNYAjR+nW6sh7N7hQbdPuaO5lyY0IWkut3Eyy7F6b5zfpUUF7EOKtyimhvjRjpmwgglUOxmbOBY+S+0zyDCLPJV2+kQ8sj0H4jjH0GQ5dB0INoTmnvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895604; c=relaxed/simple;
	bh=A82OQ2BFXXAxnTr/n1kS9ARBrMRjwjgGM6jtBrrEcd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQ1+XCADVWo+ODBQgNUUT4qoE2qzwHWqxF8bCAZJK/VwwESBbki6CMtd5m8dAwVOxSdCIIEaKtfQy4vckWApUnKmImbKdU5f4OS2CxtPEmFIAJ8p9xybbCiSE/o6MqZ28D4XchLxxxQboRLWVeBeY1k13aesSrW0663oKfKKsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D62E168F;
	Mon,  7 Jul 2025 06:39:50 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04163F6A8;
	Mon,  7 Jul 2025 06:40:00 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 07 Jul 2025 14:39:27 +0100
Subject: [PATCH v3 05/14] perf arm_spe: Directly propagate raw event
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-5-33ea82da3280@arm.com>
References: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
In-Reply-To: <20250707-arm_spe_support_hitm_overhead_v1_public-v3-0-33ea82da3280@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 German Gomez <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751895589; l=3995;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=A82OQ2BFXXAxnTr/n1kS9ARBrMRjwjgGM6jtBrrEcd0=;
 b=7KZCnwM07siLzXn7j4jWuJu7gq5jcZgzX6XGgFWFYxWFavF9QHvB1aP2aqdybysTynpniOG3a
 JYCwVQpeSXxCx6j0UbB1gIDf8jZa/wpuKyTnXWEIDfWLMXqjxITkJNk
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Two sets of event bits are defined: one for generating samples and
another are raw event bits used in the backend decoder. Reduce the
redundancy by using the raw event bits directly in the frontend code.

To avoid overflow issues, change the type of the event variable from
enum to u64.

Reviewed-by: James Clark <james.clark@linaro.org>
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

