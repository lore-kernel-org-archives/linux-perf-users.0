Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38863BED61
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751050; cv=none; b=HmkSlzIic+JQLaKfgbCI6UxBI0gFjB3JYFFUZZsrUpOgw1g1LSjqgon0OygndxTZUGQuc2lQt2MG4lNjCa0MYDPc2NXDba7bwtWEkagfC7TslG+QFsa7N6NsCL9L0P7I9mLVgN9ehJsHEzQr2qzhSZw0xnmFAgGJT/bhVpRMoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751050; c=relaxed/simple;
	bh=GgkJE2xLDdjZqklqUhCDEhxkm36eAmlFxAyoZsAagIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YikumOHjfP6rcjZOhKJPxRzZcwHAeD4+tJbemPS2vKP64in9rfLjfxMWMS7BAqmrgYhEws31yKxFFXVIwChTxDRmucfiNRkZD5OiOFnjeLHXjOEckHYO53dhGmQk+dA2aoVYKWB4yWQ8THQHLiNmvO7+zaeFUx5DbpRIcjshUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyIJxVXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyIJxVXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4C81F000FF;
	Wed, 30 Sep 2026 06:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751043;
	bh=vjQtQ7l7kGee//fpGXriMFCB3dFlGZz/8ScO1t5CrrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AyIJxVXGubk3RxgLv68jY04cPwOyntmijbEDEJRuyc7DIUkBq/eu11sgxAV0zTS0M
	 j63g4A+VSn/vV0qvpkwA4zD1iQsbC9m3f9skldeps6fM46u0bX5CTLkJVWv4FkqUNa
	 QAt7SbOv59rRxazquBW8NOOe3/VaJXhSJh9BdjK93DApHWqHeXA8+Et9KMVD9ZhZwl
	 z7oRa3y18ZZYQ8vqda4FyCIz3pncuEHs8WE6n6bb5W5HrmB1GRhJoPwNHv97ecj5Hg
	 jMr10Ls8IQ0SwPxRtI0vI4wpsHD2mFBAmFERe5kwRh/3hMgowbScqiTfTYCSpUoTmc
	 Y7yjz5gCptfIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/8] RISC-V: Add fetch and decode helpers to a common
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930063919.608911-6-himanshu.chauhan@oss.qualcomm.com>
References: <20260930063919.608911-1-himanshu.chauhan@oss.qualcomm.com>
 <20260930063919.608911-6-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:50:42 +0000
Message-Id: <20260930065042.CE4C81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] riscv: raw pointer dereference in get_insn_safe() causes Oops
- [Medium] riscv: missing LSB clearing in JALR target address calculation
--

commit b41a38b921ab3b79d54f05b386dc929fbff4659a
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

RISC-V: Add fetch and decode helpers to a common file

This commit adds helper functions for fetching and decoding RISC-V
instructions. It also introduces functions to retrieve register values and
calculate the next execution address based on the current PC, register stat=
es,
and control-flow instructions.

> diff --git a/arch/riscv/lib/insn.c b/arch/riscv/lib/insn.c
> new file mode 100644
> index 0000000000000..361cac7abe108
> --- /dev/null
> +++ b/arch/riscv/lib/insn.c
> @@ -0,0 +1,263 @@
[ ... ]
> +#define __fetch_insn(regs, insn, insn_addr, type)		\
> +({								\
> +	type __val;						\
> +	int __ret;						\
> +								\
> +	if (user_mode(regs))					\
> +		__ret =3D get_user(__val,				\
> +				 (type __user *)(insn_addr));	\
> +	else {							\
> +		__val =3D *(type *)(insn_addr);			\
> +		__ret =3D 0;					\
> +	}							\
> +								\
[ ... ]
> +int get_insn_safe(struct pt_regs *regs, ulong epc, ulong *r_insn)
> +{
> +	int ret;
> +
> +	pagefault_disable();
> +	ret =3D get_insn(regs, epc, r_insn);
> +	pagefault_enable();
> +
> +	return ret;
> +}

[Severity: High]
Does this raw pointer dereference in __fetch_insn() actually safely handle
faults on kernel addresses?

While get_insn_safe() disables page faults, this does not make unmapped mem=
ory
accesses safe. It just forces the fault handler to directly look up excepti=
on
tables and panic if none are found.

Because __fetch_insn() performs a raw C pointer dereference *(type *)(insn_=
addr)
without an exception table entry, any invalid kernel address will cause an
immediate kernel panic (Oops) instead of safely returning an error.

Should this use get_kernel_nofault() for safely reading arbitrary kernel me=
mory?

[ ... ]
> +static unsigned long get_next_insn_address_compressed(struct pt_regs *re=
gs, u32 insn,
> +						      unsigned long pc)
> +{
> +	unsigned int rs1_num;
> +
> +	if (riscv_insn_is_c_jalr(insn) || riscv_insn_is_c_jr(insn)) {
> +		rs1_num =3D RV_X(insn, RVC_C2_RS1_OPOFF, 5);
> +		return regs_get_register(regs, rs1_num * sizeof(unsigned long));
> +	}

[Severity: Medium]
Will this fail to clear the least-significant bit (LSB) of the target addre=
ss?

The RISC-V ISA specification mandates that the target address for C.JALR and
C.JR instructions has its LSB set to zero by hardware. Since this function
does not apply & ~1UL to the register value, if the source register has the=
 LSB
set, it will incorrectly return an odd (unaligned) address.

Subsystems relying on this for single-stepping might set breakpoints at the=
 odd
address, which would fail to trigger when the CPU actually executes the ali=
gned
target.

[ ... ]
> +static unsigned long get_next_insn_address_standard(struct pt_regs *regs=
, u32 insn,
> +						    unsigned long pc)
> +{
> +	unsigned int rs1_num;
> +
> +	if ((insn & __INSN_OPCODE_MASK) =3D=3D __INSN_BRANCH_OPCODE)
> +		return riscv_branch_taken(regs, insn) ?
> +			RV_EXTRACT_BTYPE_IMM(insn) + pc : pc + 4;
> +
> +	if (riscv_insn_is_jal(insn))
> +		return RV_EXTRACT_JTYPE_IMM(insn) + pc;
> +
> +	if (riscv_insn_is_jalr(insn)) {
> +		rs1_num =3D RV_X(insn, RVG_RS1_OPOFF, 5);
> +		return RV_EXTRACT_ITYPE_IMM(insn) + riscv_get_reg_value(regs, rs1_num);
> +	}

[Severity: Medium]
Does this calculation also need to clear the LSB?

Similar to the compressed JALR handling above, JALR requires its target add=
ress
LSB to be cleared. Without applying & ~1UL, calculating the target address =
here
could also return an unaligned address if the LSB is set, breaking debug
control.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930063919.6089=
11-1-himanshu.chauhan@oss.qualcomm.com?part=3D5
