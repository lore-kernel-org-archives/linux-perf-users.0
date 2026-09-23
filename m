Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E2357C72E;
	Wed, 23 Sep 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176944; cv=none; b=BNMS8Lprx6RoZu3H8lHSjtQ2YJsnqDLQwCu8J4Age3rH7/7eIuA1ouqv0YqRc6r0G84Dr3A6CRXDt0oHUCEFOnbXffBfPi5fV3G7iKND/Obg1BZl6TyplzU4L87j7hpam+RUkX4Vml6XFpSA0G2EbYhcKOtUQiPuaTl6OWexj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176944; c=relaxed/simple;
	bh=GJmCbEJOW+JcbeKN6pUS0ubgm4N3ESLhcQNQ0oR73x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efG6dCNNCb0tCSHeH8aLAH6CXbHPGqIGYjLe4wttRQY6F2+DN+GIO9eEHLCzO3chm8h1lT0+3lLihp8fHWrKDCjQdf1EoFGw/0Lei6lN1HCYuB3oKVCfkFREaibzidQVP43oPO5MtSfHqsH9593bygL9GSPylYtpV4P/rlpCDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UcYEkkRa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UcYEkkRa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D54561D70;
	Wed, 23 Sep 2026 08:22:17 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2605A3F86F;
	Wed, 23 Sep 2026 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176941; bh=GJmCbEJOW+JcbeKN6pUS0ubgm4N3ESLhcQNQ0oR73x0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UcYEkkRaFt2uwzw+Diy0c7/Cr2TF44L4vMLcFIB+xkedIjh/Mj8P2WPJCWUcfjXIG
	 mWWc5+hIXvnRaOn8cOqikPrbuIwvqN16DvxdNctw2tzNCzwsZSsq8WaSFRSNHRch+5
	 to45PE8dCzqF0rlWaIsZ2z6LtL8Mmh15X7L8VNgM=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:50 +0100
Subject: [PATCH v2 10/14] perf cs-etm: Synthesize exception entries
 separately from branches
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-10-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=13665;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=GJmCbEJOW+JcbeKN6pUS0ubgm4N3ESLhcQNQ0oR73x0=;
 b=afaGFn6Lhpa6LnMlWXrgh4n18hKYp8oF/D1MqRCdj9Spz417Lx28Qt28/6uC+h/ipYgP/xKBU
 TC5d7Kj0/UoBX1PL0OE/59XQGlFzLwXCxIRRzOUXTumMhZ90ie+/kC5
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

Keep T32 exception samples on the existing fallback path, so determining
the call size requires an instruction read. Retain end_addr for the
frontend's SVC check. RESET and missing return addresses also use the
fallback because their source PC is unknown.

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

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  31 ++++++-
 tools/perf/util/cs-etm.c                        | 102 ++++++++++++++----------
 tools/perf/util/cs-etm.h                        |   1 +
 3 files changed, 91 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 48e8c355a3e495cc30dcb4056c04a034d10ce860..83a851bdd87bf0aa3fbc565305451a68f42c69e6 100644
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
-		packet->end_addr = elem->en_addr;
+
+	/* RESET has no defined preferred return address. */
+	if (!elem->excep_ret_addr ||
+	    packet->exception_number == CS_ETMV4_EXC_RESET)
+		return ret;
+
+	packet->end_addr = elem->en_addr;
+
+	/*
+	 * T32 calls can be two or four bytes, requiring an instruction read
+	 * before end_addr to determine their size. Keep end_addr for the
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
+	packet->start_addr = packet->end_addr - last_instr_size;
+	packet->last_instr_size = last_instr_size;
 
 	return ret;
 }
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a40b3b2fe2e6318154111d9b7ebd05bee53934f1..6641e257e5f18f30a185a88db720c1404cf2bd36 100644
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
@@ -1364,11 +1362,10 @@ static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
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
@@ -1537,6 +1534,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 	}
 
 	sample->insn_len = cs_etm__instr_size(etmq, tidq, packet, sample->ip);
+	if (packet->sample_type == CS_ETM_EXCEPTION && !sample->insn_len)
+		return;
 
 	cs_etm__frontend_mem_access(etmq, tidq, packet, sample->ip,
 				    sample->insn_len, (void *)sample->insn);
@@ -1564,8 +1563,11 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
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
@@ -1583,7 +1585,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
 		return;
 
-	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
+	if (!cs_etm__packet_has_branch(tidq->prev_packet))
 		return;
 
 	if (etmq->etm->use_thread_stack) {
@@ -1695,7 +1697,8 @@ static int cs_etm__synth_last_instruction_sample(struct cs_etm_queue *etmq,
 	    !etmq->etm->synth_opts.instructions)
 		return 0;
 
-	if (packet->sample_type != CS_ETM_RANGE)
+	/* Only nonempty ranges provide a final instruction to sample. */
+	if (packet->sample_type != CS_ETM_RANGE || !packet->instr_count)
 		return 0;
 
 	ret = cs_etm__synth_instruction_sample(etmq, tidq, packet,
@@ -1729,7 +1732,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	if (!etm->synth_opts.branches)
 		return 0;
 
-	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet) &&
+	if (!cs_etm__packet_has_branch(tidq->prev_packet) &&
 	    !(tidq->prev_packet->flags & (PERF_IP_FLAG_TRACE_BEGIN |
 					  PERF_IP_FLAG_TRACE_END)))
 		return 0;
@@ -1760,6 +1763,9 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	sample.flags = tidq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
+	if (tidq->prev_packet->sample_type == CS_ETM_EXCEPTION)
+		sample.ret_addr = tidq->prev_packet->end_addr;
+
 	cs_etm__copy_insn(etmq, tidq, tidq->prev_packet, &sample);
 
 	/*
@@ -2010,21 +2016,23 @@ static int cs_etm__context(struct cs_etm_queue *etmq,
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
@@ -2418,7 +2426,8 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 		 * instruction packet, set flag PERF_IP_FLAG_TRACE_END
 		 * for previous packet.
 		 */
-		if (prev_packet->sample_type == CS_ETM_RANGE)
+		if (prev_packet->sample_type == CS_ETM_RANGE ||
+		    prev_packet->sample_type == CS_ETM_EXCEPTION)
 			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
 					      PERF_IP_FLAG_TRACE_END;
 		break;
@@ -2450,15 +2459,23 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
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
+					packet->start_addr)) {
+			prev_packet->flags = PERF_IP_FLAG_BRANCH |
+					     PERF_IP_FLAG_RETURN |
+					     PERF_IP_FLAG_SYSCALLRET;
+		}
 		break;
 	case CS_ETM_EXCEPTION_RET:
 		/*
@@ -2486,10 +2503,12 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
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
@@ -2565,7 +2584,9 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
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
@@ -2579,13 +2600,12 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
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
index 4d03f2a680b58aacd91c9f6c957fb2d38e7ac2ad..27201fea5af2764adf85a766925c393ad93d40f8 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -173,6 +173,7 @@ struct cs_etm_queue;
 struct cs_etm_packet {
 	enum cs_etm_sample_type sample_type;
 	enum cs_etm_isa isa;
+	/* For exceptions: source PC, or CS_ETM_INVAL_ADDR. */
 	u64 start_addr;
 	/* For exceptions: preferred return address, or CS_ETM_INVAL_ADDR. */
 	u64 end_addr;

-- 
2.34.1

