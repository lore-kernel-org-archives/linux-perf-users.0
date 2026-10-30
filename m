Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373230;
	b=knR4XJQdYlnYl3k0cve9G+DpYewR39JPh/hVMLagqf3LRFoSBDcSZgzd+pZ4TlPCYRHF
	 bKreAuPjkNDUdh0+pRGCQrHYSRhX+w5BQmhIEiF9F0kkhg5mcxiJNZsnHZxbRT4o4un28
	 fvQRg5yt4xPMBX/LoRhVhrJw1+lZ2/PYnork7TTe9LTeqAUtqXBJrZW6WqLAdGDmUyH+M
	 WvnmibNrJ2X1/upyxOZ0JjxE3MybL/+lSGbHxSE4RTH6SzahAnLrCpW2XteUey/QmUARR
	 SE3wtRsOydElErEVB1w1NVzu9sHwmYTCdAWQuOE6xh5BC8Q09H5dj8FD5Fp214Ubbow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373230;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=TNxZ7axTcrT/+NML9NB+Fl/TsENesjnDg4LpAJAQg5k=;
	b=jgbcGbP0QQfnfwgBwFM2p7CjrsY3NkVBCY0VEEfB0Ts4VKSobnXqSqiWmmj5/2j2JEXD
	 dXj8QzJrKzto5quxq91rKuwnt0Y1jTKpI9uj0tRVIhklqIaVZGnKKwf6AgiGpSrYyI5JX
	 tSDrpUH0wCGjR49ArOiQM1YuTOmNk5aSvvlS08g3j6nTa0wel6fhJfVKzYv1ry4gAyDQo
	 6napegtuqKTt167RgllJoD78ssZd9zhkQY24x309eGPKwpo53H6eUIL0wi8EZrYPf8DQi
	 VZtahEKIWyNQ5YWDb4o8SHtn2t0bpF4LGWnxFwBc2jjHkn/VoWT2p+1ex6bYJVheqvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iVP7w9K+;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292DD606A33B;
	Fri, 30 Oct 2026 15:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 292DD606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iVP7w9K+
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 769C41F60;
	Fri, 30 Oct 2026 08:13:46 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BDC53F59E;
	Fri, 30 Oct 2026 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373229; bh=0gmZhEot7GujYs9He/zUpHOzKjHkDUDZHoj/zmdZoH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iVP7w9K+PZWcJZaX7/xiHYH+/vaVHUD9qiBdK45sjfRMefb8NgdAE+GmD48B5cUI2
	 xfFBUlElXvHd9Pv+67FTML0+eXVEtxFMl90zoz6j9EqQmaOAahI/K+B2ksN7TCIgPi
	 TWPkPm4GSvkRJejmABVpWSeQB+opiXvnKtCnN+Lg=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:17 +0000
Subject: [PATCH v3 10/14] perf cs-etm: Synthesize exception entries
 separately from branches
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-10-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=14094;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=0gmZhEot7GujYs9He/zUpHOzKjHkDUDZHoj/zmdZoH4=;
 b=6vFRgB6OCWU3pWgSw+vJ4psymBAbsOCyyoIzhAd/K+Jh0l3iIM+HnnZHuHL+MHxz7C9CoohXK
 sZXB5QP/sJpAoDMsWVXbB8BDGo8B+we7eJcJ4bGMSytrsupycAwv+UI
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Exception entry is currently represented by replacing the preceding
range's flags and forcing its last_instr_taken_branch bit. This gives
an interrupt the source address of the last executed instruction. When
that instruction is a taken branch, its edge and original flags are lost.

For example, consider an untaken B.LS followed by an IRQ:

  4000f4: eb02003f  cmp  x1, x2
  4000f8: 54000109  b.ls 400118
  4000fc: d282f2c2  mov  x2, #0x1796

If B.LS completes untaken and the IRQ is taken before MOV completes, the
preferred exception return address is 4000fc. With kernel tracing disabled,
perf script previously attributed the IRQ to the preceding range:

  tr end  hw int  4000f8 => 0       b.ls #0x400118
  tr strt jmp          0 => 4000fc

When an IRQ element provides that return address, use it as the source of
the synthesized exception sample:

  tr end  hw int  4000fc => 0       movz x2, #0x1796
  tr strt jmp          0 => 4000fc

