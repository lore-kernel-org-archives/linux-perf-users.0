Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB546AED1
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708962; cv=none; b=c+9p0ECPZzEy9Nnl3gv2Kiu7VQuKID4H3rQJd6Szdwr7rGxzsZ3RsEWRp8PxHWK2c28HNVvsJdmiQLwYCkSG3xY4M7di0huhku8fNQnFCAsCJveNBy7UtxfcckGeAt43jHGRqSnWdo5q05HrNim7tX0cij8kU7hW9MoUOnuims8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708962; c=relaxed/simple;
	bh=mTKq2ImBm2irHH3kAkru20kzzTQxdZeAoTGapAgUF24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2OxeKaOYOKi2OOaCRCPP32cS1N1OV9lAK4E7Z4U43857HK2FeaNsrhyQAbEsNGdQZTnhdM896eCWTSKi4tneSLBGB5EhIacAIdTAz9jHSgejnvwEJK2Qyo8ZYv1iepcdnq5G4yv5eqDI4TZqPk68ruL3UXGB147UsKwz8sCzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uytxvM8L; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uytxvM8L"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14D1B32AB;
	Wed, 17 Jun 2026 08:09:15 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4C213F915;
	Wed, 17 Jun 2026 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781708959; bh=mTKq2ImBm2irHH3kAkru20kzzTQxdZeAoTGapAgUF24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uytxvM8L6lUf6tNT6IZPS/PuYvTvgcn0mxLCVaZIcXLCdPiTDZYZJw6OUBNz8xhxS
	 k/BVf8KK3hHW3ddFmjTEpHpX1DdTgLxRDW6g1iXbEzjsxcNYcYOim40jqLqAHwg8vo
	 rPjelqUPTvCfsmbTxnqO2vA/qxhDeSeJmKQstaKA=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 17 Jun 2026 16:08:56 +0100
Subject: [PATCH v10 5/9] perf cs-etm: Use thread-stack for last branch
 entries
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-b4-arm_cs_callchain_support_v1-v10-5-e8b6e5d63db5@arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
In-Reply-To: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781708939; l=10773;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=mTKq2ImBm2irHH3kAkru20kzzTQxdZeAoTGapAgUF24=;
 b=1wTqzRVfVU9kj4HI0eCU55vu+PU7MQIevbt5yD4oT2PcWMoexvY7xol5GBcrJFGZAD5ihvQve
 rxJMSowXeE/AwUtVuHkXZBq03hVcFRmpnp8Txqk0QffW1XnrYJ4jlih
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

CS ETM maintains its own circular array for last branch entries, with
local helpers to update, copy and reset the branch stack. This
duplicates logic already provided by the common code.

Record taken branches with thread_stack__event() and synthesize
PERF_SAMPLE_BRANCH_STACK data with thread_stack__br_sample(). This
removes the private last_branch_rb buffer and its position tracking.

This also makes the branch history state belong to the thread rather
than the trace queue. That is a better fit for CoreSight traces where
a trace queue can effectively be CPU scoped, while call/return history
is per thread.

Keep the buffer number updated via thread_stack__set_trace_nr(), which
is used when exporting samples to Python scripts. Pass callstack=false
for now; synthesized callchains are added by a later patch.

The output should remain same, except that be->flags.predicted is no
longer set. Since CoreSight trace does not provide branch prediction
information, clearing the flag avoids confusion.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 173 ++++++++++++++++-------------------------------
 1 file changed, 58 insertions(+), 115 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 6827ef8871a8fc092500b93a8284d5d162558357..5ede0f0ff8c6ec3aa10545693eb914af2e7b5285 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -85,10 +85,9 @@ struct cs_etm_auxtrace {
 struct cs_etm_traceid_queue {
 	u8 trace_chan_id;
 	u64 period_instructions;
-	size_t last_branch_pos;
 	union perf_event *event_buf;
+	unsigned int br_stack_sz;
 	struct branch_stack *last_branch;
-	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
 	struct cs_etm_packet_queue packet_queue;
@@ -647,9 +646,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 		tidq->last_branch = zalloc(sz);
 		if (!tidq->last_branch)
 			goto out_free;
-		tidq->last_branch_rb = zalloc(sz);
-		if (!tidq->last_branch_rb)
-			goto out_free;
+
+		tidq->br_stack_sz = etm->synth_opts.last_branch_sz;
 	}
 
 	tidq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
@@ -659,7 +657,6 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	return 0;
 
 out_free:
-	zfree(&tidq->last_branch_rb);
 	zfree(&tidq->last_branch);
 	zfree(&tidq->prev_packet);
 	zfree(&tidq->packet);
@@ -944,7 +941,6 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		thread__zput(tidq->decode_thread);
 		zfree(&tidq->event_buf);
 		zfree(&tidq->last_branch);
-		zfree(&tidq->last_branch_rb);
 		zfree(&tidq->prev_packet);
 		zfree(&tidq->packet);
 		zfree(&tidq);
@@ -1304,57 +1300,6 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
 	return ret;
 }
 
