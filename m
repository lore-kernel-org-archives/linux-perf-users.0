Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB57376497
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729771; cv=none; b=qGx4scImFJjqHDQVz4JmlbeJNUMKPd3ZFNTJGaiYp1eOw1VZTSyRfTSbzDuaWAkYQi14YRixpXOkbhWJgy0lDpfyrFQd3pr+J/gxId3sRtXkfdJXzW44uuWa/+Mx7n7HLryqhpXntFY/EA/Hi2uRGDVgSBZ+HyiwkbIQb3sZDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729771; c=relaxed/simple;
	bh=IhwbWJODW8DYjmk0rml6TZf1FRRL3y3mKqAO+6OHr2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cq6ifgUuysfn6qh8mW7zk7VsH6pcScfaRI243uSnOlv85U7Cx27L3xIU2DfLCq9YbVDS9KocVZ75sMZLBwdUuaB4cqEyPxHILlXjSpTLUMREIiORPs/vY5XeckzPj/Yyyq9Vb5+A6pY2yzrCFWErrche4UrFTEuDvo5ggVEzLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YovIiHZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YovIiHZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73851F00A3A;
	Wed, 17 Jun 2026 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729770;
	bh=nwiQTveffu8QPzDj15JY6wdYKf57rSepQmQpEMZ3Ffo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YovIiHZ+lk1WPgByyXp5F2cw3QgdjzhcDqJ1lO7ndDeOzNgYs64eKhMT4GC33+o4f
	 Ga1DWRjDpnwcAi95yxiFV4tialer9T1byPtcHHg+B8I0ghuUoaOFHh+ow6BH35UEu5
	 Mfv9W/SbKSGeLwW4aVUcHknyg5AzLTSUbCYGEB38WbqHxpadEF1wqcQ3j8S/kbhCdK
	 Z3M4RFFjKcbpVMKRsktoSwGjJ2MK3ywdHCC03E7pOmfa3uveMfFped92z8XTtCNqAD
	 JWXvI8jx3Dj4FsD+vShtC95Bkfw977oXNgaOBFSuEaBy7KAvCP4c1zP0QUmsq+YWOU
	 zc+vjJloLapqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/9] perf cs-etm: Use thread-stack for last branch
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260617-b4-arm_cs_callchain_support_v1-v10-5-e8b6e5d63db5@arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
 <20260617-b4-arm_cs_callchain_support_v1-v10-5-e8b6e5d63db5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:56:09 +0000
Message-Id: <20260617205609.D73851F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Integration with `thread_stack__event` exposes a fatal NULL poin=
ter dereference when CS ETM branch tracing is used concurrently with db-exp=
ort.
- [Medium] Calling `thread_stack__flush` with `frontend_thread` erroneously=
 flushes branch stacks for all CPUs instead of just the affected channel.

Pre-existing issues:
- [Critical] Preexisting heap buffer overflow in `thread_stack__br_sample` =
when copying ring buffer elements.
--

commit 6bec7142808bcd09595848f0ba62d4272539a5be
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Use thread-stack for last branch entries

