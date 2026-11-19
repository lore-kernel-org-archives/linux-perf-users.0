Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091814;
	b=xyryiApMQcwNZSXtuYaXuIuKtHAJ9wt6iHlp0XtIifZlWPv9/qHcyiKqXDwtluYcKTLy
	 8zjDAnp03AOo4X7MjtTYaS0NhVJ69HB4pO3Wtm+YWnDIJUTGHCHd9huVblqOuRZObKylk
	 JA3bMfQDHO7WXVrGRfN6hJdc+bZkaFD148rjUW9Xx0WxDpKBXCvPMlk7HL3ZxmfB1YNV1
	 deb212uyHwyIYZF6x1Edq/V2+i/d0+2w4pt7j5CyhHmtNgLhgt+hZWFu8qgiV/KivuaT+
	 URC9iKsNUliB8dRVY8gy5UNYGFXu8MbPZyXQrIS/OWIv4bZfu465gCjg/kBwdeNH05w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RflxcL1xPTpAJ4CvFjnM565PtkrLnSCfF1K40R/4AoQ=;
	b=Pqf/Eg5V62ACLWJ07R1EyZuWuICv0FJ2d+7ypkHJsywJ3ZP+UE+z5qRHBix5tJedKjVP
	 JwvCPRkz5GQeesAqA+SvdJ3L4jCc2SOsJvvaXjkQkEU1khHxMHAvx73n5F/FfEPaWv/hh
	 VKh6Ed0MtU+JXYDhdDIaHkqj9/OTfIWU5w9CjpZACUOPBwicXUf+zUARpvEpAZlwD7snI
	 MMJi5V7Ckf2q1ACKgIRuYIMm7GqRkKRrX1o757FW6nxuV8KTDn79Z9noWZ3UhwIUnrNbB
	 ZpK0/KWH7JMOtIdDBNQkxut/KJ7/vh0QLrMiBxKuyphd7DCh0gg+2Rb+T6AklVgufNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oo1Rn8oe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29433606A335
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oo1Rn8oe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAB81F000D0;
	Thu, 19 Nov 2026 12:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795091813;
	bh=RflxcL1xPTpAJ4CvFjnM565PtkrLnSCfF1K40R/4AoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oo1Rn8oex2EJNOv3c1AxteGs1gE5+NjofIf1Blf3qYxt7qy56G9mRxvTV8waVVOgP
	 vLBep7jQ/vw9stw73RtsJZ66mYCtvFmbzJIDCStuB9if+rRiWUWQRUv20CiZfCJ/c9
	 7CLbYhsKrrMbcboiJVGBpO9eFeOiJVZPFFMl4vH2gmcXKfwknrh2jY2wOhG2+MYEHu
	 rLJnLfhOvV8BripbUjx71gA7B1KG7tREJTQ1tL+SHSl3wH60IiXEWbARf6/w9tA37r
	 pKeMNTacWVh/JVyZT9/kmH+H0Plvst37Vk/2p+QMxIqF9E+9eS8mdqrFOH8JQ2ZV8Q
	 9ouX1tBDwNtkw==
Message-ID: <sashiko-outbox-223096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/11] riscv: add support for SBI Supervisor
 Software Events extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-15-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-15-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:36:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] riscv: sbi_sse: field-spanning memcpy() on regs->a6 in do_sse()
- [High] riscv: sse: NULL tp dereference in handle_sse() during
  __switch_to()
--

commit 498ea890d0b707a9ef408aa0d005f9d3ac0e2ea3
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

riscv: add support for SBI Supervisor Software Events extension

This commit adds architectural support for the RISC-V SBI Supervisor
Software Events (SSE) extension, including dedicated per-event stacks,
entry/exit assembly, and context preservation across SSE handlers.

Link: https://lore.kernel.org/r/as79MHtNYd-VbUug@hu-himchau-blr.qualcomm.co=
m/

