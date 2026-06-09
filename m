Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521C344029
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015482; cv=none; b=nyy1eDgpFY1IHt0e7MKFIgjK3cG+vFA033/BRFr3b/m8HMxy8w3DkRHSKwb6tTt6Q81e6Y/KX486FDt/3h0g0yofASdsx12oUYlu6jQC3wR/m9bTNiXgCvbpcV5wzh5KfLHm2fLWhZV5ZnI18RX9CuYRA9sSCNGq9KRvMOC/Irk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015482; c=relaxed/simple;
	bh=gzxrUJbtfjWTpc3zGDl9kezrEOn2hVE7sLoZYTUVPlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4geLCEf9Yb7DO0V0hLGMRQge0Y19FF+3QuPn6RPm3NgTVLz++xyz/Lq/+fsVvJZvF3giTyPRUUtMQCfvwnm3UhWUQdgjbZZ5Doaddot2xGxzvVb/8Miczdd+4SpAVfSVsjk0KktpTVJgzjihtgHq7k2oZdTOC5sReAR1WZcJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hRrwL/Sa; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRrwL/Sa"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-46019b190b6so4210573f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781015478; x=1781620278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpGnyLvwWq67NnsCJpMBssWvTtwEzrclFBuzAjBljx4=;
        b=hRrwL/Sa9k0BhPxAxLqZHXAQ6jYTWevJui2phFa5PItyIiKCt4VwMfEFA2qU1IdjlE
         hUHdOnKzysMfeM0U7eBp3FLcBaKGP9c899+Ds4QX4H48/ZxpxDloVMr8IZKKM1czbGk8
         GhvDd0IfsT4L7bKrW7Yzob54atc42/LX4UBY2SLqj0gRS69Qio4W0iA8XGahjXNsTT0L
         9QJ5T3OAl71mFdpeaUx0s64kymIEH1hO781A6UkYZ9BIOQQGgnhRrz6ssbPenlLtj+1p
         zh3EQez6K7GhdEHW04emcPfV7eUZYpAprbdk07rvN5KgC1OtQdOJxWnyykyrt6Pc8A66
         8Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015478; x=1781620278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xpGnyLvwWq67NnsCJpMBssWvTtwEzrclFBuzAjBljx4=;
        b=YFFFmmE6Anwa6SiHso5ArlnTqNaCMN9zFANZGlZwPaibmBl6+lcBw6b620+08/g6Be
         rdSCGpUIKf+UthbIMjeoeYqVFK9Q86UYdQQ7c5RJYbYHlchop8wPgiJpGe2Lfv8zh6KN
         iipev8kZPuc7Bv/G5WW+DAUyRAPn74aAJNJRwJPJGYi1t2ij+HqNLKfDbaVHPGB/BnwX
         twlliZQmwwoZUZVm3O72JdvVZgMcPM/yVcfI8iEgYXP1bEJ0fnSru8aa6I4qud1c4fCR
         62CEm1cavq4BnXjgKNx5Wo7bvbU5XRlxNLXpWbfCgh3lUYfskafIGCEdLD/2IBOoiQ66
         /4Jw==
X-Forwarded-Encrypted: i=1; AFNElJ9awU1KH01nq7ZfnBZyjK8k5rr1gu3mqa7kp06el6E+Fo3rG2HBQ0d3AmmxgcVk9Z1aZKQFvVsFai1yhRTUXoqg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8yR1f7mYkJkNDn1YpJzlDRN/xxDOyW+b1VpoB5plkjZjv+oTW
	mV63FtznShQ95lEUXPQ/zMUXPJkkIacOu7mzMu6SsU56j8gLwm0Yyk30gvV7acSIwbs=
