Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0C40B6EE
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820347; cv=none; b=HvXYFCMd20JPymMBGpwuxLGqdlPEQiwLz3BzgT02lFtANMfcjihoNo6ZOa6+RP8i4xcI6j6uIraCf4B6eH9NJvMvcgFfZyFosrbTvilkLz7i6WrH8UMdIlrioNwdcS6wK5yEw/Xs2iJZwmVm671m8al/ySzkAm12Fuuja86nO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820347; c=relaxed/simple;
	bh=vkWY2pwRUjYo08lNGtur+k2dF0+dUG3dKa3M/HDliAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rzXO11F7BW62fvNPFHv+t6r5kTVBgGk5KZKgOfmX0G0eO8i7szpOSJEZdB+cuu0CFs9QOcsd+nybfHQmVGUecJepUCc5fKYuzEABZgpdG6uyss+4QAVgmI4+9KNN2kGHpy2E/P2S+1HU5ar0Q7oyuGNsCVWipadqzznCa4akM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGkxmEMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGkxmEMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376271F000E9;
	Tue, 26 May 2026 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779820346;
	bh=L4LyxIQRJvYvCdQSZLQGMe3OtsJ3yVqg1xtRoG9GwWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGkxmEMuEtCbFJ5j4pGfRd4XkqFe64iNiL0oshOjeH4+4tjU2EDijah3C/RZBBr6z
	 yBSzB+TG3WKi0n2i2FGdA0Dx5ohmaHG4xGLWSrUV4tX1TkX3RZezB1Zqtzgbj/C7D0
	 q5llJ9WfBHHi1JEpcZ/BM9VMz3TEaY9YVun3VsNmcMiHH3QQltcCIUwGIluBuwanwQ
	 SV9V1XNnPIyyiS0j1HwspEm1XxiFvIsNE4ffKjdt5T8ReIF6iubU52xklToFHLgPWn
	 hDPDUviJo5huGyM5xsEeVuYjdLHVt8rMLcIoWRCZsOG03GdBXIHF962d1ec3VK28a1
	 dXgvmY/CsFXSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] perf cs-etm: Use thread-stack for last branch
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-3-f9f49f53c9dd@arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-3-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 18:32:25 +0000
Message-Id: <20260526183226.376271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Flushing the thread branch stack via thread_stack__flush() globall=
y resets branch state for all CPUs a thread has run on, corrupting concurre=
nt branch traces.
- [High] Unconditional NULL pointer dereference of `tidq->thread` in `cs_et=
m__flush()` when flushing the thread stack.
- [Medium] Forcing the creation of a full callstack introduces hidden CPU a=
nd memory overhead even when only branch tracking is requested.

Pre-existing issues:
- [Critical] Heap buffer overflow in thread_stack__br_sample() when copying=
 branch entries.
- [High] NULL pointer dereference in thread_stack__update_br_stack() when p=
rocessing mixed perf events.
--

commit 423cf82c1cfc3330f4878f3ed31b1cf46de41008
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Use thread-stack for last branch entries

CS ETM maintains its own circular array for last branch entries, with
local helpers to update, copy and reset the branch stack. This duplicates
logic already provided by the common code.

Record branch with thread_stack__event() and synthesize branch stack
with thread_stack__br_sample(). This removes the local last_branch_rb
buffer and position tracking.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1579,6 +1492,37 @@ static inline u64 cs_etm__resolve_sample_time(
> +		/* Enable callchain so thread stack entry can be allocated */
> +		thread_stack__event(tidq->thread, tidq->prev_packet->cpu,
> +				    tidq->prev_packet->flags, from, to, size,
> +				    etmq->buffer->buffer_nr + 1, true,
> +				    tidq->br_stack_sz, 0);

[Severity: High]
This is a pre-existing issue, but is there a NULL pointer dereference in
thread_stack__update_br_stack() when processing mixed perf events?

If a thread stack is initially created by a normal PERF_RECORD_SAMPLE event
via thread_stack__process(), it is initialized with br_stack_sz =3D 0.
Consequently, ts->br_stack_rb is left as NULL.

When an auxtrace record (from intel-pt or cs-etm) is processed subsequently,
thread_stack__event() bypasses initialization because the thread stack alre=
ady
exists.=20

It then unconditionally calls thread_stack__update_br_stack() since
tidq->br_stack_sz > 0, which dereferences ts->br_stack_rb->entries[...],
causing an immediate crash.

[Severity: Medium]
Does passing true for the callstack parameter force the creation of a full
callstack?

This causes thread_stack__event() to parse PERF_IP_FLAG_CALL and
PERF_IP_FLAG_RETURN events and maintain a full function call stack in memor=
y.

Could this introduce hidden CPU and memory overhead even when users only
requested the lightweight --last-branch tracking?

[ ... ]

> @@ -1608,8 +1552,12 @@ static int cs_etm__synth_instruction_sample(
> =20
>  	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
> =20
> -	if (etm->synth_opts.last_branch)
> +	if (etm->synth_opts.last_branch) {
> +		thread_stack__br_sample(tidq->thread, tidq->packet->cpu,
> +					tidq->last_branch,
> +					tidq->br_stack_sz);

[Severity: Critical]
This is a pre-existing issue, but does thread_stack__br_sample() have a heap
buffer overflow when copying branch entries?

If ts->br_stack_sz is greater than the size of the destination buffer, the
wrap-around logic is triggered.

The second memcpy intended to copy the remaining elements is:
memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);

It completely ignores the calculated nr bounds and copies up to ts->br_stac=
k_sz
entries into the destination buffer. For Intel PT, ts->br_stack_sz can be 1=
024
while the destination size is 16.

Can this write hundreds of branch entries past the end of the array,
leading to a heap buffer overflow?

[ ... ]

> @@ -1982,7 +1915,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
> =20
>  	/* Reset last branches after flush the trace */
>  	if (etm->synth_opts.last_branch)
> -		cs_etm__reset_last_branch_rb(tidq);
> +		thread_stack__flush(tidq->thread);

[Severity: High]
Does thread_stack__flush() globally reset the branch state for all CPUs a
thread has run on?

For threads that can run on multiple CPUs concurrently (e.g., the idle thre=
ad),
thread->ts points to an array of thread stacks for each CPU, and
thread_stack__flush() iterates over ts->arr_sz and resets all of them.

Can this cause a trace discontinuity on one CPU's queue to wipe out the act=
ive
branch histories and call chains of the same thread on all other CPUs?

[Severity: High]
Can tidq->thread be NULL here?

In cs_etm__init_traceid_queue(), tidq->thread is initialized via
machine__findnew_thread(), which may return NULL on allocation failure.

If tidq->thread is NULL, won't thread_stack__flush() cause an immediate NULL
pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-b4-arm_cs_=
callchain_support_v1-v6-0-f9f49f53c9dd@arm.com?part=3D3
