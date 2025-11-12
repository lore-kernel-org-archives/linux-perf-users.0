Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5434F24A;
	Wed, 12 Nov 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971916; cv=none; b=AFheKSl9trJxk1EAPpfjo5FXSsXdhb+iGAxHLW456qKLdkeH5YgezBiAmEGWtCOiqYqtuGCf8XkxktO8y0jvbrfEoHVTwb0xI2o82iKQvq3gLY1XlWo6qDbTn9WJGmSNPp3hYNvZCIBefp5Yvvt+VdL1dGUM8MD0S4Do18TYSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971916; c=relaxed/simple;
	bh=HHOOdkzKuLKsg1t2wcgtmBC8Ve28pWlydemgtJS2c20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hR8FIAmYhaU6A3PgMuSpqKmnVXTbppfEO9GR4whkpMXLtcDHEYWljQBmvwDlIH7WcVKe35NDE/cVhCfPlxy4cr17BvuaCCydMyGeWpoawCi7kOgynaFgunGwxZIx8YYEAKBlH2u0pn3ppw6K4Hy9fyIme83elzPPFYPrQQfLZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33BCC1515;
	Wed, 12 Nov 2025 10:25:07 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 002D03F63F;
	Wed, 12 Nov 2025 10:25:12 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:36 +0000
Subject: [PATCH v3 10/25] perf arm_spe: Report register access in record
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-10-e63c9829f9d9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971891; l=1481;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=HHOOdkzKuLKsg1t2wcgtmBC8Ve28pWlydemgtJS2c20=;
 b=4hsUP2OvotNhNXauUj1DDopPhAkHT0c80GQjf1KX5l3MAenuWz+S6/CbSJxXqzBHccWZpoAjt
 VMzPPGGredbBLdyEc8m4XbwipDOm9yfnm2sO2dIdhB/TxOCILSGCg9p
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

