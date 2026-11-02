Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622875;
	b=5BBmEDTu5o9Av0ykvsXOhH9S3lnkSONt3ddX4GcIdWqX5lUEqiQ/GquiPnwL5PKF04dO
	 mt9tEN7nnJL8PeMh4qLEqnVcsgnnASYixuEUhrmTQ5plCEPXrMcc6g8hWavQ5r8i6f6p2
	 JUWu/3d/piEWAL9ES+VTYKUis0w4FFpkz+qPCR3KgQpy6V77ns2nXoMcXm+n2QEHir1tD
	 pE8/mFYY5l+AWYJGLhczYuQJrzMbIOeC7BG6rt8MxDZEl6fSxMsQ3lHcCeB4XDcShKKtq
	 gSJIWngFxcGM10Zj8fenTo4zf+Q4StHo53CMPb9lvLLkRBFQ1w4ZIvfyhgOVJTEVyDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2gEo+UMWCH1ZzQM5IKvCTVmf88oxoc6d6TnMlxNpPtg=;
	b=OJGWZDlahR6Dwz4wBDbpTnMLxhhr6LOcqW5VEkDhFO+MIYQL4p5TP3E//gPvZowh+BAz
	 RJVfSteWUA9taij2htRksT7Equxz8rI5rJyWJ2KsNtUjihV+2cULJOSXrfi8VDHksJ5VO
	 utihFWLWCUh3HUSfuEwWK5ToHm9zSqoYjFhhrSHlXyNAfB65rKrU2SMVY9FouJjuOJyzr
	 g2/jiE9YEQXoHAH28oc1Pz4Xjq4pYQ2tO+c0HRX367wbBTGArZ3pGIs32an5YxdJOPLh2
	 NN4BRd7YvdXZFHugc5yFTaEGWnoZ46hbE3blSfj+CTmLT/QDSuOOpJ7+XOkP4JAoKYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6IilQor;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5460A2605
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6IilQor
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166CD1F00A17;
	Mon,  2 Nov 2026 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622875;
	bh=2gEo+UMWCH1ZzQM5IKvCTVmf88oxoc6d6TnMlxNpPtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J6IilQorN31P7HmukBRoOidUBauoIM7QFgJWqv+lH26cbXUWikY2WfK0fBZKQ/bwD
	 C5pcYPggUjmYCxRaT9CS3LfUR0JOup/HLYqNsLocjKFR/yvJpXQH8C7xgV91/uWH2c
	 dntpZDz+ds0LpahiGpBuX1+NR7wfOB9PK7ctAst9LG4BVqxx5Am3t/7FYFOLx67/F0
	 q/Dmqe9bkCzeO97q8N9BIKEts813cKgOlwatwEHyhLVJv5NxwS6UCtqiyH+rRfFYgh
	 3ufpWtcYp+POFrVnShhVrBey/GFmP6oeMT+1gkRtqQtvuD4iw9otVTXm8V2shmf/FG
	 UjrQ0t1OfV/qg==
Message-ID: <sashiko-outbox-193423@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/18] perf cs-etm: Use per-CPU queues for per-thread
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-4-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-4-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:34:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf cs-etm: cs_etm__get_data_block() clobbers frontend_thread b=
efore flush
- [Medium] perf cs-etm: missing NULL checks in cs_etm__get_data_block()
- [Medium] perf cs-etm: per-CPU queues break TID matching in cs_etm__proces=
s_timeless_queues()
--

commit e38f1bcfae5e4494bb005e6c5cf9aa519d0b1814
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Use per-CPU queues for per-thread mode

