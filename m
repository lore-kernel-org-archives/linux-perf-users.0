Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237D3DEACC
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794104; cv=none; b=EeVQXlMUfazBgZXJfYPPHl1r05FhF7cwhgPz/6qRt4oEp+KxAPHbfMXRsOPdmnCffl23CKXl9AjVR94NX1eMQXH7OejJAG7GXM8DB7e4Bz0og1ok3z2LD/kIDgWcuPCe6vMg36tJ48mZMk1ILPUa1ja10zHrc5ILQpWoscRJHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794104; c=relaxed/simple;
	bh=sEqYCxwjU2V4GJiG7J3k6zErBVJ9R+Ysk7ePY/i1lXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nubNy1OtoWHRNIdyRQfLOMLhnyIH4iz47rii7rFVIrWAxLJ/04MG2R/gQLugiaGRM92xA/aUq/Q4t7J2xDLdO2RfP327lHuXkaQxWjMitC1+nyZCoM+H3PTHu7K+GEpZ92J9SIDlqOdXUkXmBlUKKzv1DXoWWGGXrIpzLOnJr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3puEqac; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3puEqac"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45e8a834cc2so5874968f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 04:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779794100; x=1780398900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUQ9aH6Hr11xQQK3fkMvBqfcxTYIu1DuJ1KpZwF6rS8=;
        b=m3puEqacDS5qu5YKw3aFjHWw9XLSmiwCRao4CPbCugBfGE3YSzixxoNQdCQ/s06Nk+
         uTVnFPVxqtP9GApp66namFjz/eK2Gvc7I3A0at3s7wcx4p7ZlbVeHJFyJaYhdhnnln5L
         kowWqzIXILOh3vL7JuoXeM2UicgfXcqzrvVX8anYByBgLQfGuKft3xp27PWN3OE7KW2W
         ukB/nmnc2IJbZ0ILQLZEtYcSEzzyszqqo07uc5M6FhSYJtUrpxkSA1d6u4Zin7DFVNEY
         nI2onZtc6UPBqsjdiqoWfGqjix0C4hurvGevs5+MmDKQwYnyiGYKDY3JBneOVcqZcS33
         UQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794100; x=1780398900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EUQ9aH6Hr11xQQK3fkMvBqfcxTYIu1DuJ1KpZwF6rS8=;
        b=s43V3ojBU4oN1eWUhAA5g+nHYTbQo7ELNAfXdJWay6oI8B1+hgn1qNsCJM2CSyIZa/
         qxo+gtoLYiD4nfRWmq7eQJFpP7W9zGtiArPp4mqaRj6b/n2OwEsxJvj8/+gxmoa2dhJ2
         iXaZvrTdnqat2eYvTcqcNrd+QdTs3dQ8ouKNGu5tMq6yvpLXEfzT2PQkgoXPDG+68aLP
         7uRoyw8mUsjzfcpXrNz6/1qYVYPixxoRqqEykQzTwFXVTZcTSyJKsCgpXK7RCKuhMoY5
         8rVuuNwGwn0by1nB+dxEqH+PIYuznOEcvrMXT3+WVn09Z6ho039lbnNqMj1eSDk/hLv8
         +KAA==
X-Forwarded-Encrypted: i=1; AFNElJ+v80olWJ9sTMUUjIXxIaRRQ1DznjtWdaXAJHXXijSdGs8ElgC5XO1XX7zccE+ab8wfl2xh1AaQO0EGCfEZ00Cl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoux4i7rgp1RuVoRnSpR89BEEwMEJFInZCMxm56GAqRMShqCne
	Jt87/BHzsjCogqka35jSFBc3BgdpNHjJU5pcMs3FJBp4U2Gs3GeUY0fEXVEUFcL7uE4=