X-Gm-Gg: Acq92OFaulyBZFCfXRKvYEIGUjMUn3a01jTirVwU+0msY4uHmcvJItM911uCJNbKpit
	QyFzog7GMMeD//kWnZ0P4UVhpaDFAGUhXMl/BdPXjbc9svkfysfSVvF0C7rZzHRcCLCb815h0Ac
	wIK/4mnOGRaFQRGD2HeTJtiFFXFGaGbCE/EY34wnFQjCiXDV27IXT1bxhjBOVX5hEV6rhBpepp4
	Tqna1AMEOSysRAZxyOeRjRtx6eWhZUcyq2Ffyxhw/g8/AfyLPUCvtHxK0invgz8Tm9Ax+b3Eqrd
	ejUMznXtVwcgxtra8RuGPniRIJrnnFeSVXnCcwAGq8O65cwbIkTg9befd2sy2KEPk0rblij3S09
	h/C+lvOVHmORQUXWFruC62cr6E5HoA3L9oCJHd1Tain+NRkf2BkV7a6MlV/VX5pS0CpDEqMI0ur
	5POk3dNkDwO5Ke7Nza9vlj0TapxlOpABcAIeGMidj7qle/bbzr2pBVsQ==
X-Received: by 2002:adf:fb85:0:b0:45e:e44b:312b with SMTP id ffacd0b85a97d-460305061a9mr25423591f8f.18.1781015477198;
        Tue, 09 Jun 2026 07:31:17 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm62738388f8f.20.2026.06.09.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:31:16 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 09 Jun 2026 15:30:54 +0100
Subject: [PATCH v4 01/19] perf cs-etm: Queue context packets for frontend
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-james-cs-context-tracking-fix-v4-1-44f9fb9e5c42@linaro.org>
References: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
In-Reply-To: <20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

PE_CONTEXT elements update the context ID and exception level, but the
decoder may still have prior packets cached for frontend processing.
Updating the context immediately in the decoder backend can make those
cached packets get consumed with the wrong thread or EL state.

Add a CS_ETM_CONTEXT packet carrying the TID and EL to the frontend,
this keeps context changes ordered with the rest of the packet stream
and avoids mismatches when synthesizing samples from cached packets.

Separate the memory access function into one for the frontend and one
for decoding. The frontend also needs memory access to attach the
instruction to samples. Because the frontend does memory access for
both previous and current packets, change all the frontend memory access
function signatures to take both a tidq and packet. But backend always
uses the current backend EL and thread from the tidq.

Treat context packets as a boundary for branch sample generation and
remove tidq->prev_packet_thread because it's not possible to branch to a
different thread, so only tracking the current thread is required for
sample generation.

Fixes: e573e978fb12 ("perf cs-etm: Inject capabilitity for CoreSight traces")
Reported-by: Amir Ayupov <aaupov@meta.com>
Closes: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-aaupov@meta.com/
Co-authored-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  21 ++-
 tools/perf/util/cs-etm.c                        | 236 ++++++++++++++----------
 tools/perf/util/cs-etm.h                        |   8 +-
 3 files changed, 163 insertions(+), 102 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index dee3020ceaa9..26940f1f1b0b 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -402,6 +402,8 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	packet_queue->packet_buffer[et].flags = 0;
 	packet_queue->packet_buffer[et].exception_number = UINT32_MAX;
 	packet_queue->packet_buffer[et].trace_chan_id = trace_chan_id;
