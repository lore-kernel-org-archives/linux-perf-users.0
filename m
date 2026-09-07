Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213B1E3DDE;
	Mon,  7 Sep 2026 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753725; cv=none; b=WZCDBqggzxtsG3pyf24xV1vDApoosQmacOb34aBY6D7rYH7lr7FgX+JeZATI/ER3LCpSc7EUnVA+A3zwc8dbT0BCPvM7U6hBMZ3TcpgNKXfXxZRK7uCMMvjeiNV9dSwZYe8vHZ+I+SeoZRWkuPUDM1v5sSGAo2ANamJGjZSzXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753725; c=relaxed/simple;
	bh=DB6Mym9o8wUukRqp7IWFn71mdplwCKNL2eHH1d/NBwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A1k/dim2oa3Y1/2HuwnFfzXL9XXrT8ZoESF1ckzSPrZF15uCQAP8U868YYxw/JwayeolzqwhQUlgAN/0ZySlFABEBf3jI4QR77T9puthbj6w3dHOAXR5k0Hd2u7ixVThQ8IBbdYqLN1RrpYaiN9X45mK31tj+X4az3Z9MVPC4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjaFEA+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjaFEA+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2941F00A3A;
	Mon,  7 Sep 2026 04:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753724;
	bh=5FFclixOcrOCTvILYx59sNMcyjlA3+wVi0Y27X0RkuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjaFEA+rl9c3iTNzBdzqb6lRTs8a5wwghagacXYp+pEeijyhjD9kjTZZ0it2tHmim
	 K/p1hErmuqel31KEirazaQkksZYQQvVLCUPgrwBGO9+WEn8GrC8n8xSPAVnnO0shFI
	 pWVH381OKZATefR43sjVkW4eUct/bwicUv0/PQk5DyCqbYFts59WZPi6mmwZ/dVFsq
	 ko0b1SdMe5wAceQFNl3CcdIK5+Q3VRVRO5uOVp8rGUGIGlJUqnfwHkGKyo6sWgcr/y
	 +hzbngoZXk/uQUennG8hsGEvwhtogfiO6vedQHPsA/HscPZLKRgKNT/fu7QB3BEOmY
	 WwvvXgGhNobGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 03/12] x86/hw_breakpoints: Add
 arch_modify_local_hw_breakpoint_addr() API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178875281237.93794.4844650709915505895.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875281237.93794.4844650709915505895.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:02:03 +0000
Message-Id: <20260907040203.BA2941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Modifying a debug address register while the breakpoint is enabled=
 in DR7 violates the Intel SDM. This can occur due to a race condition with=
 an NMI because the `cpu_dr7` shadow state is not temporarily updated.
--

commit ca38cc4e9ed0533dfe16175c78dba60903420a8b
Author: Jinchao Wang <wangjinchao600@gmail.com>

x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

Wprobe needs to move an active per-CPU watchpoint without releasing and
reserving its hardware slot.

Add arch_modify_local_hw_breakpoint_addr() as the architecture backend for
modify_local_hw_breakpoint_addr(). It validates the new address, finds the
installed local slot, and updates the hardware debug register and per-CPU
shadow register.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpo=
int.c
> index 312550be3ad2b..99f0926298a85 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
[ ... ]
> @@ -129,6 +129,62 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
[ ... ]
> +	do {
> +		seq =3D this_cpu_inc_return(cpu_dr7_seq);
> +
> +		/* Disable breakpoint in DR7 before updating address register */
> +		dr7 =3D this_cpu_read(cpu_dr7);
> +		set_debugreg((dr7 & ~__encode_dr7(i, info->len, info->type)) | DR7_FIX=
ED_1, 7);

[Severity: High]
Does arch_modify_local_hw_breakpoint_addr() need to clear the breakpoint in
the shadow cpu_dr7 state as well?

Since the breakpoint isn't cleared in the cpu_dr7 shadow state, could an NMI
that interrupts execution here inadvertently re-enable the breakpoint
prematurely?

If an NMI handler (such as kgdb or perf) modifies breakpoints, it increments
cpu_dr7_seq and invokes local_db_save() and local_db_restore(). When the NMI
completes, local_db_restore() detects the sequence mismatch and restores
hardware DR7 using the cpu_dr7 shadow cache. Because cpu_dr7 still has this
breakpoint enabled, the target breakpoint gets re-enabled in hardware DR7
before the execution below resumes.

> +		barrier();
> +
> +		this_cpu_write(cpu_debugreg[i], addr);
> +		barrier();
> +		set_debugreg(addr, i);

[Severity: High]
If an NMI prematurely restored DR7 as described above, won't this modify the
debug address register while the breakpoint is enabled in DR7?

Modifying a debug address register while its corresponding DR7 enable bit is
set violates the Intel SDM and causes spurious #DB exceptions.

While the sequence loop retry mechanism will catch the mismatch, it only do=
es
so after this instruction has already executed, which is too late to prevent
the spurious exception.

> +		barrier();
> +
> +		/* Re-enable breakpoint in DR7 */
> +		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
> +		barrier();
> +	} while (seq !=3D this_cpu_read(cpu_dr7_seq));
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D3
