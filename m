Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996167;
	b=WIHQ3BCx1iPbps6sqPRpUgw8DPF2esP/Nf04t46hrh3WE4CrRgeYQmTD5K81wXN4gfGE
	 QkpJMKnDKo1X3tMyvBvfanyDOhNRA4OOrm3/O1wGxAg2VULT7nFAOklQCz+6TnpWkCy3d
	 F+jlmDO2JHihMAbu6hsY/lV6ZQAP7Gw8Xb0kPfYpZRK13rVMcycoxsMp211oUO9pfsgdd
	 tOoyE0HJhIukJvpmroNTdUhaf2K15h0Ih0OM6tqcuGil9+65IhtYmClsjfk2/mbRRLx+P
	 BsgJMzmDXJKmVHHopsB2EmqHMJBCKFDI11QX7foZlPrrAoFiWQDUWbPSadOXm+8jLug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EHEaWGksQ4QvLO5xx89HxiqeFMO+Z+4r28bvw03htq4=;
	b=0BOzjqFnkEfv9RYF0+xw05D08ui5gBdIhepg0OL6JwRh0mpQhMdpN/SL0Ira053xLQiL
	 TogmutJKbubyc4JkfrPu9iCKP06JkoGbj/DRqx5IrJJS2dJPg5Kup065OT67TE42tca3L
	 4HoYwAleFihv48YDzpmj5oU3wj9JP/C0pfutVFfrTmQtHXt1l5Ct/iX0p34BzJKTG9Vvs
	 3/VAd7dOEXsyOjTQiTPqbOXCENReUeNM5et+EZZEjGor/R5vD3zRPG0Kmm1Wwut0jBUZS
	 Rt88lTShPul3IB4iJcLCnD6deYyUuWdaEECDY7yxRBhB6Yx5QWyuM8F6ih+0E+R+++g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrQERGrB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB249606A320;
	Wed, 18 Nov 2026 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrQERGrB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD481F000C4;
	Wed, 18 Nov 2026 10:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996166;
	bh=EHEaWGksQ4QvLO5xx89HxiqeFMO+Z+4r28bvw03htq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DrQERGrBS6dv3uxn2bdDcQsOSarB2Vw9VaB0fMJWpL/FdfROI3aG2J6IcuwnT1u8s
	 9RYp4DhG3+bffUYtOOvVqGVO8PDZIdWIFLGXYrSZpLF/ygBxwHybta9cRzMZnRvTiH
	 hmOg7PTJoKECT1zuzKpVXeZalnAg2fd8T5As/Y4mgHHCCPYcIhYkgLaDztmBBFtR0o
	 uQXqhBpfSKfuN8LO9cC+BXPtGF8bYYB2GrO7cG/uW+77DiAvxrubYiMTxh3PHTf8fU
	 3htsAeeo9xVW9MqmqWzla7xubf+Bd8LJikUKjKiqO0emaP7/Ss1JKrckbxNorljhtI
	 H4PYPBtT8scwQ==
Message-ID: <sashiko-outbox-220651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] riscv: Add Control Transfer Records extension
 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118095053.3871267-4-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
 <20261118095053.3871267-4-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:02:45 +0000
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
- [Low] riscv: unused RISCV_ISA_EXT_SSPESA and RISCV_ISA_EXT_SSPLCOFI in
  hwcap.h
- [Low] riscv: non-canonical ordering of smctr and ssctr in
  riscv_isa_ext[]
--

commit 4ae624ba46f94bfad975e230dbad25a6ad5f53d0
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

riscv: Add Control Transfer Records extension parsing

This commit adds ISA extension definitions and parsing entries for the
Smctr and Ssctr Control Transfer Records extensions.

Link: https://lore.kernel.org/r/20261106173942.3175069-4-vikram.singh3@oss.=
qualcomm.com

> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index b5952db9259f8..ee200d8cfccbb 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -126,6 +126,10 @@
>  #define RISCV_ISA_EXT_ZIC64B		116
>  #define RISCV_ISA_EXT_SV48		117
>  #define RISCV_ISA_EXT_SV57		118
> +#define RISCV_ISA_EXT_SSPESA		119
> +#define RISCV_ISA_EXT_SSPLCOFI		120
> +#define RISCV_ISA_EXT_SMCTR		121
> +#define RISCV_ISA_EXT_SSCTR		122

[Severity: Low]
Are RISCV_ISA_EXT_SSPESA and RISCV_ISA_EXT_SSPLCOFI left over from
another change?  Neither has a corresponding entry in riscv_isa_ext[] or
any reference in the tree, so bits 119 and 120 can never be set and use
up two of the remaining IDs below RISCV_ISA_EXT_MAX (128).

[ ... ]

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 72bce616491f1..b3e3c30f4c8bf 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -652,6 +652,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
>  	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg=
_exts),
>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
> +	__RISCV_ISA_EXT_DATA(smctr, RISCV_ISA_EXT_SMCTR),
>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>  	__RISCV_ISA_EXT_DATA_VALIDATE(ssccfg, RISCV_ISA_EXT_SSCCFG, riscv_ext_s=
sccfg_validate),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> @@ -659,6 +660,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg=
_exts),
>  	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> +	__RISCV_ISA_EXT_DATA(ssctr, RISCV_ISA_EXT_SSCTR),
>  	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),

[Severity: Low]
Should smctr and ssctr be placed in alphabetical order (after smcsrind
and sscsrind, respectively)?  print_isa() walks riscv_isa_ext[] in array
order to format /proc/cpuinfo, which expects machine-level and
supervisor-level extensions to be sorted alphabetically for canonical ISA
strings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118095053.3871=
267-1-vikram.singh3@oss.qualcomm.com?part=3D3
