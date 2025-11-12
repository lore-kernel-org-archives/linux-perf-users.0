Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829D3350A11;
	Wed, 12 Nov 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971920; cv=none; b=W4s3Ln9RVQNfaVecttTe/WppXrbGB7e4Wy2gSA1jTDItDCUhQJyYmxwEyA0u+cmWDPokDxHiDRnGd2CIXIEP11BChtKAQse9KXozMNO3IcZzyITzNLEjd93Wr8PlcLLuP7hassx0aWvkIG1JNTb+EWtumPLbduBvMrZYbvXPjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971920; c=relaxed/simple;
	bh=IN1q4IBQZez4Gc/ZmEnYrKyLPI5UL1+SlIBjzXyHK0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ka5RyjpQtA66iu+C8hMIr8k/22u7xrfzIQIYMkLk0Wv1zNa4zlJ4cM4YsNtZ+/0Sjt8YYMFxUtkvglqDlwXFswmyp5kUeNBsishgz2FFlrItncXLrkl/ACP+8FJEE7sJIa7Vb7hU2gJ8oH7vVyH2I3P5hj2B7HlM/b7Ec/B4hwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C621515;
	Wed, 12 Nov 2025 10:25:11 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504073F63F;
	Wed, 12 Nov 2025 10:25:17 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:38 +0000
Subject: [PATCH v3 12/25] perf arm_spe: Report extended memory operations
 in records
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-12-e63c9829f9d9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971891; l=1324;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=IN1q4IBQZez4Gc/ZmEnYrKyLPI5UL1+SlIBjzXyHK0A=;
 b=gm7Ug7SfbufrC8gQNypKLowGc/kYYlopBFgaPUUnzEqs+elkD5cF/0ZlTiYoEYkp1fY66AYNs
 46Y9FMdykLQB/3rYRizpiiI+ROvXsBStnl4OOLRCln/NrQhtSxaz/rC
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Extended memory operations include atomic (AT), acquire/release (AR),
and exclusive (EXCL) operations. Save the relevant information
in the records.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 6696448bdf4f347e2032a1b4da46fcdd4016f9fc..949c20816826a4d45d6cf9a5efaa125acea90b0a 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -211,6 +211,13 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 					decoder->record.op |= ARM_SPE_OP_NV_SYSREG;
 				} else if (SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(payload)) {
 					decoder->record.op |= ARM_SPE_OP_MTE_TAG;
+				} else if (SPE_OP_PKT_LDST_SUBCLASS_EXTENDED(payload)) {
+					if (payload & SPE_OP_PKT_AR)
+						decoder->record.op |= ARM_SPE_OP_AR;
+					if (payload & SPE_OP_PKT_EXCL)
+						decoder->record.op |= ARM_SPE_OP_EXCL;
+					if (payload & SPE_OP_PKT_AT)
+						decoder->record.op |= ARM_SPE_OP_ATOMIC;
 				} else if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload)) {
 					decoder->record.op |= ARM_SPE_OP_SVE;
 				}

-- 
2.34.1

