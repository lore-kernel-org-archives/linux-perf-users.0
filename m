Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54A263F5D;
	Thu, 13 Aug 2026 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602139; cv=none; b=XVNoOgZ8L2pctJNE8PKH0m/KfLFCjt+qG85tuc4I1e/eUks70ZUR/E/Ap64L1dWF1J5Og16Dab471/7mGF8Yhpp8K2ENB026ULgXLtUh5UE4iNehPF41AfsfE0xnWxv2X+X4jUTywQ+gkye4wFjDqs54lJSHCCI2UQZAsR+csMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602139; c=relaxed/simple;
	bh=+5D3p7sScaegm1VIyeqCpLf42CdpIop97jVtqGW3CuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R8IBjyIs9/rSjEMHTWNsgJcLN36hcJi4VPgAiBFLNUUrwj/kWrsOfAlhsvoQHix0jxD/buSHYVq7BVyxSM8d7qLLAHtJZY12SU9xB0fhvzSnOT0OumVrd2w2WqPX4TvLp+GybeEfwiapjh636aJzEuo17Ql9JBixv9RqtuXw7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6wiVsus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6wiVsus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279721F000E9;
	Thu, 13 Aug 2026 06:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786602137;
	bh=Rlj1vBayaDgp+9Da8eEHI6cd9R9vw9wihbVfkn1bs7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W6wiVsusoSR1wDQPEvTaTVdyDoIazlFyoA9h4w1trf8gj08kgGvoahxYZrnOUdxWg
	 Diqg+RW3Mc0GkhQpkkDilFEyatnLAFn2+seZ4b7WqUYlXPIzZicaWQ+lhb/NAIup4y
	 nOf5+FcdSO3QbRDpAFDcWigtDKd/dc2xghF9w8FDmch8YjrGv7jGKRr6p15+e5IXgx
	 qBbLRmHcIos0IpTVyhNs40SnzJL845WsNK/eo/wUaiGbQxHq9AldgUq/t06GJ/KK5E
	 IuhbKsqn8TSCcX3VlsFb5mAQyQT9fT3vW/95FCy9AMGk8gm2v3l/rOTZx5pDGVbSC2
	 RUTyCLwBGKokA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/bpf: Fix data races in BPF perf event handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260813060528.365959-1-kartikey406@gmail.com>
References: <20260813060528.365959-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:22:16 +0000
Message-Id: <20260813062217.279721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Unconditional use of `bpf_event_mutex` in `kernel/events/core.c` c=
auses a linker error in valid Kconfig combinations where `CONFIG_BPF_EVENTS=
` is disabled.

Pre-existing issues:
- [High] The fix for the data race in `perf_event_alloc()` is incomplete be=
cause `bpf_event_mutex` is not held during the detachment of non-tracing BP=
F programs, leaving the use-after-free race unfixed.
- [High] Dereferencing prog->type without rcu_read_lock_trace() exposes sle=
epable BPF programs to Use-After-Free.
- [Medium] The patch misses a plain write to event->prog in perf_event_atta=
ch_bpf_prog(), leaving a data race with READ_ONCE(event->prog) unfixed.
- [Medium] `perf_event_free_bpf_handler()` still contains a plain read of `=
event->prog` which can race with a concurrent `WRITE_ONCE()` in `perf_event=
_set_bpf_handler()`.
- [Medium] Missing release barrier in perf_event_set_bpf_handler() allows B=
PF programs to observe uninitialized or stale bpf_cookie values.
--

--- Patch [1]: [PATCH v2] perf/bpf: Fix data races in BPF perf event handli=
ng ---
commit f4518a73c55a1297eca26073838ec515d34cb05a
Author: Deepanshu Kartikey <kartikey406@gmail.com>
perf/bpf: Fix data races in BPF perf event handling

This commit attempts to fix data races around the event->prog field
by introducing READ_ONCE and WRITE_ONCE in various handlers, and acquiring
bpf_event_mutex during fork() in perf_event_alloc().

Link: https://lore.kernel.org/all/20260811235331.10044-1-kartikey406@gmail.=
com/T/

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea5..5c6dabb6dccb1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -2136,4 +2136,6 @@ static inline void perf_lopwr_cb(bool mode)
>  }
>  #endif
> =20
> +extern struct mutex bpf_event_mutex;
> +

[Severity: High]
Will this extern declaration lead to a linker error in valid Kconfig
combinations where CONFIG_BPF_EVENTS is disabled?

The bpf_event_mutex is defined in kernel/trace/bpf_trace.c, which is
only compiled when CONFIG_BPF_EVENTS=3Dy. If a kernel is configured with
CONFIG_BPF_SYSCALL=3Dy and CONFIG_EVENT_TRACING=3Dy, but kprobe and uprobe
events are disabled, this might result in an unresolved external symbol.