This commit switches per-thread CoreSight ETM decoding to use per-CPU queues
and re-initializes the trace ID queue's threads in cs_etm__get_data_block()
when the AUX buffer TID changes on a CPU.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 509ec014b2760..f19aa4f787fa3 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -2215,6 +2209,29 @@ static int cs_etm__get_data_block(struct cs_etm_qu=
eue *etmq)
>  	 */
>  	cs_etm__flush_all_stack(etmq);
> =20
> +	/*
> +	 * Per-thread mode still uses a queue for each CPU, but that CPU can run
> +	 * different threads. When the TID from the AUX record on a CPU changes,
> +	 * re-initialize the thread using the AUX record/buffer fragment TID so
> +	 * we can start decoding even if the context ID packet was cropped or
> +	 * they're disabled.
> +	 */
> +	if (etm->per_thread_decoding) {
> +		struct cs_etm_traceid_queue *tidq =3D cs_etm__etmq_get_traceid_queue(e=
tmq,
> +							CS_ETM_PER_THREAD_TRACEID);
> +
> +		if (thread__tid(tidq->decode_thread) !=3D etmq->buffer->tid) {
> +			thread__zput(tidq->frontend_thread);
> +			thread__zput(tidq->decode_thread);
> +			tidq->frontend_thread =3D machine__findnew_thread(
> +				&etm->session->machines.host, -1,
> +				etmq->buffer->tid);
> +			tidq->decode_thread =3D machine__findnew_thread(
> +				&etm->session->machines.host, -1,
> +				etmq->buffer->tid);
> +		}
> +	}

[Severity: Medium]
When two threads run consecutively on the same CPU in per-thread mode, can
replacing tidq->frontend_thread here in cs_etm__get_data_block() clobber the
previous thread before its trailing packets and thread stack are flushed?

At the end of an AUX buffer for thread A, the last CS_ETM_RANGE or
CS_ETM_EXCEPTION packet remains in tidq->prev_packet. When
cs_etm__get_data_block() loads the next AUX buffer on that CPU for thread B,
cs_etm_decoder__reset() queues a CS_ETM_DISCONTINUITY packet into
tidq->packet_queue, and cs_etm__flush_all_stack() is a no-op because pid_fmt
is CS_ETM_PIDFMT_NONE in per-thread mode:

tools/perf/util/cs-etm.c:cs_etm__flush_all_stack() {
	...
	switch (pid_fmt) {
	...
	case CS_ETM_PIDFMT_NONE:
	default:
		break;
	}
}

Because cs_etm__get_data_block() immediately overwrites tidq->frontend_thre=
ad
with thread B before the frontend processes the queued CS_ETM_DISCONTINUITY
packet, the subsequent call to cs_etm__process_traceid_queue() ->
cs_etm__flush() runs with tidq->frontend_thread already pointing to thread =
B:

tools/perf/util/cs-etm.c:cs_etm__flush() {
	...
	err =3D cs_etm__synth_last_instruction_sample(etmq, tidq);
	if (err)
		return err;

	err =3D cs_etm__synth_branch_sample(etmq, tidq);
	if (err)
		return err;

swap_packet:
	cs_etm__packet_swap(etm, tidq);

	/* Reset last branches after flush the trace */
	if (etm->use_thread_stack)
		thread_stack__flush(tidq->frontend_thread);
	...
}

Wouldn't this attribute thread A's trailing instruction and TRACE_END branch
samples to thread B, read instruction bytes from thread B's memory maps via
cs_etm__copy_insn() -> cs_etm__frontend_mem_access(), and flush thread B's
thread_stack while leaving thread A's thread_stack unflushed?

[Severity: Medium]
As reported by Sashiko on v2 [1], what happens if
cs_etm__etmq_get_traceid_queue() or machine__findnew_thread() returns NULL =
in
cs_etm__get_data_block()?

In timestamped per-thread mode, cs_etm__process_timestamped_queues() ->
cs_etm__queue_first_cs_timestamp() -> cs_etm__get_data_block() is the first
call site that allocates the trace ID queue for etmq. If memory allocation
fails inside cs_etm__etmq_get_traceid_queue(), tidq is NULL and passing
tidq->decode_thread to thread__tid() will dereference a NULL pointer.

Similarly, if either machine__findnew_thread() call returns NULL when
re-initializing tidq->frontend_thread and tidq->decode_thread,
cs_etm__get_data_block() still returns 1, unlike cs_etm__init_traceid_queue=
()
which checks both pointers:

tools/perf/util/cs-etm.c:cs_etm__init_traceid_queue() {
	...
	tidq->frontend_thread =3D machine__findnew_thread(&etm->session->machines.=
host, -1,
					       queue->tid);
	tidq->decode_thread =3D machine__findnew_thread(&etm->session->machines.ho=
st, -1,
					       queue->tid);
	if (!tidq->frontend_thread || !tidq->decode_thread)
		goto out;
}

