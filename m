Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD74968F5
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198335; cv=none; b=RvBd7fzE/Oq44a2MoHntA7iOq1i9/QBFK6A9r3P8K1zfzCtGc9xG19/Io0/gVkVnsRCPsO247osHqhXshb5kdB2GTyvShfvjQFZWKYgQ8kk2+yWD8HpOv2VX7GdiBuXMnhOP1Y3t7ijzAXIJnYo31aQsko+9IOBUXKPD96Sx9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198335; c=relaxed/simple;
	bh=Uvtmr2KKzW6vjUzUl43txtaoYUnaloIEQmk52xfPPOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eX8OaZVzo7007MtKT1Lhzr/PnlkYpLk4rUoXbjh+5LdNj50c+Chn8JVqCpV2YN81IipJaQeUcXZnEtDZbmADLQyXxOE6uttrcsV5WKnReQhnrZSvpPMJpR7Snwqih0y6P8ySriqe3tbehC0npBsTdMGNDmNCPE3oL+oRu7zxNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvmNOvR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvmNOvR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8031F00893;
	Thu, 11 Jun 2026 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198327;
	bh=AoVen7e1m+GCRwoJ0A+YIozd9FUclxQZRaQJGpoPOOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YvmNOvR+/ooaj0IPaeIExi5EFnHy3hBQm/U4Ici4J35lGidJ42mv8R6sZmlBcMQyx
	 NAMIVyUeqeY6beUoe07G6Qg5OUbA5w94szWvK0My8cOxpNHhEW0yTBY8g3ql4ZKWt1
	 XdEEce71C+lsnJXjxwniTuSKaIn1m/J/0GqRiQlQWtP9izgAhTmF6Zs9UXFCkyhHxV
	 W/+g7t8892ED/u2lfWiiEVR4PEA1je9v1A12XTx733pVD1mi1xR8BKvXR2njY0lR+B
	 9VJhcQdquf6mPVKylD6Q2cv7yAnSZc7D/IRAtCZA1gwd7n21itlt2n7txu7zLYUvHQ
	 lesmcPe98bTcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/8] perf cs-etm: Use thread-stack for last branch
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v8-4-737948584fea@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v8-4-737948584fea@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:18:46 +0000
Message-Id: <20260611171846.DC8031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Branch history and callchain are corrupted in CPU-wide trace mod=
e due to sharing a single `thread_stack` across all CPUs.
- [Medium] Improper handling of trace discontinuity via `thread_stack__flus=
h()` causes stale branches and cross-CPU corruption.
- [Medium] Missing NULL check on thread allocation leads to segmentation fa=
ult in newly added `thread_stack__flush()`.

Pre-existing issues:
- [Critical] Heap buffer overflow (out-of-bounds write) in `thread_stack__b=
r_sample` due to incorrect `memcpy` length.
--

commit 0a266f6d8db7cc2c2667bdbd916921a70696b02b
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Use thread-stack for last branch entries

This commit replaces the custom CoreSight ETM last branch circular array
with the common thread_stack helpers. It records taken branches with
thread_stack__event() and synthesizes PERF_SAMPLE_BRANCH_STACK data with
thread_stack__br_sample().

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4127120459418..8798bf0471faf 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1614,6 +1527,42 @@ static inline u64 cs_etm__resolve_sample_time(stru=
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
> +	u64 from, to;
> +	int size;
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
In CPU-wide tracing mode where hardware context IDs are absent, queue->tid
is initialized to -1. machine__findnew_thread() assigns the same dummy
thread (TID=3D-1) to all trace queues. Because thread_stack__per_cpu() only
handles TID=3D0 for idle tasks, all CPU trace queues will share the exact
same thread_stack object.

Does this cause thread_stack__event() to push branches from multiple CPUs
into the same shared branch stack ring buffer, corrupting the trace output
by interleaving them?

> +	} else {
> +		thread_stack__set_trace_nr(tidq->frontend_thread,
> +					   tidq->prev_packet->cpu,
> +					   etmq->buffer->buffer_nr + 1);
> +	}
> +}
> +

[ ... ]

> @@ -1644,8 +1593,11 @@ static int cs_etm__synth_instruction_sample(struct=
 cs_etm_queue *etmq,
> =20
>  	cs_etm__copy_insn(etmq, tidq, packet, &sample);
> =20
> -	if (etm->synth_opts.last_branch)
> +	if (etm->synth_opts.last_branch) {
> +		thread_stack__br_sample(tidq->frontend_thread, tidq->packet->cpu,
> +					tidq->last_branch, tidq->br_stack_sz);

[Severity: Critical]
This is a pre-existing issue, but calling thread_stack__br_sample() can
trigger an out-of-bounds write in that function.

In thread_stack__br_sample(), when copying from the wrapped ring buffer, it
calculates bounds using nr but ignores it in memcpy:

	nr =3D min(ts->br_stack_pos, sz);
	memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);

If the destination buffer size sz is smaller than ts->br_stack_pos, does the
memcpy write beyond the allocated bounds for nr elements?

>  		sample.branch_stack =3D tidq->last_branch;
> +	}

[ ... ]

> @@ -2020,7 +1956,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
> =20
>  	/* Reset last branches after flush the trace */
>  	if (etm->synth_opts.last_branch)
> -		cs_etm__reset_last_branch_rb(tidq);
> +		thread_stack__flush(tidq->frontend_thread);

[Severity: Medium]
In cs_etm__init_traceid_queue(), the return value of
machine__findnew_thread() is not checked, meaning tidq->frontend_thread
could be NULL upon memory allocation failure.

Does thread_stack__flush() dereference tidq->frontend_thread without
validation, potentially leading to a segmentation fault on error paths?

[Severity: Medium]
Looking at thread_stack__flush(), it clears the call stack but does not
reset the branch stack array (ts->br_stack_pos and ts->br_stack_rb remain
intact).

Will this leave stale branch entries from before a trace gap to be prepended
to the new trace segment?

Additionally, thread_stack__flush() iterates and flushes stacks for all
CPUs associated with the thread. For a shared dummy thread (TID=3D-1) or the
idle thread (TID=3D0), does this inappropriately flush and destroy in-progr=
ess
histories for all other CPUs?

> =20
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-arm_cs_=
callchain_support_v1-v8-0-737948584fea@arm.com?part=3D4
