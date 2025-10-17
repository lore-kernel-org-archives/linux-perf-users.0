Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3003126C1
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695529; cv=none; b=eZ9rj8D1OceIn7DivyJ/3oGm/4rXwetoTjX7BQggZfANKmbWt557p6MG30XZSF1WCxN0NAMmEtrZQ09RxHJ/xFXpjRcRroozAYnYgo6iC0TQ37mQ16Sp1710vbd2g4eH0lKiihPADMdp6PtSF1+GD0G2b8rePiwo8FfHYzEsB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695529; c=relaxed/simple;
	bh=9xyqlRibKdfIEBA60SZCFaRYBKwargJv8y6O2L3jq+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hw3mtuxadWnRhJzSPBPoWKMZx47UI5/0zEWUYA+KWfyVr7pjkM/ZIa4TaShYyXgASjGzwixEu6thFk6DojjCkPBoGRSKhhJ7bqtRyuuyD2g8mkYShhlTUwqc9J8Eowgh/sVG8CbTFM5gfcdT4O/NrBL/OIOB2N89mbTsEVoi++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 288BB1596;
	Fri, 17 Oct 2025 03:05:19 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A878D3F59E;
	Fri, 17 Oct 2025 03:05:25 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:05:00 +0100
Subject: [PATCH v2 11/25] perf arm_spe: Report MTE allocation tag in record
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-11-2d41e4746e1b@arm.com>
References: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
In-Reply-To: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=1653;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=9xyqlRibKdfIEBA60SZCFaRYBKwargJv8y6O2L3jq+o=;
 b=ibo47XJONTx9L1NypgbygYZ3EIHgbZlMlhVH89a95xTvdbeRq2C7a7OJCqoyvgEeyKyrJeF8y
 jCZ0gkFxIzlC5Dd1iymBSy3C9BhtmB6BMNvqDWpMgXR/djVMa3prv5b
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Save MTE tag info in memory record.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 804dce129121b9d2600be01af7f1f2780a9d0fc9..6696448bdf4f347e2032a1b4da46fcdd4016f9fc 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -209,6 +209,8 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 					decoder->record.op |= ARM_SPE_OP_UNSPEC_REG;
 				} else if (SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG(payload)) {
 					decoder->record.op |= ARM_SPE_OP_NV_SYSREG;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(payload)) {
+					decoder->record.op |= ARM_SPE_OP_MTE_TAG;
 				} else if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload)) {
 					decoder->record.op |= ARM_SPE_OP_SVE;
 				}
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index acab6d11096b19b1d31a553c83cba9732ecf5ddb..7b4d26f2ebfe17a9187f959e5ec0b2479f70cc2f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -44,6 +44,7 @@ enum arm_spe_2nd_op_ldst {
 	ARM_SPE_OP_NV_SYSREG		= 1 << 10,
 	ARM_SPE_OP_SIMD_FP		= 1 << 11,
 	ARM_SPE_OP_SVE			= 1 << 12,
+	ARM_SPE_OP_MTE_TAG		= 1 << 13,
 
 	/* Assisted information for memory / SIMD */
 	ARM_SPE_OP_LD			= 1 << 20,

-- 
2.34.1

