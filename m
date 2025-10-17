Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4B32E54A2
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Oct 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695532; cv=none; b=C0Hhav41OTlzdKOzX0Pogk2vCNwEF9CM9kCFKKf5AKaHPb2LHGNqGF7OYe0v0Qj6rWZOvDKVfa5ZX5ybpX5Fn0Yhu3RQ2L8sJ0rl5ANKXBwhBc/fOSfOh1z1krOsLcmdSPB/VmST6NvZq3M4yNkhnYO+lz+iuRWcVHaoHrkdZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695532; c=relaxed/simple;
	bh=zinKOe0OnQlC3Qe3ta5WLcFD5NOnPxLV9drCk020yzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcGKp1uxYsYakW0riXTHzP/8PQmCQj1V3ToGg4VuRyeNzPI7L2vLnHZwrXQZacWYUA5S68z09/bygKuVhjGblTcLr2WXc/ul5zXhMcGYPv50/TWs1lUwwH/w8rHh8Fa0zh6hXmmLB0GdVZfHZqHAMArTGcd/zxnJNETKkOTN6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 738341596;
	Fri, 17 Oct 2025 03:05:22 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F36FE3F59E;
	Fri, 17 Oct 2025 03:05:28 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 17 Oct 2025 11:05:02 +0100
Subject: [PATCH v2 13/25] perf arm_spe: Report associated info for SVE /
 SME operations
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-perf_support_arm_spev1-3-v2-13-2d41e4746e1b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760695507; l=1727;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=zinKOe0OnQlC3Qe3ta5WLcFD5NOnPxLV9drCk020yzQ=;
 b=LO8FRYC95KLUH45j9sKs+4J4d9XhY9zeXNi7MHgZxpPokeJGlXNVggMonv3m966iCpwdDWaL7
 RYkExZlFaZEABGIgk1On4BvZlggydGPQMbwUb7iWDTt9yvp10+PSSiG
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
index 7b4d26f2ebfe17a9187f959e5ec0b2479f70cc2f..d14cf6b95507bcbdb1f7e6d4908e6c40c4a8279c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -53,6 +53,8 @@ enum arm_spe_2nd_op_ldst {
 	ARM_SPE_OP_EXCL			= 1 << 23,
 	ARM_SPE_OP_AR			= 1 << 24,
 	ARM_SPE_OP_DP			= 1 << 25,	/* Data processing */
+	ARM_SPE_OP_PRED			= 1 << 26,	/* Predicated */
+	ARM_SPE_OP_SG			= 1 << 27,	/* Gather/Scatter */
 };
 
 enum arm_spe_2nd_op_branch {

-- 
2.34.1