X-Gm-Gg: Acq92OHTNjdrf6BhEFPkElerY11IBq/r1F/nw7sH7yDMkshZFdcbEhNDJL0hCpDJ0gP
	pyck0YDE2NSvGVw8zk0ckIPHErcH3aBrDwCKgaB1khHNbyMBGzUX7DojrhBiRJgqqdJLHcEsY3E
	fAJI+Z1o3FWj2wcP+LjZkAAHsmJCVZ6NnYjAxvY8N5uFiBwjF0W5GX1DD4sqzeV/4/VOxZpwtRU
	UNII4sxdSx44muhHcS6HZ5f5lKEYnCKjN4RK1lfNqtCJWFx1m5e8hQ25Id8jvYrstoXRLbO1vb0
	wkbbCYoDAYV9EkWR6Xelt9nk4+e6XMia5sKiMTGsFAxwlecnGYluZu8Ek2u0RZDnv18kDLHEm43
	4YkAkcCdpXanf0z9V+NQHKN0ZTbg8bCirrBXl67IiHznK9LiqFItfYeceQstdxmTUzhF5Rh2+zZ
	q7MHfZMni2wKdDwXpqITZfS2HxQa7dW+E8
X-Received: by 2002:a05:6000:4283:b0:43d:73de:abd2 with SMTP id ffacd0b85a97d-45eb38b38c3mr29078790f8f.26.1779794099874;
        Tue, 26 May 2026 04:14:59 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f598sm35375627f8f.6.2026.05.26.04.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:14:59 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 26 May 2026 12:14:36 +0100
Subject: [PATCH 1/2] perf cs-etm: Queue context packets for frontend
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-james-cs-context-tracking-fix-v1-1-ebd602e18287@linaro.org>
References: <20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org>
In-Reply-To: <20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Amir Ayupov <aaupov@meta.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Leo Yan <leo.yan@arm.com>

PE_CONTEXT elements update the context ID and exception level, but the
decoder may still have prior packets cached for frontend processing.
Updating the context immediately in the decoder backend can make those
cached packets get consumed with the wrong thread or EL state.

Add a CS_ETM_CONTEXT packet carrying the TID and EL to the frontend,
this keeps context changes ordered with the rest of the packet stream
and avoids mismatches when synthesizing samples from cached packets.

Separate the memory access function into one for the frontend and one
for decoding. The frontend also needs memory access to attach the
instruction to samples.

Treat context packets as a boundary for branch sample generation and
remove tidq->prev_packet_thread because it's not possible to branch to a
different thread, so only tracking the current thread is required for
sample generation.

