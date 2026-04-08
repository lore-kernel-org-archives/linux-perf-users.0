Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4D3AD511
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641423; cv=none; b=bnDBXYeXsk3Q0G76NfV3mHqTQPARDRbmAiYdIUxwaLrCWHyXG/3wPT8WEoWvltdMOh/0XDayOkgC+D50iHqQA9kun6qxGZIlX7yYcAstqF9pSnBb/gYpUOZq8PpCtl47tGpD9lXUpMUNVhM4vxFnQekGyn2wE6siyBryF/QQ510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641423; c=relaxed/simple;
	bh=mIHRreF4FA7HVCoDiQrweeJgXjlFbqer2/TWKgSYjlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EzwnFE8PdE7Jm2sNCc53q5Br33mAzL3tulntQ/X9U2JNiJo0JaFG2eK8W+eBdD78xbfdBTbQfHFrXMpQGV4Xc2WAyUTEn3K1sONyJvsCZcadSGlowghMphtbSKaW+QRKUyWEYK04UvfC/6/Ib36dwVYt2XPaXNwt1/Xj2lK5bck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WaPB9nCP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WaPB9nCP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 997423594;
	Wed,  8 Apr 2026 02:43:31 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D33B63F641;
	Wed,  8 Apr 2026 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775641417; bh=mIHRreF4FA7HVCoDiQrweeJgXjlFbqer2/TWKgSYjlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WaPB9nCPpien+QXC0Y7LQeTa37ySfIa7NHVmZoORH9sC6wQb8vYq3ZARpzOyJKEub
	 E87GYvb48/cFX3i6Dl3dmCaHGNjSFFvYzdKzo2MU0XXuUEUtLyVit2tatWykE++ZwL
	 u9pnawLL/u9hs0jQWa76S4d9Vq+2WCSROsDy0ZqE=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 08 Apr 2026 10:42:34 +0100
Subject: [PATCH v5 4/4] perf arm_spe: Improve SIMD flags setting
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-perf_support_arm_spev1-3-v5-4-b5bcea6217bb@arm.com>
References: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
In-Reply-To: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775641408; l=3573;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=mIHRreF4FA7HVCoDiQrweeJgXjlFbqer2/TWKgSYjlo=;
 b=s9hSHiHCIZLZTG7yl0OfDwjTRbfJuW7r8i/jhzkRK6cBAc6cluheWwKPjHZCRtpyuVrxlbsPB
 2TXhYOtbo5lA+7IDb4GTeJHDaxVh2Qodt0GwVzcx3wvof1Fa7f9GCN+
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