+	packet_queue->packet_buffer[et].el = ocsd_EL_unknown;
+	packet_queue->packet_buffer[et].tid = -1;
 
 	if (packet_queue->packet_count == CS_ETM_PACKET_MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -449,6 +451,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 	packet->last_instr_type = elem->last_i_type;
 	packet->last_instr_subtype = elem->last_i_subtype;
 	packet->last_instr_cond = elem->last_instr_cond;
+	packet->el = elem->context.exception_level;
 
 	if (elem->last_i_type == OCSD_INSTR_BR || elem->last_i_type == OCSD_INSTR_BR_INDIRECT)
 		packet->last_instr_taken_branch = elem->last_instr_exec;
@@ -525,7 +528,9 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 			const ocsd_generic_trace_elem *elem,
 			const uint8_t trace_chan_id)
 {
+	struct cs_etm_packet *packet;
 	pid_t tid = -1;
+	int ret;
 
 	/*
 	 * Process the PE_CONTEXT packets if we have a valid contextID or VMID.
@@ -546,12 +551,18 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 		break;
 	}
 
-	if (cs_etm__etmq_set_tid_el(etmq, tid, trace_chan_id,
-				    elem->context.exception_level))
+	if (cs_etm__etmq_update_decode_context(etmq, trace_chan_id,
+				elem->context.exception_level, tid))
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
@@ -559,7 +570,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 	 */
 	cs_etm_decoder__reset_timestamp(packet_queue);
 
-	return OCSD_RESP_CONT;
+	return ret;
 }
 
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 40c6ddfa8c8d..5e92359f51a7 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -85,15 +85,22 @@ struct cs_etm_traceid_queue {
 	u64 period_instructions;
 	size_t last_branch_pos;
 	union perf_event *event_buf;
-	struct thread *thread;
-	struct thread *prev_packet_thread;
-	ocsd_ex_level prev_packet_el;
-	ocsd_ex_level el;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
 	struct cs_etm_packet_queue packet_queue;
+
+	struct thread *decode_thread;
+	ocsd_ex_level decode_el;
+
+	/*
+	 * The frontend accesses the EL from '[prev_]packet' because it needs
+	 * previous EL for branch and current EL for instruction samples. It's
+	 * not possible to change thread in a single branch sample so no need to
+	 * store or access the thread through the packet.
+	 */
+	struct thread *frontend_thread;
 };
 
 enum cs_etm_format {
@@ -614,10 +621,11 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 
 	queue = &etmq->etm->queues.queue_array[etmq->queue_nr];
 	tidq->trace_chan_id = trace_chan_id;
-	tidq->el = tidq->prev_packet_el = ocsd_EL_unknown;
-	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
+	tidq->decode_el = ocsd_EL_unknown;
+	tidq->frontend_thread = machine__findnew_thread(&etm->session->machines.host, -1,
+					       queue->tid);
+	tidq->decode_thread = machine__findnew_thread(&etm->session->machines.host, -1,
 					       queue->tid);
-	tidq->prev_packet_thread = machine__idle_thread(&etm->session->machines.host);
 
 	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
 	if (!tidq->packet)
@@ -750,21 +758,10 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
-		 *
-		 * Threads and exception levels are also tracked for both the
-		 * previous and current packets. This is because the previous
-		 * packet is used for the 'from' IP for branch samples, so the
-		 * thread at that time must also be assigned to that sample.
-		 * Across discontinuity packets the thread can change, so by
-		 * tracking the thread for the previous packet the branch sample
-		 * will have the correct info.
 		 */
 		tmp = tidq->packet;
 		tidq->packet = tidq->prev_packet;
 		tidq->prev_packet = tmp;
-		tidq->prev_packet_el = tidq->el;
-		thread__put(tidq->prev_packet_thread);
-		tidq->prev_packet_thread = thread__get(tidq->thread);
 	}
 }
 
@@ -937,8 +934,8 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 
 		/* Free this traceid_queue from the array */
 		tidq = etmq->traceid_queues[idx];
-		thread__zput(tidq->thread);
-		thread__zput(tidq->prev_packet_thread);
+		thread__zput(tidq->frontend_thread);
+		thread__zput(tidq->decode_thread);
 		zfree(&tidq->event_buf);
 		zfree(&tidq->last_branch);
 		zfree(&tidq->last_branch_rb);
@@ -1083,47 +1080,43 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address,
 	}
 }
 
