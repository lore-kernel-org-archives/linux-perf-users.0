Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6628C30C110
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163893; cv=none; b=eNwoJVsndfVNIcQk/jVb4n6RBEevaUrwAw9YfT4I33mAc1oYEueKww6OLtAW58F8Sa+e7SLcdXpgsktyKc6oE6Hgyv59aLpYd1Syi0S9q80x9wqW8hNtucxzKMDIZC7ytXTqU2qCZZ6V0x9oihz/hE8cn+/cpXKteCfcecJk8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163893; c=relaxed/simple;
	bh=oKSpUYglDy5GpsYHeULdYx7DLgugiZ4g/dNTnhls3uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmOMwfNj6LRbO0/V2JVr2SmbUw4I49Z59aey3JfjRgVjf6F7PzfEzeDzEBCXTAI77LVosUkFzPxMpUMUQ+eExltqUC1+3HUxhNCmhgUcZ/E4lZhvLz1hAEMkklpKi6dkofJC9/XNMWRzwASuWSoyz9QVUcrYiRffrn36p6MMYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF5AC1758;
	Mon, 29 Sep 2025 09:38:03 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97DD73F66E;
	Mon, 29 Sep 2025 09:38:10 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:47 +0100
Subject: [PATCH 11/25] perf arm_spe: Report MTE allocation tag in record
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-11-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=1733;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=oKSpUYglDy5GpsYHeULdYx7DLgugiZ4g/dNTnhls3uA=;
 b=BEFNsHfD0BCGkvHI/LFCKGoKXWnELUHhg9XJm8T2PgV0g/l+EMDmWlo/Ht5/gpYGImFXu+GRh
 6+93u0WAk7gDaWmt/WxL2YthbWimQaE1MNEhBmIMfC3yLPvPZ8rPr4c
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Save MTE tag info in memory record.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

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
index 08ef83cb8bf00be75459c78b9ee8a6cbf1971986..9b7b6c42505f43c32a188b6e9769390f057adce8 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -42,7 +42,8 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_UNSPEC_REG		= 1 << 9,
 	ARM_SPE_OP_NV_SYSREG		= 1 << 10,
 	ARM_SPE_OP_SIMD_FP		= 1 << 11,
-	ARM_SPE_OP_SVE			= 1 << 12,
+	ARM_SPE_OP_MTE_TAG		= 1 << 12,
+	ARM_SPE_OP_SVE			= 1 << 13,
 
 	/* Assisted information for memory / SIMD */
 	ARM_SPE_OP_LD			= 1 << 20,

-- 
2.34.1

