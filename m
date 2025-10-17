Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6030F556
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695535; cv=none; b=aotHYDv8j2aa1dWtM+asfO0IaEEYXhpsMI568meIyGlhmeK/6VWZKxbFM8fwluzEI0BiM5i30Dw6dz9API74ST9lIPySqEFl5Jg+BrVGcH5nXzDVvdJ0h2L82t75zY0J52h01a8D4diIxob64SLgTlXBxO0wdklQIaNZQBgjldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695535; c=relaxed/simple;
	bh=ixiUf5kOPNGqDsCLn1W0tcm157BdMTyzNAxILZdP0Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idZfuhS3inP25C6gUwJGxE6+wH/JV2CU0nHpG19cxlCNG22FoKkfXGdBlg2PiohGMSxhnHCpujHkMqkLZA+L0Efm0o0UbOf4fFR0HFAAUtnsmy+7BS5/U4KYkUz6EEmpHPO6Ij58c2odWD7UBIOdLJl7tvCtQil5Z8WT23pCDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDBA61596;
	Fri, 17 Oct 2025 03:05:25 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495C53F59E;
	Fri, 17 Oct 2025 03:05:32 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:05:04 +0100
Subject: [PATCH v2 15/25] perf arm_spe: Report GCS in record
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-15-2d41e4746e1b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=1911;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ixiUf5kOPNGqDsCLn1W0tcm157BdMTyzNAxILZdP0Es=;
 b=njlyUUBiX2qFoyCvQfsQzGV6HQ75k4jvWOwg3JItCR2qNUOKTLLRiHJ9/Urx5TcywCxYwlcKu
 W0LGV7nw2DKDjrWGXnY8m+PwZ/cp2FihnrD/H2+gHknhuBzOoPFKOGr
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Report GCS related info in records.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 4 ++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 6f0390d4089599cd6bbf1357fa4cd6ec8190a58c..649471abef6a4386e1b250a19cda4f4caeb0a2ff 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -228,6 +228,10 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 					decoder->record.op |= ARM_SPE_OP_MEMCPY;
 				} else if (SPE_OP_PKT_LDST_SUBCLASS_MEMSET(payload)) {
 					decoder->record.op |= ARM_SPE_OP_MEMSET;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_GCS(payload)) {
+					decoder->record.op |= ARM_SPE_OP_GCS;
+					if (payload & SPE_OP_PKT_GCS_COMM)
+						decoder->record.op |= ARM_SPE_OP_COMM;
 				}
 
 				break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 3f4dae589c062d927d286b73ce53fa39795daffd..b838e9c6168c6b7c20bb63b8e7c9d27c35f416dc 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -47,6 +47,7 @@ enum arm_spe_2nd_op_ldst {
 	ARM_SPE_OP_MTE_TAG		= 1 << 13,
 	ARM_SPE_OP_MEMCPY		= 1 << 14,
 	ARM_SPE_OP_MEMSET		= 1 << 15,
+	ARM_SPE_OP_GCS			= 1 << 16,
 
 	/* Assisted information for memory / SIMD */
 	ARM_SPE_OP_LD			= 1 << 20,
@@ -57,6 +58,7 @@ enum arm_spe_2nd_op_ldst {
 	ARM_SPE_OP_DP			= 1 << 25,	/* Data processing */
 	ARM_SPE_OP_PRED			= 1 << 26,	/* Predicated */
 	ARM_SPE_OP_SG			= 1 << 27,	/* Gather/Scatter */
+	ARM_SPE_OP_COMM			= 1 << 28,	/* Common */
 };
 
 enum arm_spe_2nd_op_branch {

-- 
2.34.1