-static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
-			      u64 address, size_t size, u8 *buffer,
-			      const ocsd_mem_space_acc_t mem_space)
+static u32 __cs_etm__mem_access(struct cs_etm_queue *etmq,
+				u64 address, size_t size, u8 *buffer,
+				const ocsd_mem_space_acc_t mem_space,
+				ocsd_ex_level el, struct thread *thread)
 {
 	u8  cpumode;
 	u64 offset;
 	int len;
 	struct addr_location al;
 	struct dso *dso;
-	struct cs_etm_traceid_queue *tidq;
 	int ret = 0;
 
 	if (!etmq)
 		return 0;
 
 	addr_location__init(&al);
-	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
-	if (!tidq)
-		goto out;
 
 	/*
-	 * We've already tracked EL along side the PID in cs_etm__set_thread()
-	 * so double check that it matches what OpenCSD thinks as well. It
-	 * doesn't distinguish between EL0 and EL1 for this mem access callback
-	 * so we had to do the extra tracking. Skip validation if it's any of
-	 * the 'any' values.
+	 * We track EL for the frontend and the backend when receiving context
+	 * and range packets. OpenCSD doesn't distinguish between EL0 and EL1
+	 * for this mem access callback so we had to do the extra tracking. Skip
+	 * validation if it's any of the 'any' values.
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
@@ -1138,7 +1131,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 
 	map__load(al.map);
 
-	len = dso__data_read_offset(dso, maps__machine(thread__maps(tidq->thread)),
+	len = dso__data_read_offset(dso, maps__machine(thread__maps(thread)),
 				    offset, buffer, size);
 
 	if (len <= 0) {
@@ -1158,6 +1151,30 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	return ret;
 }
 
+static u32 cs_etm__frontend_mem_access(struct cs_etm_queue *etmq,
+				       struct cs_etm_traceid_queue *tidq,
+				       struct cs_etm_packet *packet,
+				       u64 address, size_t size, u8 *buffer)
+{
+	return __cs_etm__mem_access(etmq, address, size, buffer, 0, packet->el,
+				    tidq->frontend_thread);
+}
+
+static u32 cs_etm__decoder_mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
+				      u64 address, size_t size, u8 *buffer,
+				      const ocsd_mem_space_acc_t mem_space)
+{
+	struct cs_etm_traceid_queue *tidq;
+
+	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+	if (!tidq)
+		return 0;
+
+	return __cs_etm__mem_access(etmq, address, size, buffer,
+				    mem_space, tidq->decode_el,
+				    tidq->decode_thread);
+}
+
 static struct cs_etm_queue *cs_etm__alloc_queue(void)
 {
 	struct cs_etm_queue *etmq = zalloc(sizeof(*etmq));
@@ -1333,12 +1350,13 @@ void cs_etm__reset_last_branch_rb(struct cs_etm_traceid_queue *tidq)
 }
 
 static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
-					 u8 trace_chan_id, u64 addr)
+					 struct cs_etm_traceid_queue *tidq,
+					 struct cs_etm_packet *packet, u64 addr)
 {
 	u8 instrBytes[2];
 
-	cs_etm__mem_access(etmq, trace_chan_id, addr, ARRAY_SIZE(instrBytes),
-			   instrBytes, 0);
+	cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
+				    ARRAY_SIZE(instrBytes), instrBytes);
 	/*
 	 * T32 instruction size is indicated by bits[15:11] of the first
 	 * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
@@ -1371,16 +1389,16 @@ u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 }
 
 static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
-				     u64 trace_chan_id,
-				     const struct cs_etm_packet *packet,
+				     struct cs_etm_traceid_queue *tidq,
+				     struct cs_etm_packet *packet,
 				     u64 offset)
 {
 	if (packet->isa == CS_ETM_ISA_T32) {
 		u64 addr = packet->start_addr;
 
 		while (offset) {
-			addr += cs_etm__t32_instr_size(etmq,
-						       trace_chan_id, addr);
+			addr += cs_etm__t32_instr_size(etmq, tidq, packet,
+						       addr);
 			offset--;
 		}
 		return addr;
@@ -1490,34 +1508,51 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 	return etmq->buf_len;
 }
 
-static void cs_etm__set_thread(struct cs_etm_queue *etmq,
-			       struct cs_etm_traceid_queue *tidq, pid_t tid,
-			       ocsd_ex_level el)
+/*
+ * Convert a raw thread number to a thread struct and assign it to **thread.
+ */
+static int cs_etm__etmq_update_thread(struct cs_etm_queue *etmq,
+				      ocsd_ex_level el, pid_t tid,
+				      struct thread **thread)
 {
 	struct machine *machine = cs_etm__get_machine(etmq, el);
 
+	if (!machine || !*thread)
+		return -EINVAL;
+
 	if (tid != -1) {
-		thread__zput(tidq->thread);
-		tidq->thread = machine__find_thread(machine, -1, tid);
+		thread__zput(*thread);
+		*thread = machine__find_thread(machine, -1, tid);
 	}
 
 	/* Couldn't find a known thread */
-	if (!tidq->thread)
-		tidq->thread = machine__idle_thread(machine);
+	if (!*thread)
+		*thread = machine__idle_thread(machine);
 
-	tidq->el = el;
+	return 0;
 }
 
-int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
-			    u8 trace_chan_id, ocsd_ex_level el)
+/*
+ * Set the thread and EL of the decode context which is ahead in time of the
+ * frontend context.
+ */
+int cs_etm__etmq_update_decode_context(struct cs_etm_queue *etmq,
+				       u8 trace_chan_id,
+				       ocsd_ex_level el, pid_t tid)
 {
 	struct cs_etm_traceid_queue *tidq;
+	int ret;
 
 	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
 	if (!tidq)
 		return -EINVAL;
 
-	cs_etm__set_thread(etmq, tidq, tid, el);
+	ret = cs_etm__etmq_update_thread(etmq, el, tid,
+					 &tidq->decode_thread);
+	if (ret)
+		return ret;
+
+	tidq->decode_el = el;
 	return 0;
 }
 
