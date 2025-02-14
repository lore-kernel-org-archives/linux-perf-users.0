Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF9265604;
	Fri, 14 Feb 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532018; cv=none; b=eBNV/mgDvXItxPT8iAOx0oLAB1hWEa4YoczgkLe01wTsKSODpTqNUO3VkOY0SfZTh4PJLxguk/Zg6CxWSj1LP39S11MWBaU+QWwQHVONFYkOLir30WwuCAxyVr2XRayw1J02wgSr/+qagE/S/SkA3rzSnKqtcwFc0ELboJ9s/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532018; c=relaxed/simple;
	bh=9K7NAi6iVE+XdBbUx+XrAHRuLWtxuxBc021UEXc4Mw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSMJdMdBdPTph3yECSEcfRwiaK/lyzSXn+E/pqVlAxl/QpBZtfqaplrPB8bat5z3uiqKwjy6f/MKF5efGjm9FHDoH2A2BlmnRL0ypN/ytlfenAijvHey1C2jhL7X3L1mVqmHkRpaYLAsyCwUGCbhSys1ar6dTlyf8A+SKxKEXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EDFD1596;
	Fri, 14 Feb 2025 03:20:36 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 833433F6A8;
	Fri, 14 Feb 2025 03:20:13 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 10/11] perf arm-spe: Add branch stack
Date: Fri, 14 Feb 2025 11:19:35 +0000
Message-Id: <20250214111936.15168-11-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214111936.15168-1-leo.yan@arm.com>
References: <20250214111936.15168-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although Arm SPE cannot generate continuous branch records, this commit
creates a branch stack with only one branch entry.  A single branch info
can be used for performance optimization.

A branch stack structure is dynamically allocated in the decode queue.
The branch stack and stack flags are synthesized based on branch types
and associated events.

After:

  # perf script --itrace=bl1 -F flags,addr,brstack

  jcc                   ffffc0fad9c6b214 0xffffc0fad9c6b234/0xffffc0fad9c6b214/P/-/-/7/COND/-
  jcc/miss,not_taken/   ffffc0fadaaebb30 0xffffc0fadaaebb2c/0xffffc0fadaaebb30/MN/-/-/7/COND/-
  jmp                   ffffc0fadaaea358 0xffffc0fadaaea5ec/0xffffc0fadaaea358/P/-/-/5//-
  jcc/not_taken/        ffffc0fadaae6494 0xffffc0fadaae6490/0xffffc0fadaae6494/PN/-/-/11/COND/-
  jcc/not_taken/            ffff7f83ab54 0xffff7f83ab50/0xffff7f83ab54/PN/-/-/13/COND/-
  jcc/not_taken/            ffff7f83ab08 0xffff7f83ab04/0xffff7f83ab08/PN/-/-/8/COND/-
  jcc                       ffff7f83aa80 0xffff7f83aa58/0xffff7f83aa80/P/-/-/10/COND/-
  jcc                       ffff7f9a45d0 0xffff7f9a43f0/0xffff7f9a45d0/P/-/-/29/COND/-
  jcc/not_taken/        ffffc0fad9ba6db4 0xffffc0fad9ba6db0/0xffffc0fad9ba6db4/PN/-/-/44/COND/-
  jcc                   ffffc0fadaac2964 0xffffc0fadaac2970/0xffffc0fadaac2964/P/-/-/6/COND/-
  jcc                   ffffc0fad99ddc10 0xffffc0fad99ddc04/0xffffc0fad99ddc10/P/-/-/72/COND/-
  jcc/not_taken/        ffffc0fad9b3f21c 0xffffc0fad9b3f218/0xffffc0fad9b3f21c/PN/-/-/64/COND/-
  jcc                   ffffc0fad9c3b604 0xffffc0fad9c3b5f8/0xffffc0fad9c3b604/P/-/-/13/COND/-
  jcc                   ffffc0fadaad6048 0xffffc0fadaad5f8c/0xffffc0fadaad6048/P/-/-/5/COND/-
  return/miss/              ffff7f84e614 0xffffc0fad98a2274/0xffff7f84e614/M/-/-/13/RET/-
  jcc/not_taken/        ffffc0fadaac4eb4 0xffffc0fadaac4eb0/0xffffc0fadaac4eb4/PN/-/-/5/COND/-
  jmp                       ffff7f8e3130 0xffff7f87555c/0xffff7f8e3130/P/-/-/5//-
  jcc/not_taken/        ffffc0fad9b3d9b0 0xffffc0fad9b3d9ac/0xffffc0fad9b3d9b0/PN/-/-/14/COND/-
  return                ffffc0fad9b91950 0xffffc0fad98c3e28/0xffffc0fad9b91950/P/-/-/12/RET/-

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 99 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index e41905a009bd..d576c60aecf7 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -101,6 +101,7 @@ struct arm_spe_queue {
 	struct thread			*thread;
 	u64				period_instructions;
 	u32				flags;
+	struct branch_stack		*last_branch;
 };
 
 struct data_source_handle {
@@ -231,6 +232,16 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
 	params.get_trace = arm_spe_get_trace;
 	params.data = speq;
 
+	if (spe->synth_opts.last_branch) {
+		size_t sz = sizeof(struct branch_stack);
+
+		/* Allocate one entry for TGT */
+		sz += sizeof(struct branch_entry);
+		speq->last_branch = zalloc(sz);
+		if (!speq->last_branch)
+			goto out_free;
+	}
+
 	/* create new decoder */
 	speq->decoder = arm_spe_decoder_new(&params);
 	if (!speq->decoder)
@@ -240,6 +251,7 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
 
 out_free:
 	zfree(&speq->event_buf);
+	zfree(&speq->last_branch);
 	free(speq);
 
 	return NULL;
@@ -346,6 +358,73 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	event->sample.header.size = sizeof(struct perf_event_header);
 }
 
