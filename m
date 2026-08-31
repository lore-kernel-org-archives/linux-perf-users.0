Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842173955CC
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202523; cv=none; b=BgXm4CmJutfgvgSYK8Q7McyG6eTw1qiJqEdIeOI0cUm9mQwsynfZN4BRkJqVMuuwxbNTUuyvz9Ds1/pIFKZ3M9HmjVjPAtgZ30WHVlfTLBU9OIFTvAeWHuB3KkPeyxhgb2bUCFqpt2LICNIHVoTEcyz5WnMkb+kzqAxERg+9hgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202523; c=relaxed/simple;
	bh=js6joqbjuGOVLuBDV+SoCE7OGCfSjnaRcWY444gCc5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CTMTKutcVt9JhMLJyBurERDQX5ZvUDrH05XJyzXP7bHsnO0ZUWKH96d+3vgIuo5eXN480ywYVJb3+YScimrEwNI6RFqMiMM7pATQuQnfpb1CbZfngeBfCy1OqYCTtfXl7eXncaOtRzjAvg4qnHyNd4vR1Uh8VjcCBJUnrtRVflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdTUH1Qg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdTUH1Qg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6241F000E9;
	Mon, 31 Aug 2026 18:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788202522;
	bh=sGV6gEPisSsSNxE02CZCpZoW5GPfinqCsQtBprFpuWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IdTUH1QgC8RM6BGIc75WJ3fqItYo7ttP21DfU0zBRMuDsmgmeFlZbEJd0DjcBTtYC
	 rBYeqJyLX5UTP2AQMkrVJvoo6gGSwhDIDGe4pD9eCODykERhHc1+4fC0Q67Y3lnFKn
	 kG32Ui0xjC+0RBh+9LPLmR50OiBG16+EXGqvx06B5YKrlri/Y9Eoaf2NhM/4phnLkc
	 lQAxUcYXQPLX8f5vC5d//tDpJGjwJdFQzszpfhON3LCk6OioH2ZgcG8YGAHHHKVMRN
	 J/e0mtUoQTT0eolLpxCkV03Bxr7E/N6eOMmI64aLtKU37Thdw9oKCwd8y5o7dZnLSB
	 +EykVCvGMEzUA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 04/19] ptwrite uprobes: Add infrastructure for ptwrite
 uprobes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-5-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-5-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:55:21 +0000
Message-Id: <20260831185522.0A6241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] handle_swbp() does not check for UPROBE_PTWRITE, leading to a =
kernel crash (NULL pointer dereference) if a thread traps at a PTWRITE upro=
be address.
- [High] uprobe_register_ptwrite incorrectly reuses dying normal uprobes, l=
eading to race conditions and SIGILL.
- [Low] uprobe_register_ptwrite requires a non-NULL handler despite documen=
ting that it is never invoked.
--

commit 25466f8679470946e2456212a51efd54e55bf02c
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add infrastructure for ptwrite uprobes

uprobes currently always require entering the kernel to log anything.
While that works well, it is rather slow.
Modern Intel CPUs have the ptwrite instruction, which can log data to
the Processor Trace buffer. This patch adds support in uprobes
to patch in ptwrites instead of the normal probes.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 941b52c478585..23202df2b51ae 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -59,6 +59,8 @@ DEFINE_STATIC_SRCU_FAST_UPDOWN(uretprobes_srcu);
>  /* Have a copy of original instruction */
>  #define UPROBE_COPY_INSN	0
> =20
> +#define UPROBE_PTWRITE		1
> +

[Severity: Critical]
Since PTWRITE uprobes do not have an initialized uprobe->arch.ops pointer,
what happens if an unprivileged user attaches with ptrace and inserts a
breakpoint at the exact address of the PTWRITE uprobe?

If the process hits the breakpoint, it enters the kernel's handle_swbp(),
looks up the uprobe, and proceeds to call arch_uprobe_skip_sstep().
Since handle_swbp() doesn't check for the UPROBE_PTWRITE flag, wouldn't
this unconditionally dereference the uninitialized auprobe->ops->emulate,
resulting in a kernel panic (null pointer dereference)?

[ ... ]
> +struct uprobe *uprobe_register_ptwrite(struct inode *inode, struct file =
*file,
> +				       loff_t offset, struct uprobe_consumer *uc,
> +				       const struct uprobe_ptwrite_desc *desc)
> +{
> +	struct uprobe *uprobe;
> +	int ret;
> +
> +	if (!file || (!uc->handler && !uc->ret_handler))
> +		return ERR_PTR(-EINVAL);

[Severity: Low]
Is this validation check correct for a PTWRITE uprobe? The comment above
states "(handler is never invoked: no kernel entry at probe hit)", but this
check requires the caller to supply a non-null handler anyway.

[ ... ]
> +	down_write(&uprobe->register_rwsem);
> +
> +	/*
> +	 * A dying normal uprobe can make reuse temporarily busy; don't overwri=
te
> +	 * it.
> +	*/
> +	if (!list_empty(&uprobe->consumers)) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}

[Severity: High]
Does this logic safely handle dying normal uprobes?

If a normal uprobe is unregistered, its consumers list becomes empty, but
threads might still be hitting the breakpoint and executing handle_swbp().
Concurrently, uprobe_register_ptwrite() called for the same address will
reuse the dying uprobe because its consumers list is empty, and then mutate
its arch state to PTWRITE, installing a 5-byte jump.

Won't the threads finishing XOL for the normal uprobe return to
bp_vaddr + ilen, which now points into the middle of the 5-byte jump,
resulting in an invalid opcode exception for the user-space process?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D4
