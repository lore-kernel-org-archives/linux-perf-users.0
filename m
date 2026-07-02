Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408D30EF8F
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022873; cv=none; b=lCPQDQu/HCc1D0e0Fy0x9viuBHGstcCmfmD5vmFAkQGQJK3EKqAQf9Lq4hgtnXgb5RE9I49HiDBjMLW2DUQjgJm+NfO9oikcid0bJ8LK7oY4Q8IOFr+6s8qivZinaftOZyCLp5HRkV3VP8rImtI0loJT0Id+qQhYel1Wvm+VMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022873; c=relaxed/simple;
	bh=yv57/dFfqqsowa+MrsmpfHjVpXAeV4P0GaRNFTqoNP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V7Q3rFPTV17wjKw5ALohMaWSY5KMFEG/5JsWiSxQyIGl0LzBvofnHqv5YhLSL8THiuYfbjIh1Y6mqulZs9HFx4tTQFyM0k9HdMF5ZDRqfbimRZUqu8n0l6YM99UasoqQF+kIGMfwQrEeTDrbg5wRU68Dwpht521q4xCLmcHs/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHC5ageY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHC5ageY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE1F1F000E9;
	Thu,  2 Jul 2026 20:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783022871;
	bh=AkM5NY0MkIh+AuLJ0hrgV7neO9QDmosYIRePtFwdM6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHC5ageYMzFYWlOP23eB754fGaColsPhXXtu9zSHPO/FvzGwLETNF599UbSaztRfC
	 OHg0xdA0z1WUUafXmClhqhL3ptQe+tbuXEKCEBl7wGF5oNt8T2oIA7mjpitagXJZe1
	 tY7A+b/t9KebLZxQxXFL4/MHVIRzYr5zEe5EDxX8eSlGT/kj0tyu0YbfwaGAhcmXlw
	 n/hJLakf+bfHHufM0MLm26AhLM9rETtL/OKy11IZC3OT9yS7vLUpbThuHjX4+mVziX
	 l6cxYL/sFk3tKOUUpguMivp4lxnmYnbahhWiCw7MTyZXWWLnGTpaAB5/M/yqD5of9o
	 0A4ks9753NPhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/9] perf cs-etm: Use thread-stack for last branch
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-5-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
 <20260702-b4-arm_cs_callchain_support_v1-v11-5-846abbf600d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 20:07:51 +0000
Message-Id: <20260702200751.7FE1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Branch stack corruption and trace history loss in CPU-wide and idl=
e-thread traces due to `thread_stack` sharing and global flushing.
--

commit 2e2bc54f5f904af76d7d22b2bf5c9fcfc4cc32e8
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Use thread-stack for last branch entries

This commit replaces the private last branch circular array with the common
thread_stack helpers. It records taken branches with thread_stack__event()
and synthesizes PERF_SAMPLE_BRANCH_STACK data with thread_stack__br_sample(=
).

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1637,6 +1550,57 @@ static inline u64 cs_etm__resolve_sample_time(stru=
ct cs_etm_queue *etmq,
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

[Severity: High]
In CPU-wide trace scenarios where queue->tid is -1,
cs_etm__init_traceid_queue() assigns the same dummy thread (PID -1, TID -1)
to tidq->frontend_thread across all queues.

Since thread_stack__per_cpu() returns false for PID -1, will all CPUs end up
sharing a single thread_stack?

If they share a single stack, interleaving cross-CPU decoding will pass
different etmq->buffer->buffer_nr + 1 trace numbers into
thread_stack__event(). Can this cause the stack to be continuously flushed
due to the mismatched trace numbers, leading to branch trace history loss?

[ ... ]

> @@ -2046,7 +1992,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
> =20
>  	/* Reset last branches after flush the trace */
>  	if (etm->synth_opts.last_branch)
> -		cs_etm__reset_last_branch_rb(tidq);
> +		thread_stack__flush(tidq->frontend_thread);

[Severity: High]
For threads that do get per-CPU stacks, such as the idle thread (PID 0,
TID 0), thread_stack__flush() unconditionally iterates over and flushes the
stacks for all CPUs associated with that thread.

Does calling thread_stack__flush() here inadvertently wipe the branch trace
history for all CPUs on the idle thread, rather than performing a
queue-local reset for just the one CPU being processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-b4-arm_cs_=
callchain_support_v1-v11-0-846abbf600d7@arm.com?part=3D5
