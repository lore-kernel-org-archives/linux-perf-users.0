Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766F3C9EFD
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653591; cv=none; b=mYiYVKnEOqc26wecVID6HyqJbal6vNfXi+gB01Eak7YE7BTYEHQ+CrDGkfImQYH4itK6Kq2KKRwyFiYpLyfRzWs/b4utS840VVUznrade2P6y/+a41+1bXAeP5Ek2uumYLNFpXc0+okPVED0cWo45GD+geuNske22wa95+8adcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653591; c=relaxed/simple;
	bh=VeEEZRvZHPj6hEyz4I2tNXf7y8H+nP53Ailnp//pEDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W6XZD9bZjAT92Gwefc+LBnqZnp2xca99GaY+47jQOGrADLPFZhOUkX8nZobJokP1H02CNWjlGenaOG5ZNIAZfcz7cg1QoCnNx+hZYQFc5OdvKtZ15V7VuMMCtwsLj/iWG4OOXboWvw5VjZMAXno/HDZCNVNF1XbTBwDm5eQjiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEIPddNI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEIPddNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB302C19421;
	Wed,  8 Apr 2026 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775653591;
	bh=VeEEZRvZHPj6hEyz4I2tNXf7y8H+nP53Ailnp//pEDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KEIPddNICjLi4DADYxKBPbnjyIg3wTJbsqHe49AW0T/gftRWm6IYP2dz9NMOoIwY1
	 CoAJ2DV/7XD+dWvG1zAiB2Du0UFHg+RzKCaupVv/jXkn5p277sIXcMRv+x6J/q78jv
	 zMPsdnIoB6R81djowqwbhi1EXB55CguaTj+sewLmjVZ0U2RV3utVmIwTszOq6uUbV+
	 Wsak9FIvSAyh+eltytzLqAVy2mGU9yp2blxAeHbUmweE10RkBntAbOsDZkqNuJ7cQO
	 Y4AFRpGi+fEZkcuBnilCFMmog9lohTgNgN0Mfn3zYj0gPkvJpgZxjftAa5AOcnQZcj
	 keZuHWfSutiMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: enable unprivileged syscall tracing with perf
 trace
Reply-To: sashiko@lists.linux.dev
To: "Anubhav Shelat" <ashelat@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408123947.23779-2-ashelat@redhat.com>
References: <20260408123947.23779-2-ashelat@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 13:06:29 +0000
Message-Id: <20260408130630.EB302C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Bypassing `perf_allow_kernel()` for task-attached tracepoints =
allows unprivileged users to leak kernel registers, instruction pointers, a=
nd callchains, completely defeating KASLR.
- [Medium] The change to make the tracefs 'id' and 'format' files world-rea=
dable is functionally ineffective for unprivileged users due to restrictive=
 parent directory permissions.
--

commit 45a1b7ae91ab57b705592c98cc8fb3677392ba0a
Author: Anubhav Shelat <ashelat@redhat.com>

perf: enable unprivileged syscall tracing with perf trace

This commit allows unprivileged users to trace their own processes' syscalls
using perf trace by loosening the perf_allow_kernel() condition in
perf_event_open() for task-attached tracepoint events. It also makes the fo=
rmat
and id tracefs files world-readable for tracepoints marked safe for
unprivileged access.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -13832,7 +13832,7 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (err)
>  		return err;
> =20
> -	if (!attr.exclude_kernel) {
> +	if (!attr.exclude_kernel && !(attr.type =3D=3D PERF_TYPE_TRACEPOINT && =
pid !=3D -1)) {
>  		err =3D perf_allow_kernel();

If we bypass the perf_allow_kernel() check here, does this allow unprivileg=
ed
users to request PERF_SAMPLE_IP, PERF_SAMPLE_CALLCHAIN, and
PERF_SAMPLE_REGS_INTR for kernel tracepoints?

Since perf_trace_event_perm() skips permission checks when PERF_SAMPLE_RAW =
is
not requested, an unprivileged user could attach to a tracepoint like
sched:sched_switch, set exclude_kernel=3D0, and omit PERF_SAMPLE_RAW.

When the tracepoint fires, would the perf core capture the actual kernel
instruction pointer, callchain, and registers into the unprivileged user's
ring buffer, potentially defeating KASLR?

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
[ ... ]
> @@ -3050,7 +3050,9 @@ static int event_callback(const char *name, umode_t=
 *mode, void **data,
>  	struct trace_event_call *call =3D file->event_call;
> =20
>  	if (strcmp(name, "format") =3D=3D 0) {
> -		*mode =3D TRACE_MODE_READ;
> +		*mode =3D (call->flags & TRACE_EVENT_FL_CAP_ANY) ?
> +			(TRACE_MODE_READ | 0004) :
> +			TRACE_MODE_READ;
>  		*fops =3D &ftrace_event_format_fops;
>  		return 1;
>  	}

Is making these files world-readable effective for unprivileged users given
the permissions of the parent directories?

The root tracefs directory (e.g., /sys/kernel/tracing/) and its
subdirectories typically have restrictive permissions like 0750 without
world-execute access.

Would an unprivileged user attempting to read the id or format file receive
-EACCES during path resolution at the parent directory level, requiring an
administrator to manually relax permissions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408123947.2377=
9-2-ashelat@redhat.com?part=3D1
