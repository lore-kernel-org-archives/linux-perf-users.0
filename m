Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990181;
	b=pGDYj0mH6KO2V4KBPYZRdKzDYeKa8VuFG2j4qg3bCJ+1VbY6hxq7j8lcnX7S8JJx5Wq3
	 Q4NjwJCZxNxhqoHtESWB6POdpf08cyh3GKsSSSMkEnLfL7XbCzglKhGg0s+yvfmEqJEu6
	 PTuhdVXJkqnkpIMeYLZzH0ba63Jm6JdD2MCRdVfltx9Jv3IsVkdKhCed5Dnnt1+velD9m
	 pei+919lkTST1onFhV9V6eh2C0iv8o4o0JqQ9wPQE1c+rXok4H2Qrp2yRJG2cdihnnMXE
	 86+oTO4UKF0jmSiY2rYDFvmCf+9C+1DbzXF46Gy9mFY9cSFm+jHkm5Mz0tencK+3RLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990181;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wtjqla/Rg8Kh1FnjAcMXs52WSzkZKC8NL7c763DxBBY=;
	b=13PFjDU3t50ozOnZXbWARh/0iChb4ymK0J+1v/ik1w98bOiGnoXaxZb8ns28fSzW0TOL
	 k6dpsOrAQmhrsVzWHbCH7iXtPhNSlEPnyeC4YkZ2fSRdlD/dpNJDGeX2nZltgtQrYzR7h
	 PWRpfzz2Js08i7GftJT1gWF+S2uKfLpd3CeXdoSP3CbeDuw4+0UCOc3RYlV9UlGBLuF/5
	 rtdg9XDtZJZG6AwZEVJiPDGx3kk+CxCQjoMhYE5eusp7vdiVo2ffFvlNoHuhuAr5IGsxg
	 VaxankBT8yQ0cIkO17z5z5GSds/S6kXgY5B6KCg36d4Gcb6AtUmX6PeA+jHVEP7yICg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W/4ldDsh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153D606A330;
	Wed, 18 Nov 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/4ldDsh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861871F000C5;
	Wed, 18 Nov 2026 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990180;
	bh=wtjqla/Rg8Kh1FnjAcMXs52WSzkZKC8NL7c763DxBBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/4ldDshIdw4HvrECaCEbiEUJflVOeWMmzrZgA1AHRBjv/zZqzOwagPjdFXg/FAnQ
	 l1mDWoCp4XPcB6dOFOoLcYZ9QHHldekOHdReQq9xWLFIw150rYYwlfI9+0OLfFEYbA
	 nlpbi1X99zMRy7U05qVuZ9cqx9vkVqTXiHPBx2WVK6BS1QvUk5NOK/xOnOu9XR/p4K
	 9LBzjmPKuw67AKrdx6sgbMPuPk8j55u0jXWSDqKr0Fh2F49ryB6tb7TkNBDw0+VLLn
	 zdIkfIVyjVlCT/hf+BWW58pIlnvmL1X/ZZiAHYBc1xUvpfgZipNFGLAtYrObpnQCce
	 KOG3q1X9iy5DA==
Message-ID: <sashiko-outbox-220433@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 1/5] dt-bindings: riscv: Add Smpdis and Sspdis
 ISA extensions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>, linux-perf-users@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118081327.10684-8-zhangzhanpeng.jasper@bytedance.com>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
 <20261118081327.10684-8-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:23:00 +0000
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
- [Medium] dt-bindings: riscv: unratified draft smpdis and sspdis
  extensions added
--

commit 6221314245742eb097a15011dd35eda824258728
Author: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

dt-bindings: riscv: Add Smpdis and Sspdis ISA extensions

This commit adds devicetree binding descriptions for the draft Smpdis and
Sspdis RISC-V Precise Decoded Instruction Sampling extensions.

> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 79491ef8f86a8..afda76b9c7c47 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -214,6 +214,15 @@ properties:
>              ratified at commit d70011dde6c2 ("Update to ratified state")
>              of riscv-j-extension.
> =20
> +        - const: smpdis
> +          description: |
> +            The draft Smpdis machine-level extension for Precise Decoded
> +            Instruction Sampling, as described at commit
> +            2de60e18118ce78e2da82ec33296345c94d8560c of the
> +            riscv-performance-event-sampling specification. It defines
> +            instruction selection, filtering and sample collection across
> +            privilege levels. This does not imply supervisor access to P=
DIS.
> +
>          - const: smstateen
>            description: |
>              The standard Smstateen extension for controlling access to C=
SRs
> @@ -269,6 +278,16 @@ properties:
>              ratified at commit d70011dde6c2 ("Update to ratified state")
>              of riscv-j-extension.
> =20
> +        - const: sspdis
> +          description: |
> +            The draft Sspdis supervisor-level extension for Precise Deco=
ded
> +            Instruction Sampling, as described at commit
> +            2de60e18118ce78e2da82ec33296345c94d8560c of the
> +            riscv-performance-event-sampling specification. It provides =
the
> +            supervisor-visible PDIS registers and behavior, excluding the
> +            machine-only state. Firmware must make this state accessible=
 to
> +            supervisor software before reporting this extension.
> +

[Severity: Medium]
Should unratified, unfrozen draft specifications claim the canonical
smpdis and sspdis strings in riscv,isa-extensions?

Documentation/devicetree/bindings/riscv/extensions.yaml states that
standard extension properties map to their originally ratified states, and
Documentation/arch/riscv/patch-acceptance.rst requires RISC-V
specifications to be Frozen or Ratified before acceptance.  Defining
unversioned standard extension names for a draft without final CSR
allocations breaks devicetree ABI stability if the specification or CSRs
change before ratification.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118081327.1068=
4-7-zhangzhanpeng.jasper@bytedance.com?part=3D1
