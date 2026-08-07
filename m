Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C9384243;
	Fri,  7 Aug 2026 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091107; cv=none; b=Tj/IRxzSImeSXiUNZn1uVebOXOO8TXYeLuHG0PSX7OSOSVXtGGC7bYEuvDJ/OLfM7ZEVfXY/TkASRVHzdyOwMtgvWLpS/MzwymLIoHDcu4tJuhffNEuOroJ0fYXD1HpjftQJ4/w9mIIS7dY/7GgQXMfWEzdL94OPkXlWp6YwKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091107; c=relaxed/simple;
	bh=ucyj4DR1CQ3V1rrl3aoOhuNZh2xQSB3cHS22rq3k8iI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U7XG5LvDdGN4WZwNG79oVO6X5J6e22YUg66Du4jnA3yLc6Fg+LjW34zl1Jb65QN4OW4Op9YXFxwkxRpgbxPws9fgbB+0aLh/tE1QiUDzKmlL4H4Igtu3W6dyEflrzW2yzN8I9WRepUwEnaPZijyc+soGW5IE4NxkYjSTpH2KFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcie+BUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcie+BUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBDB1F000E9;
	Fri,  7 Aug 2026 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786091102;
	bh=+4kpOhO2sSpWMYji0tUSwkTNUe8gYTFP+0MhrGYcARM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mcie+BUWzPSsXoKytyDgA6Nr5hwPrhWR/qOO97uxSlOVTHTfTNyi9kAwyn+gyJTd1
	 iVtsrOLEUi3eANPRVo2sgKhNjWgX7zOLfwHkaNfXKk+KDRXHTJhjvmGpqEGhFIiDvP
	 fZvqIkBf+40zov1DVw0ZSOXG/aBmUyKEIZjWUc1H3wInlyA9/WFyOlG1AQxh3I23LS
	 o7U2S0ZT9DNaIhmkKOVNUax6KF1PHnz8EVvi4NPeczf8E/MAD7g7/1h2celGfqJB5H
	 dPA2RhJe0z60iGlFxlHPMfO+ygZpOFjTD6FLgpNXMoqLAGjf2O2y7mnbxPeo+pqYe2
	 /ThAlHUhZvSXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/20] RISC-V: Add Ssccfg/Smcdeleg ISA extension
 definition and parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260807-counter_delegation-v9-9-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
 <20260807-counter_delegation-v9-9-58658104e487@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:25:00 +0000
Message-Id: <20260807082501.9BBDB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Ssccfg validation incorrectly depends on the machine-mode extensio=
n SMCDELEG, breaking virtualization.
- [Medium] Smcdeleg validation incorrectly checks for the supervisor-mode e=
xtension SSCSRIND instead of the machine-mode variant SMCSRIND.
--

--- Patch [9]: [PATCH v9 09/20] RISC-V: Add Ssccfg/Smcdeleg ISA extension d=
efinition and parsing ---
commit e656dfc58bff7f1b23f61ced28dbec6228def44b
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: Add Ssccfg/Smcdeleg ISA extension definition and parsing

Smcdeleg extension allows the M-mode to delegate selected counters
to S-mode so that it can access those counters and correpsonding
hpmevent CSRs without M-mode. Ssccfg provides access to delegated
counters and new supervisor-level state. This patch enables these
definitions and parsing.

Link: https://patch.msgid.link/20260701-counter_delegation-v8-9-7909f863a64=
5@meta.com

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1452521d740a6..1fe647e035157 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -330,6 +330,27 @@ static const unsigned int riscv_a_exts[] =3D {
>  	RISCV_ISA_EXT_ZKNE,	\
>  	RISCV_ISA_EXT_ZKNH
> =20
> +static int riscv_ext_smcdeleg_validate(const struct riscv_isa_ext_data *=
data,
> +				       const unsigned long *isa_bitmap)
> +{
> +	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_SSCSRIND)=
 &&

[Severity: Medium]
Should this check for the machine-mode extension RISCV_ISA_EXT_SMCSRIND
instead?

Validating a machine-mode extension (Smcdeleg) against a supervisor-mode
dependency (SSCSRIND) seems semantically incorrect according to the RISC-V
specification, which usually ties M-mode extensions to M-mode prerequisites.

> +	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZIHPM) &&
> +	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZICNTR))
> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}
> +
> +static int riscv_ext_ssccfg_validate(const struct riscv_isa_ext_data *da=
ta,
> +				     const unsigned long *isa_bitmap)
> +{
> +	if (!riscv_ext_smcdeleg_validate(data, isa_bitmap) &&
> +	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_SMCDELEG))

[Severity: High]
Will this check cause the Ssccfg extension to fail validation when running =
as
a guest VM?

Since a hypervisor (HS-mode) exposes the supervisor-level Ssccfg extension =
to
the guest (VS-mode) but omits machine-mode extensions like SMCDELEG,
requiring SMCDELEG to be present in the ISA bitmap means Ssccfg will return
-EPROBE_DEFER.

This appears to break performance counter configuration in virtualized
environments where M-mode extensions are structurally impossible for the gu=
est
to possess.

> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-counter_de=
legation-v9-0-58658104e487@meta.com?part=3D9
