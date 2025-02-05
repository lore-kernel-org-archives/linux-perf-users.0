Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A9822F397;
	Wed,  5 Feb 2025 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757801; cv=none; b=LHYM20n9iDGooOuTB9TC/Z2zhWhwpjCUhnjEpOZbTHgGQczRWyultPnkwDW25p0Z0+IMN49FmNiS5ogFg3a0Nh87SFyBczvhrykCQVIJKzIZ8X7z0CSsf1lU4bZDinNtPijgzQnVKMN3y5yRrh7u5d41+o3/hGkD5cRlPoMUOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757801; c=relaxed/simple;
	bh=uuMSNaBC9AotIkZWkOOsuQNqWhUw727k6l4k9GoefF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7N8RWAX16LsQTEajgv0KW6cXc1RoAryIV0Rft1/jP+4SaD6cv2dlXzrlmtQQdS2fG60HoKjsBIDNdWmxeKxtwqo9ecwES7ohiLTUGDb51De28qKPQgt2g1FzAaT/S3FdnNuxdo3fvVvCnHv+rzGPbGnQR5CtaOZ9Ue/Hqd4LaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CFB01007;
	Wed,  5 Feb 2025 04:17:03 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 450803F63F;
	Wed,  5 Feb 2025 04:16:37 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Graham Woodward <graham.woodward@arm.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 11/11] perf arm-spe: Support previous branch target (PBT) address
Date: Wed,  5 Feb 2025 12:15:55 +0000
Message-Id: <20250205121555.180606-12-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205121555.180606-1-leo.yan@arm.com>
References: <20250205121555.180606-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When FEAT_SPE_PBT is implemented, the previous branch target address
(named as PBT) before the sampled operation, will be recorded.

This commit first introduces a 'prev_br_tgt' field in the record for
saving the PBT address in the decoder.

If the current operation is a branch instruction, by combining with PBT,
it can create a chain with two consecutive branches.  As the branch
stack stores branches in descending order, meaning a newer branch is
stored in a lower entry in the stack.  Arm SPE stores the latest branch
in the first entry of branch stack, and the previous branch coming from
PBT is stored into the second entry.

Otherwise, if current operation is not a branch, the last branch will be
saved for PBT only.  PBT lacks associated information such as branch
source address, branch type, and events.  The branch entry fills zeros
for the corresponding fields and only set its target address.

After:

  perf script -f --itrace=bl -F flags,addr,brstack
  jcc/not_taken/        ff00000000000000 0xffff80008141e920/0xff00000000000000/PN/-/-/1/COND/- 0x0/0xffff8000803607d8/-/-/-/0//-
  jcc                   ffff800080187914 0xffff8000801878fc/0xffff800080187914/P/-/-/1/COND/-  0x0/0xffff8000801878f8/-/-/-/0//-
  jcc                   ffff8000802d12d8 0xffff8000802d12f8/0xffff8000802d12d8/P/-/-/1/COND/-  0x0/0xffff8000802d12ec/-/-/-/0//-
  jcc                   ffff8000813fe200 0xffff8000813fe20c/0xffff8000813fe200/P/-/-/1/COND/-  0x0/0xffff8000813fe200/-/-/-/0//-
  jcc                   ffff8000813fe200 0xffff8000813fe20c/0xffff8000813fe200/P/-/-/1/COND/-  0x0/0xffff8000813fe200/-/-/-/0//-
  jmp                   ffff800081410980 0xffff800081419108/0xffff800081410980/P/-/-/1//-  0x0/0xffff800081419104/-/-/-/0//-
  return                ffff80008036e064 0xffff80008141ba84/0xffff80008036e064/P/-/-/1/RET/-  0x0/0xffff80008141ba60/-/-/-/0//-
  jcc                   ffff8000803d54f0 0xffff8000803d54e8/0xffff8000803d54f0/P/-/-/1/COND/-  0x0/0xffff8000803d54e0/-/-/-/0//-
  jmp                   ffff80008015e468 0xffff8000803d46dc/0xffff80008015e468/P/-/-/1//-  0x0/0xffff8000803d46c8/-/-/-/0//-
  jmp                   ffff8000806e2d50 0xffff80008040f710/0xffff8000806e2d50/P/-/-/1//-  0x0/0xffff80008040f6e8/-/-/-/0//-
  jcc                   ffff800080721704 0xffff8000807216b4/0xffff800080721704/P/-/-/1/COND/-  0x0/0xffff8000807216ac/-/-/-/0//-

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    |   5 +-
 .../util/arm-spe-decoder/arm-spe-decoder.h    |   1 +
 tools/perf/util/arm-spe.c                     | 114 ++++++++++--------
 3 files changed, 70 insertions(+), 50 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 52bd0a4ea96d..688fe6d75244 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -28,7 +28,8 @@ static u64 arm_spe_calc_ip(int index, u64 payload)
 
 	/* Instruction virtual address or Branch target address */
 	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
