Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F87E18C08;
	Wed,  3 Jul 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017404; cv=none; b=gvFmZJvQJRX+TzXduJHEWQYcCDC12QpYaKJDLYD/MYpb0tYRbbTUoRx15a2Qe1pkf4vxDRoKVNCX7fem4JRZTuS+EJSOe7y3dfJ8H8iHQIem0aMcmElkYqFKKK4wsIXIKVIt9aUFKvDsvgC1D0rBldA5nhltiVVJyNzeGy7CeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017404; c=relaxed/simple;
	bh=QwO5Ixp2SXTbYSsPHvTxoG6lPzclCKAikOcW0vCg3XE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HdmEaR7CAHtkOLC4bc6m0dUxhxYq8sjFC/FU/T9MWkKb1mWp4HyfIpB779yNIOl6FQQEENPXG9LNXUdxDARoEK1MfK/rzvTxrpX1tgU4dZBT2w64lOgma8CVU7fsQLSvVjPoReDKs8Pir1cKE0vK7ERhlIdJu1vh4EFQx6lJQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsDGwI8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsDGwI8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC7FC2BD10;
	Wed,  3 Jul 2024 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720017403;
	bh=QwO5Ixp2SXTbYSsPHvTxoG6lPzclCKAikOcW0vCg3XE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OsDGwI8Xd/mKysyizFePmoWtuDKVvlwX3xJn4Upq3jB6orK91KOxlztOTzDW+UL8T
	 aKHwXWEWsl8jx6RRBSLq66YtKZgeXEKE4kw2iBe8eoE3RsvyMDzlh7X8mXlA3yhfoU
	 YZpHaQTotuIaX8BOaDdHXn+q1kLv3mvkQ2KUkPBfAJ3ihwxNyMFVJQMl1k66hRQ5jB
	 /s0F83MjAv4JudRu1Zo2poZR7WJ5QmyZ/58HO+7/Jqgcko0IVooxZabC45obJ2t1A8
	 3LFwFUyV6vqGY9akcbQ7ZIarSnPayLff0txVcrMu6MUcqmsenwk+fScxnoBTIhxZSF
	 rOXOh2e6RPojg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 kan.liang@linux.intel.com, dev.mbstr@gmail.com, samuel.holland@sifive.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH v2] riscv: stacktrace: Add USER_STACKTRACE support
In-Reply-To: <20240604034729.841930-1-ruanjinjie@huawei.com>
References: <20240604034729.841930-1-ruanjinjie@huawei.com>
Date: Wed, 03 Jul 2024 16:36:41 +0200
Message-ID: <87wmm2y22u.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jinjie Ruan <ruanjinjie@huawei.com> writes:

> Currently, userstacktrace is unsupported for riscv. So use the
> perf_callchain_user() code as blueprint to implement the
> arch_stack_walk_user() which add userstacktrace support on riscv.
> Meanwhile, we can use arch_stack_walk_user() to simplify the implementati=
on
> of perf_callchain_user().
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406012109.PDAjXm2i-lkp@i=
ntel.com/

For future reference: The LTP tags shouldn't be used when you're
spinning a new version.

> ---
> v2:
> - Fix the cocci warning, !A || A && B is equivalent to !A || B.
> ---
>  arch/riscv/Kconfig                 |  1 +
>  arch/riscv/kernel/perf_callchain.c | 46 ++----------------------------
>  arch/riscv/kernel/stacktrace.c     | 43 ++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 43 deletions(-)

