Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5E46AA91
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130089; cv=none; b=WkR55Ug4y6cm9IhK+mnXx/opjc61fWlnBhaGZIUJhJ2kpGhP4ZnytzYKSaQiovP1bWYvm9LXdN3ZqRxTWvPI32Wgk2ybYVmNzZgJljCYHi9u/8c7sq9+6TrhGLNP/iffgyH9sQBmaXwnjN8a1IgKsqJpY4AV8fIaCnPxwIks7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130089; c=relaxed/simple;
	bh=VA3HuLvZijJizUaOY+5EP4okfPxoVRS+oDwycyWXCMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QpwcyKhYnRJjEJffQ3svn7pteHnSBUWlwZX5jBHm4amoITDAIetiSHxKJIMaz/lksjTOFqwaHtkLk63jnvqSOZwXq/7JpohoxYdukv0kFrfBtztevEQ9qUKbZouniLSG5KfDc0aoexIkWjHt/rxgylaEga8BDNoQz1yuZ8hWeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6u2lbWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6u2lbWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E501F00893;
	Fri, 11 Sep 2026 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130088;
	bh=Y3HkA05iXR3vIs48oNqEnWSIizD8GJ1hJnfTUIGI1JY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K6u2lbWitMWpfdhtPLJQDfk+UUfGgz3c3qt36oHHhAo3pFqiusRZ9YAtBqqG76mWO
	 If5fQTltQ+5dZ2smVHmRsdFcWHqlQXQwbx6SuNMBcFawOmmoptoyBzjgRi7q429kG5
	 VgqcpkQgFcEK0Jfvbkd2Cnwvkp6sViZ+uhqDAnr785BU/edly7ugTZuEiwu3IZHUwp
	 I8kbZ4LeaOmy8t1gV2yVvQGET97rHO7VFZgIAAIUsrA0xDaFJbe6LjxAdoiTXXkscK
	 aKX+igHSgm5hT6ilimA7zaSg9zBVenE1xdpjsdD4KxPp8x4jrdGQBgBgZV2Twg3rm7
	 5+NXYPx02LBFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/9] riscv: add support for SBI Supervisor Software
 Events extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911121456.33223-3-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
 <20260911121456.33223-3-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:34:47 +0000
Message-Id: <20260911123448.12E501F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Physical address truncation on RV32 with 64-bit physical addresses=
 during SBI_SSE_EVENT_ATTR_READ/WRITE.
--

commit 009ca408c0e515d2b163c5c6737a07a0e84156e8
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

riscv: add support for SBI Supervisor Software Events extension

This commit adds support for the SBI Supervisor Software Events (SSE)
extension, allowing firmware to notify supervisor software of independent
events. It provisions per-event stacks, saves and restores interrupted
contexts, and handles nested exceptions safely.

> diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi_sse.c

[ ... ]

> +void noinstr do_sse(struct sse_event_arch_data *arch_evt,
> +		    struct pt_regs *regs, unsigned long hstatus)
> +{
> +	struct riscv_sse_interrupted_context context =3D { regs, hstatus };
> +	struct riscv_sse_interrupted_context *previous;
> +	struct sbiret sret;
> +
> +	nmi_enter();
> +	instrumentation_begin();
> +
> +	/* Retrieve missing GPRs from SBI */
> +	sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_=
id,
> +			 SBI_SSE_ATTR_INTERRUPTED_A6,
> +			 (SBI_SSE_ATTR_INTERRUPTED_A7 -
> +			  SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
> +			 (unsigned long)arch_evt->interrupted_phys, 0, 0);

[Severity: High]
Does casting arch_evt->interrupted_phys to unsigned long truncate the
physical address on RV32 systems?

When CONFIG_PHYS_ADDR_T_64BIT is enabled on RV32, virt_to_phys() returns a
64-bit physical address. By casting to unsigned long for the phys_lo
argument and hardcoding 0 for the phys_hi argument, if the physical memory
resides above the 4GB boundary, the firmware receives a truncated 32-bit
address. Could this result in the firmware reading from unintended memory?

> +	if (sret.error) {
> +		pr_warn("Failed to read interrupted registers for event %x: %ld\n",
> +			arch_evt->evt_id, sret.error);

[ ... ]

> +	if (memcmp(&regs->a6, arch_evt->interrupted,
> +		   sizeof(*arch_evt->interrupted))) {
> +		memcpy(arch_evt->interrupted, &regs->a6,
> +		       sizeof(*arch_evt->interrupted));
> +		sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_WRITE,
> +				 arch_evt->evt_id, SBI_SSE_ATTR_INTERRUPTED_A6,
> +				 (SBI_SSE_ATTR_INTERRUPTED_A7 -
> +				  SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
> +				 (unsigned long)arch_evt->interrupted_phys, 0, 0);

[Severity: High]
Similarly, could this truncation cause memory corruption here?

If the firmware writes back the state using a truncated 32-bit physical
address, it may corrupt unintended memory regions if the original address
was above 4GB.

> +		/*
> +		 * If writeback fails, COMPLETE resumes with firmware's original
> +		 * a6/a7 rather than treating the shared buffer as committed.
> +		 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911121456.3322=
3-1-zhangzhanpeng.jasper@bytedance.com?part=3D2
