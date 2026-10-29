Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275955;
	b=TAfAg23Gldk9+S64RpSezgId2SdLi50spQXtycu7pXJkqYUE20jqHtLE891xuD8dw3OC
	 TYthRLSruyNqnx+qT6MdsJCFNtyFUpvz2wrgnkxseLK+sc3/CCkCuqyrnqR3KoiDQooL8
	 o1VuCSo2YQ8T42lapg5Uo4g2nsG+CxfanA5sY0vxGbKldKP27ZKLo99csYSODxXcQTG09
	 uh5eSXsGHmzzU56tXHWkwTexw96Rt4ZyPVwjym0ua5ZmIllRiCt8RaibwiaDPHHdmHfX4
	 59YydUzqsChmB9a9EQBaASzVbjV9R4ARnY3ozeALcY1+TxTwHPFKqtHeVkUT7gQAn9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275955;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lpwQVzbbYyVwPDa5i2NOcoEIIiBUWoMtlcARNsaSC5Q=;
	b=vxBXhXcQHS3PJ+NkVn4XYaT6151Zfc9s6cLS2FeogwbPlzkvnXgoodNs8VSJ5NldEgtG
	 ItUTjjXYA/+KZVYRSU5pG5+h9SuiCwlnYs/0/9F51KjlQHgu0eEhKPxpmp6XabqfwOIXA
	 xeIoh11NulDHfTgL8LpWFeIlRsURfMZHamd4GH9ppW9FPhQWnWK/SUGV38UOvgO3Ynddv
	 nIgwW60yNgqS0CsWIPsx3kpUJCv59JU1cpST+bkUW6rc5DinZv4H7iDA92FIGbot2iKFq
	 kkScQeuMuP4O7Eha4jUPc6z80m1gy5tx4TwIqba0sgjvgd3hB8Wo37U4L+Vn52HJxcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QySv/tUf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD5606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QySv/tUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B39D1F01828;
	Thu, 29 Oct 2026 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793275955;
	bh=lpwQVzbbYyVwPDa5i2NOcoEIIiBUWoMtlcARNsaSC5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QySv/tUfFuSMYnN3vruhpq0nle0dVwmncuvmvCDGydYtuOUHcbMTVmiRHMoRKWd/P
	 T+6dRJRswLvM5mrZk/mg08R2dAoVqlkYIyQ55ONRSbEFI7HtzgzP/xbfiX/IXk4ffJ
	 Tcy200eLF15n2qX9JdLXVJMq60CvSDN1/vVtUUKn8v+89JQgSnXrCd1xX15ZseIBYD
	 XSeq1BWtANanJwan3oHOSedlUj3dMzBbepCoEhlRgo36DTsbnFOdYY9RLIR9Mc/l5E
	 gyQTt/7YeDvz9U8mRqNS4kvDtMu87w//7ej7eaK24GNl28dQYp+yxT+yraaynQQj7t
	 bDDYIK6WyREFA==
Message-ID: <sashiko-outbox-189261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/11] riscv: add support for SBI Supervisor
 Software Events extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029074853.35467-3-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-3-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:12:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] riscv: sbi_sse: field-spanning memcpy() on regs->a6 in do_sse()
- [High] riscv: sse: avoid clobbering tp with NULL in handle_sse() during _=
_switch_to()
--

commit bce7a5b04f20b2889a18e324f4cb5a0c7506b960
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

riscv: add support for SBI Supervisor Software Events extension

This commit adds architectural support for the RISC-V SBI Supervisor
Software Events (SSE) extension, including dedicated per-event stacks,
shadow call stacks, and low-level entry and exit assembly handling.

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
Does passing &regs->a6 to memcpy() and memcmp() with
sizeof(*arch_evt->interrupted) trigger a field-spanning overflow under
CONFIG_FORTIFY_SOURCE=3Dy?

In struct pt_regs (arch/riscv/include/asm/ptrace.h), a6 and a7 are separate
unsigned long members:

	struct_group(a_regs,
		unsigned long a0;
		...
		unsigned long a6;
		unsigned long a7;
	);

Because &regs->a6 points to a single unsigned long field while
sizeof(*arch_evt->interrupted) spans two unsigned longs (a6 and a7),
fortify_memcpy_chk() sees __builtin_object_size(&regs->a6, 1) as smaller th=
an
the copy size. This triggers a compile-time __write_overflow_field() error
when CONFIG_FORTIFY_SOURCE=3Dy and CONFIG_WERROR=3Dy are enabled (as well as
__read_overflow2_field() under W=3D1), or a runtime fortify_warn_once() ins=
ide
NMI context when an SSE event is delivered.

Could do_sse() read and write regs->a6 and regs->a7 directly (or group them
with struct_group()) instead of using memcpy() and memcmp() across the field
boundary?

[ ... ]

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
Can a higher-priority nested SSE event observe a NULL tp here if the first
event interrupted __switch_to()?

In __switch_to() (arch/riscv/kernel/entry.S), __sbi_sse_entry_task is clear=
ed
to zero during the task switch window, relying on the interrupted tp regist=
er
remaining valid:

	asm_per_cpu t0, __sbi_sse_entry_task, t1
	REG_S zero, 0(t0)

When a lower-priority SSE event arrives during this window, handle_sse saves
the valid tp into PT_TP(sp) on its stack and then executes:

	REG_L tp, 0(t2)
	bnez tp, .Lcurrent_task_found
	REG_L tp, PT_TP(sp)

Because REG_L tp, 0(t2) loads NULL directly into tp before checking for zer=
o,
both __sbi_sse_entry_task and the live tp register are simultaneously NULL
between those two loads. If a higher-priority SSE event preempts handle_sse
in that window, the nested handle_sse saves tp (now NULL) into its own
PT_TP(sp), loads NULL from __sbi_sse_entry_task, reloads NULL from PT_TP(sp=
),
and dereferences NULL at REG_L s6, TASK_TI_KERNEL_SP(tp).

Would loading __sbi_sse_entry_task into a temporary register first and only
moving it into tp when non-zero avoid clobbering the live tp register?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D2