@@ -1527,8 +1562,8 @@ bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq)
 }
 
 static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
-			      u64 trace_chan_id,
-			      const struct cs_etm_packet *packet,
+			      struct cs_etm_traceid_queue *tidq,
+			      struct cs_etm_packet *packet,
 			      struct perf_sample *sample)
 {
 	/*
@@ -1545,14 +1580,14 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 	 * cs_etm__t32_instr_size().
 	 */
 	if (packet->isa == CS_ETM_ISA_T32)
-		sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
+		sample->insn_len = cs_etm__t32_instr_size(etmq, tidq, packet,
 							  sample->ip);
 	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
 	else
 		sample->insn_len = 4;
 
-	cs_etm__mem_access(etmq, trace_chan_id, sample->ip, sample->insn_len,
-			   (void *)sample->insn, 0);
+	cs_etm__frontend_mem_access(etmq, tidq, packet, sample->ip,
+				    sample->insn_len, (void *)sample->insn);
 }
 
 u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
@@ -1579,6 +1614,7 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
 
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
+					    struct cs_etm_packet *packet,
 					    u64 addr, u64 period)
 {
 	int ret = 0;
@@ -1588,23 +1624,23 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	perf_sample__init(&sample, /*all=*/true);
 	event->sample.header.type = PERF_RECORD_SAMPLE;
-	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->el);
+	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, packet->el);
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
-	sample.cpu = tidq->packet->cpu;
+	sample.cpu = packet->cpu;
 	sample.flags = tidq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
-	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
+	cs_etm__copy_insn(etmq, tidq, packet, &sample);
 
 	if (etm->synth_opts.last_branch)
 		sample.branch_stack = tidq->last_branch;
@@ -1649,15 +1685,15 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip,
-						     tidq->prev_packet_el);
+						     tidq->prev_packet->el);
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
@@ -1666,8 +1702,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	sample.flags = tidq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
-	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet,
-			  &sample);
+	cs_etm__copy_insn(etmq, tidq, tidq->prev_packet, &sample);
 
 	/*
 	 * perf report cannot handle events without a branch stack
@@ -1788,7 +1823,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	int ret;
-	u8 trace_chan_id = tidq->trace_chan_id;
 	u64 instrs_prev;
 
 	/* Get instructions remainder from previous packet */