This commit refactors CS ETM to use common thread-stack helpers for
last branch entries instead of maintaining its own circular array.
It removes the private last_branch_rb buffer and synthesizes branch stack
data using thread_stack__event() and thread_stack__br_sample().

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 6827ef8871a8f..5ede0f0ff8c6e 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1619,6 +1532,57 @@ static inline u64 cs_etm__resolve_sample_time(stru=
ct cs_etm_queue *etmq,
>  		return etm->latest_kernel_timestamp;
>  }
> =20
> +static bool cs_etm__packet_has_taken_branch(struct cs_etm_packet *packet)
> +{
> +	if (packet->sample_type =3D=3D CS_ETM_RANGE &&
> +	    packet->last_instr_taken_branch)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
> +				    struct cs_etm_traceid_queue *tidq)
> +{
> +	struct cs_etm_auxtrace *etm =3D etmq->etm;
> +	u64 from, to;
> +	int size;
> +
> +	if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
> +		return;
> +
> +	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
> +		return;
> +
> +	if (etmq->etm->synth_opts.last_branch) {
> +		from =3D cs_etm__last_executed_instr(tidq->prev_packet);
> +		to =3D cs_etm__first_executed_instr(tidq->packet);
> +
> +		size =3D cs_etm__instr_size(etmq, tidq, tidq->prev_packet, from);
> +
> +		/* Enable callchain so thread stack entry can be allocated */
> +		thread_stack__event(tidq->frontend_thread, tidq->prev_packet->cpu,
> +				    tidq->prev_packet->flags, from, to, size,
> +				    etmq->buffer->buffer_nr + 1, false,
> +				    tidq->br_stack_sz, 0);

[Severity: Medium]
When CS ETM traces are processed with db-export (e.g., via a Python script),
could this integration with thread_stack__event() expose a NULL pointer
dereference?

If db-export supersedes the stack, thread_stack__process() recreates ts with
br_stack_sz =3D 0:

tools/perf/util/thread-stack.c:thread_stack__process() {
    ...
    thread_stack__reset(thread, ts);
    ts =3D NULL;
    ...
}

However, subsequent trace packets cause CS ETM to call thread_stack__event()
with a br_stack_sz greater than 0, which blindly invokes
thread_stack__update_br_stack(). Can this dereference a now-NULL
ts->br_stack_rb?

tools/perf/util/thread-stack.c:thread_stack__update_br_stack() {
    ...
    be =3D &bs->entries[ts->br_stack_pos];
    ...
}

> +	} else {
> +		thread_stack__set_trace_nr(tidq->frontend_thread,
> +					   tidq->prev_packet->cpu,
> +					   etmq->buffer->buffer_nr + 1);
> +	}
> +}
> +
> +static void cs_etm__sample_branch_stack(struct cs_etm_auxtrace *etm,
> +					struct cs_etm_traceid_queue *tidq,
> +					struct perf_sample *sample)
> +{
> +	if (etm->synth_opts.last_branch) {
> +		thread_stack__br_sample(tidq->frontend_thread, tidq->packet->cpu,
> +					tidq->last_branch, tidq->br_stack_sz);

[Severity: High]
This is a pre-existing issue, but I wanted to ask about a potential heap
buffer overflow in thread_stack__br_sample() when copying ring buffer
elements.

When the branch stack ring buffer wraps around, the function copies the
remaining older elements:

tools/perf/util/thread-stack.c:thread_stack__br_sample() {
    ...
    if (src->nr >=3D ts->br_stack_sz) {
        sz -=3D nr;
        be =3D &dst->entries[nr];
        nr =3D min(ts->br_stack_pos, sz);
        memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
    }
    ...
}

Since the second memcpy() uses bsz * ts->br_stack_pos instead of bsz * nr,
and ts->br_stack_sz can be dynamically allocated to be much larger than the
requested size (for example, intel-pt allocates requested_size + 1024),
could ts->br_stack_pos exceed the remaining capacity of the destination
buffer and cause an out-of-bounds write?

> +		sample->branch_stack =3D tidq->last_branch;
> +	}
> +}

[ ... ]

> @@ -2025,7 +1971,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
> =20
>  	/* Reset last branches after flush the trace */
>  	if (etm->synth_opts.last_branch)
> -		cs_etm__reset_last_branch_rb(tidq);
> +		thread_stack__flush(tidq->frontend_thread);

[Severity: Medium]
Does calling thread_stack__flush() with the frontend_thread clear the branch
stacks for all CPUs?

The thread_stack__flush() function iterates over all per-CPU thread stacks
allocated for the given thread struct:

tools/perf/util/thread-stack.c:thread_stack__flush() {
    ...
    for (pos =3D 0; pos < ts->arr_sz; pos++) {
    ...
}

In CPU-wide tracing modes, frontend_thread represents the shared idle thread
across all CPUs. Could a trace discontinuity on a single CPU inadvertently
wipe out the active branch stacks for all other unaffected CPUs instead of
restricting the flush to tidq->prev_packet->cpu?

> =20
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-b4-arm_cs_=
callchain_support_v1-v10-0-e8b6e5d63db5@arm.com?part=3D5
