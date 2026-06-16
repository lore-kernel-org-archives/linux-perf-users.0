Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F04333067C
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621504; cv=none; b=dbKhlyyOFB/vW/VQqshQpAbTd0nTtK9tMfBX2CSn5BhRhymr+xkT3n7AjndVCpj7tjSjQmaALkQPnzmDyyxj3EzeYrtvVwn5J3nlJqc/K+4uoDy0NEvBvhAj73pP73ZIzFN/gu3STAJ9Z/BA6aKHkFhzOikMKGEvPKRBtICLl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621504; c=relaxed/simple;
	bh=FnO0LO32mW2LD8CVKYHvGMuOnbbBs+tCZMcMEvZvcX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SdF5wSImJHgB5t0LHTFWIuo0ej90wc3wRnd1OkCrHfb9fSqqEl267MVHpheyOZ5b7C5QNGVRjICXJjfGcf7xPggwMc96HPoU9hoh6Z4ZoVaZGEkomt/ef7f+cDRv75PtJAqniC11+3PWmN9WZ7z0aam9oXEuzVQ0cwx6gWY6ZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ABH+VR6+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ABH+VR6+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD2941FC7;
	Tue, 16 Jun 2026 07:51:36 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A13473F915;
	Tue, 16 Jun 2026 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781621501; bh=FnO0LO32mW2LD8CVKYHvGMuOnbbBs+tCZMcMEvZvcX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ABH+VR6+bvmyoLoj69osYlerqmUIpL7X4Rn34FgsJqvyUTcwPyi+2LSTHcZkIDl8D
	 JvRdHdP6IhHD6x8LikLS5SzThVDURHuhsmoUvDLNUVx96jbDpSNrmCSSKEiGCye98P
	 bxmpd1putglbaGuioHYm33USRvnIfUrLOTh8oGIc=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 16 Jun 2026 15:51:13 +0100
Subject: [PATCH v9 5/9] perf cs-etm: Use thread-stack for last branch
 entries
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-b4-arm_cs_callchain_support_v1-v9-5-f8fad931c413@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781621481; l=10470;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=FnO0LO32mW2LD8CVKYHvGMuOnbbBs+tCZMcMEvZvcX0=;
 b=lzUyy5iu7xF8oYYK/ERgEGIKwyaj5eSGwxv20ocu5/EP0q2gupF6WUxkH6mPSRXTIfDiS0ZBJ
 IhD5MxN8DrEACESixU6qIfnDw4dT7+miJf/AOhKCfgTOwGVZEbLxEtH
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
 tools/perf/util/cs-etm.c | 163 +++++++++++++++--------------------------------
 1 file changed, 50 insertions(+), 113 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 6827ef8871a8fc092500b93a8284d5d162558357..51b05a0bc1898128ad66d82bef6e09b5c853463c 100644
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
@@ -1619,6 +1532,46 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
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
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    struct cs_etm_packet *packet,
@@ -1649,8 +1602,11 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	cs_etm__copy_insn(etmq, tidq, packet, &sample);
 
-	if (etm->synth_opts.last_branch)
+	if (etm->synth_opts.last_branch) {
+		thread_stack__br_sample(tidq->frontend_thread, tidq->packet->cpu,
+					tidq->last_branch, tidq->br_stack_sz);
 		sample.branch_stack = tidq->last_branch;
+	}
 
 	if (etm->synth_opts.inject) {
 		ret = cs_etm__inject_event(etm, event, &sample,
@@ -1841,14 +1797,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 
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
@@ -1907,10 +1856,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		u64 offset = etm->instructions_sample_period - instrs_prev;
 		u64 addr;
 
-		/* Prepare last branches for instruction sample */
-		if (etm->synth_opts.last_branch)
-			cs_etm__copy_last_branch_rb(etmq, tidq);
-
 		while (tidq->period_instructions >=
 				etm->instructions_sample_period) {
 			/*
@@ -1941,8 +1886,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 			generate_sample = true;
 
 		/* Generate sample for branch taken packet */
-		if (tidq->prev_packet->sample_type == CS_ETM_RANGE &&
-		    tidq->prev_packet->last_instr_taken_branch)
+		if (cs_etm__packet_has_taken_branch(tidq->prev_packet))
 			generate_sample = true;
 
 		if (generate_sample) {
@@ -1990,10 +1934,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
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
@@ -2025,7 +1965,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
 	/* Reset last branches after flush the trace */
 	if (etm->synth_opts.last_branch)
-		cs_etm__reset_last_branch_rb(tidq);
+		thread_stack__flush(tidq->frontend_thread);
 
 	return err;
 }
@@ -2049,9 +1989,6 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
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