> diff --git a/arch/riscv/kernel/sbi_sse.c b/arch/riscv/kernel/sbi_sse.c
> new file mode 100644
> index 0000000000000..032fcc07abcf7
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi_sse.c
> @@ -0,0 +1,251 @@

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
> +	if (sret.error) {
> +		pr_warn("Failed to read interrupted registers for event %x: %ld\n",
> +			arch_evt->evt_id, sret.error);
> +		/* Let the client quiesce its source without using incomplete regs. */
> +		sse_handle_event(arch_evt, NULL);
> +		goto out;
> +	}
> +
> +	memcpy(&regs->a6, arch_evt->interrupted,
> +	       sizeof(*arch_evt->interrupted));
> +
> +	/* Make the interrupted frame visible while clients handle this event. =
*/
> +	previous =3D this_cpu_read(riscv_sse_interrupted_context);
> +	this_cpu_write(riscv_sse_interrupted_context, &context);
> +	sse_handle_event(arch_evt, regs);
> +	this_cpu_write(riscv_sse_interrupted_context, previous);
> +
> +	if (memcmp(&regs->a6, arch_evt->interrupted,
> +		   sizeof(*arch_evt->interrupted))) {
> +		memcpy(arch_evt->interrupted, &regs->a6,
> +		       sizeof(*arch_evt->interrupted));

[Severity: High]
Does copying sizeof(*arch_evt->interrupted) bytes across &regs->a6 trip
CONFIG_FORTIFY_SOURCE?

In struct pt_regs, a6 and a7 are individual unsigned long fields rather
than a 2-register struct_group, so __builtin_object_size(&regs->a6, 1) is
sizeof(unsigned long) while sizeof(*arch_evt->interrupted) is
2 * sizeof(unsigned long).  With CONFIG_FORTIFY_SOURCE=3Dy, the first
memcpy() fails the build with __write_overflow_field() under
CONFIG_WERROR=3Dy (and the second triggers __read_overflow2_field() under
W=3D1), or triggers a runtime fortify WARN_ONCE() inside NMI context when
an SSE event arrives.  Copying and comparing a6 and a7 directly by field
avoids the field-spanning memcpy().

> diff --git a/arch/riscv/kernel/sbi_sse_entry.S b/arch/riscv/kernel/sbi_ss=
e_entry.S
> new file mode 100644
> index 0000000000000..1e38fbb1c2a42
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi_sse_entry.S
> @@ -0,0 +1,237 @@

[ ... ]

> +	asm_per_cpu_with_cpu t2 __sbi_sse_entry_task t1 t3
> +	REG_L tp, 0(t2)
> +	bnez tp, .Lcurrent_task_found
> +
> +	/* __switch_to() marks its transition window with a NULL entry task. */
> +	REG_L tp, PT_TP(sp)
> +
> +.Lcurrent_task_found:
> +	/* Nested exceptions temporarily replace these with the SSE stack. */
> +	REG_L s6, TASK_TI_KERNEL_SP(tp)

[Severity: High]
Can a nested higher-priority SSE event see tp =3D=3D NULL here when an SSE
interrupts __switch_to()?

__switch_to() zeroes __sbi_sse_entry_task while switching from prev to
next, relying on handle_sse() recovering current from the interrupted tp
register saved in PT_TP(sp).  However, REG_L tp, 0(t2) loads NULL directly
into the live tp register before falling back to PT_TP(sp), and leaves
__sbi_sse_entry_task NULL while do_sse() runs:

__switch_to()
  __sbi_sse_entry_task =3D NULL
  <low-priority SSE>
    handle_sse()
      REG_S tp, PT_TP(sp)
      REG_L tp, 0(t2)            # tp becomes 0
      <high-priority SSE>
        handle_sse()
          REG_S tp, PT_TP(sp)    # saves 0
          REG_L tp, 0(t2)        # still 0
          REG_L tp, PT_TP(sp)    # reloads 0
          REG_L s6, TASK_TI_KERNEL_SP(tp)  <-- NULL pointer dereference

The same NULL tp window also occurs if do_sse() takes a nested synchronous
exception while __sbi_sse_entry_task is still NULL, because
handle_exception() swaps tp with CSR_SCRATCH (which handle_sse() cleared
to 0) for a few instructions before restoring tp.

Loading __sbi_sse_entry_task into a temporary register before overwriting
tp, or updating __sbi_sse_entry_task in lockstep with move tp, a1 in
__switch_to(), avoids exposing a NULL tp to nested SSE events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D2