+static void arm_spe__prep_branch_stack(struct arm_spe_queue *speq)
+{
+	struct arm_spe_record *record = &speq->decoder->record;
+	struct branch_stack *bstack = speq->last_branch;
+	struct branch_flags *bs_flags;
+	size_t sz = sizeof(struct branch_stack) +
+		    sizeof(struct branch_entry) /* TGT */;
+
+	/* Clean up branch stack */
+	memset(bstack, 0x0, sz);
+
+	if (!(speq->flags & PERF_IP_FLAG_BRANCH))
+		return;
+
+	bstack->entries[0].from = record->from_ip;
+	bstack->entries[0].to = record->to_ip;
+
+	bs_flags = &bstack->entries[0].flags;
+	bs_flags->value = 0;
+
+	if (record->op & ARM_SPE_OP_BR_CR_BL) {
+		if (record->op & ARM_SPE_OP_BR_COND)
+			bs_flags->type |= PERF_BR_COND_CALL;
+		else
+			bs_flags->type |= PERF_BR_CALL;
+	/*
+	 * Indirect branch instruction without link (e.g. BR),
+	 * take this case as function return.
+	 */
+	} else if (record->op & ARM_SPE_OP_BR_CR_RET ||
+		   record->op & ARM_SPE_OP_BR_INDIRECT) {
+		if (record->op & ARM_SPE_OP_BR_COND)
+			bs_flags->type |= PERF_BR_COND_RET;
+		else
+			bs_flags->type |= PERF_BR_RET;
+	} else if (record->op & ARM_SPE_OP_BR_CR_NON_BL_RET) {
+		if (record->op & ARM_SPE_OP_BR_COND)
+			bs_flags->type |= PERF_BR_COND;
+		else
+			bs_flags->type |= PERF_BR_UNCOND;
+	} else {
+		if (record->op & ARM_SPE_OP_BR_COND)
+			bs_flags->type |= PERF_BR_COND;
+		else
+			bs_flags->type |= PERF_BR_UNKNOWN;
+	}
+
+	if (record->type & ARM_SPE_BRANCH_MISS) {
+		bs_flags->mispred = 1;
+		bs_flags->predicted = 0;
+	} else {
+		bs_flags->mispred = 0;
+		bs_flags->predicted = 1;
+	}
+
+	if (record->type & ARM_SPE_BRANCH_NOT_TAKEN)
+		bs_flags->not_taken = 1;
+
+	if (record->type & ARM_SPE_IN_TXN)
+		bs_flags->in_tx = 1;
+
+	bs_flags->cycles = min(record->latency, 0xFFFFU);
+
+	bstack->nr = 1;
+	bstack->hw_idx = -1ULL;
+}
+
 static int arm_spe__inject_event(union perf_event *event, struct perf_sample *sample, u64 type)
 {
 	event->header.size = perf_event__sample_event_size(sample, type, 0);
@@ -414,6 +493,7 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	sample.addr = record->to_ip;
 	sample.weight = record->latency;
 	sample.flags = speq->flags;
+	sample.branch_stack = speq->last_branch;
 
 	ret = arm_spe_deliver_synth_event(spe, speq, event, &sample);
 	perf_sample__exit(&sample);
@@ -448,6 +528,7 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	sample.period = spe->instructions_sample_period;
 	sample.weight = record->latency;
 	sample.flags = speq->flags;
+	sample.branch_stack = speq->last_branch;
 
 	ret = arm_spe_deliver_synth_event(spe, speq, event, &sample);
 	perf_sample__exit(&sample);
@@ -781,6 +862,10 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 		}
 	}
 
+	if (spe->synth_opts.last_branch &&
+	    (spe->sample_branch || spe->sample_instructions))
+		arm_spe__prep_branch_stack(speq);
+
 	if (spe->sample_branch && (record->op & ARM_SPE_OP_BRANCH_ERET)) {
 		err = arm_spe__synth_branch_sample(speq, spe->branch_id);
 		if (err)
@@ -1272,6 +1357,7 @@ static void arm_spe_free_queue(void *priv)
 	thread__zput(speq->thread);
 	arm_spe_decoder_free(speq->decoder);
 	zfree(&speq->event_buf);
+	zfree(&speq->last_branch);
 	free(speq);
 }
 
@@ -1491,6 +1577,19 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		id += 1;
 	}
 
+	if (spe->synth_opts.last_branch) {
+		if (spe->synth_opts.last_branch_sz > 1)
+			pr_debug("Arm SPE supports only one bstack entry (TGT).\n");
+
+		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+		/*
+		 * We don't use the hardware index, but the sample generation
+		 * code uses the new format branch_stack with this field,
+		 * so the event attributes must indicate that it's present.
+		 */
+		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+	}
+
 	if (spe->synth_opts.branches) {
 		spe->sample_branch = true;
 
-- 
2.34.1

