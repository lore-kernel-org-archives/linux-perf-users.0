Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C978948489A
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990088; cv=none; b=HJx5kgPqswHRFMeAo92pHAJiG4D0gQx6Q6GeQZ8YvGNy7B/t5AskBWGH4HWlj7J5MlJeKLQ/FE3LrujLd6Xh7gvozVMFqzlfsCwguJQ49R2drPxBPI3KRYaLnHmGqFFfDLlm5Y944Ruc7kpLXNbYI/74y83JYSva3/lCF2rMBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990088; c=relaxed/simple;
	bh=rOKe0h9Yt6ODY5nOj1dqNrNxSSl2vs0WXmvHm9J3Hyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ke4M7TUksn0FlF9r7AbJDjHZ+qtBw7/TfpmIvH+8CQ29CvYpGNtBGi7X9qBhT7HG4LOlok/DG1urS89zrOzvWM9DuL/t71w/N/p9i9GuglF6i9gQ3it7Erl+B4Fb3G2/gWqi9UvT4xqZ/dl70tdeSa+MMU71sh0Sjgk73klRAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEm8FggI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEm8FggI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C96A1F000FF;
	Mon, 21 Sep 2026 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990086;
	bh=Yc5LOT42b+cR4amik7rpLIfEqsvW9e66d675zIv93rA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XEm8FggIGrcTSQdFge8liDN8nn9/XgdzrxZxPTYZEkkWkSVBEWUMzit8dhrybvA6m
	 bmsR2sdlB90JTahyIJ1w6mQWFijoLFGYU/tUCwfx0fXknmR8WEQQ2T/o7Yew+Fkk9Z
	 QAzvCR7S/HjXYH36aDx0aOFICFAzBo81S1uAkQ81aGq5JEn9OS9ET9ngSYElBXCkuD
	 zP7A/nKBjqo5h5fXcrFreQkr4Ys5IPuSutn2w7GHgiYItM2kpj9gstc3GCGQY7H9ac
	 Z/6er9Btyi0TvlKqZJyv+JuyiSUvKH8WfJmDcHvdLy5kupzfDpwBA/mX+A7S3evHZV
	 dBpZuylsm+PeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 RESEND 5/9] riscv: mm: avoid enabling interrupts for
 nofault page faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4bc18f96053a7859a3ff33747479b05a9e42a706.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <4bc18f96053a7859a3ff33747479b05a9e42a706.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:28:05 +0000
Message-Id: <20260921112806.2C96A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] riscv: mm: fixup_exception bypasses vmalloc_fault for nofault acce=
sses
--

commit b959120cb7ee095dc7b5e388ec2110c0a78dd4ac
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

riscv: mm: avoid enabling interrupts for nofault page faults

This commit modifies the RISC-V page fault handler to resolve nofault acces=
ses
via the exception table before enabling interrupts or entering the generic
fault path. It aims to prevent in-atomic nofault accesses from inadvertently
running tracepoints or opening an interrupt window.

> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
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

[Severity: High]
Will this new check in handle_page_fault intercept faults on valid vmalloc
addresses before vmalloc_fault has a chance to execute?

When tools like BPF or perf perform a legitimate nofault read (such as via
copy_from_kernel_nofault) on a vmalloc address that has not yet been
synchronized to the current task PGD, it triggers a page fault. Since
faulthandler_disabled is true in a nofault context, it appears this new
early check will call fixup_exception and immediately return.

On 32-bit RISC-V and !MMU configurations, this bypasses the lazy PGD
synchronization performed a few lines further down:

if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
    unlikely(addr >=3D VMALLOC_START && addr < VMALLOC_END)) {
        vmalloc_fault(regs, code, addr);
        return;
}

Could this cause valid kernel vmalloc reads via nofault accessors to
spuriously fail with -EFAULT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789974241.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D5
