Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B05397E81
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118485; cv=none; b=Y5LYYxaLL34lptW4RLE+bGXiKnMnJ8t808uHueYEdD0l3kjp4e+JcM6grmx2qMj8ucvYApVmMDtE5OKGd9hLDAGRIt+R5T2JgEf9RFS3UYa9y1qm4VHdU093B6CqDOzVyOjMweWLuv6L/zvo2DQ8dwCPSERuYyrgL5eo/jkKDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118485; c=relaxed/simple;
	bh=pRpvQQzdMofrUfWNAB8p2hR2OK2d5PV8KjPLCA7PaLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kyfDsBc4HSG2DAb2mS/UpwATmiTqz/vCclTWNzOC+fFMQc+ejxlzDVlYwBsziowASaTYPtKGVEgZZNaIgVUB5opbA8brIZPSljEUq0Iu9ZZaV8g8/S7BDtZFpQ5IcbhfwfRv6hRcz9infr4K8JM7vCEUTAjHJuxocJdsJMRH2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtffLTlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtffLTlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1D31F000E9;
	Fri,  7 Aug 2026 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118483;
	bh=ajaMyTt+hmJkdIFDe1+4SBDso63sryq65OZsWa25OA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KtffLTlLDEBGl0oj9t9kG4/ljKJvc8QIzGv0woJr4H9ZRn7572AdmbUVcK8ZFOmgR
	 tPgN0kqkqZGWQw4BnYuVbzsPsZReE7+dIy25ljgvunR+9BoJR7EfdytqoVzdlBTW0c
	 x+qTvLdz1pdqnYREIYCfAb8eHm91ouIagHXzvGrjqNCeOGeQofGZb/yaTO5THFL9Oo
	 ksGiD/cd+5N5opcj8qGR0/tVcfCfcLZ4dI7TzUr91PjnI94bD0KjLC6eByZ4W2TZv4
	 u+3SjHhzTCWQgZAii4HWuSZXMUGGzbFKKOWeZsDoneStgw3LPQ6gGXsofBLpyc+9TK
	 hueyLLmqS1ngg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/11] x86/hw_breakpoints: Make DR7 updates NMI safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178611680944.237811.138492867299389879.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
 <178611680944.237811.138492867299389879.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:01:23 +0000
Message-Id: <20260807160123.7A1D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing compiler barrier before the sequence number check in per-C=
PU seqlock loops allows the compiler to hoist the sequence check, leading t=
o lost hardware state updates during NMI interruption.
--

--- Patch [1]: [PATCH v12 01/11] x86/hw_breakpoints: Make DR7 updates NMI s=
afe ---
commit 585f6ee61d495eb16d59ff031d378a9d8f727fd9
Author: Jinchao Wang <wangjinchao600@gmail.com>
x86/hw_breakpoints: Make DR7 updates NMI safe

Hardware breakpoint installation and removal run with IRQs disabled, but
an NMI can still enter the same code through KGDB. The interrupted
operation and the NMI can consequently claim the same slot or overwrite
each other's DR7 state.

Claim and release per-CPU slots with cmpxchg. Update cpu_dr7 with
single-instruction per-CPU operations, and preserve hardware-first
disable and hardware-last enable ordering. Add a per-CPU sequence number
so interrupted DR7 writers and restore paths detect an NMI update and
retry from the latest shadow state.

Link: https://lore.kernel.org/all/4ee0a2efc9e8387af83286b8495b7d490247e165.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debug=
reg.h
> index a2c1f2d24b645..b1fe1c47978d1 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h

[ ... ]

> @@ -145,20 +148,33 @@ static __always_inline unsigned long local_db_save(=
void)
>  	 * be good.
>  	 */
>  	barrier();
> -
> -	return dr7;
>  }
> =20
> -static __always_inline void local_db_restore(unsigned long dr7)
> +static __always_inline void local_db_restore(unsigned long dr7,
> +					     unsigned int dr7_seq)
>  {
> +	unsigned int seq;
> +
>  	/*
>  	 * Ensure the compiler doesn't raise this statement into
>  	 * the critical section; enabling breakpoints early would
>  	 * not be good.
>  	 */
>  	barrier();
> -	if (dr7)
> +
> +	do {
> +		seq =3D this_cpu_read(cpu_dr7_seq);
> +		if (seq =3D=3D dr7_seq) {
> +			if (!dr7)
> +				return;
> +		} else {
> +			dr7 =3D this_cpu_read(cpu_dr7);
> +			if (!dr7)
> +				dr7 =3D DR7_FIXED_1;
> +		}
> +
>  		set_debugreg(dr7, 7);
> +	} while (unlikely(seq !=3D this_cpu_read(cpu_dr7_seq)));

[Severity: High]
Does this sequence check need a barrier() before it?

Without a compiler barrier, could the compiler hoist the
this_cpu_read(cpu_dr7_seq) check above the set_debugreg() update? If an NMI
fires after the hoisted read but before the update completes, the loop might
validate the pre-NMI sequence number and terminate prematurely without retr=
ying,
which could desynchronize the hardware DR7 state and per-CPU shadow state.

>  }
> =20
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index f846c15f21ca1..9ef24b55737f8 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> @@ -97,38 +100,30 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigne=
d *len, unsigned *type)
>  int arch_install_hw_breakpoint(struct perf_event *bp)
>  {
>  	struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
> -	unsigned long *dr7;
> +	unsigned int seq;
>  	int i;
> =20
>  	lockdep_assert_irqs_disabled();
> =20
>  	for (i =3D 0; i < HBP_NUM; i++) {
> -		struct perf_event **slot =3D this_cpu_ptr(&bp_per_reg[i]);
> -
> -		if (!*slot) {
> -			*slot =3D bp;
> +		if (!this_cpu_cmpxchg(bp_per_reg[i], NULL, bp))
>  			break;
> -		}
>  	}
> =20
>  	if (WARN_ONCE(i =3D=3D HBP_NUM, "Can't find any breakpoint slot"))
>  		return -EBUSY;
> =20
> -	set_debugreg(info->address, i);
> -	__this_cpu_write(cpu_debugreg[i], info->address);
> -
> -	dr7 =3D this_cpu_ptr(&cpu_dr7);
> -	*dr7 |=3D encode_dr7(i, info->len, info->type);
> -
> -	/*
> -	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> -	 */
> -	barrier();
> -
> -	set_debugreg(*dr7, 7);
> -	if (info->mask)
> -		amd_set_dr_addr_mask(info->mask, i);
> +	do {
> +		seq =3D this_cpu_inc_return(cpu_dr7_seq);
> +		this_cpu_write(cpu_debugreg[i], info->address);
> +		barrier();
> +		set_debugreg(info->address, i);
> +		if (info->mask)
> +			amd_set_dr_addr_mask(info->mask, i);
> +		this_cpu_or(cpu_dr7, encode_dr7(i, info->len, info->type));
> +		barrier();
> +		set_debugreg(this_cpu_read(cpu_dr7), 7);
> +	} while (seq !=3D this_cpu_read(cpu_dr7_seq));

[Severity: High]
Is a barrier() also missing here before the sequence check, similar to
local_db_restore(), to prevent the compiler from reordering the sequence
check before the DR7 register update?

> =20
>  	return 0;
>  }
> @@ -146,36 +141,33 @@ void arch_uninstall_hw_breakpoint(struct perf_event=
 *bp)