-static inline
-void cs_etm__copy_last_branch_rb(struct cs_etm_queue *etmq,
-				 struct cs_etm_traceid_queue *tidq)
-{
-	struct branch_stack *bs_src = tidq->last_branch_rb;
-	struct branch_stack *bs_dst = tidq->last_branch;
-	size_t nr = 0;
-
-	/*
-	 * Set the number of records before early exit: ->nr is used to
-	 * determine how many branches to copy from ->entries.
-	 */
-	bs_dst->nr = bs_src->nr;
-
-	/*
-	 * Early exit when there is nothing to copy.
-	 */
-	if (!bs_src->nr)
-		return;
-
-	/*
-	 * As bs_src->entries is a circular buffer, we need to copy from it in
-	 * two steps.  First, copy the branches from the most recently inserted
-	 * branch ->last_branch_pos until the end of bs_src->entries buffer.
-	 */
-	nr = etmq->etm->synth_opts.last_branch_sz - tidq->last_branch_pos;
-	memcpy(&bs_dst->entries[0],
-	       &bs_src->entries[tidq->last_branch_pos],
-	       sizeof(struct branch_entry) * nr);
-
-	/*
-	 * If we wrapped around at least once, the branches from the beginning
-	 * of the bs_src->entries buffer and until the ->last_branch_pos element
-	 * are older valid branches: copy them over.  The total number of
-	 * branches copied over will be equal to the number of branches asked by
-	 * the user in last_branch_sz.
-	 */
-	if (bs_src->nr >= etmq->etm->synth_opts.last_branch_sz) {
-		memcpy(&bs_dst->entries[nr],
-		       &bs_src->entries[0],
-		       sizeof(struct branch_entry) * tidq->last_branch_pos);
-	}
-}
-
-static inline
-void cs_etm__reset_last_branch_rb(struct cs_etm_traceid_queue *tidq)
-{
-	tidq->last_branch_pos = 0;
-	tidq->last_branch_rb->nr = 0;
-}
-
 static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 					 struct cs_etm_traceid_queue *tidq,
 					 struct cs_etm_packet *packet, u64 addr)
@@ -1424,38 +1369,6 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 	return addr;
 }
 
-static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
-					  struct cs_etm_traceid_queue *tidq)
-{
-	struct branch_stack *bs = tidq->last_branch_rb;
-	struct branch_entry *be;
-
-	/*
-	 * The branches are recorded in a circular buffer in reverse
-	 * chronological order: we start recording from the last element of the
-	 * buffer down.  After writing the first element of the stack, move the
-	 * insert position back to the end of the buffer.
-	 */
-	if (!tidq->last_branch_pos)
-		tidq->last_branch_pos = etmq->etm->synth_opts.last_branch_sz;
-
-	tidq->last_branch_pos -= 1;
-
-	be       = &bs->entries[tidq->last_branch_pos];
-	be->from = cs_etm__last_executed_instr(tidq->prev_packet);
-	be->to	 = cs_etm__first_executed_instr(tidq->packet);
-	/* No support for mispredict */
-	be->flags.mispred = 0;
-	be->flags.predicted = 1;
-
-	/*
-	 * Increment bs->nr until reaching the number of last branches asked by
-	 * the user on the command line.
-	 */
-	if (bs->nr < etmq->etm->synth_opts.last_branch_sz)
-		bs->nr += 1;
-}
-
 static int cs_etm__inject_event(struct cs_etm_auxtrace *etm, union perf_event *event,
 			       struct perf_sample *sample, u64 type)
 {
@@ -1619,6 +1532,57 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
 		return etm->latest_kernel_timestamp;
 }
 
