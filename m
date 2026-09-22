Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E43321C2;
	Tue, 22 Sep 2026 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052029; cv=none; b=f7I+8EDJ95c9hITR62NnmbPHCnj3pKXJUhnNHy8xLmPFcY5qNtDRbr4c8iVQU8jlluXtS4GOefo0V/1kfPXmwbh4GqFcC0ZJudN+OC6rtf/i7DyQFEYnrFyoYktCJbY0fkAZG6/Sfr8Uo7NReReTENSRvMNv5JZEQ25S2FrBlHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052029; c=relaxed/simple;
	bh=zV5oBg8OEX1VMRvsBSqTPd7Czcd0yqAtFrVdU1VcmUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sfu9Wvo2dj9LDqb8LtTSIXr4Ybd9rdPS12E7hcw5nL9zeU+3oIVeP2ZI3WMKzcOyD93Y/HtU3mt6xLWuae3IqiYxuZ6SHUng62tF/spX5Kc88XbKNGn+w7FUAhQLACrCDkXfPmeb4RTj9IP22UPU3PVOQzJkUFlABQTkAq/StNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqpzjKMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqpzjKMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF7B1F00893;
	Tue, 22 Sep 2026 04:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790052028;
	bh=VOE5oOORRXsd7SmJEE1dVmmmE512iMjLQH4FkD0aj1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqpzjKMKfX3RRAt8E0ay2T6n1pPADuLKc78Juck95y5vSxhkHxXG5mESnT42pWnIA
	 yxL67lHrC2oSG9w11AXjbkUa2mWDXXxSAFq9yI75q3P9UARrQI8m5MD8BYfAzSkf9K
	 4HiIgFpww//UkQyiwhKc3K61oAZb9UyfV8M/KlcGVw1lDFrHwujI5JcOkbxM3avNli
	 VrO4patFosPibSEd5vCCMMQAckGQBHTDERSG869sXcWar88i3K9adexjHT4sEsynmN
	 9vCtthYpgYsD8nei0S/7xeBJp2gS3Qmt+8EjNNmh7KKDLxYM4UK7YH694inbCNYr6b
	 Blrb/5EfDe03Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 02/13] perf/x86, KVM: Prevent host debug register
 leak into guest OS on NMI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179005110742.388919.1509641807739909065.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005110742.388919.1509641807739909065.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:40:27 +0000
Message-Id: <20260922044028.3AF7B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/x86: -EBUSY in arch_install_hw_breakpoint breaks KGDB and mis=
ses NMI clobbers
--

commit f10b90aff527e68c852cc3297fd95e985f01fa91
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

perf/x86, KVM: Prevent host debug register leak into guest OS on NMI

When KVM enters a guest OS, host hardware breakpoints are disabled
before running the guest. However, an NMI can occur while executing
in guest mode or during guest transition, where
arch_install_hw_breakpoint() can be invoked from NMI context.

If arch_install_hw_breakpoint() is executed while the CPU is in guest
mode or during the VM entry transition window, hardware debug registers
can be modified with host breakpoint settings, leaking host breakpoints
into the guest OS or clobbering the guest's debug registers.

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index f846c15f21ca1..0473a5c958566 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -102,6 +102,9 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
> =20
>  	lockdep_assert_irqs_disabled();
> =20
> +	if (perf_guest_in_guest())
> +		return -EBUSY;
> +

[Severity: High]
Does returning -EBUSY here break KGDB?

If an NMI (e.g., KGDB entry) occurs while the CPU is in guest mode, this
will return -EBUSY. In arch/x86/kernel/kgdb.c:kgdb_correct_hw_break(), it
receives this and leaves the breakpoint permanently disabled, since it does
not retry:

	val =3D arch_install_hw_breakpoint(bp);
	if (!val)
		bp->attr.disabled =3D 0;

Also, since arch_uninstall_hw_breakpoint() and hw_breakpoint_restore() in
arch/x86/kernel/hw_breakpoint.c do not have this perf_guest_in_guest()
check, will they still unconditionally write host state to the physical DR7
register?

For example, if KGDB removes breakpoints or resumes the CPU during guest
mode, they might still clobber the guest's active DR7:

arch/x86/kernel/hw_breakpoint.c:arch_uninstall_hw_breakpoint() {
	...
	dr7 &=3D ~__encode_dr7(i, info->len, info->type);

	set_debugreg(dr7, 7);
	...
}

arch/x86/kernel/hw_breakpoint.c:hw_breakpoint_restore() {
	...
	set_debugreg(__this_cpu_read(cpu_dr7), 7);
	...
}

>  	for (i =3D 0; i < HBP_NUM; i++) {
>  		struct perf_event **slot =3D this_cpu_ptr(&bp_per_reg[i]);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D2