>  #endif /* _LINUX_PERF_EVENT_H */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7b..1416066ef460e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -10708,7 +10707,7 @@ static inline int perf_event_set_bpf_handler(stru=
ct perf_event *event,
>  		return -EPROTO;
>  	}
> =20
> -	event->prog =3D prog;
> +	WRITE_ONCE(event->prog, prog);
>  	event->bpf_cookie =3D bpf_cookie;
>  	return 0;
>  }

[Severity: Medium]
This is a pre-existing issue, but does publishing event->prog without a
release barrier allow concurrent readers in __perf_event_overflow() to
observe an uninitialized or stale bpf_cookie?

Without smp_store_release() or similar ordering, the CPU can reorder the
event->prog write and the plain store to event->bpf_cookie. Since the reader
uses READ_ONCE(), which lacks acquire semantics, a BPF program might read
the uninitialized cookie.

> @@ -10720,7 +10719,7 @@ static inline void perf_event_free_bpf_handler(st=
ruct perf_event *event)
>  	if (!prog)
>  		return;
> =20
> -	event->prog =3D NULL;
> +	WRITE_ONCE(event->prog, NULL);
>  	bpf_prog_put(prog);
>  }

[Severity: Medium]
This is a pre-existing issue, but does perf_event_free_bpf_handler() still
contain a plain read of event->prog?

At the beginning of this function:
	struct bpf_prog *prog =3D event->prog;

Could this read race with a concurrent WRITE_ONCE() from
perf_event_set_bpf_handler() during ioctl(PERF_EVENT_IOC_SET_BPF)?

[Severity: High]
This is a pre-existing issue, but does perf_event_free_bpf_handler() need to
acquire bpf_event_mutex to safely detach non-tracing BPF programs?

Because this function clears event->prog and drops the program reference
locklessly, a concurrent fork() calling perf_event_alloc() could acquire the
mutex, read the program, and increment a zero-refcount object.

>  #else
> @@ -10753,6 +10752,7 @@ static int __perf_event_overflow(struct perf_even=
t *event,
>  {
>  	int events =3D atomic_read(&event->event_limit);
>  	int ret =3D 0;
> +	struct bpf_prog *prog;
> =20
>  	/*
>  	 * Non-sampling counters might still use the PMI to fold short
> @@ -10766,8 +10766,9 @@ static int __perf_event_overflow(struct perf_even=
t *event,
>  	if (event->attr.aux_pause)
>  		perf_event_aux_pause(event->aux_event, true);
> =20
> -	if (event->prog && event->prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> -	    !bpf_overflow_handler(event, data, regs))
> +	prog =3D READ_ONCE(event->prog);
> +	if (prog && prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT &&
> +	    !bpf_overflow_handler(event, data, regs, prog))

[Severity: High]
This is a pre-existing issue, but does dereferencing prog->type here
without rcu_read_lock_trace() expose sleepable BPF programs to a
use-after-free?

RCU Tasks Trace grace periods do not wait for NMIs or preemption-disabled
sections (Classic RCU context). If a sleepable program is detached and freed
via call_rcu_tasks_trace(), couldn't it be freed while __perf_event_overflo=
w()
is still executing and evaluating prog->type?

>  		goto out;
> =20
>  	/*
> @@ -13433,12 +13434,15 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>  		overflow_handler =3D parent_event->overflow_handler;
>  		context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -		if (parent_event->prog) {
> -			struct bpf_prog *prog =3D parent_event->prog;
> =20
> +		struct bpf_prog *prog;
> =20
> +		mutex_lock(&bpf_event_mutex);
> +		prog =3D parent_event->prog;
> +		if (prog) {
>  			bpf_prog_inc(prog);
>  			event->prog =3D prog;
>  		}
> +		mutex_unlock(&bpf_event_mutex);
>  #endif

[Severity: High]
As mentioned above, since bpf_event_mutex is only compiled when
CONFIG_BPF_EVENTS=3Dy, will unconditionally locking it here cause a build
failure on kernels where that configuration is disabled?

>  	}
> =20
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 75495a5c35079..026b5c4921158 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> @@ -2018,7 +2018,7 @@ void perf_event_detach_bpf_prog(struct perf_event *=
event)
> =20
>  put:
>  	prog =3D event->prog;
> -	event->prog =3D NULL;
> +	WRITE_ONCE(event->prog, NULL);
> =20
>  unlock:
>  	mutex_unlock(&bpf_event_mutex);

[Severity: Medium]
This isn't a bug introduced by this patch, but doesn't
perf_event_attach_bpf_prog() still contain a plain write to event->prog?

Since this patch fixes data races against the READ_ONCE() in the fast
path, should the plain write:
    event->prog =3D prog;

in the attach path also be converted to a WRITE_ONCE()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813060528.3659=
59-1-kartikey406@gmail.com?part=3D1
