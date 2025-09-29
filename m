Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7630CB4B
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163898; cv=none; b=A4+1nTyRU8qCr6W00s94kG0Y/Bgd9bEMWDrS6O4ayq+kmq8+a1xOOZb2ZfTejnPpyp137sdXwy0gqZeKEZXijWtZj9qCa11HqQUvLb4ETFWdNnhY91wB+BD/sVTXSWxf8TJpj2yWj3l2EQc2iCq2ku1dyF0wuaXJx7lTC3Dz9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163898; c=relaxed/simple;
	bh=yuX1bLKbtNtYvgw+8k1mJ3RsMWDT4yzWTFB8WvrM3rE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNM5HKOMgLOOjwuAN5HndmPQX9p+Yo4bOk3ObFFI887UU7QnFEjCzl/dJisS2BRqjSkhi6kTewVhba0FFytdY5xpqcBaj6aiu2IdiBC3t7vxKYExG3KVM+GbAj2B/G+NYyXSWuphydKjhY7FF7qtM84QHe4PyjKhlkvqYVKTN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E012D150C;
	Mon, 29 Sep 2025 09:38:08 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88AB03F66E;
	Mon, 29 Sep 2025 09:38:15 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:50 +0100
Subject: [PATCH 14/25] perf arm_spe: Report memset and memcpy in records
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-14-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=1758;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=yuX1bLKbtNtYvgw+8k1mJ3RsMWDT4yzWTFB8WvrM3rE=;
 b=tn/zbeubJ1crXa8NtFllcJpnlLSKnwcVCgznWKeQX0NC2GFBwEUGrTkQtiFwm9LaV0VL0Zb2W
 JB8b/e7GsXIDVXC1DaFaUkCuYEOTltex8j1Zs1XjTd6tkgGxHjD56lY
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Expose memset and memcpy related info in records.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 4 ++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 5b214fc4ca9f67cf11700a18939f37f4a5400b84..6f0390d4089599cd6bbf1357fa4cd6ec8190a58c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -224,6 +224,10 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 						decoder->record.op |= ARM_SPE_OP_PRED;
 					if (payload & SPE_OP_PKT_SVE_SG)
 						decoder->record.op |= ARM_SPE_OP_SG;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_MEMCPY(payload)) {
+					decoder->record.op |= ARM_SPE_OP_MEMCPY;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_MEMSET(payload)) {
+					decoder->record.op |= ARM_SPE_OP_MEMSET;
 				}
 
 				break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 87d45c11ad7483c167b4d9cb2e481a001f54e5cc..565458a7a6cbd94d67803cc122154cb5cab4f308 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -43,7 +43,9 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_NV_SYSREG		= 1 << 10,
 	ARM_SPE_OP_SIMD_FP		= 1 << 11,
 	ARM_SPE_OP_MTE_TAG		= 1 << 12,
-	ARM_SPE_OP_SVE			= 1 << 13,
+	ARM_SPE_OP_MEMCPY		= 1 << 13,
+	ARM_SPE_OP_MEMSET		= 1 << 14,
+	ARM_SPE_OP_SVE			= 1 << 15,
 
 	/* Assisted information for memory / SIMD */
 	ARM_SPE_OP_LD			= 1 << 20,

-- 
2.34.1