-	    index == SPE_ADDR_PKT_HDR_INDEX_BRANCH) {
+	    index == SPE_ADDR_PKT_HDR_INDEX_BRANCH ||
+	    index == SPE_ADDR_PKT_HDR_INDEX_PREV_BRANCH) {
 		ns = SPE_ADDR_PKT_GET_NS(payload);
 		el = SPE_ADDR_PKT_GET_EL(payload);
 
@@ -181,6 +182,8 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 				decoder->record.virt_addr = ip;
 			else if (idx == SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS)
 				decoder->record.phys_addr = ip;
+			else if (idx == SPE_ADDR_PKT_HDR_INDEX_PREV_BRANCH)
+				decoder->record.prev_br_tgt = ip;
 			break;
 		case ARM_SPE_COUNTER:
 			if (idx == SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT)
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 85b688a97436..5d232188643b 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -89,6 +89,7 @@ struct arm_spe_record {
 	u32 latency;
 	u64 from_ip;
 	u64 to_ip;
+	u64 prev_br_tgt;
 	u64 timestamp;
 	u64 virt_addr;
 	u64 phys_addr;
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index c0176de6a51b..b4a2bc349b54 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -235,8 +235,9 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
 	if (spe->synth_opts.last_branch) {
 		size_t sz = sizeof(struct branch_stack);
 
-		/* Allocate one entry for TGT */
-		sz += sizeof(struct branch_entry);
+		/* Allocate up to two entries for PBT + TGT */
+		sz += sizeof(struct branch_entry) *
+			min(spe->synth_opts.last_branch_sz, 2U);
 		speq->last_branch = zalloc(sz);
 		if (!speq->last_branch)
 			goto out_free;
@@ -360,68 +361,83 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 
 static void arm_spe__prep_branch_stack(struct arm_spe_queue *speq)
 {
+	struct arm_spe *spe = speq->spe;
 	struct arm_spe_record *record = &speq->decoder->record;
 	struct branch_stack *bstack = speq->last_branch;
 	struct branch_flags *bs_flags;
+	unsigned int last_branch_sz = spe->synth_opts.last_branch_sz;
+	bool have_tgt = !!(speq->flags & PERF_IP_FLAG_BRANCH);
+	bool have_pbt = last_branch_sz >= (have_tgt + 1U) && record->prev_br_tgt;
 	size_t sz = sizeof(struct branch_stack) +
-		    sizeof(struct branch_entry) /* TGT */;
+		    sizeof(struct branch_entry) * min(last_branch_sz, 2U) /* PBT + TGT */;
+	int i = 0;
 
 	/* Clean up branch stack */
 	memset(bstack, 0x0, sz);
 
-	if (!(speq->flags & PERF_IP_FLAG_BRANCH))
+	if (!have_tgt && !have_pbt)
 		return;
 
-	bstack->entries[0].from = record->from_ip;
-	bstack->entries[0].to = record->to_ip;
+	if (have_tgt) {
+		bstack->entries[i].from = record->from_ip;
+		bstack->entries[i].to = record->to_ip;
 
-	bs_flags = &bstack->entries[0].flags;
-	bs_flags->value = 0;
+		bs_flags = &bstack->entries[i].flags;
+		bs_flags->value = 0;
 
-	if (record->op & ARM_SPE_OP_BR_CR_BL) {
-		if (record->op & ARM_SPE_OP_BR_COND)
-			bs_flags->type |= PERF_BR_COND_CALL;
-		else
-			bs_flags->type |= PERF_BR_CALL;
-	/*
-	 * Indirect branch instruction without link (e.g. BR),
-	 * take this case as function return.
-	 */
-	} else if (record->op & ARM_SPE_OP_BR_CR_RET ||
-		   record->op & ARM_SPE_OP_BR_INDIRECT) {
-		if (record->op & ARM_SPE_OP_BR_COND)
-			bs_flags->type |= PERF_BR_COND_RET;
-		else
-			bs_flags->type |= PERF_BR_RET;
-	} else if (record->op & ARM_SPE_OP_BR_CR_NON_BL_RET) {
-		if (record->op & ARM_SPE_OP_BR_COND)
-			bs_flags->type |= PERF_BR_COND;
-		else
-			bs_flags->type |= PERF_BR_UNCOND;
-	} else {
-		if (record->op & ARM_SPE_OP_BR_COND)
-			bs_flags->type |= PERF_BR_COND;
-		else
-			bs_flags->type |= PERF_BR_UNKNOWN;
-	}
+		if (record->op & ARM_SPE_OP_BR_CR_BL) {
+			if (record->op & ARM_SPE_OP_BR_COND)
+				bs_flags->type |= PERF_BR_COND_CALL;
+			else
+				bs_flags->type |= PERF_BR_CALL;
+		/*
+		 * Indirect branch instruction without link (e.g. BR),
+		 * take this case as function return.
+		 */
+		} else if (record->op & ARM_SPE_OP_BR_CR_RET ||
+			   record->op & ARM_SPE_OP_BR_INDIRECT) {
+			if (record->op & ARM_SPE_OP_BR_COND)
+				bs_flags->type |= PERF_BR_COND_RET;
+			else
+				bs_flags->type |= PERF_BR_RET;
+		} else if (record->op & ARM_SPE_OP_BR_CR_NON_BL_RET) {
+			if (record->op & ARM_SPE_OP_BR_COND)
+				bs_flags->type |= PERF_BR_COND;
+			else
+				bs_flags->type |= PERF_BR_UNCOND;
+		} else {
+			if (record->op & ARM_SPE_OP_BR_COND)
+				bs_flags->type |= PERF_BR_COND;
+			else
+				bs_flags->type |= PERF_BR_UNKNOWN;
+		}
 
-	if (record->type & ARM_SPE_BRANCH_MISS) {
-		bs_flags->mispred = 1;
-		bs_flags->predicted = 0;
-	} else {
-		bs_flags->mispred = 0;
-		bs_flags->predicted = 1;
-	}
+		if (record->type & ARM_SPE_BRANCH_MISS) {
+			bs_flags->mispred = 1;
+			bs_flags->predicted = 0;
+		} else {
+			bs_flags->mispred = 0;
+			bs_flags->predicted = 1;
+		}
+
+		if (record->type & ARM_SPE_BRANCH_NOT_TAKEN)
+			bs_flags->not_taken = 1;
 
-	if (record->type & ARM_SPE_BRANCH_NOT_TAKEN)
-		bs_flags->not_taken = 1;
+		if (record->type & ARM_SPE_IN_TXN)
+			bs_flags->in_tx = 1;
 
-	if (record->type & ARM_SPE_IN_TXN)
-		bs_flags->in_tx = 1;
+		bs_flags->cycles = min(record->latency, 0xFFFFU);
+		i++;
+	}
 
-	bs_flags->cycles = min(record->latency, 0xFFFFU);
+	if (have_pbt) {
+		bs_flags = &bstack->entries[i].flags;
+		bs_flags->type |= PERF_BR_UNKNOWN;
+		bstack->entries[i].to = record->prev_br_tgt;
+		i++;
+	}
 
-	bstack->nr = 1;
+	bstack->nr = i;
 	bstack->hw_idx = -1ULL;
 }
 
@@ -1566,8 +1582,8 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	}
 
 	if (spe->synth_opts.last_branch) {
-		if (spe->synth_opts.last_branch_sz > 1)
-			pr_debug("Arm SPE supports only one bstack entry (TGT).\n");
+		if (spe->synth_opts.last_branch_sz > 2)
+			pr_debug("Arm SPE supports only two bstack entries (PBT+TGT).\n");
 
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
 		/*
-- 
2.34.1

