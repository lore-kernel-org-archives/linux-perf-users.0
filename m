Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882029;
	b=kw19GT0rL/QW4q/oRH8Tbcs/8K5AqQjRW+2h3GbB9GAa53xygUqLVuTNBr559CabwzQs
	 KZ2gE0qII0NZXPI8h53jqbXxLnslBPeGfNAB+U1Z/4sCZhlMH+bJ4J9aUWVBIyEmSWbdk
	 +N14UwOy6Z7RkmMHfIvSePlJ+XeyqMD89YkyTdBB6iyjlhGeKRjOWK7GJ+auaqe5scwL0
	 e87QeYPSI4Xog6CXQn6cV6mgJlqUAKIR1fu2x1mz1I2QomJL6p7EjTaRSwpvCHIhALkro
	 3PKV1OkWFQwWJTHo8RNofr+hditWi+QrTyNawpdHEP4hzeA4iSfaLeGV2/IqIGm8ErQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882029;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EoxQ+f7iJhRtgaeAtIe379WMBItl1WTPolZbOvXn6X4=;
	b=1g5TNoRXHj07FOm0TgNAy7+vU46CXV0TBanMVe8BWwiJFBf+YvIHhcrn0Zl8EZAQ2f3y
	 Z+wEauQMYOAW3xIuj52+PVwyhXWfM+Lxv6K3M8fqhYR3e8zlQ2fIudzUWMpT4MFT4uiTp
	 gaNje8innzB/xgJreVh8IuELjCvbwKCtL7t9mtwiQuniPuRyOZa1d/y3bgv63sPUXIHxh
	 k7LOp10WvW6zOgjdi9oSRbXuS5e32ntdX1nwbpxBYmqk+uNvDnzc/geguU46hvBgaHrlp
	 w9WqZ2HhrJEF/ciDrTzPFQOgT9xGtbpkS/PNSDzYkCintPPtwNFXfBVSwJWA1ItWLYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiu2nTJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBC606A326
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iiu2nTJO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1081F000C1;
	Thu,  5 Nov 2026 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882029;
	bh=EoxQ+f7iJhRtgaeAtIe379WMBItl1WTPolZbOvXn6X4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iiu2nTJOYBIvLpdM3OtdmKtJw6cfmaDqB7xL1uLIEVjcYu0XcHQsq5hgtI1GM5oc3
	 5Ng4OvyPuP9RYp+zVODu0duF2hWvXoh2xOHiILAIh+PUfdY8qSuesOwfH3kPGkIora
	 go5yJHUk1kS2HxzT2W4k1DRqV/d8etrmZF1SEWWnvzOZglBkePJPHQCM1KOTGuv6EK
	 0hiiU6K2OtMvSXLpTGGzwrc0KuAfzXL0wKiK1Th3/SN8RvJeFJqFEgvyOXTeiWKUio
	 bc6T+XtNL7R/YElrXh+jlGVzcL5dWVMjYAqZWslI4n5x0SocDV0V8dZfkt8M8iiu8b
	 ZzMfJDgl/AoyA==
Message-ID: <sashiko-outbox-199039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/19] perf cs-etm: Use per-CPU queues for per-thread
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-4-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-4-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:33:48 +0000
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
- [Medium] perf cs-etm: per-CPU queues break TID matching in cs_etm__proces=
s_timeless_queues()
- [Medium] perf cs-etm: missing NULL checks in cs_etm__get_data_block()
--

commit 0f3b8ea285f68a8f46b7c531d58a7ba0f323c483
Author: James Clark <james.clark@linaro.org>

perf cs-etm: Use per-CPU queues for per-thread mode

This commit switches per-thread CoreSight ETM decoding to use per-CPU queues
indexed by the sample CPU instead of a single shared queue, and updates the
trace ID queue threads in cs_etm__get_data_block() when the AUX buffer TID
changes.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5abdd726c6d22..966261429da61 100644
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
As reported by Sashiko on v3 [1], does replacing tidq->frontend_thread here=
 in
cs_etm__get_data_block() clobber the previous thread before its pending tra=
ce
data is flushed?

When two threads run consecutively on the same CPU in per-thread mode, the
final CS_ETM_RANGE or CS_ETM_EXCEPTION packet from the first thread remains=
 in