>  {
>  	struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
>  	unsigned long dr7;
> +	unsigned int seq;
>  	int i;
> =20
>  	lockdep_assert_irqs_disabled();
> =20
>  	for (i =3D 0; i < HBP_NUM; i++) {
> -		struct perf_event **slot =3D this_cpu_ptr(&bp_per_reg[i]);
> -
> -		if (*slot =3D=3D bp) {
> -			*slot =3D NULL;
> +		if (this_cpu_read(bp_per_reg[i]) =3D=3D bp)
>  			break;
> -		}
>  	}
> =20
>  	if (WARN_ONCE(i =3D=3D HBP_NUM, "Can't find any breakpoint slot"))
>  		return;
> =20
> -	dr7 =3D this_cpu_read(cpu_dr7);
> -	dr7 &=3D ~__encode_dr7(i, info->len, info->type);
> -
> -	set_debugreg(dr7, 7);
> -	if (info->mask)
> -		amd_set_dr_addr_mask(0, i);
> -
> -	/*
> -	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
> -	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> -	 */
> -	barrier();
> -
> -	this_cpu_write(cpu_dr7, dr7);
> +	do {
> +		seq =3D this_cpu_inc_return(cpu_dr7_seq);
> +		dr7 =3D this_cpu_read(cpu_dr7);
> +		dr7 &=3D ~__encode_dr7(i, info->len, info->type);
> +		set_debugreg(dr7, 7);
> +		if (info->mask)
> +			amd_set_dr_addr_mask(0, i);
> +		barrier();
> +		this_cpu_and(cpu_dr7,
> +			     ~__encode_dr7(i, info->len, info->type));
> +	} while (seq !=3D this_cpu_read(cpu_dr7_seq));

[Severity: High]
Could the lack of a barrier() here allow the compiler to hoist the sequence
check before the shadow state update (this_cpu_and)?

> +
> +	WARN_ONCE(this_cpu_cmpxchg(bp_per_reg[i], bp, NULL) !=3D bp,
> +		  "Can't release breakpoint slot");
>  }

[ ... ]

> @@ -483,12 +476,17 @@ void flush_ptrace_hw_breakpoint(struct task_struct =
*tsk)
> =20
>  void hw_breakpoint_restore(void)
>  {
> -	set_debugreg(__this_cpu_read(cpu_debugreg[0]), 0);
> -	set_debugreg(__this_cpu_read(cpu_debugreg[1]), 1);
> -	set_debugreg(__this_cpu_read(cpu_debugreg[2]), 2);
> -	set_debugreg(__this_cpu_read(cpu_debugreg[3]), 3);
> -	set_debugreg(DR6_RESERVED, 6);
> -	set_debugreg(__this_cpu_read(cpu_dr7), 7);
> +	unsigned int seq;
> +
> +	do {
> +		seq =3D this_cpu_inc_return(cpu_dr7_seq);
> +		set_debugreg(this_cpu_read(cpu_debugreg[0]), 0);
> +		set_debugreg(this_cpu_read(cpu_debugreg[1]), 1);
> +		set_debugreg(this_cpu_read(cpu_debugreg[2]), 2);
> +		set_debugreg(this_cpu_read(cpu_debugreg[3]), 3);
> +		set_debugreg(DR6_RESERVED, 6);
> +		set_debugreg(this_cpu_read(cpu_dr7), 7);
> +	} while (seq !=3D this_cpu_read(cpu_dr7_seq));

[Severity: High]
Does this loop also require a barrier() before the sequence check to prevent
premature termination if an NMI interrupts the register restores?

>  }
>  EXPORT_SYMBOL_FOR_KVM(hw_breakpoint_restore);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178611679753.237811=
.10190793347982785419.stgit@devnote2?part=3D1
