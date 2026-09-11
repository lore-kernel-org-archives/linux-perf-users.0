Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C7470EA7
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129715; cv=none; b=p05T3Fs8uS0joIdTGXhl7gLVWhB5RIk3btVgSAAJMrp6nVbK268QBXeetT1YHH+FiB5XpmVrbmpyWxGWgqB802qNqumkcoRA+IVyyV/lzIv76lpAE77l3vvpwhitAOeycYUqGJslu6yPTtSMF55/bnK28PTIYCxkFmgKfruaEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129715; c=relaxed/simple;
	bh=Y22oAOYfO29bV4b/uBm+1Svom9ecfhlZLcx1ZOKDvZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WgIc1ivLweWcxsZPuKmW37ajsS08nrN9+5RiXPOk3WCBQK0/9pO3kmqyp6wQLA78JFol4dNjDjYOe96AO7arJeG0kcBgbp+5f2W1xlxkwpqSnjJL5qNMBVYPqcw9RCXZPV79d6+XLIL1EKorW8sR5Ud8MVrEvxHLgTg48xSwm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPIN0z2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPIN0z2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A1C1F000FF;
	Fri, 11 Sep 2026 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129714;
	bh=UP676po0CuG7Diq2loxYvCUrWJ3ZYleNIf8atY6VASs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPIN0z2HuNVR3JDfEARUChvah7LIFH/+3Bvm/AE2qPbU1FhdhoQWv5Zrd0gak/meH
	 X9gHZit/ZzjcrDcl/riFm6R/6khR+uRr3N1g2Z3tq3ZC4xfKq2oJFizOQ5OVnbiDu7
	 yf4w+nAk05/FhMcjeHT2mjCKLiVWEAVr46AaTsW/JG84+lIzbMvN8SFwIpaXl9mwkI
	 k1765dsIKK6YLaaSKbtoLraTm1ljwp5W/7CHVBM+820oAZloql+Dve3W+suBTT/Edp
	 SyTA+LLXq4YknOR41r8PO4pWUupCk8y+E/nefz9QEVE56pHb9DSMAMVDBOAeHi3ER0
	 ihh48dOHlfeuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/9] riscv: mm: avoid enabling interrupts for
 nofault page faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911121456.33223-6-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
 <20260911121456.33223-6-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:28:33 +0000
Message-Id: <20260911122834.37A1C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Premature exception fixup bypasses vmalloc_fault() on 32-bit RISC-=
V, breaking nofault accesses to valid vmalloc addresses.
--

commit cb75a61df5b372879cfe9c956e1ab3e4a9d62e0b
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

riscv: mm: avoid enabling interrupts for nofault page faults

This commit modifies the page fault handler on RISC-V to handle nofault
accesses and perform exception-table fixups before enabling interrupts or
running tracepoints. This keeps interrupts disabled during nofault accesses
from atomic contexts.

> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 04ed6f8acae4f..520495420462f 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -294,6 +294,13 @@ void handle_page_fault(struct pt_regs *regs)
>  	if (kprobe_page_fault(regs, cause))
>  		return;
> =20
> +	/*
> +	 * Nofault accesses must be resolved through the exception table before
> +	 * entering the generic fault path or enabling interrupts.
> +	 */
> +	if (unlikely(faulthandler_disabled()) && fixup_exception(regs))
> +		return;
> +

[Severity: High]
Does this early exception fixup bypass vmalloc fault synchronization on 32-=
bit
RISC-V?

On 32-bit RISC-V, valid nofault kernel memory accesses to vmalloc addresses
(such as those made by copy_from_kernel_nofault() via bpf_probe_read_kernel=
()
or /proc/kcore) rely on vmalloc_fault() to lazily synchronize the PGD.

Because copy_from_kernel_nofault() executes with pagefault_disable(),
faulthandler_disabled() evaluates to true. By intercepting this condition a=
nd
returning early, we completely bypass vmalloc_fault(), which is called slig=
htly
later in handle_page_fault():

	if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
	    unlikely(addr >=3D VMALLOC_START && addr < VMALLOC_END)) {
		vmalloc_fault(regs, code, addr);
		return;
	}

Could this cause legitimate nofault accesses to valid vmalloc addresses to
spuriously fail with -EFAULT instead of completing successfully?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911121456.3322=
3-1-zhangzhanpeng.jasper@bytedance.com?part=3D5