@@ -1874,10 +1908,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 			 * been executed, but PC has not advanced to next
 			 * instruction)
 			 */
-			addr = cs_etm__instr_addr(etmq, trace_chan_id,
-						  tidq->packet, offset - 1);
+			addr = cs_etm__instr_addr(etmq, tidq, tidq->packet,
+						  offset - 1);
 			ret = cs_etm__synth_instruction_sample(
-				etmq, tidq, addr,
+				etmq, tidq, tidq->packet, addr,
 				etm->instructions_sample_period);
 			if (ret)
 				return ret;
@@ -1959,7 +1993,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 		addr = cs_etm__last_executed_instr(tidq->prev_packet);
 
 		err = cs_etm__synth_instruction_sample(
-			etmq, tidq, addr,
+			etmq, tidq, tidq->prev_packet, addr,
 			tidq->period_instructions);
 		if (err)
 			return err;
@@ -2014,7 +2048,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 		addr = cs_etm__last_executed_instr(tidq->prev_packet);
 
 		err = cs_etm__synth_instruction_sample(
-			etmq, tidq, addr,
+			etmq, tidq, tidq->prev_packet, addr,
 			tidq->period_instructions);
 		if (err)
 			return err;
@@ -2051,9 +2085,9 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 	return etmq->buf_len;
 }
 
-static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
-				 struct cs_etm_packet *packet,
-				 u64 end_addr)
+static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
+				 struct cs_etm_traceid_queue *tidq,
+				 struct cs_etm_packet *packet, u64 end_addr)
 {
 	/* Initialise to keep compiler happy */
 	u16 instr16 = 0;
@@ -2075,8 +2109,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * so below only read 2 bytes as instruction size for T32.
 		 */
 		addr = end_addr - 2;
-		cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr16),
-				   (u8 *)&instr16, 0);
+		cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
+					    sizeof(instr16), (u8 *)&instr16);
 		if ((instr16 & 0xFF00) == 0xDF00)
 			return true;
 
@@ -2091,8 +2125,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * +---------+---------+-------------------------+
 		 */
 		addr = end_addr - 4;
-		cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
-				   (u8 *)&instr32, 0);
+		cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
+					    sizeof(instr32), (u8 *)&instr32);
 		if ((instr32 & 0x0F000000) == 0x0F000000 &&
 		    (instr32 & 0xF0000000) != 0xF0000000)
 			return true;
@@ -2108,8 +2142,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * +-----------------------+---------+-----------+
 		 */
 		addr = end_addr - 4;
-		cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
-				   (u8 *)&instr32, 0);
+		cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
+					    sizeof(instr32), (u8 *)&instr32);
 		if ((instr32 & 0xFFE0001F) == 0xd4000001)
 			return true;
 
