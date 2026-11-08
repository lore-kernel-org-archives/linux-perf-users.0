Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105699;
	b=wSjJiaaHA+dlYi+wXHPssFCkBLNurkKBOnwxM2FGYBNpnMhQUhvdFdg9zc74MfcLk/a3
	 FDDdclrNVs8sFfHWCAQi3ByrMiviebxPhwg40HfEGyjI/mADB3FVzerzLeQ95QluX0Qpj
	 8g+RqfY83s0gM/7SzYr1+UuMPwoVRaRlwuYPT5UqEsHvBHwVfjjOzJPga/ab5mzfv2doc
	 Rr1SWQVmjTq6FQrzE/gR3tIjKoy52DUQQXmzt2w8EcSwJkk+utT4FMhq0gXpYFx1klhpm
	 NT29ABli5O9rN70EOUsdQUFG+zsnxBsY/oDJSqfRLJiBJorUHFKBcSFrvGeYvz1k9HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FUJbJ51lTqdWubeK7Pz+yMLTgk5ns2vTS5YDsnUMEm0=;
	b=mCxyj9C4Oh17J4fPv8q4kFC8AioeBvzwCSM1fnrsBAdn4cfr09iWdLQqZIGmJMOMAdkz
	 A6p6b/4SEsjigJYjJrL4IFHAjxI5WpAjPEn1Q895CJlBIt1gfC1JFO/Iw+6T1PaULvQmo
	 EbVA1BzV9E3mzWlVQhJ62K/2BEyao2omNZoe8zK1ggYxmyEctb3Z1HQMmzO4S78RIT8qF
	 vPv40KE8MTF32WGzzAPwMxiM72Dr8v3RTWxulQyDMKFeWEwXMHi5bYSuZMgIsZ3SGlMGt
	 uVWZCQHqA7vT54/mBz+BtRhRXVxMGccy73R/JACfUI4exDkudGX2k1kcwyiZBEBcz9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaRKswOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9BD606A31F
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eaRKswOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC7E1F0089F;
	Sun,  8 Nov 2026 02:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794105699;
	bh=FUJbJ51lTqdWubeK7Pz+yMLTgk5ns2vTS5YDsnUMEm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eaRKswOIbWEbCufIut/0bJZwMuU9VHG6GIMlMtU12TToqWksvsw6xA7su+FdCZXo3
	 oBe39TslcqP77qbkuz0HiAXuoCw/1DJAaRBVzu1WNWQ56PC49QQiHzVreDuKLpziCk
	 jWTLY45ny8LJVVtNUtkyNRhBZq76fInxMytGPJ4uV/VlqqLBvPsEuxd9T+aysJbQXA
	 BhgYwEMLARrNaUGDoPv3YJYPOyTHm8hSXBgVM5GzWYfiY0ZFnfnrM4/3nwRjYPTS0h
	 PKQBgWoDSTX+oVIHweWKaoGos7ZD92hTPrylr0ObzA/fwUikcVHTL1+3oo7hJ7hAKB
	 exJCsOEVfO1pA==
Message-ID: <sashiko-outbox-203525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/8] riscv: add regset access for hardware
 breakpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>
Cc: "Alexandre Ghiti" <alex@ghiti.fr>, "Jesse Taube" <jtaubepe@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, "Shuah Khan" <shuah@kernel.org>, linux-mm@kvack.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261107023917.40606-5-himanshu.chauhan@oss.qualcomm.com>
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
 <20261107023917.40606-5-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 02:41:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] riscv: ptrace: broken breakpoint disable in
  ptrace_hbp_fill_attr_ctrl()
- [Medium] riscv: ptrace: zero-filled holes in compat_riscv_user_regset
  cause div-by-zero
- [Medium] riscv: ptrace: ignored control fields in decode_ctrl_reg()
- [Medium] riscv: ptrace: wrong return value and slot bound in
  riscv_hw_break_get()
- [Medium] riscv: ptrace: leaked perf_event on error in
  riscv_hw_break_set()
--

commit 5940d70e24c6c5b6aa9c305717a9b36acc0903b2
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

riscv: add regset access for hardware breakpoints

This commit adds the NT_RISCV_HW_BREAK and NT_RISCV_HW_WATCH regsets to all=
ow
reading and programming RISC-V hardware breakpoint and watchpoint slots via
PTRACE_GETREGSET and PTRACE_SETREGSET.

> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index be076865d02d0..9959a8e4a3079 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -37,6 +37,10 @@ enum riscv_regset {
>  #ifdef CONFIG_RISCV_USER_CFI
>  	REGSET_CFI,
>  #endif
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	REGSET_RISCV_HW_BREAK,
> +	REGSET_RISCV_HW_WATCH,
> +#endif
>  };
> =20
>  static int riscv_gpr_get(struct task_struct *target,
> @@ -526,6 +530,302 @@ static struct perf_event *ptrace_hbp_create(enum ri=
scv_hbp_type hbp_type,
>  	return bp;
>  }
> =20
> +static int ptrace_hbp_note_to_type(unsigned int note_type,
> +				   enum riscv_hbp_type *hbp_type)
> +{
> +	switch (note_type) {
> +	case NT_RISCV_HW_BREAK:
> +		*hbp_type =3D RISCV_HBP_BREAK;
> +		return 0;
> +	case NT_RISCV_HW_WATCH:
> +		*hbp_type =3D RISCV_HBP_WATCH;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ptrace_hbp_fill_attr_ctrl(enum riscv_hbp_type hbp_type,
> +				     struct arch_hw_breakpoint *bpctrl,
> +				     struct perf_event_attr *attr)
> +{
> +	int len, type;
> +
> +	attr->disabled =3D 0;
> +	type =3D bpctrl->type;
> +	len =3D bpctrl->len;
> +
> +	switch (hbp_type) {
> +	case RISCV_HBP_BREAK:
> +		if ((type & HW_BREAKPOINT_X) !=3D type)
> +			return -EINVAL;
> +		break;
> +	case RISCV_HBP_WATCH:
> +		if ((type & HW_BREAKPOINT_RW) !=3D type)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	attr->bp_len	=3D len;
> +	attr->bp_type	=3D type;
> +	attr->bp_addr	=3D bpctrl->address;
> +
> +	return 0;
> +}

[ ... ]

> +static u32 encode_ctrl_reg(struct perf_event *bp)
> +{
> +	struct arch_hw_breakpoint *bpctrl =3D counter_arch_bp(bp);
> +	u32 ctrl =3D 0;
> +
> +	/* Expose the generic UAPI bp_type values in ptrace control bits. */
> +	ctrl |=3D HWDEBUG_MK_TYPE(bp->attr.bp_type);
> +	ctrl |=3D HWDEBUG_MK_MATCH(bpctrl->match);
> +	ctrl |=3D HWDEBUG_MK_SELECT(bpctrl->select);
> +	ctrl |=3D HWDEBUG_MK_WHEN(bpctrl->time);
> +	ctrl |=3D HWDEBUG_MK_SIZE(bp->attr.bp_len);
> +	ctrl |=3D HWDEBUG_MK_CHAIN(bpctrl->chain);
> +
> +	return ctrl;
> +}

[Severity: High]
As reported by Rui Qi on v6 [1], how can a tracer disable a hardware
breakpoint or watchpoint slot, or write a user_hwdebug_state buffer with
unused zeroed slots, when ptrace_hbp_fill_attr_ctrl() unconditionally sets
attr->disabled =3D 0?

The control word has no separate enable bit, so an unused or disabled slot
has control =3D=3D 0 (bpctrl->type =3D=3D HW_BREAKPOINT_EMPTY). Because (0 =
& mask) !=3D
0 is false, ptrace_hbp_fill_attr_ctrl() passes attr->disabled =3D 0 and
attr->bp_type =3D 0 to modify_user_hw_breakpoint(), which fails with -EINVA=
L in
hw_breakpoint_arch_parse() -> rv_init_mcontrol_trigger() while re-enabling =
an
already-active event at the new address set by ptrace_hbp_set_addr().

Conversely, encode_ctrl_reg() encodes bp->attr.bp_type without checking
bp->attr.disabled, so disabled events in a slot are reported as active by
PTRACE_GETREGSET. When uctrl =3D=3D 0 (or type =3D=3D HW_BREAKPOINT_EMPTY),
ptrace_hbp_fill_attr_ctrl() should set attr->disabled =3D 1 and return earl=
y,
and encode_ctrl_reg() should return 0 when bp->attr.disabled is set.

[ ... ]

> +static void decode_ctrl_reg(u32 uctrl, struct arch_hw_breakpoint *bpctrl)
> +{
> +	bpctrl->type =3D HWDEBUG_TYPE(uctrl);
> +	bpctrl->match =3D HWDEBUG_MATCH(uctrl);
> +	bpctrl->select =3D HWDEBUG_SELECT(uctrl);
> +	bpctrl->time =3D HWDEBUG_WHEN(uctrl);
> +	bpctrl->len =3D HWDEBUG_SIZE(uctrl);
> +	bpctrl->chain =3D HWDEBUG_CHAIN(uctrl);
> +}
> +
> +static int ptrace_hbp_set_ctrl(enum riscv_hbp_type hbp_type,
> +			       struct task_struct *tsk,
> +			       unsigned long idx,
> +			       u32 uctrl)
> +{
> +	int err;
> +	struct perf_event *bp;
> +	struct perf_event_attr attr;
> +	struct arch_hw_breakpoint bpctrl;
> +
> +	bp =3D ptrace_hbp_get_initialised_bp(hbp_type, tsk, idx);
> +	if (IS_ERR(bp)) {
> +		err =3D PTR_ERR(bp);
> +		return err;
> +	}
> +
> +	attr =3D bp->attr;
> +	decode_ctrl_reg(uctrl, &bpctrl);
> +	bpctrl.address =3D attr.bp_addr;
> +	err =3D ptrace_hbp_fill_attr_ctrl(hbp_type, &bpctrl, &attr);
> +	if (err)
> +		return err;
> +
> +	return modify_user_hw_breakpoint(bp, &attr);
> +}

[Severity: Medium]
Does ptrace_hbp_set_ctrl() silently discard the match, select, time, and
chain fields decoded by decode_ctrl_reg(), as well as any non-zero reserved
bits in uctrl?

decode_ctrl_reg() unpacks HWDEBUG_MATCH, HWDEBUG_SELECT, HWDEBUG_WHEN, and
HWDEBUG_CHAIN into the stack-local bpctrl, but ptrace_hbp_fill_attr_ctrl()
only copies len, type, and address into attr, and modify_user_hw_breakpoint=
()
re-initializes counter_arch_bp(bp) from attr alone. Any non-zero values
written to those fields or to reserved bits [31:17] are accepted without
taking effect and read back as 0 in encode_ctrl_reg(), preventing userspace
from detecting unsupported trigger modes.

> +static int ptrace_hbp_set_addr(enum riscv_hbp_type hbp_type,
> +			       struct task_struct *tsk,
> +			       unsigned long idx,
> +			       u64 addr)
> +{
> +	int err;
> +	struct perf_event *bp;
> +	struct perf_event_attr attr;
> +
> +	bp =3D ptrace_hbp_get_initialised_bp(hbp_type, tsk, idx);
> +	if (IS_ERR(bp)) {
> +		err =3D PTR_ERR(bp);
> +		return err;
> +	}
> +
> +	attr =3D bp->attr;
> +	attr.bp_addr =3D addr;
> +	err =3D modify_user_hw_breakpoint(bp, &attr);
> +	return err;
> +}

[Severity: Medium]
Does ptrace_hbp_set_addr() leave a newly created perf_event registered in
tsk->thread.debug when modify_user_hw_breakpoint() or the subsequent control
write in riscv_hw_break_set() fails?

When a slot is initially empty, ptrace_hbp_get_initialised_bp() calls
ptrace_hbp_create(), which registers a disabled perf_event and reserves one
of the task's shared hardware trigger slots via reserve_bp_slot(). If
modify_user_hw_breakpoint() fails (for example on an address >=3D TASK_SIZE=
) or
riscv_hw_break_set() fails while copying or applying ctrl, the event is not
unregistered, exhausting the task's hardware trigger slots until task exit =
or
execve.

> +#define PTRACE_HBP_ADDR_SZ	sizeof(u64)
> +#define PTRACE_HBP_CTRL_SZ	sizeof(u32)
> +#define PTRACE_HBP_PAD_SZ	sizeof(u32)
> +
> +static int riscv_hw_break_get(struct task_struct *target,
> +			      const struct user_regset *regset,
> +			      struct membuf to)
> +{
> +	unsigned int note_type =3D regset->core_note_type;
> +	enum riscv_hbp_type hbp_type;
> +	int ret, idx, num_slots;
> +	u32 info, ctrl;
> +	u64 addr;
> +
> +	ret =3D ptrace_hbp_note_to_type(note_type, &hbp_type);
> +	if (ret)
> +		return ret;
> +
> +	/* Resource info: number of available slots */
> +	ret =3D ptrace_hbp_get_resource_info(hbp_type, &info);
> +	if (ret)
> +		return ret;
> +
> +	membuf_write(&to, &info, sizeof(info));
> +	membuf_zero(&to, sizeof(u32));
> +
> +	/* Emit one (address, ctrl, pad) entry per available slot */
> +	num_slots =3D (int)info;
> +	for (idx =3D 0; idx < num_slots; idx++) {
> +		ret =3D ptrace_hbp_get_addr(hbp_type, target, idx, &addr);
> +		if (ret)
> +			return ret;
> +		ret =3D ptrace_hbp_get_ctrl(hbp_type, target, idx, &ctrl);
> +		if (ret)
> +			return ret;
> +		membuf_store(&to, addr);
> +		membuf_store(&to, ctrl);
> +		membuf_zero(&to, sizeof(u32));
> +	}
> +	return 0;
> +}
> +
> +static int riscv_hw_break_set(struct task_struct *target,
> +			      const struct user_regset *regset,
> +			      unsigned int pos, unsigned int count,
> +			      const void *kbuf, const void __user *ubuf)
> +{

[ ... ]

> +	/* (address, ctrl) registers */
> +	limit =3D regset->n * regset->size;
> +	while (count && offset < limit) {

[Severity: Medium]
Should riscv_hw_break_get() return to.left instead of 0, and should
riscv_hw_break_set() bound writes by num_slots rather than all 16 entries in
struct user_hwdebug_state?

__regset_get() computes the number of bytes produced as size - res, so
returning 0 after writing only num_slots entries causes PTRACE_GETREGSET and
ELF core dumps to report all 16 slots (264 bytes) as populated even when
hw_breakpoint_slots() is smaller. Meanwhile, riscv_hw_break_set() allows
programming slot indices num_slots <=3D idx < RISCV_MAX_BP, creating active
breakpoints that riscv_hw_break_get() never reads back.

[ ... ]

> @@ -919,6 +1237,28 @@ static const struct user_regset compat_riscv_user_r=
egset[] =3D {
>  		.set =3D riscv_fpr_set,
>  	},
>  #endif
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	/*
> +	 * The hardware-debug regset uses fixed-width UAPI fields, so the
> +	 * native layout is also the compat layout.
> +	 */
> +	[REGSET_RISCV_HW_BREAK] =3D {
> +		USER_REGSET_NOTE_TYPE(RISCV_HW_BREAK),
> +		.n =3D sizeof(struct user_hwdebug_state) / sizeof(u32),
> +		.size =3D sizeof(u32),
> +		.align =3D sizeof(u32),
> +		.regset_get =3D riscv_hw_break_get,
> +		.set =3D riscv_hw_break_set,
> +	},
> +	[REGSET_RISCV_HW_WATCH] =3D {
> +		USER_REGSET_NOTE_TYPE(RISCV_HW_WATCH),
> +		.n =3D sizeof(struct user_hwdebug_state) / sizeof(u32),
> +		.size =3D sizeof(u32),
> +		.align =3D sizeof(u32),
> +		.regset_get =3D riscv_hw_break_get,
> +		.set =3D riscv_hw_break_set,
> +	},
> +#endif
>  };

[Severity: Medium]
Does indexing compat_riscv_user_regset[] with REGSET_RISCV_HW_BREAK and
REGSET_RISCV_HW_WATCH create zero-initialized struct user_regset holes that
cause a division by zero in ptrace_regset()?

In enum riscv_regset, REGSET_RISCV_HW_BREAK and REGSET_RISCV_HW_WATCH follow
REGSET_V, REGSET_TAGGED_ADDR_CTRL, and REGSET_CFI, which are omitted from
compat_riscv_user_regset[]. When any of CONFIG_RISCV_ISA_V,
CONFIG_RISCV_ISA_SUPM, or CONFIG_RISCV_USER_CFI is enabled, those intermedi=
ate
slots in compat_riscv_user_regset[] are zero-filled with core_note_type =3D=
=3D 0
and size =3D=3D 0. Calling ptrace(PTRACE_GETREGSET, pid, 0, &iov) on a comp=
at
task matches the hole in find_regset(view, 0) and evaluates kiov->iov_len %
regset->size with regset->size =3D=3D 0 in kernel/ptrace.c:ptrace_regset().

[1] https://lore.kernel.org/r/5a7c08bd-4313-4424-b649-a19ffe5242e4@bytedanc=
e.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107023917.4060=
6-1-himanshu.chauhan@oss.qualcomm.com?part=3D4