Should cs_etm__get_data_block() check for NULL returns from
cs_etm__etmq_get_traceid_queue() and machine__findnew_thread() and return
-ENOMEM on failure?

> +
>  	return 1;
>  }
> =20
> @@ -3288,7 +3305,9 @@ static int cs_etm__queue_aux_fragment(struct perf_s=
ession *session, off_t file_o
> =20
>  	if (aux_offset >=3D auxtrace_event->offset &&
>  	    aux_offset + aux_size <=3D auxtrace_event->offset + auxtrace_event-=
>size) {
> -		struct cs_etm_queue *etmq =3D cs_etm__get_queue(etm, auxtrace_event->c=
pu);
> +		/* Old per-thread files have no CPU (before v6.4) */
> +		int queue_idx =3D sample->cpu =3D=3D (u32)-1 ? 0 : sample->cpu;
> +		struct cs_etm_queue *etmq =3D cs_etm__get_queue(etm, queue_idx);
> =20
>  		if (!etmq)
>  			return -EINVAL;
> @@ -3301,6 +3320,7 @@ static int cs_etm__queue_aux_fragment(struct perf_s=
ession *session, off_t file_o
>  		auxtrace_fragment.auxtrace.size =3D aux_size;
>  		auxtrace_fragment.auxtrace.offset =3D aux_offset;
>  		auxtrace_fragment.auxtrace.idx =3D etmq->queue_nr;
> +		auxtrace_fragment.auxtrace.cpu =3D etmq->queue_nr;

[Severity: Medium]
Now that cs_etm__queue_aux_fragment() places per-thread AUX fragments into
per-CPU queues indexed by sample->cpu, how does timeless per-thread decoding
work when PERF_RECORD_EXIT triggers cs_etm__process_timeless_queues()?

In cs_etm__process_event(), PERF_RECORD_EXIT passes the exiting thread's TID
to cs_etm__process_timeless_queues():

tools/perf/util/cs-etm.c:cs_etm__process_event() {
	...
	case PERF_RECORD_EXIT:
		if (etm->per_thread_decoding && etm->timeless_decoding)
			return cs_etm__process_timeless_queues(etm,
							       event->fork.tid);
		break;
}

And cs_etm__process_timeless_queues() still assumes each queue belongs to a
single thread matching tidq->frontend_thread:

tools/perf/util/cs-etm.c:cs_etm__process_timeless_queues() {
	...
		if (etm->per_thread_decoding) {
			tidq =3D cs_etm__etmq_get_traceid_queue(
				etmq, CS_ETM_PER_THREAD_TRACEID);

			if (!tidq)
				continue;

			if (tid =3D=3D -1 || thread__tid(tidq->frontend_thread) =3D=3D tid)
				cs_etm__run_per_thread_timeless_decoder(etmq);
		} else
			cs_etm__run_per_cpu_timeless_decoder(etmq);
}

Because auxtrace_queues__queue_buffer() only sets queue->tid once when the
first buffer is queued on a CPU (and leaves queue->tid as 0 on CPUs with no
queued buffers):

1. For every CPU queue that never received an AUX buffer, etmq is non-NULL =
and
   queue->tid is 0, so cs_etm__etmq_get_traceid_queue() allocates a trace ID
   queue and creates a bogus TID 0 thread in machines.host.

2. If thread T1 and thread T2 both ran on the same CPU (with T1 queued firs=
t),
   when T1 exits, thread__tid(tidq->frontend_thread) =3D=3D T1 matches and
   cs_etm__run_per_thread_timeless_decoder() drains every buffer in that CP=
U's
   queue, decoding T2's buffers prematurely before T2's subsequent MMAP or
   COMM events have been processed.

3. Conversely, if T2 exits before T1, thread__tid(tidq->frontend_thread) is=
 T1
   rather than T2, so T2's buffers on that CPU are not decoded on T2's
   PERF_RECORD_EXIT event.

Does timeless per-thread decoding also need to be updated to handle per-CPU
queues shared across multiple threads?

[1] https://lore.kernel.org/r/20260821-james-cs-unformatted-per-thread-fix-=
v2-4-00c4fd0701b4@linaro.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D4
