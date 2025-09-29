Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FEC30CB4A
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163898; cv=none; b=S4C4vLyCk16ySFyN+SiFm/sVz8MebaVnqalwhuC6nFL+45s6f6jfxMU5v+mbRrL8LyUVvk9904B+LhREiQm1F64be9v0BfnZi5OYywOeBzxuh9zXSoCYL70Qs1DAivyVf/yaurB165O9rjj+XjuBiOp5tQU4Drmn3HvFP8fMqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163898; c=relaxed/simple;
	bh=RXJ9kFGtQL5/L6WpOFZA0nkmIwCppVW2sPmyZqwDo40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/JKUAeedDxdR5PVp7/MMGwNA/cmVx5BET+pV+Al38RDzXM7FW2JoL890mZY1ZFrc+sHnudPPHOU8mMm4AMAQJjzSU6NbIYYHYmFL0bB0DzbMstMQkSxyl+cGw55+75a4hrpEpzxBCxc3F+KLlLiIDCsowbYTzOh6rbu6zJOnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40B011CC4;
	Mon, 29 Sep 2025 09:38:07 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF8443F66E;
	Mon, 29 Sep 2025 09:38:13 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 29 Sep 2025 17:37:49 +0100
Subject: [PATCH 13/25] perf arm_spe: Report associated info for SVE / SME
 operations
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-perf_support_arm_spev1-3-v1-13-1150b3c83857@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759163872; l=1773;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=RXJ9kFGtQL5/L6WpOFZA0nkmIwCppVW2sPmyZqwDo40=;
 b=ll7Gy646zJ7QZR2ZSt/393OMOj8pPdXNTZUVKsOARcXSwCY0DL8VSXBn5UeouaQacxHSi04VE
 lUMVgFtYulVBNXPq7Bvy3s3dpvOWkgSL6qrFyEzGdHkLSgXFq7fWCj0
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

SVE / SME operations can be predicated or Gather load / scatter store,
save the relevant info into record.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 4 ++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 949c20816826a4d45d6cf9a5efaa125acea90b0a..5b214fc4ca9f67cf11700a18939f37f4a5400b84 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -220,6 +220,10 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 						decoder->record.op |= ARM_SPE_OP_ATOMIC;
 				} else if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload)) {
 					decoder->record.op |= ARM_SPE_OP_SVE;
+					if (payload & SPE_OP_PKT_SVE_PRED)
+						decoder->record.op |= ARM_SPE_OP_PRED;
+					if (payload & SPE_OP_PKT_SVE_SG)
+						decoder->record.op |= ARM_SPE_OP_SG;
 				}
 
 				break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 9b7b6c42505f43c32a188b6e9769390f057adce8..87d45c11ad7483c167b4d9cb2e481a001f54e5cc 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -52,6 +52,8 @@ enum arm_spe_op_type {
 	ARM_SPE_OP_EXCL			= 1 << 23,
 	ARM_SPE_OP_AR			= 1 << 24,
 	ARM_SPE_OP_DP			= 1 << 25,	/* Data processing */
+	ARM_SPE_OP_PRED			= 1 << 26,	/* Predicated */
+	ARM_SPE_OP_SG			= 1 << 27,	/* Gather/Scatter */
 
 	/* Second level operation type for BRANCH_ERET */
 	ARM_SPE_OP_BR_COND		= 1 << 8,

-- 
2.34.1