The source now identifies the architectural resume PC, rather than the
last completed instruction. The IRQ signal could have arrived while B.LS
was executing. The traced preferred exception return address of 4000fc
confirms that B.LS had retired architecturally before the IRQ was taken.

OpenCSD provides an exception's preferred return address in en_addr when
excep_ret_addr is set. It does not define or initialize st_addr for an
exception element. Derive A32 and A64 exception source PCs from the
preferred return address. Exception calls (SVC/SMC/HVC) use the preceding
four-byte instruction; interrupts, faults and traps use the return
address with last_instr_size set to zero.

Use pref_ret_addr when deriving exception source PCs in the decoder and
cs_etm__last_executed_instr(), and when setting sample.ret_addr.

Keep T32 exception samples on the existing fallback path because
determining the call size requires an instruction read. Retain
pref_ret_addr for the frontend's SVC check. RESET and missing return
addresses also use the fallback because their source PC is unknown.

Resolve the preceding branch with its original flags without adding
instructions. Then retain the exception in prev_packet until the next
range, exception or discontinuity resolves its destination. This preserves
both edges when an exception follows a taken branch and also handles
consecutive exceptions.

Supply the preferred return address in sample.ret_addr so later instruction
fetching cannot change the return PC used by call/return export. Generate
final instruction samples only from nonempty instruction ranges.

CS_ETM_EXCEPTION_RET needs no further handling in the packet processing
loop because ERET is already part of the preceding instruction range.
cs_etm__set_sample_flags() now sets both that range's return flags and
last_instr_taken_branch.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  31 ++++++-
 tools/perf/util/cs-etm.c                        | 106 +++++++++++++++---------
 tools/perf/util/cs-etm.h                        |   1 +
 3 files changed, 95 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index ccae10e6cdad55607e092b90a1a940103fa050d7..b9397151748b222ae4542394c7b974b0fdb69bba 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -514,6 +514,7 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
 {
 	int ret = 0;
 	struct cs_etm_packet *packet;
+	u8 last_instr_size = 0;
 
 	ret = cs_etm_decoder__buffer_packet(etmq, queue, elem, trace_chan_id,
 					    CS_ETM_EXCEPTION);
@@ -524,8 +525,34 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
 	packet->exception_number = elem->exception_number;
 	if (elem->context.el_valid)
 		packet->el = elem->context.exception_level;
-	if (elem->excep_ret_addr)
-		packet->pref_ret_addr = elem->en_addr;
+
+	/* RESET has no defined preferred return address. */
+	if (!elem->excep_ret_addr ||
+	    packet->exception_number == CS_ETMV4_EXC_RESET)
+		return ret;
+
+	packet->pref_ret_addr = elem->en_addr;
+
+	/*
+	 * T32 calls can be two or four bytes, requiring an instruction read
+	 * before pref_ret_addr to determine their size. Keep it for the
+	 * frontend's SVC check and leave start_addr unknown for its fallback.
+	 */
+	if (packet->isa != CS_ETM_ISA_A32 && packet->isa != CS_ETM_ISA_A64)
+		return ret;
+
+	/*
+	 * For A32 and A64, exception calls execute a four-byte SVC, HVC or
+	 * SMC and save the following PC. Other exceptions use the interrupted
+	 * or faulting PC, including traps on those instructions.
+	 *
+	 * With a shared branch target, no instruction has completed
+	 * at the target, so last_instr_size remains zero.
+	 */
+	if (elem->exception_number == CS_ETMV4_EXC_CALL)
+		last_instr_size = 4;
+	packet->start_addr = packet->pref_ret_addr - last_instr_size;
+	packet->last_instr_size = last_instr_size;
 
 	return ret;
 }
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 14a6466255017386addaee539141bf89b6dcf76f..c8a6a6e4c7d3b4c9d58f3a5b46587ee53c864b2e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -101,10 +101,8 @@ struct cs_etm_traceid_queue {
 	ocsd_ex_level decode_el;
 
 	/*
-	 * The frontend accesses the EL from '[prev_]packet' because it needs
-	 * previous EL for branch and current EL for instruction samples. It's
-	 * not possible to change thread in a single branch sample so no need to
-	 * store or access the thread through the packet.
+	 * Samples use the EL saved in their source packet. A branch sample
+	 * cannot change thread, so the thread is kept in the frontend context.
 	 */
 	struct thread *frontend_thread;
 };
