Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C13F1ADB;
	Mon,  7 Sep 2026 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753622; cv=none; b=Hq//+SiP57ei5U4pm1BGUxOYlWlR1Y6Qc6DROiUockjCRrwYbrvc6Qs2mt8Xox5hNIUzS1BDvrK1AThM2aKDZjYejsY05JJ/XLrYkUvA7mNmEUenmTFpF7+bogMZW5nlq3MexVM9qfwO20Zi6Ns/aHwxhvyHKNvSUZRBHO/4pDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753622; c=relaxed/simple;
	bh=YhpmS/7bz/P6CYSoOC0Bed/2tIV7391xkZHvSTkM68k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JIwzC4PwOP0IspxUki45/kJOhs2D5hkB4SdgYG7njBUfmaBqXE5L3q/83RwcDDxVF1BywqS1WVuFW/aPmrLBPvjckwm3Yamd+8zNNgTISX35IEMW0T/C9e8nyVWFV2rRXfqrv68P5RjqWX9ILOTFdMwifqjMa/vwSHuZEwpO4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwN6tvrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwN6tvrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1983E1F00ACA;
	Mon,  7 Sep 2026 04:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753617;
	bh=oiAY35I5G3HJ9N58qrm0EUMKcYa6WBa/e6m2nuqyM+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MwN6tvrfIpLzvnfu0Ej0i2UJLX0vgINLyBTnduZRr0o9ya3Gac6lIptjVind7I98s
	 kWmiG7DstZHWjkqfdw3bKSFpYcBv1K6Z0zcfne+Ypsf/lzXUs/pENOX1UP/rOtu3Nb
	 l2hEZeU9xFdvcROWBaS6lIXkm1wk5MaIyhhCBk2qMAaKhtZXOn2t1/PKPA3wnwvu5D
	 HZY+6ENYkEIQQqWxpTy5TaoLOhE8MYFMdhukkLFVYuYoZ/c25O3Zhf7nNJgIB+VcBV
	 leXIoApOp3Vx7MdCDkyLVnP7aNwYrPWdK+WyGR6MD4LqLwVTiVT31nnmimS4nse7wr
	 0pYhbK7PkWzAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 02/12] x86/hw_breakpoints: Make DR7 updates NMI safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178875280112.93794.5857698342827027053.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875280112.93794.5857698342827027053.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:00:16 +0000
Message-Id: <20260907040017.1983E1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] local_db_restore() incorrectly uses dr7 =3D=3D 0 to discard NMI-in=
stalled hardware breakpoints, permanently losing debug state and corrupting=
 KVM guest debug registers.
- [High] local_db_save() destructively clears hardware DR7 inside its seque=
nce retry loop, permanently corrupting the restored state if a retry occurs.

Pre-existing issues:
- [High] The early return in local_db_save() bypasses the sequence retry lo=
op, leaving a race window where an NMI can leave hardware breakpoints enabl=
ed during critical exception handlers.
--

commit 48808d0a31b45134e9ef897c90c0f96bd987d9ce
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoints: Make DR7 updates NMI safe

This commit introduces atomic per-CPU operations and sequence numbers to
make DR7 hardware breakpoint updates NMI safe. It updates local_db_save()
and local_db_restore() to use retry loops that detect NMI interruptions,
preventing state corruption.

Link: https://lore.kernel.org/all/4ee0a2efc9e8387af83286b8495b7d490247e165.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debug=
reg.h
> index 854d82b88ff4e..3399e166d3044 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h
[ ... ]
> @@ -125,40 +126,66 @@ static __always_inline bool hw_breakpoint_active(vo=
id)
> =20
>  extern void hw_breakpoint_restore(void);
> =20
> -static __always_inline unsigned long local_db_save(void)
> +static __always_inline void local_db_save(unsigned long *dr7,
> +					  unsigned int *dr7_seq)
>  {
> -	unsigned long dr7;
> +	do {
> +		*dr7_seq =3D this_cpu_read(cpu_dr7_seq);
> +		*dr7 =3D 0;
> =20
> -	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_activ=
e())
> -		return 0;
> -
> -	get_debugreg(dr7, 7);
> +		if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) &&
> +		    !hw_breakpoint_active())
> +			return;