+static bool cs_etm__packet_has_taken_branch(struct cs_etm_packet *packet)
+{
+	if (packet->sample_type == CS_ETM_RANGE &&
+	    packet->last_instr_taken_branch)
+		return true;
+
+	return false;
+}
+
+static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
+				    struct cs_etm_traceid_queue *tidq)
+{
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	u64 from, to;
+	int size;
+
+	if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
+		return;
+
+	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
+		return;
+
+	if (etmq->etm->synth_opts.last_branch) {
+		from = cs_etm__last_executed_instr(tidq->prev_packet);
+		to = cs_etm__first_executed_instr(tidq->packet);
+
+		size = cs_etm__instr_size(etmq, tidq, tidq->prev_packet, from);
+
+		/* Enable callchain so thread stack entry can be allocated */
+		thread_stack__event(tidq->frontend_thread, tidq->prev_packet->cpu,
+				    tidq->prev_packet->flags, from, to, size,
+				    etmq->buffer->buffer_nr + 1, false,
+				    tidq->br_stack_sz, 0);
+	} else {
+		thread_stack__set_trace_nr(tidq->frontend_thread,
+					   tidq->prev_packet->cpu,
+					   etmq->buffer->buffer_nr + 1);
+	}
+}
+
+static void cs_etm__sample_branch_stack(struct cs_etm_auxtrace *etm,
+					struct cs_etm_traceid_queue *tidq,
+					struct perf_sample *sample)
+{
+	if (etm->synth_opts.last_branch) {
+		thread_stack__br_sample(tidq->frontend_thread, tidq->packet->cpu,
+					tidq->last_branch, tidq->br_stack_sz);
+		sample->branch_stack = tidq->last_branch;
+	}
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    struct cs_etm_packet *packet,
@@ -1648,9 +1612,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.cpumode = event->sample.header.misc;
 
 	cs_etm__copy_insn(etmq, tidq, packet, &sample);
-
-	if (etm->synth_opts.last_branch)
-		sample.branch_stack = tidq->last_branch;
+	cs_etm__sample_branch_stack(etm, tidq, &sample);
 
 	if (etm->synth_opts.inject) {
 		ret = cs_etm__inject_event(etm, event, &sample,
@@ -1841,14 +1803,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 
 	tidq->period_instructions += tidq->packet->instr_count;
 
-	/*
-	 * Record a branch when the last instruction in
-	 * PREV_PACKET is a branch.
-	 */
-	if (etm->synth_opts.last_branch &&
-	    tidq->prev_packet->sample_type == CS_ETM_RANGE &&
-	    tidq->prev_packet->last_instr_taken_branch)
-		cs_etm__update_last_branch_rb(etmq, tidq);
+	cs_etm__add_stack_event(etmq, tidq);
 
 	if (etm->synth_opts.instructions &&
 	    tidq->period_instructions >= etm->instructions_sample_period) {
@@ -1907,10 +1862,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		u64 offset = etm->instructions_sample_period - instrs_prev;
 		u64 addr;
 
-		/* Prepare last branches for instruction sample */
-		if (etm->synth_opts.last_branch)
-			cs_etm__copy_last_branch_rb(etmq, tidq);
-
 		while (tidq->period_instructions >=
 				etm->instructions_sample_period) {
 			/*
@@ -1941,8 +1892,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 			generate_sample = true;
 
 		/* Generate sample for branch taken packet */
-		if (tidq->prev_packet->sample_type == CS_ETM_RANGE &&
-		    tidq->prev_packet->last_instr_taken_branch)
+		if (cs_etm__packet_has_taken_branch(tidq->prev_packet))
 			generate_sample = true;
 
 		if (generate_sample) {
@@ -1990,10 +1940,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 	    etmq->etm->synth_opts.instructions &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
 		u64 addr;
-
-		/* Prepare last branches for instruction sample */
-		cs_etm__copy_last_branch_rb(etmq, tidq);
-
 		/*
 		 * Generate a last branch event for the branches left in the
 		 * circular buffer at the end of the trace.
@@ -2025,7 +1971,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
 	/* Reset last branches after flush the trace */
 	if (etm->synth_opts.last_branch)
-		cs_etm__reset_last_branch_rb(tidq);
+		thread_stack__flush(tidq->frontend_thread);
 
 	return err;
 }
@@ -2049,9 +1995,6 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
 		u64 addr;
 
-		/* Prepare last branches for instruction sample */
-		cs_etm__copy_last_branch_rb(etmq, tidq);
-
 		/*
 		 * Use the address of the end of the last reported execution
 		 * range.

-- 
2.34.1