Reported-by: Amir Ayupov <aaupov@meta.com>
Closes: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-aaupov@meta.com/
Co-authored-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  18 ++-
 tools/perf/util/cs-etm.c                        | 181 +++++++++++++++---------
 tools/perf/util/cs-etm.h                        |   5 +-
 3 files changed, 133 insertions(+), 71 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index dee3020ceaa9..0b9e316b3bf4 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -525,6 +525,8 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 			const ocsd_generic_trace_elem *elem,
 			const uint8_t trace_chan_id)
 {
+	struct cs_etm_packet *packet;
+	int ret;
 	pid_t tid = -1;
 
 	/*
@@ -546,12 +548,18 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 		break;
 	}
 
-	if (cs_etm__etmq_set_tid_el(etmq, tid, trace_chan_id,
-				    elem->context.exception_level))
+	if (cs_etm__etmq_set_decode_tid_el(etmq, tid, trace_chan_id,
+					   elem->context.exception_level))
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	if (tid == -1)
-		return OCSD_RESP_CONT;
+	ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, trace_chan_id,
+					    CS_ETM_CONTEXT);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &packet_queue->packet_buffer[packet_queue->tail];
+	packet->tid = tid;
+	packet->el = elem->context.exception_level;
 
 	/*
 	 * A timestamp is generated after a PE_CONTEXT element so make sure
@@ -559,7 +567,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 	 */
 	cs_etm_decoder__reset_timestamp(packet_queue);
 
-	return OCSD_RESP_CONT;
+	return ret;
 }
 
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8a639d2e51a4..e22196418e8a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -85,10 +85,11 @@ struct cs_etm_traceid_queue {
 	u64 period_instructions;
 	size_t last_branch_pos;
 	union perf_event *event_buf;
-	struct thread *thread;
-	struct thread *prev_packet_thread;
-	ocsd_ex_level prev_packet_el;
-	ocsd_ex_level el;
+	struct thread *frontend_thread;
+	struct thread *decode_thread;
+	ocsd_ex_level prev_frontend_el;
+	ocsd_ex_level frontend_el;
+	ocsd_ex_level decode_el;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
@@ -614,10 +615,12 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 
 	queue = &etmq->etm->queues.queue_array[etmq->queue_nr];
 	tidq->trace_chan_id = trace_chan_id;
-	tidq->el = tidq->prev_packet_el = ocsd_EL_unknown;
-	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
+	tidq->frontend_el = tidq->decode_el = ocsd_EL_unknown;
+	tidq->frontend_thread = machine__findnew_thread(&etm->session->machines.host, -1,
 					       queue->tid);
-	tidq->prev_packet_thread = machine__idle_thread(&etm->session->machines.host);
+	tidq->decode_thread = machine__findnew_thread(&etm->session->machines.host, -1,
+					       queue->tid);
+
 
 	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
 	if (!tidq->packet)
@@ -751,20 +754,17 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
 		 *
-		 * Threads and exception levels are also tracked for both the
-		 * previous and current packets. This is because the previous
-		 * packet is used for the 'from' IP for branch samples, so the
-		 * thread at that time must also be assigned to that sample.
-		 * Across discontinuity packets the thread can change, so by
-		 * tracking the thread for the previous packet the branch sample
-		 * will have the correct info.
+		 * Track Exception levels for both the previous and current
+		 * packets. This is because the previous packet's address is
+		 * used for the 'from' IP for branch samples, so the previous EL
+		 * must also be used so that sample shows it originates from the
+		 * correct EL. Branches can't branch to a different thread, so
+		 * no need to track the previous thread.
 		 */
 		tmp = tidq->packet;
 		tidq->packet = tidq->prev_packet;
 		tidq->prev_packet = tmp;
-		tidq->prev_packet_el = tidq->el;
-		thread__put(tidq->prev_packet_thread);
-		tidq->prev_packet_thread = thread__get(tidq->thread);
+		tidq->prev_frontend_el = tidq->frontend_el;
 	}
 }
 
@@ -937,8 +937,8 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 
 		/* Free this traceid_queue from the array */
 		tidq = etmq->traceid_queues[idx];
-		thread__zput(tidq->thread);
-		thread__zput(tidq->prev_packet_thread);
+		thread__zput(tidq->frontend_thread);
+		thread__zput(tidq->decode_thread);
 		zfree(&tidq->event_buf);
 		zfree(&tidq->last_branch);
 		zfree(&tidq->last_branch_rb);
@@ -1083,9 +1083,10 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address,
 	}
 }
 
