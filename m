Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74952F5A0E;
	Tue,  9 Jun 2026 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985560; cv=none; b=bIHQPb0vruQRDZqFB1reA0XCVpUSe4sdD37IWO4Zl1MnPE6q1CHFoONYTTURBM9A0NCfNdsnDCuYVCRXUap3bkJuXn5lDv28wJAuX/Techzvekc3CDH+u7PqHjHn0ih6wgVJ1YzSQGgg+stMOuRPtmLKgVfDaz9zo1BNpuAYiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985560; c=relaxed/simple;
	bh=IbCWbhkmcBU09d/e9UT6DRTRIupKz5/XXAmpi3LN8iQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m7jY8GwVqMqvktuHR4zIY4R8qoPhAucASQiXtBveQ2kCCrGYx9I+2Sn7faD+3X4TN9vWEia8GJFdkAeyfN7DAIyaNQU/dmGDpa7f8EmQZx1X3f+BCGxyxpH5jW+REfmLVjZegJ5dXBrTPXzSxyD9oxP4z1AjgxcuXyhciKOT0fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8c4FQnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8c4FQnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160901F00893;
	Tue,  9 Jun 2026 06:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780985559;
	bh=C5Pe2cLn4crcljr3sJVEvV1sUygn/HIYPWL9+kPHbLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U8c4FQnSHCII0c7GWTdieRgfVNRsExoU6cdt1PyVMPof7sBjseuEk2j/3M6GyqqAX
	 1s2mJ8xlMvhrpdDIFxJvJgAysV9AfKxiFSgfsuMSCPOXe0WA7dwB2RQwkGM/uBZ0lt
	 bQPCCiDuSVNSijmtv7DyOSdh4vNcXq8NSN10ucDSFQ7ihN7PXVKWYGo9NQfYk+Z2IE
	 K1EnLeX9qjFdeL3+GGskGK0rAvN90y5WF1eLWMfAkBzse3AUm6K3NR4WEwPNN4o3ej
	 7woPU2m3Xdk+03qy236AyQjd8R/xqcPYGLVPfyv59dmH07FsM33yxhNgt4IkeufUds
	 wa4Po3Kwk3m0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/21] dt-bindings: riscv: add Counter delegation ISA
 extensions description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: conor+dt@kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260608-counter_delegation-v6-9-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-9-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:12:38 +0000
Message-Id: <20260609061239.160901F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Incorrect dependency for smcdeleg: depends on sscsrind instead o=
f smcsrind.
- [Medium] The ssccfg extension is over-constrained by strictly requiring s=
mcntrpmf.
- [Low] Contradictory description for the smcdeleg extension.
--

commit 53fb261803de68f9caaa685d63588c9cac6c0f5c
Author: Atish Patra <atishp@rivosinc.com>

dt-bindings: riscv: add Counter delegation ISA extensions description

This commit adds device tree binding descriptions for the Smcdeleg and
Ssccfg RISC-V ISA extensions. It also specifies the conditional dependencies
required for these extensions to pass schema validation.

> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index ece3edccee42c..2845e8e2999a7 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -181,6 +181,13 @@ properties:
>              changes to interrupts as frozen at commit ccbddab ("Merge pu=
ll
>              request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
> =20
> +        - const: smcdeleg
> +          description: |
> +            The standard Smcdeleg supervisor-level extension for the mac=
hine mode

[Severity: Low]
This isn't a bug, but should this say machine-level instead of
supervisor-level? Since it has an Sm prefix and is meant for machine mode,
calling it a supervisor-level extension might be a copy-paste typo.

> +            to delegate the hpmcounters to supervisor mode so that they =
are
> +            directly accessible in the supervisor mode as ratified in the
> +            20240213 version of the privileged ISA specification.

[ ... ]

> @@ -1135,6 +1150,36 @@ properties:
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
Does smcdeleg actually depend on sscsrind here?

Since smcdeleg is a machine-mode extension that uses M-mode indirect CSRs to
delegate counters, shouldn't it depend on the smcsrind extension instead of
sscsrind? If a valid hardware configuration implements smcsrind and smcdeleg
without sscsrind, would this schema incorrectly reject it?

> +            - contains:
> +                const: zihpm
> +            - contains:
> +                const: zicntr
> +      # Ssccfg depends on Smcdeleg, Sscsrind, Zihpm, Zicntr, Sscofpmf, S=
mcntrpmf
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
> +                const: sscofpmf
> +            - contains:
> +                const: smcntrpmf

[Severity: Medium]
Is smcntrpmf a strict requirement for ssccfg?

The ssccfg extension provides supervisor-mode access to delegated counters,
but the kernel implementation seems to only conditionally expose
cyclecfg/instretcfg CSRs if smcntrpmf is present. If ssccfg can exist
independently, will requiring smcntrpmf in this binding incorrectly fail
validation for valid hardware that omits it?

> +            - contains:
> +                const: zihpm
> +            - contains:
> +                const: zicntr

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D9
