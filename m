Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E8352018;
	Fri, 21 Aug 2026 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787277390; cv=none; b=XJ2uQpnMsMLw/EYAx69IsZEDRG9XQ+CgX2lZlunsrhADcCEOMTKOkz3IrBB38d6Q6ZWn5DiAvw8ikBIjBHhRxiVnitHZ3faQzcYKPbnnzSt3fsSlvuY4fqWeNefIihdn5tqSUVzC8VUzErxDYmXzvghXWaAtGNnT5ap2PhmTQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787277390; c=relaxed/simple;
	bh=Ii1AnT0UgnYwkqRaQdOxDbEek/O/yTQQ1ZpMn8+3qA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJqN87zDCLuSZtWQypTDTF93ZwABG7QIQyo9Chm8x0cG8YA0HI4SkobTCvoSe3UiTaaPjgSIY1NvUzVCkOUHSXip6NVCaL8MHUbSKsTfrItbkp3tLGUwDE3dfQro2GTLd/BPZsT7NDUhJFycrQUB+pePXkG0z5UnSnZZJjme48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxDrRazl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxDrRazl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2C61F00A3A;
	Fri, 21 Aug 2026 01:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787277389;
	bh=JUmPDRmvMxHFLfF9+Liqr3d2OkeovUNHrU7qBdG/Pts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZxDrRazlJ031Fjr9fHs+4try12RXfx0VB7lRO94oes90sX7XzkCzDGCCQDNHSgCgX
	 Mm8joY9iB9yhIMjsEEoEtEVK2FAMiU0xMpBn6pJca4KDK6OQXLlCELUXLH/pOrOw8e
	 88XKF6EGLIkPweXik4Kl44gSXZNcIZIBhZ/J9MmLkNSBfaFK63v4+/6aI7rk1hutvJ
	 X935tE89IQzER3bZd0PqAaNArVkejK9Da+cO0VTUCGjRkffzEgwTmTBQGGkdgQB7Mc
	 1R9DDD5j5MxrlHDBQB/6Tr83JUcUsIOQzH+zDaM9QB/xPyE9o0kTh7vQkO5Z/j9I3P
	 JwFgyRSRK90sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in
 perf_event_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260821014210.18681-1-kartikey406@gmail.com>
References: <20260821014210.18681-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 01:56:28 +0000
Message-Id: <20260821015629.1A2C61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a build failure/linker error on configuration=
s where `CONFIG_BPF_EVENTS` is disabled.
- [High] Severe global lock contention and performance regression during `f=
ork()` for all inherited perf events.

Pre-existing issues:
- [High] Memory and reference count leak of BPF programs and address filter=
s in the `perf_event_alloc` error path.
- [High] The patch fails to fix the use-after-free race condition for non-t=
racing events, as they bypass `bpf_event_mutex`.
- [High] Tracepoint BPF programs are globally detached and disabled when an=
y inherited child perf event is closed.
--

--- Patch [1]: [PATCH] perf/bpf: Fix lockless access to parent_event->prog =
in perf_event_alloc() ---
commit f1b901f0de2c25ddd86c536608909f0fd81cff45
Author: Deepanshu Kartikey <kartikey406@gmail.com>

perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()

This patch attempts to fix a use-after-free and NULL pointer dereference in
perf_event_alloc() during fork(). It introduces bpf_event_mutex to
synchronize the inheritance of the BPF program with concurrent detach
operations.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2eee83cdb43de..e62c34f1f89c7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13463,12 +13463,15 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>  		overflow_handler =3D parent_event->overflow_handler;
>  		context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -		if (parent_event->prog) {
> -			struct bpf_prog *prog =3D parent_event->prog;
> =20
> +		struct bpf_prog *prog;
> +
> +		mutex_lock(&bpf_event_mutex);

[Severity: High]
Does this introduce a linker error when CONFIG_BPF_EVENTS is disabled?

The bpf_event_mutex is defined in kernel/trace/bpf_trace.c, which is only
compiled when CONFIG_BPF_EVENTS is enabled. However, this code is guarded by
checking CONFIG_BPF_SYSCALL and CONFIG_EVENT_TRACING.

If a configuration has CONFIG_BPF_SYSCALL=3Dy, CONFIG_EVENT_TRACING=3Dy, and
CONFIG_PERF_EVENTS=3Dy, but disables CONFIG_KPROBE_EVENTS and
CONFIG_UPROBE_EVENTS, CONFIG_BPF_EVENTS evaluates to n. Will this result
in an undefined reference to bpf_event_mutex?

[Severity: High]
Does unconditionally acquiring this global lock penalize the performance of
process creation when basic perf inherited tracing is active?

This acquires bpf_event_mutex across all CPUs during fork() for every
inherited event, even when parent_event->prog is NULL. Should there be a
lockless fast-path check, for example:

if (READ_ONCE(parent_event->prog))

before acquiring the mutex?

[Severity: High]
This is a pre-existing issue, but does this fail to prevent the race
condition for non-tracing events?

While bpf_event_mutex is held here in perf_event_alloc(), concurrent
detach operations for non-tracing events bypass this mutex entirely:

kernel/events/core.c:perf_event_free_bpf_handler() {
    event->prog =3D NULL;
    bpf_prog_put(prog);
}

Since perf_event_free_bpf_handler() operates locklessly, doesn't the
original use-after-free vulnerability remain unfixed for event types
like BPF_PROG_TYPE_PERF_EVENT?

> +		prog =3D parent_event->prog;
> +		if (prog) {
>  			bpf_prog_inc(prog);

[Severity: High]
This is a pre-existing issue, but does this leak the BPF program reference
and address filters if perf_event_alloc() fails later on?

If a failure occurs after this point, the error path uses the
__free(__free_event) cleanup mechanism:

kernel/events/core.c:__free_event() {
    ...
}

Unlike _free_event(), __free_event() omits the calls to
perf_event_free_bpf_prog(event) and perf_free_addr_filters(event).
Will this leave the reference incremented by bpf_prog_inc() unbalanced?

>  			event->prog =3D prog;

[Severity: High]
This is a pre-existing issue, but does sharing the parent's program pointer
here cause tracepoint BPF programs to be globally detached when a child
exits?

When an inherited child event is closed, it eventually calls:

kernel/trace/bpf_trace.c:perf_event_detach_bpf_prog() {
    ...
    ret =3D bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array=
);
    ...
}

This permanently removes event->prog from the tracepoint's shared global
array. If an unprivileged child process exits, will it maliciously or
accidentally remove the parent's BPF program from the tracepoint entirely?

>  		}
> +		mutex_unlock(&bpf_event_mutex);
>  #endif
>  	}

[ ... ]

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 29260951aa871..73065ddad7f6d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1944,7 +1944,7 @@ const struct bpf_verifier_ops perf_event_verifier_o=
ps =3D {
>  const struct bpf_prog_ops perf_event_prog_ops =3D {
>  };
> =20
> -static DEFINE_MUTEX(bpf_event_mutex);
> +DEFINE_MUTEX(bpf_event_mutex);
> =20
>  #define BPF_TRACE_MAX_PROGS 64

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821014210.1868=
1-1-kartikey406@gmail.com?part=3D1