@@ -1397,11 +1395,10 @@ static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
 	/*
-	 * Return 0 for packets that have no addresses so that CS_ETM_INVAL_ADDR doesn't
-	 * appear in samples.
+	 * Return 0 for discontinuities so that CS_ETM_INVAL_ADDR doesn't appear
+	 * in samples.
 	 */
-	if (packet->sample_type == CS_ETM_DISCONTINUITY ||
-	    packet->sample_type == CS_ETM_EXCEPTION)
+	if (packet->sample_type == CS_ETM_DISCONTINUITY)
 		return 0;
 
 	return packet->start_addr;
@@ -1414,6 +1411,9 @@ u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 	if (packet->sample_type == CS_ETM_DISCONTINUITY)
 		return 0;
 
+	if (packet->sample_type == CS_ETM_EXCEPTION)
+		return packet->pref_ret_addr - packet->last_instr_size;
+
 	return packet->end_addr - packet->last_instr_size;
 }
 
@@ -1580,6 +1580,9 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 		return;
 	}
 
+	if (packet->sample_type == CS_ETM_EXCEPTION && !sample->insn_len)
+		return;
+
 	cs_etm__frontend_mem_access(etmq, tidq, packet, sample->ip,
 				    sample->insn_len, (void *)sample->insn);
 }
@@ -1606,8 +1609,11 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
 		return etm->latest_kernel_timestamp;
 }
 
