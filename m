Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6419366DD3;
	Sat, 22 Aug 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391668; cv=none; b=HOclSKLt45JOzSsJb7ruUxEV70mMb0rM85TyVWjkI+yPCWzG5s+K7VCfgKDmTNchi7fqifuy/QHYM4vS4D6YQwTnKlOJRNFt2akkv6a6GH67mLV5EHKhOz9rsPu3MAP0sNXYrEBVz5YCGDjzCOY3zqHzqxvlaf/EDQUQHRkNg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391668; c=relaxed/simple;
	bh=nzfAB6Nczenc82Id71ay4eKCQfGiMVpMHNHaPW3ju4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qwnjSU1cC8JaESJTc1AVThFWrsY1nTTCny96pERN5/bK+OnXcxuLBijkyEx4+0WroQ0P4dyKrIUDs5Lq4n3zuAa3RLRymItPwkh39VtEj9PLdF6EVgawOm06gpKZ79mFOaSdTpUENU8198AJG+tPhp/XUIH3s2cUq2v3XmNvyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X43qK6kq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X43qK6kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349031F00A3A;
	Sat, 22 Aug 2026 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391667;
	bh=1pyUjjMbx0WlyUH1hICkro2FSdzKZ7E0078lpH9Apgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X43qK6kqiTqBkF07ztgoavOxqlSUeWsMHYLDmBL+ugs395y2C5SrIPsl68CuiRAm0
	 68A28tTAiSRQn8tz1V5oAmnEEDtIbUU+leCOWBBUH9/UgoWcIwPnojt8zwufo5qMy0
	 d7feNkZuVU+6EdI8EJnwaUuBJwkxhH0DBHwRhmwFx7zQ1qkLU+n9UI4su0sMt56+yq
	 7SSlka5Q78FRQel2dlcE9oPRrEuxDwqWGLGIkdsXM4WetxmVMbV6dS5L7FfYbYrFVX
	 B4nA1f0H/dmZc3BI+xw6Xw2VK6milLczCHhmL4HiJfbuaLCjPqeeviIv3g4nCk7Z2y
	 4bFvvQBse9qqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/12] x86/hw_breakpoints: Make DR7 updates NMI safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178739056219.1520941.16843776326995549779.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739056219.1520941.16843776326995549779.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:41:06 +0000
Message-Id: <20260822094107.349031F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] local_db_restore overwrites an intentionally cleared hardware DR7 =
state (e.g., KVM VMENTER) with the host's shadow cpu_dr7 if an NMI modifies=
 the sequence counter.

Pre-existing issues:
- [High] Task migration during user-mode machine check exceptions corrupts =
hardware debug registers on the new CPU.
--

--- Patch [2]: [PATCH v13 02/12] x86/hw_breakpoints: Make DR7 updates NMI s=
afe ---
commit 0d8b774ae86048690b3378737c33f417379e85de
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoints: Make DR7 updates NMI safe
   =20
Hardware breakpoint installation and removal run with IRQs disabled, but
an NMI can still enter the same code through KGDB. The interrupted
operation and the NMI can consequently claim the same slot or overwrite
each other's DR7 state.
   =20
Claim and release per-CPU slots with cmpxchg. Update cpu_dr7 with
single-instruction per-CPU operations, and preserve hardware-first
disable and hardware-last enable ordering. Add a per-CPU sequence number
so interrupted DR7 writers and restore paths detect an NMI update and
retry from the latest shadow state.

Link: https://lore.kernel.org/all/4ee0a2efc9e8387af83286b8495b7d490247e165.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debug=
reg.h
> index a2c1f2d24b645..c41ee981c2303 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h
[ ... ]
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
> +		barrier();
> +	} while (unlikely(seq !=3D this_cpu_read(cpu_dr7_seq)));
>  }

[Severity: High]
If KVM intentionally clears the hardware DR7 state to isolate the guest from
host breakpoints before VMENTER without modifying the host's cpu_dr7 shadow
state:

arch/x86/kvm/x86.c:vcpu_enter_guest() {
    ...
    if (unlikely(vcpu->arch.switch_db_regs &&
                 !(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH))) {
        set_debugreg(DR7_FIXED_1, 7);
    ...
    } else if (unlikely(hw_breakpoint_active())) {
        set_debugreg(DR7_FIXED_1, 7);
    }
    ...
}

Could an NMI firing shortly after this permanently undo this isolation
upon return?

If an NMI (such as a perf event) fires before vmlaunch/vmresume, exc_nmi
calls local_db_save, saving dr7=3D0. If the NMI modifies a breakpoint,
cpu_dr7_seq increments.

When exc_nmi calls local_db_restore, the sequence mismatch causes it to
discard the saved dr7=3D0 state and instead unconditionally restore the hos=
t's
active breakpoints (this_cpu_read(cpu_dr7)) to the hardware DR7. This could
leak host hardware breakpoints into a KVM guest and cause unexpected #DB
exceptions.

[ ... ]
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index 9bba1e2f03af7..8dba9cd04bfa5 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
[ ... ]
> @@ -2139,20 +2139,22 @@ static __always_inline void exc_machine_check_use=
r(struct pt_regs *regs)
>  DEFINE_IDTENTRY_MCE(exc_machine_check)
>  {
>  	unsigned long dr7;
> +	unsigned int dr7_seq;
> =20
> -	dr7 =3D local_db_save();
> +	local_db_save(&dr7, &dr7_seq);
>  	exc_machine_check_kernel(regs);
> -	local_db_restore(dr7);
> +	local_db_restore(dr7, dr7_seq);
>  }
> =20
>  /* The user mode variant. */
>  DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
>  {
>  	unsigned long dr7;
> +	unsigned int dr7_seq;
> =20
> -	dr7 =3D local_db_save();
> +	local_db_save(&dr7, &dr7_seq);
>  	exc_machine_check_user(regs);
> -	local_db_restore(dr7);
> +	local_db_restore(dr7, dr7_seq);
>  }

[Severity: High]
This is a pre-existing issue, but does task migration during user-mode
machine check exceptions corrupt hardware debug registers on the new CPU?

exc_machine_check_user invokes irqentry_exit_to_user_mode, which processes
pending thread work (like TIF_NEED_RESCHED), enabling interrupts and allowi=
ng
the task to be scheduled out and migrate to a new CPU:

CPU1
exc_machine_check()
    local_db_save(&dr7, &dr7_seq);
    exc_machine_check_user(regs)
        irqentry_exit_to_user_mode(regs)
            // Task migrates to CPU2

CPU2
    local_db_restore(dr7, dr7_seq);

When it resumes on the new CPU, local_db_restore is executed with the dr7
and dr7_seq values saved from the old CPU. If the new CPU's cpu_dr7_seq
matches the old CPU's saved dr7_seq, it would erroneously write the old CPU=
's
hardware DR7 state to the new CPU's hardware DR7 register. Could this cause
spurious #DB exceptions or break hardware breakpoints on the new CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D2
