Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996053;
	b=vXqCEoLjdlIZZ7jZaEVgeVpBJ9rkLiLL438WS4bzNzJVChIxUfCAX5SgrHwPa/6JNP1D
	 A8QnWVGS+rBCAf2KRIikgYsoMIWgyOz214gV/p6BnpsF7h6TYG/7pK+n4yh6JSO3eH7d8
	 EllhCuPYfplMyX2Kz/YSNAlK8BCgLDD1ibPT38B4zVSY+sg5RBAtt8FMhdvWD3w30iUnJ
	 kJ35JwComwsVsmrMutWizOxcPWqRkoOPmiX6iIOJvZCm17ummFlzoEth6Phwt2Bwy7c6/
	 mMEiSLA8epgwmVDaOy2j/+MPodiYSAoT3iFAWhrUwgYHIqx7LaNUNouGSyEdqBsUtVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PXEhzNknghwGmjMUy7SBzYBEsNqiGaNKcJSwxe2qbUI=;
	b=o3fck4p9DT91oj8Me0LG7kmn28cRxofZY6n4gwkXDWF+h//uC3/9QnqaUSSTxTqa3RSy
	 wou3Qi0wEay/jr1kAb6iMqzxUM7wSKdK7vS4peum/cKIvnJOrk3kOH7Y7qBaPjY3KQoq1
	 xvD6Ignf6vz0mEy8lR+q37Z68bHyAA36XFsuLm/cewlyPctWzWbX2yHEmmtt7bPlWGbcj
	 YgMQugaVoN/UzU93++rfDy915hr4839ZRaqVLpyDYInTi+ZgwKI1puGwW9xzDnpSHb6g9
	 2b96T6d6Ok15AYllWw4vuTgqp/clm8QGPEcoRo8awQj5zVIszuvu53BoshrMJxYLLVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu7FmUse;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB6606A320;
	Wed, 18 Nov 2026 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu7FmUse
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254D01F000C4;
	Wed, 18 Nov 2026 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996053;
	bh=PXEhzNknghwGmjMUy7SBzYBEsNqiGaNKcJSwxe2qbUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mu7FmUseUZIC/r5+J+qLGY2QHNFMfhUc0d5VpRCO7H/hgU1jtrHPwpgJvTaB4PTwF
	 VS/PPvT6Im6piF2+mi774V48uwzzyP5qdbr5pAXMbCh7xmMt6z9YpPv95MdYeZ7dgY
	 r/67BwSLeA9AMqBB+Ugrcqc4ojAgZq+VU9cikeHxDSif7R2fN0k25FrEqUy+vaONpg
	 639TY0+WTP5IZLGBYv5hY2T46GpH1MVdQOIrVxPVh3mUPPSx8uqbSEyyuO2csIL/FI
	 iP0nNjjirjmBmV5H+JFgBYRoZpIPr6ij5PXNe16Z45diD2ZmnxcAu6EI00BWqhdj7S
	 FcoV6UuJHeR/Q==
Message-ID: <sashiko-outbox-220649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/7] riscv: pmu: Add Control transfer records CSR
 definations.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118095053.3871267-3-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
 <20261118095053.3871267-3-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:00:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] riscv: csr: unrelated temporary Sspesa CSR definitions in csr.h
--

commit 0d6ea9c7c50171c8bc5449b363f28764d22f3466
Author: Vikram Singh <vikram.singh3@oss.qualcomm.com>

riscv: pmu: Add Control transfer records CSR definations.

This commit adds CSR addresses and bit-field definitions for the RISC-V
Control Transfer Records (CTR) extension to arch/riscv/include/asm/csr.h.

Link: https://lore.kernel.org/r/20261106173942.3175069-3-vikram.singh3@oss.=
qualcomm.com

> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 621f84d1898f4..063351d9b406c 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -350,6 +350,97 @@

[ ... ]

> +#define CTR_ENTRIES_FIRST	0x200
> +#define CTR_ENTRIES_LAST	0x2ff
> +
> +/* Temporary addresses for Sspesa (Precise Event Sample Attribution) CSR=
s. */
> +#define CSR_SHPMSPC		0x5d0
> +#define CSR_SHPMSDATA		0x5d1
> +
> +/* shpmsdata fields */
> +#define SHPMSDATA_CNTRID	GENMASK(4, 0)
> +#define SHPMSDATA_MODE		GENMASK(6, 5)
> +#define SHPMSDATA_V		BIT(7)
> +#define SHPMSDATA_METADATA_SHIFT	8
> +#define SHPMSDATA_MODE_U	0
> +#define SHPMSDATA_MODE_S	1

[Severity: Low]
Were CSR_SHPMSPC, CSR_SHPMSDATA, and the SHPMSDATA_* definitions included
here by mistake? They belong to the separate, unratified Sspesa extension,
use temporary S-mode custom CSR addresses (0x5d0 and 0x5d1), and are
unused in the tree and unlisted in the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118095053.3871=
267-1-vikram.singh3@oss.qualcomm.com?part=3D2
