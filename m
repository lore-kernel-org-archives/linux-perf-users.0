Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105702;
	b=MC3C2we1JMoqwNAuHetsaRuDSRP65Y8WWBXjLPvYxNTlnE3KFc50ZrPOgCOK2nCm4ql7
	 V54v71B16xrs8t+j3XK/xkOavdOnyokLTJ0ubyCa1UeFodDDEHE01/RzJyOO0KpomR5+w
	 yiCELbRzcpsksgSXaRW8qAQvFTDRYSVGBvtit4byJbH5aeRacDZNPbyimRG+2kEZqWgAh
	 /AOm9aAg3A3pNWqV7cDsVMbSN3F0y58ZTyyOzeatwgSE/2iCZzImpMJ8UswjVb0ptGlz4
	 Mk3GVlIwTKhbvuX/iWfDQvlcU9N+Xo785Ivm6Fz90/h8hqy1dVNVoQbOFd7rFperBYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DRHvIw1u2uHJfm4qV+SPn2XIBsYniEYEKzVAR8jCY1A=;
	b=3r3r/h4/D5il4e5wUR+NWb9Q1qgbx3vrrQhbGSKvs0WXbxlEzm9mIVvKldBz+4Xzl0Di
	 HQ+3TjTtHggqwb7RL2x9SQT0xP8NSL+dKaIAMlMgFSkQmmI5vVTNSusqUnYEQwZ1v1qYg
	 kJ3BDOHxNEFgB7TE4tTl4HUbEQlVNlANyC0N+xtQ2ueRv63GDHxfLO9jxV+9HZEEpNCLt
	 xXopM5+RK+aJAxv5WWqqQF4+X9XR+CvZUmlZjpvWnzLIyCIK/o7V3yQ+Ha0a4wXFadT3i
	 /UopFebmVE5H3xr7we6vnHzY6s3taYGx2JprbVvyv6xBJE9vegyW0b2nyChPxOgWR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqUWd+hL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24429606A31C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 02:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqUWd+hL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081DD1F0089F;
	Sun,  8 Nov 2026 02:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794105702;
	bh=DRHvIw1u2uHJfm4qV+SPn2XIBsYniEYEKzVAR8jCY1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oqUWd+hLytVSiXaShntxJ/FH6ebYoenXwjkB9WjF8xdIP9TK08Dh9Xzqjn47s56ch
	 7KoBDwXd50TVDtjwEXovPtiCkyYlXtEr3BwOS6a93p/AZEB9TDeIHiO9qbe+YsBR+Z
	 XuJzX0XhdbQpa5rBhsehMz2MdyRTHPO7GAiR67Tdazka+5/RH8dHKZP8CssenSJ1e1
	 QYvOpnsMdtW8urPtpht5KxYez3hnl3PTg/Mu48LtuWFSSTHjz5auNtQjl2C8Jlcl9R
	 oV6mFU0aDuLKmxJryJztXlPThGc60u6nK4T7hvnXa5zvciDkO4nsostq7CIZ4ljntp
	 QV1pOlmiOB7zw==
Message-ID: <sashiko-outbox-203527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/8] riscv: Add shared instruction fetch and decode
 helpers
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
In-Reply-To: <20261107023917.40606-7-himanshu.chauhan@oss.qualcomm.com>
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
 <20261107023917.40606-7-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 02:41:40 +0000
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
- [High] riscv: missing s32 sign extension of offsets in
  get_next_insn_address()
- [Low] riscv: duplicate include of asm/insn.h in traps_misaligned.c
--

commit c0540231e3e0c755203ccef775001d61bb9b1fb4
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

riscv: Add shared instruction fetch and decode helpers

This commit moves get_insn() into arch/riscv/lib/insn.c and adds helpers to
fetch instructions and compute the next PC for control-flow instructions
during software single-stepping.

> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 6e8ae6c66322c..541e6a5b80394 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -10,6 +10,7 @@
>  #include <linux/irq.h>
>  #include <linux/stringify.h>
> =20
> +#include <asm/insn.h>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>

[Severity: Low]
This isn't a bug, but arch/riscv/kernel/traps_misaligned.c already includes
asm/insn.h a few lines below.

[ ... ]

> diff --git a/arch/riscv/lib/insn.c b/arch/riscv/lib/insn.c
> new file mode 100644
> index 0000000000000..fc44e2aa6f5f0
> --- /dev/null
> +++ b/arch/riscv/lib/insn.c

[ ... ]

> +static unsigned long get_next_insn_address_compressed(struct pt_regs *re=
gs, u32 insn,
> +						      unsigned long pc)
> +{
> +	unsigned int rs1_num;
> +
> +	if (riscv_insn_is_c_jalr(insn) || riscv_insn_is_c_jr(insn)) {
> +		rs1_num =3D RV_X(insn, RVC_C2_RS1_OPOFF, 5);
> +		return riscv_jalr_target(riscv_get_reg_value(regs, rs1_num), 0);
> +	}
> +
> +	if (riscv_insn_is_c_j(insn) || riscv_insn_is_c_jal(insn))
> +		return RVC_EXTRACT_JTYPE_IMM(insn) + pc;
> +
> +	if (riscv_insn_is_c_beqz(insn)) {
> +		rs1_num =3D RV_X(insn, RVC_C1_RS1_OPOFF, 3) + 8;
> +		if (!rs1_num || riscv_get_reg_value(regs, rs1_num) =3D=3D 0)
> +			return RVC_EXTRACT_BTYPE_IMM(insn) + pc;
> +		return pc + 2;
> +	}
> +
> +	if (riscv_insn_is_c_bnez(insn)) {
> +		rs1_num =3D RV_X(insn, RVC_C1_RS1_OPOFF, 3) + 8;
> +		if (rs1_num && riscv_get_reg_value(regs, rs1_num) !=3D 0)
> +			return RVC_EXTRACT_BTYPE_IMM(insn) + pc;
> +		return pc + 2;
> +	}
> +
> +	return pc + 2;
> +}

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
> +		return riscv_jalr_target(riscv_get_reg_value(regs, rs1_num),
> +					 RV_EXTRACT_ITYPE_IMM(insn));
> +	}

[Severity: High]
On 64-bit RISC-V, do RVC_EXTRACT_*_IMM(insn) and RV_EXTRACT_*_IMM(insn)
zero-extend negative branch and jump offsets to 64 bits instead of
sign-extending them?

Because insn is u32, RV_IMM_SIGN(x_) and RVC_IMM_SIGN(x_) evaluate in 32-bit
unsigned arithmetic (producing a 32-bit unsigned mask such as 0xfffff000U),
and bitwise-ORing that with the GENMASK()-based unsigned long bitfields
zero-extends the result to 64-bit unsigned long. Any backward branch,
backward jump, or negative-offset JALR in get_next_insn_address_compressed()
and get_next_insn_address_standard() will miscompute the next PC by +4 GiB,
arming software single-step breakpoints at the wrong address.

Casting the extracted immediates to s32 before adding pc or passing the
offset to riscv_jalr_target() (as done in simulate-insn.c) would sign-extend
them properly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107023917.4060=
6-1-himanshu.chauhan@oss.qualcomm.com?part=3D6
