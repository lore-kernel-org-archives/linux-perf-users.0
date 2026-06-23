Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078D1DE4FB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243981; cv=none; b=LE1BPzfo9EgQBG1NmTcMTJkvxxSdC5DNv6VBOBB89gy8k0FbrloZbO1l/1vBsSzGS+2ooWPbNWVrCig4pJKXiVKDJU/ReJQn5yBR9ihSnf5CifZ6S10GrscWoijWZ7O89gICwXUN9gDkyYpC4hoDmwnfeS3l/bFTVNZdQaAnChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243981; c=relaxed/simple;
	bh=m4B5vMh/o47S5POOX29zQeyx7jgSY2eMRd09QJSC2aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RMz47h49CqFctnvGWz2XzjvPtHqDKhB2e1lBYuSdk1LZsD2cU9wnVYwfpYAImk9wJIeeqV7NrwpyDig+IHDO10dUcwaKicRhCy/zG7Qglce7FU6sGocLXjUuF5oQdgp7sxGPGhkgH8aELxjiWs7ddPap+Dp+ZC/5FCuhtdf/9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4Ko6Y8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4Ko6Y8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B4E1F000E9;
	Tue, 23 Jun 2026 19:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782243979;
	bh=ujDS3aVoudhawEQ6ZMdTp6Uk7EAL1kzM0xSSASvZelY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J4Ko6Y8esb1hxN+togE21KRypab41EHbsMMzxN6i//sHRHyUNomwVhI1vx2hZ0tzT
	 NwXVyPjemyoOCpM8JLw6K0Espevjj68b88xvGz1W/Xafu1Yi+ymZL1gSPXCMglTaoM
	 uEm2stBHfXEYvFnQYmtcJ7TZdiQOSykbYLb2/G7G+SvmajRvvaSvqBsuuuCEWrITPQ
	 nGxkJb3Rf/sf4+57vy6GrM0/smK2ZOsoD4c8pHJp2MQAqQtR50jMRqbw2FY151RbF6
	 AWG0MLVyIY2LBR6I9P6Jqrh8XuISL0jkv/RY1KhRKhHxYEBzon8OvZ7GeknbT6JXEd
	 QDLVqg4S9kHuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/8] perf cs-etm: Use thread-stack for last branch
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-4-1ba770c862ae@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v7-4-1ba770c862ae@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 19:46:19 +0000
Message-Id: <20260623194619.B3B4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Cross-CPU State Corruption via global thread stack flush in `cs_et=
m__flush()`

Pre-existing issues:
- [Critical] Heap buffer overflow in `thread_stack__br_sample()` when `ts->=
br_stack_sz > sz`
- [High] Unbounded memory leak for per-CPU threads when `callstack` is false
- [High] NULL pointer dereference crash when `thread_stack__event()` is int=
erleaved with `thread_stack__process()`
--

commit b1984c35dca6a97fee9de9c9a7a5db94fd997b41
Author: Leo Yan <leo.yan@arm.com>
perf cs-etm: Use thread-stack for last branch entries

This commit modifies the CoreSight ETM trace code to use the common
thread_stack helper functions for last branch entries. It removes the
private last_branch_rb circular buffer in favor of tracking branch history
at the thread level.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4127120459418..8798bf0471faf 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -1614,6 +1527,42 @@ static inline u64 cs_etm__resolve_sample_time(stru=
ct cs_etm_queue *etmq,
[ ... ]
> +static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
> +				    struct cs_etm_traceid_queue *tidq)
> +{
[ ... ]
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
This is a pre-existing issue, but does passing false for callstack here
trigger an unbounded memory leak in thread_stack__event()?

In tools/perf/util/thread-stack.c, thread__cpu_stack() will
unconditionally return NULL if !ts->stack. Because callstack=3Dfalse skips
allocating ts->stack, thread__cpu_stack() constantly returns NULL.

Subsequently, thread_stack__event() sees a missing stack and re-invokes
thread_stack__new(), allocating and leaking a new ts->br_stack_rb ring
buffer on every single branch event. This could lead to rapid OOM crashes
during trace decoding.

[Severity: High]
This is also a pre-existing issue, but could the new thread stack usage
cause a NULL pointer dereference crash if thread_stack__event() is
interleaved with thread_stack__process()?

If perf script is run with a DB export script, db_export__sample() calls
thread_stack__process(), which supersedes the thread stack with
br_stack_sz=3D0, leaving ts->br_stack_rb as NULL.

If a subsequent branch packet invokes thread_stack__event() here with
br_stack_sz > 0, thread_stack__update_br_stack() will unconditionally
dereference the NULL ts->br_stack_rb buffer.

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
This isn't a bug introduced by this patch, but does calling
thread_stack__br_sample() risk a heap buffer overflow here if
ts->br_stack_sz > sz?

In tools/perf/util/thread-stack.c:thread_stack__br_sample(), when wrapping
the ring buffer, the memcpy incorrectly uses ts->br_stack_pos as the size
scalar instead of the newly computed nr bound:

if (src->nr >=3D ts->br_stack_sz) {
    sz -=3D nr;
    be =3D &dst->entries[nr];
    nr =3D min(ts->br_stack_pos, sz);
    memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
}

If another tracing mechanism (like intel_pt) inflates ts->br_stack_sz
beyond the requested branch stack size sz, this memcpy could write far
beyond the end of the dst->entries allocation.

[ ... ]
> @@ -2020,7 +1956,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
> =20
>  	/* Reset last branches after flush the trace */
>  	if (etm->synth_opts.last_branch)
> -		cs_etm__reset_last_branch_rb(tidq);
> +		thread_stack__flush(tidq->frontend_thread);

[Severity: High]
Could this global thread stack flush cause cross-CPU state corruption?

When a trace discontinuity or block end on a single CPU invokes
cs_etm__flush(), thread_stack__flush() unconditionally loops over all
CPUs for the given thread.=20

For globally shared threads (like the idle thread) or multi-threaded
processes, a local trace flush on one CPU appears to improperly reset
and destroy the active branch stack arrays of all other concurrently
traced CPUs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-arm_cs_=
callchain_support_v1-v7-0-1ba770c862ae@arm.com?part=3D4