-static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
-			      u64 address, size_t size, u8 *buffer,
-			      const ocsd_mem_space_acc_t mem_space)
+static u32 __cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
+				u64 address, size_t size, u8 *buffer,
+				const ocsd_mem_space_acc_t mem_space,
+				bool is_decoder)
 {
 	u8  cpumode;
 	u64 offset;
@@ -1094,6 +1095,8 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	struct dso *dso;
 	struct cs_etm_traceid_queue *tidq;
 	int ret = 0;
+	ocsd_ex_level el;
+	struct thread *thread;
 
 	if (!etmq)
 		return 0;
@@ -1103,27 +1106,35 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (!tidq)
 		goto out;
 
+	if (is_decoder) {
+		el = tidq->decode_el;
+		thread = tidq->decode_thread;
+	} else {
+		el = tidq->frontend_el;
+		thread = tidq->frontend_thread;
+	}
+
 	/*
-	 * We've already tracked EL along side the PID in cs_etm__set_thread()
-	 * so double check that it matches what OpenCSD thinks as well. It
-	 * doesn't distinguish between EL0 and EL1 for this mem access callback
-	 * so we had to do the extra tracking. Skip validation if it's any of
-	 * the 'any' values.
+	 * We've already tracked EL along side the PID in
+	 * cs_etm__etmq_set_[decode/frontend]_tid_el() so double check that it
+	 * matches what OpenCSD thinks as well. OpenCSD doesn't distinguish
+	 * between EL0 and EL1 for this mem access callback so we had to do the
+	 * extra tracking. Skip validation if it's any of the 'any' values.
 	 */
 	if (!(mem_space == OCSD_MEM_SPACE_ANY ||
 	      mem_space == OCSD_MEM_SPACE_N || mem_space == OCSD_MEM_SPACE_S)) {
 		if (mem_space & OCSD_MEM_SPACE_EL1N) {
 			/* Includes both non secure EL1 and EL0 */
-			assert(tidq->el == ocsd_EL1 || tidq->el == ocsd_EL0);
+			assert(el == ocsd_EL1 || el == ocsd_EL0);
 		} else if (mem_space & OCSD_MEM_SPACE_EL2)
-			assert(tidq->el == ocsd_EL2);
+			assert(el == ocsd_EL2);
 		else if (mem_space & OCSD_MEM_SPACE_EL3)
-			assert(tidq->el == ocsd_EL3);
+			assert(el == ocsd_EL3);
 	}
 
-	cpumode = cs_etm__cpu_mode(etmq, address, tidq->el);
+	cpumode = cs_etm__cpu_mode(etmq, address, el);
 
-	if (!thread__find_map(tidq->thread, cpumode, address, &al))
+	if (!thread__find_map(thread, cpumode, address, &al))
 		goto out;
 
 	dso = map__dso(al.map);
@@ -1138,7 +1149,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 
 	map__load(al.map);
 
-	len = dso__data_read_offset(dso, maps__machine(thread__maps(tidq->thread)),
+	len = dso__data_read_offset(dso, maps__machine(thread__maps(thread)),
 				    offset, buffer, size);
 
 	if (len <= 0) {
@@ -1158,6 +1169,20 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	return ret;
 }
 
+static u32 cs_etm__frontend_mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
+			    u64 address, size_t size, u8 *buffer)
+{
+	return __cs_etm__mem_access(etmq, trace_chan_id, address, size, buffer,
+				    OCSD_MEM_SPACE_NONE, false);
+}
+static u32 cs_etm__decoder_mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
+				      u64 address, size_t size, u8 *buffer,
+				      const ocsd_mem_space_acc_t mem_space)
+{
+	return __cs_etm__mem_access(etmq, trace_chan_id, address, size, buffer,
+				    mem_space, true);
+}
+
 static struct cs_etm_queue *cs_etm__alloc_queue(void)
 {
 	struct cs_etm_queue *etmq = zalloc(sizeof(*etmq));
@@ -1337,8 +1362,8 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 {
 	u8 instrBytes[2];
 
-	cs_etm__mem_access(etmq, trace_chan_id, addr, ARRAY_SIZE(instrBytes),
-			   instrBytes, 0);
+	cs_etm__frontend_mem_access(etmq, trace_chan_id, addr,
+				    ARRAY_SIZE(instrBytes), instrBytes);
 	/*
 	 * T32 instruction size is indicated by bits[15:11] of the first
 	 * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
@@ -1472,34 +1497,55 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 	return etmq->buf_len;
 }
 
-static void cs_etm__set_thread(struct cs_etm_queue *etmq,
-			       struct cs_etm_traceid_queue *tidq, pid_t tid,
-			       ocsd_ex_level el)
+/*
+ * Set the TID and EL from the latest packet pulled out of the
+ * cs_etm_packet_queue. Used for generating samples by the frontend.
+ */
+static int cs_etm__etmq_set_frontend_tid_el(struct cs_etm_queue *etmq,
+					    struct cs_etm_traceid_queue *tidq)
 {
-	struct machine *machine = cs_etm__get_machine(etmq, el);
+	struct cs_etm_packet *packet = tidq->packet;
 
-	if (tid != -1) {
-		thread__zput(tidq->thread);
-		tidq->thread = machine__find_thread(machine, -1, tid);
+	struct machine *machine = cs_etm__get_machine(etmq, packet->el);
+
+	if (packet->tid != -1) {
+		thread__zput(tidq->frontend_thread);
+		tidq->frontend_thread = machine__find_thread(machine, -1, packet->tid);
 	}
 
 	/* Couldn't find a known thread */
-	if (!tidq->thread)
-		tidq->thread = machine__idle_thread(machine);
+	if (!tidq->frontend_thread)
+		tidq->frontend_thread = machine__idle_thread(machine);
 
-	tidq->el = el;
+	tidq->frontend_el = packet->el;
+
+	return 0;
 }
 
-int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
-			    u8 trace_chan_id, ocsd_ex_level el)
+/*
+ * Set the TID and EL used to access memory for decoding. This is ahead
+ * of the TID and EL for generating samples
+ */
+int cs_etm__etmq_set_decode_tid_el(struct cs_etm_queue *etmq, pid_t tid,
+				   u8 trace_chan_id, ocsd_ex_level el)
 {
 	struct cs_etm_traceid_queue *tidq;
+	struct machine *machine = cs_etm__get_machine(etmq, el);
 
 	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
 	if (!tidq)
 		return -EINVAL;
 
-	cs_etm__set_thread(etmq, tidq, tid, el);
+	if (tid != -1) {
+		thread__zput(tidq->decode_thread);
+		tidq->decode_thread = machine__find_thread(machine, -1, tid);
+	}
+
+	/* Couldn't find a known thread */
+	if (!tidq->decode_thread)
+		tidq->decode_thread = machine__idle_thread(machine);
+
+	tidq->decode_el = el;
 	return 0;
 }
 
@@ -1533,8 +1579,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 	else
 		sample->insn_len = 4;
 
-	cs_etm__mem_access(etmq, trace_chan_id, sample->ip, sample->insn_len,
-			   (void *)sample->insn, 0);
+	cs_etm__frontend_mem_access(etmq, trace_chan_id, sample->ip,
+				    sample->insn_len, (void *)sample->insn);
 }
 
 u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
@@ -1570,15 +1616,15 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	perf_sample__init(&sample, /*all=*/true);
 	event->sample.header.type = PERF_RECORD_SAMPLE;
-	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->el);
+	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->frontend_el);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
 	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
 
 	sample.ip = addr;
