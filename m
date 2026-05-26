Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A33C0A19
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822648; cv=none; b=NA6OFpA/jSyqrQycMWB1QAf+Thi4Nw/gaGR1/nU0icybAIzY26ZKKMhvXH0Semso6aMNC09NnxQXXELl83GVnVzVlbqVyAXG3c+09z3WL8OPFRRrLFhjY3HSJXZ/2wl0NnVIzpqHrV/XgKnDJwSfqb71mifMvNWhxdsZOqsVRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822648; c=relaxed/simple;
	bh=WNvP3ZTPuLxBBR4sR/MaVKFUEqG5jSueo0i1L4tzmWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pttYTtSUUP7WHNANXrZSKV0nkvxSv7/oU4Q7kHL7l8N2oheoohGvXZvPHIE5x6vucrbLKFdyVvTraY4lxn/v1IC/0OKXhYqRwrxWUoayd/O6VYY8MPpJQ4KyEpviRW6qF7o8r/KndjtU9RYtwf59HxPYhVUoKAoxVGB3MUr3dzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKGHEnok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKGHEnok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2FE1F000E9;
	Tue, 26 May 2026 19:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779822647;
	bh=MWDyL4G5gWK4K/3bNT5jJ/pFByo6LkKgHbTMfzlD9kY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VKGHEnokTi2NzVl/bnw91CNDtQXo41zEHIXSAV+9oJpZGI96C8mxcJlAZcaDOfzRa
	 ndOYW6/Pb81jtGHVI4obGwhY5pCEOAAdPYORULal8VxMH+oqOd1sK4L0CFsowLVy3c
	 mKv+flmziLzDdD6PpDzpfXFwE8URcKfB4uZPTm4TX+er8Ie8EErDwWbxqmug/XC0AD
	 WwjRRdY6p1BeLERDBGZUpYfGVljNFCeUtShFcGTQituB8ny+uTFXByxX6Bh8dnlJQX
	 Sy/D5bwOyvtevE/iBaV2Fv4h+J8WuUvTXvb8SHhsAVO3RcM1hfxD/NdBLRZpPzdN0d
	 p2D2Gt4lGJc6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] perf cs-etm: Flush thread stacks after decoder
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-4-f9f49f53c9dd@arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-4-f9f49f53c9dd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 19:10:46 +0000
Message-Id: <20260526191047.0D2FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Flushing all thread stacks globally across the machine upon a pe=
r-queue decoder reset corrupts callchains for threads executing on other CP=
Us.
- [Medium] The thread stack flush callback silently ignores errors returned=
 by `thread_stack__flush()`.
--

commit 5bb375ff87340381fc1d45a283d0256f7738d4d0
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Flush thread stacks after decoder reset

Perf resets the CoreSight decoder when moving to a new AUX trace buffer,
causing a global trace discontinuity. To prevent stale call and return
history from attaching to later threads, this patch flushes all host and
guest thread stacks after a decoder reset.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 398ab3b7a429d..ea2424175558d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> +static int cs_etm__flush_stack_cb(struct thread *thread,
> +				  void *data __maybe_unused)
> +{
> +	thread_stack__flush(thread);
> +	return 0;
> +}

[Severity: Medium]
Does this callback safely ignore errors from thread_stack__flush()?

thread_stack__flush() can return error codes such as -ENOMEM when memory
allocation fails during call and return synthesis. Returning 0 unconditiona=
lly
prevents machine__for_each_thread() from aborting early, but it also
silently drops the error.

Could this mask underlying synthesis failures?

> +
> +static void cs_etm__flush_machine_stack(struct cs_etm_queue *etmq, pid_t=
 pid)
> +{
> +	struct machine *machine;
> +
> +	machine =3D machines__find(&etmq->etm->session->machines, pid);
> +	if (machine)
> +		machine__for_each_thread(machine, cs_etm__flush_stack_cb, NULL);
> +}

[Severity: Medium]
Does flushing all threads globally cause issues for other CPUs?

In CoreSight tracing, traces are decoded using per-CPU queues. When one
cs_etm_queue encounters a trace discontinuity, calling
machine__for_each_thread() will flush the call stacks for all threads in
the machine.

Could this destroy the call and return state of threads that are actively
executing and being decoded on other queues, resulting in corrupted
synthesized callchains for those unrelated threads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-b4-arm_cs_=
callchain_support_v1-v6-0-f9f49f53c9dd@arm.com?part=3D4