-static bool cs_etm__packet_has_taken_branch(struct cs_etm_packet *packet)
+static bool cs_etm__packet_has_branch(struct cs_etm_packet *packet)
 {
+	if (packet->sample_type == CS_ETM_EXCEPTION)
+		return true;
+
 	if (packet->sample_type == CS_ETM_RANGE &&
 	    packet->last_instr_taken_branch)
 		return true;
@@ -1625,7 +1631,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
 		return;
 
-	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
+	if (!cs_etm__packet_has_branch(tidq->prev_packet))
 		return;
 
 	if (etmq->etm->use_thread_stack) {
@@ -1737,7 +1743,8 @@ static int cs_etm__synth_last_instruction_sample(struct cs_etm_queue *etmq,
 	    !etmq->etm->synth_opts.instructions)
 		return 0;
 
-	if (packet->sample_type != CS_ETM_RANGE)
+	/* Only nonempty ranges provide a final instruction to sample. */
+	if (packet->sample_type != CS_ETM_RANGE || !packet->instr_count)
 		return 0;
 
 	ret = cs_etm__synth_instruction_sample(etmq, tidq, packet,
@@ -1771,7 +1778,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	if (!etm->synth_opts.branches)
 		return 0;
 
-	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet) &&
+	if (!cs_etm__packet_has_branch(tidq->prev_packet) &&
 	    !(tidq->prev_packet->flags & (PERF_IP_FLAG_TRACE_BEGIN |
 					  PERF_IP_FLAG_TRACE_END)))
 		return 0;
@@ -1802,6 +1809,9 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	sample.flags = tidq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
+	if (tidq->prev_packet->sample_type == CS_ETM_EXCEPTION)
+		sample.ret_addr = tidq->prev_packet->pref_ret_addr;
+
 	cs_etm__copy_insn(etmq, tidq, tidq->prev_packet, &sample);
 
 	/*
@@ -2052,21 +2062,23 @@ static int cs_etm__context(struct cs_etm_queue *etmq,
 	return ret;
 }
 
-static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
+static int cs_etm__exception(struct cs_etm_queue *etmq,
+			     struct cs_etm_traceid_queue *tidq)
 {
+	struct cs_etm_packet *packet = tidq->packet;
+
 	/*
-	 * When the exception packet is inserted, whether the last instruction
-	 * in previous range packet is taken branch or not, we need to force
-	 * to set 'prev_packet->last_instr_taken_branch' to true.  This ensures
-	 * to generate branch sample for the instruction range before the
-	 * exception is trapped to kernel or before the exception returning.
-	 *
-	 * The exception packet does not describe an instruction range, so don't
-	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
-	 * for generating instruction and branch samples.
+	 * Resolve the preceding branch without adding instructions, then keep
+	 * this exception as prev_packet until its destination is known.
 	 */
-	if (tidq->prev_packet->sample_type == CS_ETM_RANGE)
+	if (packet->start_addr != CS_ETM_INVAL_ADDR)
+		return cs_etm__sample(etmq, tidq);
+
+	/* Fall back to attributing the exception to the preceding range. */
+	if (tidq->prev_packet->sample_type == CS_ETM_RANGE) {
+		tidq->prev_packet->flags = packet->flags;
 		tidq->prev_packet->last_instr_taken_branch = true;
+	}
 
 	return 0;
 }
@@ -2463,7 +2475,8 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 		 * instruction packet, set flag PERF_IP_FLAG_TRACE_END
 		 * for previous packet.
 		 */
-		if (prev_packet->sample_type == CS_ETM_RANGE)
+		if (prev_packet->sample_type == CS_ETM_RANGE ||
+		    prev_packet->sample_type == CS_ETM_EXCEPTION)
 			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
 					      PERF_IP_FLAG_TRACE_END;
 		break;
@@ -2495,15 +2508,23 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 					PERF_IP_FLAG_CALL |
 					PERF_IP_FLAG_INTERRUPT;
 
-		/*
-		 * When the exception packet is inserted, since exception
-		 * packet is not used standalone for generating samples
-		 * and it's affiliation to the previous instruction range
-		 * packet; so set previous range packet flags to tell perf
-		 * it is an exception taken branch.
-		 */
-		if (prev_packet->sample_type == CS_ETM_RANGE)
-			prev_packet->flags = packet->flags;
+		if (packet->start_addr == CS_ETM_INVAL_ADDR)
+			break;
+
+		/* Resolve the preceding trace start or exception return. */
+		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
+			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
+					      PERF_IP_FLAG_TRACE_BEGIN;
+
+		if (prev_packet->flags == (PERF_IP_FLAG_BRANCH |
+					   PERF_IP_FLAG_RETURN |
+					   PERF_IP_FLAG_INTERRUPT) &&
+		    cs_etm__is_svc_instr(etmq, tidq, packet,
+					 packet->start_addr)) {
+			prev_packet->flags = PERF_IP_FLAG_BRANCH |
+					     PERF_IP_FLAG_RETURN |
+					     PERF_IP_FLAG_SYSCALLRET;
+		}
 		break;
 	case CS_ETM_EXCEPTION_RET:
 		/*
@@ -2531,10 +2552,12 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 		 * system call instruction and then calibrate the sample flag
 		 * as needed.
 		 */
-		if (prev_packet->sample_type == CS_ETM_RANGE)
+		if (prev_packet->sample_type == CS_ETM_RANGE) {
 			prev_packet->flags = PERF_IP_FLAG_BRANCH |
 					     PERF_IP_FLAG_RETURN |
 					     PERF_IP_FLAG_INTERRUPT;
+			prev_packet->last_instr_taken_branch = true;
+		}
 		break;
 	case CS_ETM_CONTEXT:
 	case CS_ETM_EMPTY:
@@ -2610,7 +2633,9 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 			 * range, generate instruction sequence
 			 * events.
 			 */
-			cs_etm__sample(etmq, tidq);
+			ret = cs_etm__sample(etmq, tidq);
+			if (ret)
+				goto out;
 			break;
 		case CS_ETM_CONTEXT:
 			/*
@@ -2624,13 +2649,12 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 				goto out;
 			break;
 		case CS_ETM_EXCEPTION:
+			ret = cs_etm__exception(etmq, tidq);
+			if (ret)
+				goto out;
+			break;
 		case CS_ETM_EXCEPTION_RET:
-			/*
-			 * If the exception packet is coming,
-			 * make sure the previous instruction
-			 * range packet to be handled properly.
-			 */
-			cs_etm__exception(tidq);
+			/* The return annotates the preceding instruction range. */
 			break;
 		case CS_ETM_DISCONTINUITY:
 			/*
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index e40b9b7d0a9bd90f089c2f20527332264ead4249..bf0e0f5a9711f8d450ea8a0f9d67aa5e8d7204ab 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -173,6 +173,7 @@ struct cs_etm_queue;
 struct cs_etm_packet {
 	enum cs_etm_sample_type sample_type;
 	enum cs_etm_isa isa;
+	/* For exceptions: source PC, or CS_ETM_INVAL_ADDR. */
 	u64 start_addr;
 	union {
 		u64 end_addr;		/* Range packets */

-- 
2.34.1