-	sample.pid = thread__pid(tidq->thread);
-	sample.tid = thread__tid(tidq->thread);
+	sample.pid = thread__pid(tidq->frontend_thread);
+	sample.tid = thread__tid(tidq->frontend_thread);
 	sample.id = etmq->etm->instructions_id;
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
@@ -1631,15 +1677,15 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip,
-						     tidq->prev_packet_el);
+						     tidq->prev_frontend_el);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
 	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
 
 	sample.ip = ip;
-	sample.pid = thread__pid(tidq->prev_packet_thread);
-	sample.tid = thread__tid(tidq->prev_packet_thread);
+	sample.pid = thread__pid(tidq->frontend_thread);
+	sample.tid = thread__tid(tidq->frontend_thread);
 	sample.addr = cs_etm__first_executed_instr(tidq->packet);
 	sample.id = etmq->etm->branches_id;
 	sample.stream_id = etmq->etm->branches_id;
@@ -1874,7 +1920,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		bool generate_sample = false;
 
 		/* Generate sample for tracing on packet */
-		if (tidq->prev_packet->sample_type == CS_ETM_DISCONTINUITY)
+		if (tidq->prev_packet->sample_type == CS_ETM_DISCONTINUITY ||
+		    tidq->prev_packet->sample_type == CS_ETM_CONTEXT)
 			generate_sample = true;
 
 		/* Generate sample for branch taken packet */
