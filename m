Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808078;
	b=rPpn6S3AiE4RC+BWdP1Z5UgvNh/HaaCUiV+lGQqv71ovB+up+E6fQIDoWFLBV1t8OYBG
	 aKdaM/0WDPY9NIMGF09KNABHlvQCgkLLj5Z4s/8oUeIoyTuJu+LM9+AQsxEX3JsigLBbi
	 Sa87cAfZxczyqDAw20kKCLoHUa8gksnNIN43FnElLiGi+PfUDR+tH6VuPIIrqMmB2yNK4
	 2JhLfd+9p4gu86H3yMzvcgitHHDyML7cfDTmRi//mrVYN9qqRcfgaZGy3njcR8gky4IXa
	 OF3rdBRSGrEgLaiiwUjGCMYFPn0OAlqNPsDhXOKCg88vhwhT0k6i27AqQOtH1dx58nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808078;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r+7Vzjwcp9BgxCv1py5tD9OGWxIByxPeQv9aWLm9NLo=;
	b=ewbydUMgOHrtRrcpe940Oy6uIplRHrFtVQjW/b/Xcy4F7nHGcaR1USYI0ZQn9NpNvGi+
	 MMp3OlD8CCuKo4IHBAszPqw+5TcnynqoVzSLsDyC/zhMrCQf66Nkr3wdNqS1lpIlcwMFY
	 12JURfg9n4rHchzgZ+OWARqJh81WnQzEAYyt3Uxn3TRNpyjQQxK5ziMWIADMaAtZnN/81
	 4p2G5Q2d6p8K+9KQdtvzzPI6Ey/OIUWH5kpl/tgFT5IQQSH3prKMtEfV59lUrjI7UAFI6
	 pFcVVjkNrzimoF9XWyvSYD2dioBQ7yZ4sE0yWFJkcI2p+8dDNoOQPhBE4G4zdU8eJ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGoSxT5C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F6606A31C;
	Mon, 16 Nov 2026 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGoSxT5C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB021F000C5;
	Mon, 16 Nov 2026 05:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808078;
	bh=r+7Vzjwcp9BgxCv1py5tD9OGWxIByxPeQv9aWLm9NLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kGoSxT5CfYrxX/d3uZTJcWKuScm/kPPD83xwtdig7W+nBYg8Dp/plDUcATnFeCKRF
	 Dj124pWk80ETU+fzkrwEpsLqkB29pgbwvDmEWV1sZczo098/E6uqWGm2I5tO3vBUSX
	 tovvD35PS4z4BgDXq3bT4SiYwCvcM2iDoLe+9NpMPfb18q6REUF3iON/B/3UWoYQvD
	 QYGcO/6qoH29jYt5/7eZDVQPLkYqBmhoRB+zMIec4URLLX9IeapNvYfqqb3xsjJmOs
	 k46HV5lxlT/PCO1XOAox1oRprLkffCEcTd0BXg2zYnZepSrFOAnJlRShFeFEgkNkhW
	 PYOHe/AEQQXgg==
Message-ID: <sashiko-outbox-216226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 01/11] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179480676405.38065.17662254533654266956.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480676405.38065.17662254533654266956.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:47:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] x86/hw_breakpoints: arch_modify_local_hw_breakpoint_addr()
  corrupts DRs
--

commit 490e341c5679ea8c1cf5b3a39b5b39ecc93de7d0
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

This commit adds arch_modify_local_hw_breakpoint_addr() to update the
address of an installed per-CPU hardware breakpoint on the local CPU
without releasing and re-allocating its debug register slot.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index f846c15f21ca1..3f63f7899f95e 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -133,6 +133,57 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return 0;
>  }
> =20
> +/*
> + * Modify the address of an installed perf counter breakpoint on local C=
PU.
> + *
> + * This updates the debug address register and per-CPU shadow state with=
out
> + * changing slot allocation or DR7. The core layer (modify_local_hw_brea=
kpoint_addr())
> + * manages updating bp->attr.bp_addr and counter_arch_bp(bp)->address.
> + *
> + * Atomic: called with IRQs disabled and handles variables and registers
> + * local to this CPU.
> + */
> +int arch_modify_local_hw_breakpoint_addr(struct perf_event *bp,
> +					 unsigned long addr)
> +{
> +	struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
> +	struct arch_hw_breakpoint hw;
> +	struct perf_event_attr attr =3D bp->attr;
> +	unsigned long dr7;
> +	int i, ret;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	attr.bp_addr =3D addr;
> +	ret =3D hw_breakpoint_arch_parse(bp, &attr, &hw);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D 0; i < HBP_NUM; i++) {
> +		if (this_cpu_read(bp_per_reg[i]) =3D=3D bp)
> +			break;
> +	}
> +
> +	if (WARN_ONCE(i =3D=3D HBP_NUM, "Can't find any breakpoint slot"))
> +		return -ENOENT;
> +
> +	/*
> +	 * Temporarily clear the breakpoint enable bit in DR7 before updating t=
he
> +	 * debug address register, and re-enable it afterward, to comply with t=
he
> +	 * x86 hardware specification and avoid spurious #DB exceptions.
> +	 */
> +	dr7 =3D this_cpu_read(cpu_dr7);
> +	set_debugreg(dr7 & ~__encode_dr7(i, info->len, info->type), 7);
> +
> +	this_cpu_write(cpu_debugreg[i], addr);
> +	barrier();
> +	set_debugreg(addr, i);
> +
> +	set_debugreg(dr7, 7);

[Severity: High]
Can arch_modify_local_hw_breakpoint_addr() corrupt hardware debug
registers or prematurely re-enable hardware DR7 when host breakpoints are
temporarily disabled or switched to KVM guest state?

Several paths disable hardware DR7 (writing DR7_FIXED_1) or replace
hardware DR0-DR3 without clearing the per-CPU shadow cpu_dr7:

arch/x86/kvm/x86.c:vcpu_enter_guest() {
	...
	if (unlikely(vcpu->arch.switch_db_regs &&
		     !(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH))) {
		set_debugreg(DR7_FIXED_1, 7);
		set_debugreg(vcpu->arch.eff_db[0], 0);
		set_debugreg(vcpu->arch.eff_db[1], 1);
		set_debugreg(vcpu->arch.eff_db[2], 2);
		set_debugreg(vcpu->arch.eff_db[3], 3);
	}
	...
}

vcpu_enter_guest() runs in normal context with IRQs disabled and invokes
instrumentable functions and tracepoints (such as trace_kvm_entry and
trace_kvm_exit) before sync_dirty_debug_regs() and
hw_breakpoint_restore().  If a wprobe trigger calls
arch_modify_local_hw_breakpoint_addr() in this window, set_debugreg(addr,
i) overwrites the guest's hardware DR[i] with the host kernel address
(which sync_dirty_debug_regs() then saves into vcpu->arch.db[i], leaking
the host address to the guest), and set_debugreg(dr7, 7) activates host
cpu_dr7 while the remaining hardware DR[j] registers still hold guest
addresses.

Similarly, if called while use_temporary_mm() -> hw_breakpoint_disable()
or local_db_save() has suppressed hardware breakpoints, writing cpu_dr7
back to hardware DR7 re-enables the breakpoints prematurely while temp_mm
is loaded (with 0UL in the other DR registers) or while inside a #DB
exception context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D1