[Severity: High]
This isn't a bug introduced by this patch, but could this early return
in local_db_save() bypass the sequence retry loop?

If an NMI hits exactly before the return instruction and installs a
breakpoint, the function exits immediately. This leaves the newly installed
hardware breakpoint active during exception handlers like MCE, which could
trigger a recursive #DB exception and lead to a kernel panic.

> =20
> +		get_debugreg(*dr7, 7);
> =20
> -	/* Architecturally set bit */
> -	dr7 &=3D ~DR7_FIXED_1;
> -	if (dr7)
> -		set_debugreg(DR7_FIXED_1, 7);
> +		/* Architecturally set bit */
> +		*dr7 &=3D ~DR7_FIXED_1;
> +		if (*dr7)
> +			set_debugreg(DR7_FIXED_1, 7);

[Severity: High]
Can this destructively overwrite the hardware DR7 state inside the sequence
retry loop?

If an NMI interrupts execution between reading and clearing DR7, installs a
breakpoint, and increments cpu_dr7_seq, this set_debugreg() call will
overwrite the NMI's new hardware state with 0x400.

When the loop detects the sequence mismatch and retries, the next
iteration's get_debugreg() will read this clobbered 0x400 value instead of
the state installed by the NMI, permanently corrupting the restored state.

> =20
> -	/*
> -	 * Ensure the compiler doesn't lower the above statements into
> -	 * the critical section; disabling breakpoints late would not
> -	 * be good.
> -	 */
> -	barrier();
> +		/*
> +		 * Ensure the compiler doesn't lower the above statements into
> +		 * the critical section; disabling breakpoints late would not
> +		 * be good.
> +		 */
> +		barrier();
> +	} while (unlikely(*dr7_seq !=3D this_cpu_read(cpu_dr7_seq)));
>  }
[ ... ]
> -static __always_inline void local_db_restore(unsigned long dr7)
> +static __always_inline void local_db_restore(unsigned long dr7,
> +					     unsigned int dr7_seq)
>  {
> +	unsigned long val;
> +	unsigned int seq;
> +
>  	/*
>  	 * Ensure the compiler doesn't raise this statement into
>  	 * the critical section; enabling breakpoints early would
>  	 * not be good.
>  	 */
>  	barrier();
> -	if (dr7)
> -		set_debugreg(dr7, 7);
> +
> +	do {
> +		seq =3D this_cpu_read(cpu_dr7_seq);
> +		if (seq =3D=3D dr7_seq) {
> +			if (!dr7)
> +				return;
> +			val =3D dr7;
> +		} else {
> +			/*
> +			 * If an NMI modified breakpoints while DR7 was saved as 0
> +			 * (e.g. KVM guest entry), arch_install_hw_breakpoint()
> +			 * clobbered hardware DR7. Restore val =3D 0 (DR7_FIXED_1)
> +			 * to clean up the NMI's write and preserve guest isolation.
> +			 * Otherwise, load the latest cpu_dr7 state.
> +			 */
> +			val =3D dr7 ? this_cpu_read(cpu_dr7) : 0;

[Severity: High]
Does this logic permanently discard the hardware breakpoint installed by an
NMI if dr7 was initially 0?

If dr7 was saved as 0, which happens when no host breakpoints were active,
and an NMI subsequently installs a breakpoint, this logic evaluates to 0
and ignores the new cpu_dr7 state.

It will then write 0x400 to hardware DR7, completely overriding the NMI
update. Furthermore, if an NMI interrupts a KVM guest, the guest's DR7
state is completely destroyed and replaced with 0x400.

> +		}
> +
> +		set_debugreg(val | DR7_FIXED_1, 7);
> +		barrier();
> +	} while (unlikely(seq !=3D this_cpu_read(cpu_dr7_seq)));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D2