@@ -2057,8 +2104,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * so below only read 2 bytes as instruction size for T32.
 		 */
 		addr = end_addr - 2;
-		cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr16),
-				   (u8 *)&instr16, 0);
+		cs_etm__frontend_mem_access(etmq, trace_chan_id, addr,
+					    sizeof(instr16), (u8 *)&instr16);
 		if ((instr16 & 0xFF00) == 0xDF00)
 			return true;
 
@@ -2073,8 +2120,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * +---------+---------+-------------------------+
 		 */
 		addr = end_addr - 4;
-		cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
-				   (u8 *)&instr32, 0);
+		cs_etm__frontend_mem_access(etmq, trace_chan_id, addr,
+					    sizeof(instr32), (u8 *)&instr32);
 		if ((instr32 & 0x0F000000) == 0x0F000000 &&
 		    (instr32 & 0xF0000000) != 0xF0000000)
 			return true;
@@ -2090,8 +2137,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * +-----------------------+---------+-----------+
 		 */
 		addr = end_addr - 4;
-		cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
-				   (u8 *)&instr32, 0);
+		cs_etm__frontend_mem_access(etmq, trace_chan_id, addr,
+					    sizeof(instr32), (u8 *)&instr32);
 		if ((instr32 & 0xFFE0001F) == 0xd4000001)
 			return true;
 
@@ -2376,6 +2423,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 					     PERF_IP_FLAG_RETURN |
 					     PERF_IP_FLAG_INTERRUPT;
 		break;
+	case CS_ETM_CONTEXT:
 	case CS_ETM_EMPTY:
 	default:
 		break;
@@ -2451,6 +2499,9 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 			 */
 			cs_etm__sample(etmq, tidq);
 			break;
+		case CS_ETM_CONTEXT:
+			cs_etm__etmq_set_frontend_tid_el(etmq, tidq);
+			break;
 		case CS_ETM_EXCEPTION:
 		case CS_ETM_EXCEPTION_RET:
 			/*
@@ -2602,7 +2653,7 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 			if (!tidq)
 				continue;
 
-			if (tid == -1 || thread__tid(tidq->thread) == tid)
+			if (tid == -1 || thread__tid(tidq->frontend_thread) == tid)
 				cs_etm__run_per_thread_timeless_decoder(etmq);
 		} else
 			cs_etm__run_per_cpu_timeless_decoder(etmq);
@@ -3310,7 +3361,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
 	 */
 	if (cs_etm_decoder__add_mem_access_cb(etmq->decoder,
 					      0x0L, ((u64) -1L),
-					      cs_etm__mem_access))
+					      cs_etm__decoder_mem_access))
 		goto out_free_decoder;
 
 	zfree(&t_params);
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index aa9bb4a32eca..0c6dac9ebd11 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -158,6 +158,7 @@ enum cs_etm_sample_type {
 	CS_ETM_DISCONTINUITY,
 	CS_ETM_EXCEPTION,
 	CS_ETM_EXCEPTION_RET,
+	CS_ETM_CONTEXT,
 };
 
 enum cs_etm_isa {
@@ -184,6 +185,8 @@ struct cs_etm_packet {
 	u8 last_instr_size;
 	u8 trace_chan_id;
 	int cpu;
+	pid_t tid;
+	int el;
 };
 
 #define CS_ETM_PACKET_MAX_BUFFER 1024
@@ -259,7 +262,7 @@ enum cs_etm_pid_fmt {
 #include <opencsd/ocsd_if_types.h>
 int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu);
 enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
-int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
+int cs_etm__etmq_set_decode_tid_el(struct cs_etm_queue *etmq, pid_t tid,
 			    u8 trace_chan_id, ocsd_ex_level el);
 bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,

-- 
2.34.1

