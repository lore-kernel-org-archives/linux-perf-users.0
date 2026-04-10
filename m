Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DCD387591
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806635; cv=none; b=Hr+3l3JeDK4NefWtIarK0JLpo5LWeT/9iBkzp2X1tieTI+9iESlt+U+CsooTFUr9GrRV07kCvJ2XyrhPDJFfppx/f9T1sF6z1WtK5J1WEhSufsx/SyLOxspLDHufrj31mqDqNiWcv4AJ7WXEbrW0YsVAhiHUkdHKs7go8t2KKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806635; c=relaxed/simple;
	bh=mIHRreF4FA7HVCoDiQrweeJgXjlFbqer2/TWKgSYjlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O33oDhijwgddpakLdHdfmzsQsd/WhDTVpf96GLOY87YelUV+3EgpqnON3AgV+uo/VgXUMWvw6LC+aHCApJjg+QQ6uhM40XTKn/tkODKoxOnLlYhmARiQWODMy8YBTawSIG9bokGvuBAD4P+aeUo5iOmmR+/qVz+zOV1PWcJFSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Yd/e4WEO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Yd/e4WEO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FDB01CE2;
	Fri, 10 Apr 2026 00:37:08 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3E6D3FAF5;
	Fri, 10 Apr 2026 00:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775806634; bh=mIHRreF4FA7HVCoDiQrweeJgXjlFbqer2/TWKgSYjlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yd/e4WEOTRbuEi/h5NIw2xmRUDLu9CHxv25Gf4s/5bHgjIott0gcRMOXuYSU+Z9Z3
	 KuRfd7iG+whMVocTfPiQ851XYejgpTtYChBa/nLLbr+aXJ8Y887vh/aSgkx9rGGceX
	 EkQi43hOL+AXODcFNyiqSzizSRpWjjfm8SkPr/Ys=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 10 Apr 2026 08:37:01 +0100
Subject: [PATCH v6 4/4] perf arm_spe: Improve SIMD flags setting
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-perf_support_arm_spev1-3-v6-4-3c6f2dfe2cd3@arm.com>
References: <20260410-perf_support_arm_spev1-3-v6-0-3c6f2dfe2cd3@arm.com>
In-Reply-To: <20260410-perf_support_arm_spev1-3-v6-0-3c6f2dfe2cd3@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775806625; l=3573;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=mIHRreF4FA7HVCoDiQrweeJgXjlFbqer2/TWKgSYjlo=;
 b=TZi+uFUeUNpLL6YyPgGawzNDxBZjwMg1fzrNRcmaXPrOud/sxDluYV8eeVG0nsrgsVfOZoo2I
 alKpKs/ngyqCRv/5/lYqu7jotpeKY5R7i8BK05y9F6x7PJo9uE9Oze+
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

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 70dd9bee47c755f19a51b80c6df3499180de9540..e5835042acdf7685f95e19665cd45f97ed868275 100644
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