[...]

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..6ed96d935b8f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -193,6 +193,7 @@ config RISCV
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select UACCESS_MEMCPY if !MMU
> +	select USER_STACKTRACE_SUPPORT
>  	select ZONE_DMA32 if 64BIT
>=20=20
>  config CLANG_SUPPORTS_DYNAMIC_FTRACE
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_=
callchain.c
> index 3348a61de7d9..c7468af77c66 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -6,37 +6,9 @@
>=20=20
>  #include <asm/stacktrace.h>
>=20=20
> -/*
> - * Get the return address for a single stackframe and return a pointer t=
o the
> - * next frame tail.
> - */
> -static unsigned long user_backtrace(struct perf_callchain_entry_ctx *ent=
ry,
> -				    unsigned long fp, unsigned long reg_ra)
> +static bool fill_callchain(void *entry, unsigned long pc)
>  {
> -	struct stackframe buftail;
> -	unsigned long ra =3D 0;
> -	unsigned long __user *user_frame_tail =3D
> -		(unsigned long __user *)(fp - sizeof(struct stackframe));
> -
> -	/* Check accessibility of one struct frame_tail beyond */
> -	if (!access_ok(user_frame_tail, sizeof(buftail)))
> -		return 0;
> -	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
> -				      sizeof(buftail)))
> -		return 0;
> -
> -	if (reg_ra !=3D 0)
> -		ra =3D reg_ra;
> -	else
> -		ra =3D buftail.ra;
> -
> -	fp =3D buftail.fp;
> -	if (ra !=3D 0)
> -		perf_callchain_store(entry, ra);
> -	else
> -		return 0;
> -
> -	return fp;
> +	return perf_callchain_store(entry, pc) =3D=3D 0;
>  }
>=20=20
>  /*
> @@ -56,19 +28,7 @@ static unsigned long user_backtrace(struct perf_callch=
ain_entry_ctx *entry,
>  void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  			 struct pt_regs *regs)
>  {
> -	unsigned long fp =3D 0;
> -
> -	fp =3D regs->s0;
> -	perf_callchain_store(entry, regs->epc);
> -
> -	fp =3D user_backtrace(entry, fp, regs->ra);
> -	while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
> -		fp =3D user_backtrace(entry, fp, 0);
> -}
> -
> -static bool fill_callchain(void *entry, unsigned long pc)
> -{
> -	return perf_callchain_store(entry, pc) =3D=3D 0;
> +	arch_stack_walk_user(fill_callchain, entry, regs);
>  }
>=20=20
>  void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 528ec7cc9a62..9685a2baa5d9 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -161,3 +161,46 @@ noinline void arch_stack_walk(stack_trace_consume_fn=
 consume_entry, void *cookie
>  {
>  	walk_stackframe(task, regs, consume_entry, cookie);
>  }
> +
> +/*
> + * Get the return address for a single stackframe and return a pointer t=
o the
> + * next frame tail.
> + */
> +static unsigned long unwind_user_frame(stack_trace_consume_fn consume_en=
try,
> +				       void *cookie, unsigned long fp,
> +				       unsigned long reg_ra)
> +{
> +	struct stackframe buftail;
> +	unsigned long ra =3D 0;
> +	unsigned long __user *user_frame_tail =3D
> +		(unsigned long __user *)(fp - sizeof(struct stackframe));
> +
> +	/* Check accessibility of one struct frame_tail beyond */
> +	if (!access_ok(user_frame_tail, sizeof(buftail)))
> +		return 0;
> +	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
> +				      sizeof(buftail)))
> +		return 0;
> +
> +	ra =3D reg_ra ? : buftail.ra;
> +
> +	fp =3D buftail.fp;
> +	if (!ra || !consume_entry(cookie, ra))
> +		return 0;
> +
> +	return fp;
> +}
> +
> +void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *co=
okie,
> +			  const struct pt_regs *regs)
> +{
> +	unsigned long fp =3D 0;
> +
> +	fp =3D regs->s0;
> +	if (!consume_entry(cookie, regs->epc))
> +		return;
> +
> +	fp =3D unwind_user_frame(consume_entry, cookie, fp, regs->ra);
> +	while (fp && !(fp & 0x3))

Just an observation that the "entry->nr < entry->max_stack" check was
removed in this generalization, but that's OK since it's checked in
perf_callchain_store().

Not really part of your change, but shouldn't the check be 0x7 (checking
for 16B sp/fp alignment), rather than 0x3?


Bj=C3=B6rn
