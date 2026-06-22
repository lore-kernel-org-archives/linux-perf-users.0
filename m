Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECFE38F227;
	Mon, 22 Jun 2026 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116449; cv=none; b=hW4dHBKF0JZmy/V8s+DCVRibv5QCy4gJubL8lMpTakaozdj5Ehy+qcWPBX2SeTTXjsX2feJxYFc6EL+wVl3+l2JC/dQFYsInm63xNB4Qb0WWHOtPJVlaZ5l+fxoknwpYU/NtFqbpojgp9VdxLycZfjn6OShIcZ/9XzBWYaDsimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116449; c=relaxed/simple;
	bh=LpsRXhuvGqgIw1m28krMp/GmafP556pVbr7YxBde9EQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4AfZ1JyoPgTsaTnBrfGkgxGEJ+Teau5LoqwFrgxNV1hRzugSIbF7vS4lh0FfMS76iWG6xzZwt52lbOfJqXGjM0wJyh0qY16Tm9UL5onMvgdwZiEpAjmJ1i0rgHVzFnWa+1JwEiJ+UFC+YboAIOCbDkPW5ISNeZKsrj2DjHA7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e91Lew/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e91Lew/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A5D1F000E9;
	Mon, 22 Jun 2026 08:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782116448;
	bh=YxIdICqZJpwzIxEoYc7NxPLlU1cMiTqOPyRn/hBvVw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e91Lew/ugRFmaevu1caYd/ylh47euof1oS07Bz75wF0ETcm3lxa2spA/BQLiNkk5Q
	 jdjJsGGA9K01265fTe8kt2N6Fq9N4I3aEDnhgvW1UCfdIeVp/j94WeRxl45/q9Y7RD
	 nzsZE/BUVOc7O3l8hmS1cYAi/y3mf8tc2RgSqWXlhSvkXEAqSssux+SMzzUP+VAyln
	 Lwg7xIg8iySzUAiXjlcyu830ZD4YuCWrCDUrrMSjSZCLXJ7hCRgfvqpNECMkyVtSZ5
	 HxDf+znYzCXvB5GFav/YGNb0tZCjGMm2ypn/sMhUohSRfRwm9qii9H7+oYvjzY+SNA
	 r27YxKpflx4TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/22] dt-bindings: riscv: add Counter delegation ISA
 extensions description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260622-counter_delegation-v7-10-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
 <20260622-counter_delegation-v7-10-0ba2fd34614e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:20:47 +0000
Message-Id: <20260622082047.A8A5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The DT binding and kernel validation logic incorrectly specifies=
 that the machine-level `smcdeleg` extension depends on the supervisor-leve=
l `sscsrind` extension instead of the machine-level `smcsrind` extension.
--

commit 42d2ddd2073c82637c3671b249f0ee2a2583f0b7
Author: Atish Patra <atishp@rivosinc.com>
Date:   Mon Jun 22 08:04:22 2026 +0000

    dt-bindings: riscv: add Counter delegation ISA extensions description
   =20
    Add description for the Smcdeleg/Ssccfg extension.

> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 2493766e956d5..eef5eeb198d05 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml

[ ... ]

> @@ -1135,6 +1150,32 @@ properties:
>              allOf:
>                - const: zilsd
>                - const: zca
> +      # Smcdeleg depends on Sscsrind, Zihpm, Zicntr
> +      - if:
> +          contains:
> +            const: smcdeleg
> +        then:
> +          allOf:
> +            - contains:
> +                const: sscsrind

[Severity: Medium]
Does the smcdeleg machine-level extension architecturally depend on the
supervisor-level sscsrind extension, or should it depend on the machine-lev=
el
smcsrind extension instead?

According to the RISC-V Privileged ISA, smcdeleg utilizes machine-level
indirect CSR access (smcsrind) to configure counter delegation. By tying it=
 to
sscsrind here, valid device trees featuring smcdeleg and smcsrind (but lack=
ing
sscsrind) will erroneously fail validation.

Additionally, the kernel CPU feature validator in
arch/riscv/kernel/cpufeature.c:riscv_ext_smcdeleg_validate() appears to mir=
ror
this logic and checks for RISCV_ISA_EXT_SSCSRIND. Will the kernel also
silently discard the smcdeleg capability on such platforms and fall back to
slower PMU access methods?

> +            - contains:
> +                const: zihpm
> +            - contains:
> +                const: zicntr
> +      # Ssccfg depends on Smcdeleg, Sscsrind, Zihpm, Zicntr
> +      - if:
> +          contains:
> +            const: ssccfg
> +        then:
> +          allOf:
> +            - contains:
> +                const: smcdeleg
> +            - contains:
> +                const: sscsrind
> +            - contains:
> +                const: zihpm
> +            - contains:
> +                const: zicntr
> =20
>  allOf:
>    # Zcf extension does not exist on rv64

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-counter_de=
legation-v7-0-0ba2fd34614e@meta.com?part=3D10
