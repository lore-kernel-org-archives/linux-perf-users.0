Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD13C9892;
	Tue,  9 Jun 2026 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985357; cv=none; b=adY0IGmLCbBMp2jVMKjxQo4fOEYhBiN8Nbp8gS3XoGKCnk0f9A412vQb7mZwCoBIHmFtFJ8+HIIrP8rfslYPIn+XAQwZwj6JCtydomePDu2ZuxhJFj0NszaWG4P7mLVBhnUtL6C8Gj0haTDgCKg4Zs2oStrSfC0Jl5IQ8i9lZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985357; c=relaxed/simple;
	bh=0Ay88O+2kxHABmI6EvThN2jLEhnbjPME3y1qREbMckw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqSL4HinJQ4d3Ah/3mm8QGaMuI8Ye42tgde17GHYFXc9j9YKL0ivOAZdU7LYW1ZpAPjfR6JdsiaFQacgvwdAyxGZBiB8rbNnOfT/TM2h28Z9/mDfabTAw8lTjLXeX+kTKc8zsffI223tujM+HVa+1SUnsLSW/chMo2m4HyNFWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGqy3Usb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGqy3Usb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7461F00893;
	Tue,  9 Jun 2026 06:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780985355;
	bh=ooDz4EIMEgbHpb/W6cEtkiQRNh0ExMmK5C88lKJxYvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TGqy3UsbeH2Gt6GN+I5zRatZNpna/tx/5psomwTL4rnZiXCkRyi+NE7RdlcOSadW7
	 WhJbbCuVWExo4PD55iCMLxbfW5af+vXeu4Xqpd0RrI4+C0tq5C8/m58lVLGdZlfgQq
	 zZl0Z1RBhJoVdIzaXo8ESewXXuGKwjjJqL3ofNFIFpYXce+kp1k+PbbC6urXmCDB6G
	 /6AWkwHpYmOq+ST4b9aQdyVupBpJWoUdrIii+yqGXFvzDOpG54h349soMrPAOUDSai
	 +Gv7hKxy5HpclGftbweIswiebMIKZdrRPiRMaCkmaZGtfKcCn+6lx6g9R0fVCq5Bys
	 zJCMFPU+FCxAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/21] dt-bindings: riscv: add Smcntrpmf ISA
 extension description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260608-counter_delegation-v6-6-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-6-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:09:14 +0000
Message-Id: <20260609060915.6C7461F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `smcntrpmf` extension is inserted in the wrong alphabetical ord=
er.
- [Low] The description incorrectly refers to `Smcntrpmf` as a 'supervisor-=
level' extension.
--

commit 9fd028f70a33e1a78db2f635eed4200c33b6b90d
Author: Atish Patra <atishp@rivosinc.com>

dt-bindings: riscv: add Smcntrpmf ISA extension description

Add the description for the Smcntrpmf ISA extension.

> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 4be557dc215de..ece3edccee42c 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -189,6 +189,12 @@ properties:
>              mechanism in M-mode as ratified in the 20240326 version of t=
he
>              privileged ISA specification.
> =20
> +        - const: smcntrpmf

[Severity: Low]
Is this inserted in the correct alphabetical order?

The multi-letter extensions list in this file explicitly requires entries t=
o be
sorted alphanumerically. Alphabetically, smcntrpmf ("c-n") should come befo=
re
the preceding extension (smcsrind, "c-s").

> +          description: |
> +            The standard Smcntrpmf supervisor-level extension for the ma=
chine mode

[Severity: Low]
Is "supervisor-level" accurate here?

In the RISC-V ISA naming convention, the "Sm" prefix denotes a standard
machine-level extension, while "Ss" denotes a supervisor-level extension.

Calling it a "supervisor-level extension for the machine mode" seems
contradictory. Could this be a copy-paste error?

> +            to enable privilege mode filtering for cycle and instret cou=
nters as
> +            ratified in the 20240326 version of the privileged ISA speci=
fication.
> +
>          - const: smmpm
>            description: |
>              The standard Smmpm extension for M-mode pointer masking as

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D6
