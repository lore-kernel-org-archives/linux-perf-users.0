Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D433B38B8
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792217310; cv=none; b=LH1OYEZmFU/VnIah57Qz9LPe7u4T5qxat2bmZ90slYSX9TopNWPC32WZAstpWPwKcSx3SuxlkIiSyfa86Ezh3jVlxPqmmq0NH6SCGfUERvqaU28Pks6V4xGv/8nTVaukzby6CAop1GLrit3TsCgMslkzVjmOWSg14L/TV0xlih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792217310; c=relaxed/simple;
	bh=ef3al2T/jfc9uRGuvfozG4cygqDglJb4s2xBllyfDqQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZGKPulFIg2AipQQLEszdbRlrTMxy69zaDgAG4MQXWfCmR2bDxL7ZGBddND7yPr9tCtZh744BvNQGLCwOMO5FdFAliFUpW39TF93YJNh0ZTV35harRKQemzRSpVy6XqB594rCM6H9KOtd9gaGfOx3MGW9b2M+W18Y5YrpCYpUs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehM8oAa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehM8oAa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29D01F000C4;
	Sat, 17 Oct 2026 06:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792217309;
	bh=0pWfrYBuA/CDHuPrq+BQyUoBDvjwxK4ZxmwClXMcwok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ehM8oAa0lckQFVGh2iImZ7gtCVSVMrysKQeRI1XwZtGKnQrKXJgGVsDxxxFaOXOnF
	 qVrTPVBwMxEeaclrrkXFdH+YJ9O9z0D6MhyPhpa7IlZS02iUhXD+cHZxDSEZy4+TtM
	 W1iRWVyPnlJOixIafr8H5iT7SnGqtmvdGXJUrXpYaPAKOfGzecQn27Olcn/d4sr869
	 XAJRI/MeYLfUhUS6oBZs5wWBMMptbRUexjlz3WVmjju6kntnW48HPKD550q5FZLijC
	 e93ZHmKtodFwEEU0O/Q2Hz0SJ3kTD7LwHPa+PxJBOno4FPWDhI8I5chqneG0ABTUaW
	 ksnpQosdKGKWw==
Message-ID: <sashiko-outbox-175330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/5] perf lock contention: Extend BPF lock contention
 to RCU and SRCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017054555.1655407-6-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017054555.1655407-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 06:08:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf lock contention: wrong caller stack skip in do_contention_b=
egin() for fentry
--

commit 9ca74d6f51b3408e9a151b639dd644cd10562df1
Author: Ian Rogers <irogers@google.com>

perf lock contention: Extend BPF lock contention to RCU and SRCU

This commit extends 'perf lock contention --use-bpf' to track RCU and SRCU
grace-period and barrier waits using fentry/fexit BPF programs and adds
lock type and name filtering support for rcu and srcu.

> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index 0f2118006005a..257e3402e8151 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
[ ... ]
> @@ -474,21 +489,20 @@ static inline void update_owner_stat(u32 id, u64 du=
ration, u32 flags)
>  	}
>  }
> =20
> -SEC("tp_btf/contention_begin")
> -int contention_begin(u64 *ctx)
> +static __always_inline int do_contention_begin(void *ctx, __u64 lock, __=
u32 flags)
>  {
>  	struct tstamp_data *pelem;
> =20
> -	if (!enabled || !can_record(ctx))
> +	if (!enabled || !can_record(lock, flags))
>  		return 0;
> =20
> -	pelem =3D get_tstamp_elem(ctx[1]);
> +	pelem =3D get_tstamp_elem(flags);
>  	if (pelem =3D=3D NULL)
>  		return 0;
> =20
>  	pelem->timestamp =3D bpf_ktime_get_ns();
> -	pelem->lock =3D (__u64)ctx[0];
> -	pelem->flags =3D (__u32)ctx[1];
> +	pelem->lock =3D lock;
> +	pelem->flags =3D flags;
>  	if (aggr_mode =3D=3D LOCK_AGGR_CGROUP)
>  		pelem->cgroup_id =3D get_current_cgroup_id();
> =20
[ ... ]
> @@ -795,11 +812,109 @@ int contention_end(u64 *ctx)
>  		check_lock_delay(pelem->lock);
> =20
>  	pelem->lock =3D 0;
> -	if (need_delete)
> -		bpf_map_delete_elem(&tstamp, &pid);
> +	if (ts_map)
> +		bpf_map_delete_elem(ts_map, &pid);
>  	return 0;
>  }
> =20
> +SEC("tp_btf/contention_begin")
> +int contention_begin(u64 *ctx)
> +{
> +	return do_contention_begin(ctx, (__u64)ctx[0], (__u32)ctx[1]);
> +}
> +
> +SEC("tp_btf/contention_end")
> +int contention_end(u64 *ctx)
> +{
> +	return do_contention_end((__u64)ctx[0], (__s32)ctx[1]);
> +}
> +
> +/* RCU grace-period synchronize / barrier contention hooks */
> +SEC("fentry/synchronize_rcu")
> +int BPF_PROG(fentry_synchronize_rcu)
> +{
> +	return do_contention_begin(ctx, rcu_state_addr, LCB_F_RCU | LCB_F_WRITE=
);
> +}

[Severity: Medium]
In do_contention_begin() in tools/perf/util/bpf_skel/lock_contention.bpf.c,
bpf_get_stackid() uses stack_skip (which defaults to CONTENTION_STACK_SKIP =
=3D
4) unconditionally for both tp_btf/contention_begin and the new fentry RCU
and SRCU programs:

skip_owner:
		pelem->stack_id =3D bpf_get_stackid(ctx, &stacks,
						  BPF_F_FAST_STACK_CMP | stack_skip);

For tp_btf/contention_begin, the tracepoint fires inside a lock slowpath via
tracepoint dispatch:

  caller -> mutex_lock -> __mutex_lock_slowpath -> __mutex_lock ->
  trace_contention_begin -> __bpf_trace_contention_begin -> bpf_trace_run2 =
->
  bpf_prog

Skipping 4 frames lands inside the locking functions (.sched.text,
.spinlock.text, or trace_contention_begin), which lock_contention_get_name()
in tools/perf/util/bpf_lock_contention.c then skips via
machine__is_lock_function() to reach the direct caller:

	/* LOCK_AGGR_CALLER: skip lock internal functions */
	while (machine__is_lock_function(machine, stack_trace[idx]) &&
	       idx < con->max_stack - 1)
		idx++;

	addr =3D stack_trace[idx];

In contrast, fentry_synchronize_rcu() (and the other six RCU/SRCU fentry
programs) attach directly to the top-level API functions. In an fentry
program, the callchain captured by bpf_get_stackid_raw_tp() ->
perf_callchain_kernel() only has two frames before the traced function
itself: ip[0] is the BPF prog, ip[1] is the BPF trampoline, ip[2] is the
traced function (e.g., synchronize_rcu), ip[3] is the direct caller, and
ip[4] is the caller's caller.

Won't skipping stack_skip =3D 4 frames in bpf_get_stackid() skip past ip[3],
dropping the direct caller from the recorded stack trace, attributing RCU
and SRCU contention in LOCK_AGGR_CALLER mode to the caller's caller (ip[4]),
and causing callstack filtering (-S) in match_callstack_filter() to miss the
direct caller?

Also, if the fentry stack skip is adjusted so that the traced RCU/SRCU
function itself can appear at stack_trace[0], machine__is_lock_function() in
tools/perf/util/machine.c only checks .sched.text, .spinlock.text,
__traceiter_contention_begin, and trace_contention_begin. Since
synchronize_rcu*(), synchronize_srcu*(), rcu_barrier(), and srcu_barrier()
are not in .sched.text or .spinlock.text, should machine__is_lock_function()
or the fentry skip depth account for those functions as well?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017054555.1655=
407-1-irogers@google.com?part=3D5
