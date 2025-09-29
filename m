Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C8530CB51
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163892; cv=none; b=f+EbMNuZy/nWzwSilBQ1KZnIN+tg4HMqqN0LatTRqq1XhyMZoVpTeqBqNj+8Q5h9+gQ6WtGwATvRd/RHJDO9bhrqwhv8Hph4EsIguRwSAms+0thoBMyZs/MozK8vY9VW9SCRWedSaIyZcE5fVxDsCIMaMd9o8OpSftDRsZ/NiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163892; c=relaxed/simple;
	bh=HHOOdkzKuLKsg1t2wcgtmBC8Ve28pWlydemgtJS2c20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4Q/RA3uz4aAlOw43l/oQqfQ0zXAI2/TQx9Ladw48yxHRgnKUkfbqtn01CFDRTDqfhanRSyYUZi0QFRcSsjLDCPXU7IwxqKj6b1XvtVfivcGSIH8e/U8DYYGS/LTzeJwKA0R7EJfxwQg3Ma3dRAkOzr7I1AYRnib9orQ7n8eM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53068150C;
	Mon, 29 Sep 2025 09:38:02 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDB263F66E;
	Mon, 29 Sep 2025 09:38:08 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:46 +0100
Subject: [PATCH 10/25] perf arm_spe: Report register access in record
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-10-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=1481;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=HHOOdkzKuLKsg1t2wcgtmBC8Ve28pWlydemgtJS2c20=;
 b=tKpPleWtflT6QZ6mnjkL2m/Z9HVBORYC5p+Wi0KK767u0CFP5OlkqCpnRkruoz+ha4RXcvJAP
 w2xuNDkRLoQA2gKd29EVn6sfex0PBP3lAql5zaeIN3I1f1tgOwTiWuy
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Record register access info for load / store operations.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 6974f594f37c9916fff591ced1e9c2d60cf84f14..804dce129121b9d2600be01af7f1f2780a9d0fc9 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -200,8 +200,19 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 					decoder->record.op |= ARM_SPE_OP_ST;
 				else
 					decoder->record.op |= ARM_SPE_OP_LD;
-				if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload))
+
+				if (SPE_OP_PKT_LDST_SUBCLASS_GP_REG(payload)) {
+					decoder->record.op |= ARM_SPE_OP_GP_REG;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP(payload)) {
+					decoder->record.op |= ARM_SPE_OP_SIMD_FP;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG(payload)) {
+					decoder->record.op |= ARM_SPE_OP_UNSPEC_REG;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG(payload)) {
+					decoder->record.op |= ARM_SPE_OP_NV_SYSREG;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload)) {
 					decoder->record.op |= ARM_SPE_OP_SVE;
+				}
+
 				break;
 			case SPE_OP_PKT_HDR_CLASS_OTHER:
 				decoder->record.op |= ARM_SPE_OP_OTHER;

-- 
2.34.1

