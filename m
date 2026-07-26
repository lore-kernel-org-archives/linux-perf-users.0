Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354043812EF
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069318; cv=none; b=lZDbvG+Q8EifzeCqmFMy/J8uUz7xi+cDerVlm/417xt+OE93FqzBleozBnZ+f+m1CsuyU8EeIm+BxoBdfFDFR0qoqzlsJFSZ8/34QcbCbM86PEAZkQTFfUDX/4rq3wWysDkFKhGFbgdGxFFxIJUSkd8kQpRwyTB0ECbi4DjvMs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069318; c=relaxed/simple;
	bh=aTMt+AzxBcO4LnZtkWMn5UXKYHV1b1UpPLuXvQiHcuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mCe/Rpa2rA+sLQLNbOWDlxTJlQIS1zFObX83F5jsPhFkAw/daUNq9fkWZWz/IPz57YwujiHTtzt1z8Ty32qugchyFPR6dRfghNo12JIQ3ZDHUYk9EbwxbOpLsTscWz08NgmGdB4A0fhKDSi6Nqe1OhKXzi/QnK+DmTE8jV7BD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UV5MTeQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UV5MTeQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DE51F000E9;
	Sun, 26 Jul 2026 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069316;
	bh=KdEw2BuzSDFyVD6CTqc1hQHKYrnJDbISg/HPpt51pCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UV5MTeQjc9Lv2FUbr4DNlRguWFQAYAnkf2dOlenzLey6NX1uMtDlJILvQE4X2g0sH
	 fqBCsjeRcErwLNKWwqK62kHp2HQxzOUgjADKNQ2L6x7emKKZqrTYlPLehnADC8r1Z2
	 IA7Y76tM/sZRjyZ1l2VKc/K8z859h/ib3maK4MlDfuyvGS+PpiEwQiqbglYeB0d4wz
	 CtslzSlWA5F5/Z/X6UOeN3snsKMaFYuYrCRYE4jFV9Ewy3ySjI1sDgkENyZnk+VA1i
	 QB4JEFHihV1mrV5YDQJJkqATAnBMh2GRMHmF7XE/Gjb1cN+iWkceByTmwlp6w4kzY0
	 4YPkG1/tXLsrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] HWBP: Add modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f9c49dfa49bdc57ba8c0574bc9981c1e581acf92.1785067572.git.wangjinchao600@gmail.com>
References: <178476143000.26117.9810509272687580410.stgit@devnote2>
 <cover.1785067572.git.wangjinchao600@gmail.com>
 <f9c49dfa49bdc57ba8c0574bc9981c1e581acf92.1785067572.git.wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 12:35:16 +0000
Message-Id: <20260726123516.90DE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] arch_modify_local_hw_breakpoint_addr() lacks NMI-safe sequence cou=
nter protection and violates the x86 SDM by modifying active debug register=
s.
- [High] modify_local_hw_breakpoint_addr() bypasses mandatory architecture-=
specific address validation, allowing safe-guards to be circumvented.
- [Medium] modify_local_hw_breakpoint_addr() updates generic software state=
 locklessly before calling the arch-specific function, and returns success =
even if the arch function fails.
--

--- Patch [3]: [PATCH 3/3] HWBP: Add modify_local_hw_breakpoint_addr() API =
---
commit 46c7b1b307ec0fc122a4f26e8e8f3b876fbd24b7
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

HWBP: Add modify_local_hw_breakpoint_addr() API
   =20
Add modify_local_hw_breakpoint_addr() to update only the watched
address of an installed hardware breakpoint on the local CPU without
releasing and reserving its hardware slot. This is available when the
architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.
   =20
The caller must provide an installed local event and a valid address,
and update other CPUs separately.

[ ... ]

> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 789add0c185a0..0b1fc01f19349 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -888,6 +888,36 @@ void unregister_wide_hw_breakpoint(struct perf_event=
 * __percpu *cpu_events)
>  }
>  EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
> =20
> +/**
> + * modify_local_hw_breakpoint_addr - update a local breakpoint address
> + * @bp: the hwbp perf event for this CPU
> + * @addr: the new address for @bp
> + *
> + * Update only the address of an installed breakpoint on the local CPU w=
ithout
> + * releasing and reserving its hardware slot. The caller must update oth=
er CPUs.
> + * Return 0, or -EOPNOTSUPP if the architecture does not support this op=
eration.
> + */
> +#ifdef CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
> +int modify_local_hw_breakpoint_addr(struct perf_event *bp,
> +				    unsigned long addr)
> +{
> +	lockdep_assert_irqs_disabled();
> +
> +	counter_arch_bp(bp)->address =3D addr;
> +	bp->attr.bp_addr =3D addr;

[Severity: High]
Is mandatory architecture-specific address validation bypassed here?

The normal breakpoint installation path uses hw_breakpoint_arch_parse() to
ensure the address is safe (e.g., properly aligned, canonical, and not
overlapping with critical CPU entry areas like cpu_dr7_seq or the GDT).

By blindly assigning the new address and passing it to the architecture lay=
er
without invoking hw_breakpoint_arch_parse() or any architectural validation,
modify_local_hw_breakpoint_addr() bypasses all these safe-guards.

Since generic code cannot know x86-specific exclusion zones, any caller
supplying an invalid address will directly program the hardware, potentially
triggering recursive exceptions that hang the system.

> +	arch_modify_local_hw_breakpoint_addr(bp, addr);

[Severity: High]
Are we missing NMI-safe sequence counter protection in
arch_modify_local_hw_breakpoint_addr()?

Looking at arch_modify_local_hw_breakpoint_addr() in
arch/x86/kernel/hw_breakpoint.c, it modifies the CPU debug register directly
without incrementing cpu_dr7_seq to protect against NMI races, and without
temporarily disabling the breakpoint in DR7:

    this_cpu_write(cpu_debugreg[i], addr);
    barrier();
    set_debugreg(addr, i);

If an NMI occurs inside hw_breakpoint_restore() between reading a debug
register and writing it, and the NMI handler uses
modify_local_hw_breakpoint_addr() to update the same debug register, the
sequence counter (cpu_dr7_seq) is not incremented.

When hw_breakpoint_restore() resumes, it will overwrite the debug register
with the old stale address without detecting the interference, while the
software state retains the new address.

Additionally, does writing directly to DR0-DR3 while the breakpoint is
enabled in DR7 violate the Intel SDM (Vol 3, 18.2.2)? This could result in
hardware and software breakpoint state becoming permanently desynced, and
undefined hardware behavior may occur.

> +
> +	return 0;

[Severity: Medium]
Could this unconditionally return success even if the underlying architectu=
re
function fails?

If a caller passes an inactive or remote-CPU hardware breakpoint to
modify_local_hw_breakpoint_addr(), the generic code unconditionally updates
bp->attr.bp_addr and counter_arch_bp(bp)->address locklessly before calling
the arch-specific function.

The arch_modify_local_hw_breakpoint_addr() function will fail to find the
slot, trigger a WARN_ONCE, and return early without modifying hardware.

However, since it returns void, the generic function unconditionally
returns 0 (success). This leaves the software and hardware states permanent=
ly
desynced.

> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785067572.gi=
t.wangjinchao600@gmail.com?part=3D3
