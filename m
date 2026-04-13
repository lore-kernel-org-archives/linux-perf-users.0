Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96236B06F
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073271; cv=none; b=LshcnIBv/IVVwqLbD1xtLQDGqsG/SUy29EXmLA2ODNqauN0lVz5R//Xe8dYR2XBw8Ceu3ivlwPkLv8hYaC5YnOiuerJwb3PNr5po6AlobTKK68BO2rUYfZTba+MH70z7ITP/d1FTxLuZ1GHHok6ED1mONW6CdP2OS/RjgL0PLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073271; c=relaxed/simple;
	bh=MvsSjY800qzV9UiV/BKtYfdNcsgsGJXeu6GKFLkpDAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p0WQcUCDexkkuMKL/V9whlVMp5XSQ9WsTq6Mi/b54JbpGqEAvZGPl2NKUteiuv1krtdAHdlplTNIHOnCn98rgKVEhIMvz4B5GwcxTVwCchKbNVlF+NO+9FLbhs/e2ottVt+DjpxW9Eb97wPN7R6yU3VX+Sfmws/bwuehxV3ORjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV1gnFUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV1gnFUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CAAC116C6;
	Mon, 13 Apr 2026 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073270;
	bh=MvsSjY800qzV9UiV/BKtYfdNcsgsGJXeu6GKFLkpDAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XV1gnFUSV92aB5sLX/dlK6gef6OGn8J9er30Em+bu2yXAZIUOpSmVyhkh7mCI21KG
	 Z/SJF/2BrybKKuVwlwGxWwoiBPOaEXP+iOO3V9am4HC4/GKbvjTvsS5wo2Jh7iAt7j
	 x9ttEmDymVvykJ2Nz7lRMSZdUcTs+sqbrheGZNnJHlwna7niy8F1kua5K/UP5r35QR
	 Nm/aTy1cGdkVwp8McE5eP4nymEjpLucNBk88eac/IwOJ3IZPxQP4Svw1Rr3hhVJYYK
	 8AgNZnbCb9vvLZcPmRwxafmlo+V+3w2vSyttfA1HSekqM839AXIUnKs0Of5Hn7umCw
	 ZFcc2XP+Pw8fA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL] Performance events changes for v7.1
Reply-To: sashiko@lists.linux.dev
To: "Ingo Molnar" <mingo@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <adynEfZ0r_GIu06k@gmail.com>
References: <adynEfZ0r_GIu06k@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 09:41:09 +0000
Message-Id: <20260413094110.C3CAAC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Pre-existing Stack Buffer Overflow in AMD IBS NMI handler on C=
PUs supporting `IBS_CAPS_OPDATA4`.
- [High] Reference count leak of `perf_ctx_data` in `attach_global_ctx_data=
()` when racing with a concurrent non-global context creation.
--

commit 167b4d230f2ffe8284d5afdbd849ef2f4f05ef9a
Author: Ingo Molnar <mingo@kernel.org>

Performance events changes for v7.1

This commit pulls in various performance event changes for v7.1. It includes
an optimization to allocate task_ctx_data quickly on large systems, updates
and fixes for the AMD PMU driver IBS support, Intel PEBS constraint
validation, and MSR driver changes.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5487,6 +5487,12 @@ attach_global_ctx_data(struct kmem_cache *ctx_cach=
e)
>  					cd =3D NULL;
>  			}
>  			if (!cd) {
> +				/*
> +				 * Try to allocate context quickly before
> +				 * traversing the whole thread list again.
> +				 */
> +				if (!attach_task_ctx_data(p, ctx_cache, true, GFP_NOWAIT))
> +					continue;
>  				get_task_struct(p);
>  				goto alloc;
>  			}

Could the new GFP_NOWAIT fast-path in attach_global_ctx_data() leak the
perf_ctx_data reference if it races with a concurrent non-global context
creation?

