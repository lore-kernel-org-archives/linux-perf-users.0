Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD3E3A963A
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814836; cv=none; b=H1VJwe8hv9QqQeGyv/ad2m3KAm8tJ1aYaJ96qobDS5Gq0YRLcJUHBEhTbjzFd1a1333MTYz37yDPs1IdReJSSYRMpC0wZ6we7Xa6XY3gWQg+uZIkgCKKioM7vQAOK9Ksg3ZG3LEuOCn5mgF/P57ZXsH57M8Qr57E7ec0KtXetCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814836; c=relaxed/simple;
	bh=qqJoGoub9p0YkSbtpT0PewaEcBbGGz+gl5DZZ31iOZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPG/7MuSrl6Lcqp/dAQRf8Moege47WtVC2P9FHB0WTQG7bo+SKRO1h4f7uF7lnch4O2TB9SXayerE0VYQWYjcAoG4ml3SwmcIZXEqsN6HVhNwBkk7FLMIAQOUHYcYnP36Z9uJrrmzyW4tBkHPykUIWDYAk2UOgEg0OwUFtUrW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ftWkrq8B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ftWkrq8B"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D15316F2;
	Tue, 26 May 2026 10:00:28 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39F6F3F7B4;
	Tue, 26 May 2026 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779814833; bh=qqJoGoub9p0YkSbtpT0PewaEcBbGGz+gl5DZZ31iOZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ftWkrq8BmbpCDottUdXk4xV43ICUKWJO3Lx9pS6BNpvOkCkFnqM6pYmOZPfjS6Kc1
	 ZnAK2MStPoCt0dyQaZrkbGdrwtclBA/U0YfEnq+n+MxoyoGhVN1KaF8J9r7N31KJHQ
	 W5dctTkEZYShdhWSFN1xOh4Yf8CV9rg33xtCKrNw=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 26 May 2026 17:59:39 +0100
Subject: [PATCH v6 3/8] perf cs-etm: Use thread-stack for last branch
 entries
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-arm_cs_callchain_support_v1-v6-3-f9f49f53c9dd@arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
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
 linux-perf-users@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779814822; l=9539;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=qqJoGoub9p0YkSbtpT0PewaEcBbGGz+gl5DZZ31iOZI=;
 b=xPAaOGvwTYzy80vwMs7jYy+Zp2ZWmGykiYgKhmoJs2QfaSY4MwSTV3heFvk81+ytzqdEa2OQY
 W0vyNp0HR45BgIEonqnyD2ywy5xJ2CzVYeKtcmiUFy0I6W5togjuyvw
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

CS ETM maintains its own circular array for last branch entries, with
local helpers to update, copy and reset the branch stack. This duplicates
logic already provided by the common code.

Record branch with thread_stack__event() and synthesize branch stack
with thread_stack__br_sample(). This removes the local last_branch_rb
buffer and position tracking. Keep the buffer number updated via
thread_stack__set_trace_nr(), which is used when exporting samples to
Python scripts.

The output should remain same, except that be->flags.predicted is no
longer set. Since CoreSight trace does not provide branch prediction
information, clearing the flag avoids confusion.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 152 +++++++++++++----------------------------------
 1 file changed, 41 insertions(+), 111 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5bff8811d61e423463b7bd4e20d599d5b5307a1a..398ab3b7a429d402cc8e5f6cccb35c0b7c253732 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -83,14 +83,13 @@ struct cs_etm_auxtrace {
 struct cs_etm_traceid_queue {
 	u8 trace_chan_id;
 	u64 period_instructions;
-	size_t last_branch_pos;
 	union perf_event *event_buf;
 	struct thread *thread;
 	struct thread *prev_packet_thread;
 	ocsd_ex_level prev_packet_el;
 	ocsd_ex_level el;
+	unsigned int br_stack_sz;
 	struct branch_stack *last_branch;
-	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
 	struct cs_etm_packet_queue packet_queue;
@@ -635,9 +634,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
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
@@ -647,7 +645,6 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	return 0;
 
 out_free:
-	zfree(&tidq->last_branch_rb);
 	zfree(&tidq->last_branch);
 	zfree(&tidq->prev_packet);
 	zfree(&tidq->packet);
@@ -941,7 +938,6 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		thread__zput(tidq->prev_packet_thread);
 		zfree(&tidq->event_buf);
 		zfree(&tidq->last_branch);
-		zfree(&tidq->last_branch_rb);
 		zfree(&tidq->prev_packet);
 		zfree(&tidq->packet);
 		zfree(&tidq);
@@ -1281,57 +1277,6 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
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
 					 u8 trace_chan_id, u64 addr)
 {
@@ -1400,38 +1345,6 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
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
@@ -1579,6 +1492,37 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
 		return etm->latest_kernel_timestamp;
 }
 
+static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
+				    struct cs_etm_traceid_queue *tidq)
+{
+	u64 from, to;
+	int size;
+
+	if (!tidq->prev_packet->last_instr_taken_branch)
+		return;
+
+	if (tidq->prev_packet->sample_type != CS_ETM_RANGE ||
+	    tidq->packet->sample_type != CS_ETM_RANGE)
+		return;
+
+	if (etmq->etm->synth_opts.last_branch) {
+		from = cs_etm__last_executed_instr(tidq->prev_packet);
+		to = cs_etm__first_executed_instr(tidq->packet);
+
+		size = cs_etm__instr_size(etmq, tidq->trace_chan_id,
+					  tidq->prev_packet->isa, from);
+
+		/* Enable callchain so thread stack entry can be allocated */
+		thread_stack__event(tidq->thread, tidq->prev_packet->cpu,
+				    tidq->prev_packet->flags, from, to, size,
+				    etmq->buffer->buffer_nr + 1, true,
+				    tidq->br_stack_sz, 0);
+	} else {
+		thread_stack__set_trace_nr(tidq->thread, tidq->prev_packet->cpu,
+					   etmq->buffer->buffer_nr + 1);
+	}
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1608,8 +1552,12 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
 
-	if (etm->synth_opts.last_branch)
+	if (etm->synth_opts.last_branch) {
+		thread_stack__br_sample(tidq->thread, tidq->packet->cpu,
+					tidq->last_branch,
+					tidq->br_stack_sz);
 		sample.branch_stack = tidq->last_branch;
+	}
 
 	if (etm->synth_opts.inject) {
 		ret = cs_etm__inject_event(etm, event, &sample,
@@ -1798,14 +1746,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 
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
@@ -1864,10 +1805,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		u64 offset = etm->instructions_sample_period - instrs_prev;
 		u64 addr;
 
-		/* Prepare last branches for instruction sample */
-		if (etm->synth_opts.last_branch)
-			cs_etm__copy_last_branch_rb(etmq, tidq);
-
 		while (tidq->period_instructions >=
 				etm->instructions_sample_period) {
 			/*
@@ -1947,10 +1884,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
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
@@ -1982,7 +1915,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
 	/* Reset last branches after flush the trace */
 	if (etm->synth_opts.last_branch)
-		cs_etm__reset_last_branch_rb(tidq);
+		thread_stack__flush(tidq->thread);
 
 	return err;
 }
@@ -2006,9 +1939,6 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
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