tidq->prev_packet at the end of its buffer, and its branches remain on its
thread_stack.

When cs_etm__get_data_block() fetches the next buffer for the second thread,
cs_etm_decoder__reset() queues a CS_ETM_DISCONTINUITY packet into
tidq->packet_queue, and cs_etm__flush_all_stack() does nothing because pid_=
fmt
is CS_ETM_PIDFMT_NONE:

tools/perf/util/cs-etm.c:cs_etm__flush_all_stack() {
	...
	switch (pid_fmt) {
	case CS_ETM_PIDFMT_CTXTID2:
		...
	case CS_ETM_PIDFMT_CTXTID:
		cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
		break;
	case CS_ETM_PIDFMT_NONE:
	default:
		break;
	}
}

Overwriting tidq->frontend_thread immediately in cs_etm__get_data_block()
means that when cs_etm__process_traceid_queue() later processes the queued
CS_ETM_DISCONTINUITY packet and calls cs_etm__flush(), it runs against the =
new
thread instead of the previous one:

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

Won't this attribute the previous thread's trailing instruction and trace-e=
nd
branch samples to the new thread, read instruction bytes from the new threa=
d's
address space, and flush the new thread's thread_stack while leaving the old
thread's thread_stack unflushed?

[Severity: Medium]
As reported by Sashiko on v3 [2], can cs_etm__get_data_block() dereference a
NULL pointer if cs_etm__etmq_get_traceid_queue() or machine__findnew_thread=
()
fails?

In timestamped per-thread mode, cs_etm__queue_first_cs_timestamp() calls
cs_etm__get_data_block() before the trace ID queue has been created, so
cs_etm__etmq_get_traceid_queue() allocates tidq here and can return NULL on
allocation failure. Passing tidq->decode_thread to thread__tid() without a
NULL check on tidq will crash.

Similarly, cs_etm__init_traceid_queue() checks that both
tidq->frontend_thread and tidq->decode_thread are non-NULL after calling
machine__findnew_thread(), whereas cs_etm__get_data_block() leaves them NULL
and returns 1 on failure. Should both tidq and the new thread pointers be
checked for NULL here?

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
As reported by Sashiko on v3 [3], how does queuing per-thread AUX fragments
into per-CPU queues interact with timeless decoding in
cs_etm__process_timeless_queues()?

When PERF_RECORD_EXIT is processed in timeless per-thread mode,
cs_etm__process_event() calls cs_etm__process_timeless_queues() with the
exiting thread's TID:

tools/perf/util/cs-etm.c:cs_etm__process_timeless_queues() {
	...
	for (i =3D 0; i < etm->queues.nr_queues; i++) {
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
	...
}

Because auxtrace_queues__queue_buffer() only sets queue->tid on the first
buffer queued to a given CPU queue, and cs_etm__run_per_thread_timeless_dec=
oder()
drains all buffers in that CPU queue in a loop:

1. If thread A and thread B both ran on the same CPU (with thread A first),
   when thread A exits, thread__tid(tidq->frontend_thread) =3D=3D tid match=
es and
   cs_etm__run_per_thread_timeless_decoder() will drain and decode thread B=
's
   buffers on that CPU before thread B exits and before its subsequent MMAP=
 or
   COMM events have been processed.
2. Conversely, if thread B exits before thread A, tidq->frontend_thread sti=
ll
   holds thread A's TID, so thread B's buffers on that CPU will not be deco=
ded
   when thread B exits.
3. For any CPU queue that received no AUX buffers, queue->tid remains 0, so
   cs_etm__etmq_get_traceid_queue() will allocate a traceid_queue and creat=
e a
   spurious TID 0 thread in machines.host.

Does timeless per-thread decoding need to avoid draining buffers belonging =
to
other threads when a single thread exits?

[1] https://lore.kernel.org/r/20261102-james-cs-unformatted-per-thread-fix-=
v3-4-dbcb0c281b9b@linaro.org
[2] https://lore.kernel.org/r/20261102-james-cs-unformatted-per-thread-fix-=
v3-4-dbcb0c281b9b@linaro.org
[3] https://lore.kernel.org/r/20261102-james-cs-unformatted-per-thread-fix-=
v3-4-dbcb0c281b9b@linaro.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D4
