Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC73090C6
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163880; cv=none; b=lQG8kBO96KbdEep2piaJyU4bnrRSL74Z8jOYuolHglp8U+bgIiE8dZQMyML9niNncNC97YhS1PUSuO6YLnGzs6p5Bwu3VK3C5cxYs5NKaq/MlWeDZ2gV6JeOlixvWtAY/OeB8G4u7QzPFL0oKHwWpSRZHdc3YMz/J/vKU7J83l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163880; c=relaxed/simple;
	bh=AI7UBaNe19y2ZmOnZ10XQZCilrMUPhEQMhX054AblbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mr5uadccpy67G5KmYFz4jhKq34Y3O1FDp04ZoGM4iQv9soYgpzGdOZCE/ajrtvR/w9Q0fFElVMXvlPrEtnWdmbQc8p20/6+shk86XTfOtNSkuWCBldPz/PMfvcaB+UB8k1QonZ+rXUdQ00qiz5Yt1ubU7uqW2gv2kEjc2WMU/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C417A25DC;
	Mon, 29 Sep 2025 09:37:50 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B1F63F66E;
	Mon, 29 Sep 2025 09:37:57 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:39 +0100
Subject: [PATCH 03/25] perf arm_spe: Decode GCS operation
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-3-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=2306;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=AI7UBaNe19y2ZmOnZ10XQZCilrMUPhEQMhX054AblbQ=;
 b=IFeOP0ha97BCPfQInT1PBqUf/gjH6TH8lk16Adq7+FWB8NNgiFbUIks5sCqs46zRy52IsVp3D
 nxOeo6e0zo6DsTJDz/5WK3/3Wt/8a2FU/NqG4jOGoIgXJ3X7aTo667z
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Decode a load or store from a GCS operation and the associated "common"
field.

After:

  .  00000000:  49 44                                           LD GCS COMM
  .  00000002:  b2 18 3c d7 83 00 80 ff ff                      VA 0xffff800083d73c18
  .  0000000b:  9a 00 00                                        LAT 0 XLAT
  .  0000000e:  43 00                                           DATA-SOURCE 0

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 ++++
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index f6e9c58ce62f3ae227a79d91caefaef4bd87d98a..0046079edaccdd4d0c093f73395d1ecdc0007621 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -394,6 +394,10 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " PRED");
 			if (payload & SPE_OP_PKT_SVE_SG)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " SG");
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_GCS(payload)) {
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " GCS");
+			if (payload & SPE_OP_PKT_GCS_COMM)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " COMM");
 		}
 		break;
 	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index cb947e625918922dc1fa25cf8843b09661197782..94333e7bc382deef119414e4f1de7c2878620035 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -154,6 +154,10 @@ enum arm_spe_events {
 #define SPE_OP_PKT_SVE_PRED			BIT(2)
 #define SPE_OP_PKT_SVE_FP			BIT(1)
 
+#define SPE_OP_PKT_LDST_SUBCLASS_GCS(v)		(((v) & (GENMASK_ULL(7, 3) | BIT(1))) == 0x40)
+
+#define SPE_OP_PKT_GCS_COMM			BIT(2)
+
 #define SPE_OP_PKT_CR_MASK			GENMASK_ULL(4, 3)
 #define SPE_OP_PKT_CR_BL(v)			(FIELD_GET(SPE_OP_PKT_CR_MASK, (v)) == 1)
 #define SPE_OP_PKT_CR_RET(v)			(FIELD_GET(SPE_OP_PKT_CR_MASK, (v)) == 2)

-- 
2.34.1

