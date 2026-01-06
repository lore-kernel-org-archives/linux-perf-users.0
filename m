Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4C32E721;
	Tue,  6 Jan 2026 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700658; cv=none; b=NQj9yYGCHuq7SZUwqECC8wIVKwJf8ZunYVBWBOhI59cepn+j5Jspnfko+VolvExFcG2sqrzpYh5Zoq3aptdYKY6oRpu/xWRG7rweF6UMESuBVgVvcPlB6ER0chr1MELGAsys9IBs/7/oGgThYfNqkjqJOedWt621EIekZd00V30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700658; c=relaxed/simple;
	bh=P6VcteePjsOc+z/jfh3BzQITL5eU0H0T4edf/3LxbtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHHmv5PGc1FBStzsk6lMqv1P0Rq52CDYtg1/Co8+dCJv/z+oNiJcunahdgPPOXpRB6Aai49qmAnW0dQt8z/xgXEfUrCQoPGyKrljrjUHZ19BGfosGmrlSvuqQ9lC0sRoWKOVXLeIIZtxOT3R1bDui2Bh/a+NDvzasXWVcEwaSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1DCF497;
	Tue,  6 Jan 2026 03:57:29 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EDBE3F5A1;
	Tue,  6 Jan 2026 03:57:34 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 06 Jan 2026 11:56:53 +0000
Subject: [PATCH v4 8/8] perf arm_spe: Improve SIMD flags setting
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-perf_support_arm_spev1-3-v4-8-bb2d143b3860@arm.com>
References: <20260106-perf_support_arm_spev1-3-v4-0-bb2d143b3860@arm.com>
In-Reply-To: <20260106-perf_support_arm_spev1-3-v4-0-bb2d143b3860@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767700634; l=3476;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=P6VcteePjsOc+z/jfh3BzQITL5eU0H0T4edf/3LxbtU=;
 b=BMN+L20Ua3YV27ClacmEvIKK9dEDIXf+gnCuecz3SXntbvjFIKGpPkFp/miYObBW5aQ/KC21Z
 QIrgqG6sIkGAzTchvWSoqmkrG/aQ+d7+CphD3TuyhSk2K+zCXrnEu0d
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Fill in ASE and SME operations for the SIMD arch field.

Also set the predicate flags for SVE and SME, but differences between
them: SME does not have a predicate flag, so the setting is based on
events. SVE provides a predicate flag to indicate whether the predicate
is disabled, which allows it to be distinguished into four cases: full
predicates, empty predicates, fully predicated, and disabled predicates.

After:

    perf report -s +simd
    ...
    0.06%     0.06%  sve-test  sve-test               [.] setz                                        [p] SVE
    0.06%     0.06%  sve-test  [kernel.kallsyms]      [k] do_raw_spin_lock
    0.06%     0.06%  sve-test  sve-test               [.] getz                                        [p] SVE
    0.06%     0.06%  sve-test  [kernel.kallsyms]      [k] timekeeping_advance
    0.06%     0.06%  sve-test  sve-test               [.] getz                                        [d] SVE
    0.06%     0.06%  sve-test  [kernel.kallsyms]      [k] update_load_avg
    0.06%     0.06%  sve-test  sve-test               [.] getz                                        [e] SVE
    0.05%     0.05%  sve-test  sve-test               [.] setz                                        [e] SVE
    0.05%     0.05%  sve-test  [kernel.kallsyms]      [k] update_curr
    0.05%     0.05%  sve-test  sve-test               [.] setz                                        [d] SVE
    0.05%     0.05%  sve-test  [kernel.kallsyms]      [k] do_raw_spin_unlock
    0.05%     0.05%  sve-test  [kernel.kallsyms]      [k] timekeeping_update_from_shadow.constprop.0
    0.05%     0.05%  sve-test  sve-test               [.] getz                                        [f] SVE
    0.05%     0.05%  sve-test  sve-test               [.] setz                                        [f] SVE

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8e9004213e163a46fcacecb4ee32e199a0ec50b2..0a20591d49e821357d3d9ac559874179f1d4f378 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -353,12 +353,26 @@ static struct simd_flags arm_spe__synth_simd_flags(const struct arm_spe_record *
 
 	if (record->op & ARM_SPE_OP_SVE)
 		simd_flags.arch |= SIMD_OP_FLAGS_ARCH_SVE;
-
-	if (record->type & ARM_SPE_SVE_PARTIAL_PRED)
-		simd_flags.pred |= SIMD_OP_FLAGS_PRED_PARTIAL;
-
-	if (record->type & ARM_SPE_SVE_EMPTY_PRED)
-		simd_flags.pred |= SIMD_OP_FLAGS_PRED_EMPTY;
+	else if (record->op & ARM_SPE_OP_SME)
+		simd_flags.arch |= SIMD_OP_FLAGS_ARCH_SME;
+	else if (record->op & (ARM_SPE_OP_ASE | ARM_SPE_OP_SIMD_FP))
+		simd_flags.arch |= SIMD_OP_FLAGS_ARCH_ASE;
+
+	if (record->op & ARM_SPE_OP_SVE) {
+		if (!(record->op & ARM_SPE_OP_PRED))
+			simd_flags.pred = SIMD_OP_FLAGS_PRED_DISABLED;
+		else if (record->type & ARM_SPE_SVE_PARTIAL_PRED)
+			simd_flags.pred = SIMD_OP_FLAGS_PRED_PARTIAL;
+		else if (record->type & ARM_SPE_SVE_EMPTY_PRED)
+			simd_flags.pred = SIMD_OP_FLAGS_PRED_EMPTY;
+		else
+			simd_flags.pred = SIMD_OP_FLAGS_PRED_FULL;
+	} else {
+		if (record->type & ARM_SPE_SVE_PARTIAL_PRED)
+			simd_flags.pred = SIMD_OP_FLAGS_PRED_PARTIAL;
+		else if (record->type & ARM_SPE_SVE_EMPTY_PRED)
+			simd_flags.pred = SIMD_OP_FLAGS_PRED_EMPTY;
+	}
 
 	return simd_flags;
 }

-- 
2.34.1

