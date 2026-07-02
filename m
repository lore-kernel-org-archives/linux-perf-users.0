Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ABB399365;
	Thu,  2 Jul 2026 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983789; cv=none; b=NpLLXStXp4liZ/8bkc822loq6wCf9XU9rpaUuwxykwiJytYXgw0fwGFIitzpROtEFo4WfrcOYYJ61iUbCVSiDpeMFvU4imQltyLU3IZc+DbEnDMZ756+4uWVf+1wK/8HuvHoy91DxqPjH8WO2phkHcHpIEkkMN7SssVj8TFZU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983789; c=relaxed/simple;
	bh=1x1Hu3hedgMBwNq7SoCp9xSXmb6NokWC+v5iymNGrrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MiTkRHF2l5y8uEM3M7A2zHkQmIzRqmRpO+QdfQfPYEks7G2eD3mBKPifrGQOlOKFl15xoIt8/P78NL0RoOblQ+owvqHRufuncbk6ihcXazann35rle6LbDAwMA7pJalM0M24iTt5Qux+m2HVGJRTMMsdlPCP1j1LQdnEFnQqXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/TMudwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/TMudwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B5D1F000E9;
	Thu,  2 Jul 2026 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782983788;
	bh=0Noc9bGmhd05/MNkTgzXEBsyrdl7wGq+DgJXxCN9idg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/TMudwb1IOYa6OegWtc432S5FrskqU9QVB2YLLzyH0ORyeljSyAEtfDdbHisQn65
	 WUrW3Kohs43lM5JA67aaKR94SYwQMCgqEsSr4DFY5Kcd6vM1Vuw8hpd4X9yoBvhrgB
	 wp9q13D/65FEUN73+r4dOwO8OsdDWVXKMVLzNp/iXtOLylM5R/Cjg36vDLof1BDDk/
	 LVnrr9nnBEariJunqwzIi40DmE/WowKczeF6TOnTB076eNgurHVVA4Fdnx7Grsv/yR
	 cExuJoDDPz7C9Bb88iuGaAuzDul0ltUzwhwQ75gqi7MVEH7r4q5rYBsWjfvuRn1UsR
	 nFQRHq/UxDrpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] dt-bindings: perf: riscv,pmu: Add
 interrupts-extended property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Lin" <eric.lin@sifive.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260702-pmu-dt-property-v1-1-a7a7737afb72@sifive.com>
References: <20260702-pmu-dt-property-v1-1-a7a7737afb72@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 09:16:27 +0000
Message-Id: <20260702091627.C5B5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Overloading `interrupts-extended` as the sole CPU affinity map f=
ails when PMU interrupts are optional.
--

commit c04ae2b471021dd39ca8ccf1e788362245660a9d
Author: Eric Lin <eric.lin@sifive.com>

dt-bindings: perf: riscv,pmu: Add interrupts-extended property

This commit adds the interrupts-extended property to the riscv,pmu binding
to define the connection between the PMU overflow interrupt and the CPU
local interrupt controller. It also notes this property is used by software
to associate a PMU node with a specific CPU on heterogeneous systems.

> diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Docu=
mentation/devicetree/bindings/perf/riscv,pmu.yaml
> --- a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> +++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> @@ -34,6 +34,13 @@ properties:
>    compatible:
>      const: riscv,pmu
> =20
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 4095
> +    description:
> +      Specifies the interrupt-parent and local interrupt index for each =
CPU's
> +      PMU counter overflow. Each item points to a riscv,cpu-intc node.

[Severity: Medium]
Does overloading interrupts-extended as the sole CPU affinity map cause
failures on systems without PMU interrupts?

If a heterogeneous RISC-V SoC lacks the optional Sscofpmf extension, it
would omit the interrupts-extended property entirely. Without this property,
it seems the OS would have no mechanism to determine which PMU node belongs
to which CPU, potentially breaking perf functionality on such hardware.

Would it be safer to introduce a dedicated affinity property to prevent
future fragmentation when PMU interrupts are absent?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-pmu-dt-pro=
perty-v1-1-a7a7737afb72@sifive.com?part=3D1