@@ -2125,7 +2159,6 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 			       struct cs_etm_traceid_queue *tidq, u64 magic)
 {
-	u8 trace_chan_id = tidq->trace_chan_id;
 	struct cs_etm_packet *packet = tidq->packet;
 	struct cs_etm_packet *prev_packet = tidq->prev_packet;
 
@@ -2140,7 +2173,7 @@ static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 	 */
 	if (magic == __perf_cs_etmv4_magic) {
 		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
-		    cs_etm__is_svc_instr(etmq, trace_chan_id, prev_packet,
+		    cs_etm__is_svc_instr(etmq, tidq, prev_packet,
 					 prev_packet->end_addr))
 			return true;
 	}
@@ -2178,7 +2211,6 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 				      struct cs_etm_traceid_queue *tidq,
 				      u64 magic)
 {
-	u8 trace_chan_id = tidq->trace_chan_id;
 	struct cs_etm_packet *packet = tidq->packet;
 	struct cs_etm_packet *prev_packet = tidq->prev_packet;
 
@@ -2204,7 +2236,7 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 		 * (SMC, HVC) are taken as sync exceptions.
 		 */
 		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
-		    !cs_etm__is_svc_instr(etmq, trace_chan_id, prev_packet,
+		    !cs_etm__is_svc_instr(etmq, tidq, prev_packet,
 					  prev_packet->end_addr))
 			return true;
 
@@ -2228,7 +2260,6 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 {
 	struct cs_etm_packet *packet = tidq->packet;
 	struct cs_etm_packet *prev_packet = tidq->prev_packet;
-	u8 trace_chan_id = tidq->trace_chan_id;
 	u64 magic;
 	int ret;
 
@@ -2309,11 +2340,11 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 		if (prev_packet->flags == (PERF_IP_FLAG_BRANCH |
 					   PERF_IP_FLAG_RETURN |
 					   PERF_IP_FLAG_INTERRUPT) &&
-		    cs_etm__is_svc_instr(etmq, trace_chan_id,
-					 packet, packet->start_addr))
+		    cs_etm__is_svc_instr(etmq, tidq, packet, packet->start_addr)) {
 			prev_packet->flags = PERF_IP_FLAG_BRANCH |
 					     PERF_IP_FLAG_RETURN |
 					     PERF_IP_FLAG_SYSCALLRET;
+		}
 		break;
 	case CS_ETM_DISCONTINUITY:
 		/*
@@ -2394,6 +2425,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 					     PERF_IP_FLAG_RETURN |
 					     PERF_IP_FLAG_INTERRUPT;
 		break;
+	case CS_ETM_CONTEXT:
 	case CS_ETM_EMPTY:
 	default:
 		break;
@@ -2469,6 +2501,19 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 			 */
 			cs_etm__sample(etmq, tidq);
 			break;
+		case CS_ETM_CONTEXT:
+			/*
+			 * Update context but don't swap packet. Keep the
+			 * previous one for branch source address info, if
+			 * tracing the kernel the context packet will be emitted
+			 * between two ranges.
+			 */
+			ret = cs_etm__etmq_update_thread(etmq, tidq->packet->el,
+							 tidq->packet->tid,
+							 &tidq->frontend_thread);
+			if (ret)
+				goto out;
+			break;
 		case CS_ETM_EXCEPTION:
 		case CS_ETM_EXCEPTION_RET:
 			/*
@@ -2497,6 +2542,7 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 		}
 	}
 
+out:
 	return ret;
 }
 
@@ -2620,7 +2666,7 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 			if (!tidq)
 				continue;
 
-			if (tid == -1 || thread__tid(tidq->thread) == tid)
+			if (tid == -1 || thread__tid(tidq->frontend_thread) == tid)
 				cs_etm__run_per_thread_timeless_decoder(etmq);
 		} else
 			cs_etm__run_per_cpu_timeless_decoder(etmq);
@@ -3328,7 +3374,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
 	 */
 	if (cs_etm_decoder__add_mem_access_cb(etmq->decoder,
 					      0x0L, ((u64) -1L),
-					      cs_etm__mem_access))
+					      cs_etm__decoder_mem_access))
 		goto out_free_decoder;
 
 	zfree(&t_params);
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index aa9bb4a32eca..b81099c2b301 100644
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
+	int el;
+	pid_t tid;
 };
 
 #define CS_ETM_PACKET_MAX_BUFFER 1024
@@ -259,8 +262,9 @@ enum cs_etm_pid_fmt {
 #include <opencsd/ocsd_if_types.h>
 int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu);
 enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
-int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
-			    u8 trace_chan_id, ocsd_ex_level el);
+int cs_etm__etmq_update_decode_context(struct cs_etm_queue *etmq,
+				       u8 trace_chan_id, ocsd_ex_level el,
+				       pid_t tid);
 bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id);

-- 
2.34.1