If attach_task_ctx_data() races with a per-task event attaching a non-global
context, it will find an existing context where old is not NULL. It increme=
nts
old->refcount and returns 0, but intentionally ignores the global argument
and does not set old->global to 1.

Because it returns success, attach_global_ctx_data() executes continue and
skips to the next thread. The context for the thread is left with an
extra reference but global remains 0.

Later, when the global context is detached, __detach_global_ctx_data()
iterates over all threads and only calls detach_task_ctx_data(p) if
cd and cd->global are true. Since cd->global is 0, the context is skipped,
permanently leaking the perf_ctx_data allocation.

> @@ -5497,7 +5503,7 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
> =20
>  	return 0;
>  alloc:
> -	ret =3D attach_task_ctx_data(p, ctx_cache, true);
> +	ret =3D attach_task_ctx_data(p, ctx_cache, true, GFP_KERNEL);
>  	put_task_struct(p);
>  	if (ret) {
>  		__detach_global_ctx_data();

Can this result in a double-increment leak? If the same race occurs,
attach_task_ctx_data() bumps the refcount without setting global to 1 and
returns success. Then goto again restarts the loop.

When the loop reaches the thread again, it evaluates:

	cd =3D rcu_dereference(p->perf_ctx_data);
	if (cd && !cd->global) {
		cd->global =3D 1;
		refcount_inc_not_zero(&cd->refcount);
	}

This bumps the refcount a second time. Since __detach_global_ctx_data()
only decrements once, the extra reference is leaked.

> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -698,6 +698,8 @@
>  #define MSR_AMD64_IBSBRTARGET		0xc001103b
>  #define MSR_AMD64_ICIBSEXTDCTL		0xc001103c
>  #define MSR_AMD64_IBSOPDATA4		0xc001103d
> +#define MSR_AMD64_IBSOPCTL2		0xc001103e
> +#define MSR_AMD64_IBSFETCHCTL2		0xc001103f
>  #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET =
*/

This isn't a regression from the current patch, but looking at the adjacent
MSR handling code, is there a potential stack buffer overflow in the IBS
NMI handler on CPUs supporting IBS_CAPS_OPDATA4?

In arch/x86/events/amd/ibs.c, struct perf_ibs_data is allocated on the
stack in perf_ibs_handle_irq(). Its regs array is sized using
MSR_AMD64_IBS_REG_COUNT_MAX, which is 8.

When handling a perf_ibs_op event, the initial read loop fetches up to 7
MSRs, advancing the pointer buf to &ibs_data.regs[7].

Subsequently, the handler reads additional MSRs depending on CPU caps:

	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
		if (perf_ibs =3D=3D &perf_ibs_op) {
			if (ibs_caps & IBS_CAPS_BRNTRGT) {
				rdmsrq(MSR_AMD64_IBSBRTARGET, *buf++);
				br_target_idx =3D size;
				size++;
			}
			if (ibs_caps & IBS_CAPS_OPDATA4) {
				rdmsrq(MSR_AMD64_IBSOPDATA4, *buf++);
				size++;
			}
		}

If the CPU supports IBS_CAPS_BRNTRGT, MSR_AMD64_IBSBRTARGET is read into
regs[7], advancing buf to &regs[8].

If the CPU also supports IBS_CAPS_OPDATA4, it reads MSR_AMD64_IBSOPDATA4 in=
to
the next pointer position, which translates to regs[8]. This writes one
element past the end of the 8-element array, overwriting adjacent local
variables on the stack.

Furthermore, ibs_data.size is incremented to 9, so
perf_sample_save_raw_data() will subsequently read 72 bytes of regs,
exposing the corrupted stack data to user-space in the raw perf record. Sin=
ce
unprivileged users can configure RAW IBS events, this might lead to
unintended behavior.

Should MSR_AMD64_IBS_REG_COUNT_MAX be increased to account for
IBS_CAPS_OPDATA4?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/adynEfZ0r_GIu06k@gm=
ail.com?part=3D1
