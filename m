Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAFA3B9DAE;
	Sun, 30 Aug 2026 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101121; cv=none; b=jHFWCDI9BmOv5wNUrDVqrBKpOsRWU/xDQ75dllX2LdLYrkemYfb/wntMUnDEJe6kcZ/wUhofhmXfV5sJ+N4WPnW0or9H2b+o2cA+5hm6AeWCKOAndAm1VHlC1/w2V0tGUAgcVHAjk8JjvoaDsoxQAqd9t8a3vICjjIrerFbvw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101121; c=relaxed/simple;
	bh=Y2JURpZJD4+l/EkzTRe+SY6TBMTJOeDWh3hPNx4trqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cQXKukJKuQ3o6tbXOCC5FoTFLMcbbHpiNwxeUtzUWKfyuSW2MvhkbEm44zsxE/rb49FH51ty/z8M+JDZPifGBcIT9x2TlsT8JMVLLfU8zzc0VUizzKL9IUOX+HX79Dx6MdEsKFEG5BNa/pATK+fXJRdZgj1QB9T90FBheQbdCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTXfivYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTXfivYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081FF1F000E9;
	Sun, 30 Aug 2026 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788101120;
	bh=EWeLX5OmZx/wP+dup04Qn7OrAwJjY+6o7Av8+SA3RUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MTXfivYnBHHc/YM/rk2BuuYA1I+lNYwdNrVvwqAEjgd5+VxY1flMd5r6/TbsWbvKo
	 wtJrH+iGc/i4fJ9nnTD5viQEfeOhDJb8Y/3xGPddqOlqH+6VBH0zhvL8sn2IOv40j4
	 2BAOxVdP3XLnOJK5z+ZaI779cW4fIoHxkdwyeoUPcCQRfUw5UE5lVQCSM3g8+eJYoY
	 2Sdxv1qwVUE7DRXMxBaND11tocmEleJnn1l1OHAhHk/9pEA958abB0ucaskpeVEQb6
	 483fbQQNCxYHTEU9ipMJN6zffUCy8h7QlDdLptPduOTX4WihZP0XZZdqh4oUSUdi2G
	 6VFtnH8lobRzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/14] x86/hw_breakpoints: Make DR7 updates NMI safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178810005476.64882.15902865504188093281.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810005476.64882.15902865504188093281.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:45:19 +0000
Message-Id: <20260830144520.081FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Preexisting race condition in `local_db_save()` leads to recur=
sive exceptions. The function reads DR7, then checks if it was non-zero bef=
ore disabling hardware breakpoints. If an NMI (e.g., KGDB) installs a break=
point after DR7 is read but before the check, `local_db_save()` will falsel=
y believe no breakpoints are active and skip disabling them. The exception =
handler (e.g., `#DB` or `#MC`) will then run with hardware breakpoints enab=
led, risking a recursive exception.
- [High] The patch adds `if (!dr7) return;` in `local_db_restore()` to oste=
nsibly prevent an NMI from overwriting an intentionally cleared hardware DR=
7 state (such as during KVM guest entry). However, if an NMI (e.g., from KG=
DB) installs a hardware breakpoint, `arch_install_hw_breakpoint()` directly=
 overwrites the hardware DR7 register with `cpu_dr7`. By returning immediat=
ely when `dr7 =3D=3D 0`, `local_db_restore()` fails to restore the hardware=
 DR7 back to its cleared state (0x400). Consequently, KVM resumes the guest=
 with the host's newly installed hardware breakpoint active.
--

commit e145a86b764e63c7282dc5c5fb7c745db147953a
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoints: Make DR7 updates NMI safe

Hardware breakpoint installation and removal run with IRQs disabled, but
an NMI can still enter the same code through KGDB. This patch uses cmpxchg
and a per-CPU sequence number to make DR7 updates safe from NMI interruptio=
ns.

Link: https://lore.kernel.org/all/4ee0a2efc9e8387af83286b8495b7d490247e165.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debug=
reg.h
> index a2c1f2d24b645..65e80cd62193f 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h

[ ... ]

> @@ -125,18 +126,20 @@ static __always_inline bool hw_breakpoint_active(vo=
id)
> =20
>  extern void hw_breakpoint_restore(void);
> =20
> -static __always_inline unsigned long local_db_save(void)
> +static __always_inline void local_db_save(unsigned long *dr7,
> +					  unsigned int *dr7_seq)
>  {
> -	unsigned long dr7;
> +	*dr7 =3D 0;
> +	*dr7_seq =3D this_cpu_read(cpu_dr7_seq);
> =20
>  	if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
> -		return 0;
> +		return;
> =20
> -	get_debugreg(dr7, 7);
> +	get_debugreg(*dr7, 7);
> =20
>  	/* Architecturally set bit */
> -	dr7 &=3D ~DR7_FIXED_1;
> -	if (dr7)
> +	*dr7 &=3D ~DR7_FIXED_1;
> +	if (*dr7)
>  		set_debugreg(DR7_FIXED_1, 7);

[Severity: Critical]
This is a pre-existing issue, but does this conditional check rely on a sta=
le
read of DR7?

If an NMI (e.g. KGDB) installs a breakpoint after DR7 is read via
get_debugreg() but before this check, local_db_save() will evaluate the old=
 0
and skip disabling DR7. Can this cause the exception handler (such as #DB or
#MC) to run with hardware breakpoints still enabled, risking a recursive
exception?

> =20
>  	/*
> @@ -145,20 +148,34 @@ static __always_inline unsigned long local_db_save(=
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
> +	if (!dr7)
> +		return;

[Severity: High]
This isn't a bug introduced by this patch, but if an NMI interrupts a
cleared DR7 state (such as during KVM guest entry), and the NMI installs
a hardware breakpoint, doesn't this early return fail to restore the hardwa=
re
DR7 back to its cleared state (0x400)?

Consequently, it looks like KVM would resume the guest with the host's
newly installed hardware breakpoint active.

[ ... ]

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index f846c15f21ca1..3204e75dc4546 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

[ ... ]

> @@ -97,38 +100,31 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigne=
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

[Severity: High]
This is a pre-existing issue, but since arch_install_hw_breakpoint()
unconditionally overwrites the hardware DR7 register inside the NMI,
does this mean the KVM cleared state is already lost here before
local_db_restore() is even called?

> +		barrier();
> +	} while (seq !=3D this_cpu_read(cpu_dr7_seq));
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D4
