Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAB3CF68E;
	Tue,  9 Jun 2026 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985646; cv=none; b=LWADB5goJ5e6nr6vDMxL+nj+VasuKYigWvFtC2Ik7YNngxgRQvlgRDTWHzpznfEVTYReGhYjNUngpSXw1RQicFJEdW/ewRknasxYJSB4XUA15f58nDjwXEwJ7h0fePzPNuazC7lp9PtfrmWhd8T+Y/j5lYr+0PIPoRMAvo22Ylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985646; c=relaxed/simple;
	bh=Qav8HxT2N0VtEBEK7Ao3mDBsmMuFEZ/x6bpWIPsGoRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TSFBGddyI59h5L9ZmoUgE4a3Oyg8PxsmWeVdcQKi3iCLCm/jwNi9+W5PZ1rny+7EIlcKA/9REPgX/om7sBWSw6fXM+ex/yNaRL9zXhGZi3UtPzb9+88X6XdndSJ8r3xp3kYbhvGMtZYJNMvZh8BwX10aBc4GQ5biBN3lmBDXhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRwrptiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRwrptiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1943F1F00893;
	Tue,  9 Jun 2026 06:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780985645;
	bh=k89+UKXIdU7yTbUn3YhJMTqC1uOd1xqD4j8ULcgl3nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRwrptiLCKJegNGDJINBzAAEDQjTcw+h9AFuNYyHQvbjfi7k3GNS7HeKAkvPOcG+s
	 GFQpWeHhHYGkqeajdp+CQmbJJDWAaXC1xwy8bmrljpaya6XPd6giRSnW7iptXNIKhs
	 VgfVXL4cEuzona4iWbWoKwDJ7GfjO8i4hIoVXINkAEPmd89Svs5oKjPe+wax1R+eCD
	 4u39QLfr7hK1DfhYDXugMfXI50aIxwlpjfaXc2zQZMUCHXu1p0tlUeGP7hdnSHaKJ0
	 1h8IAfNKrpIMj96th11D4A/MkgZGVWcrcxYt8ugSLbMeqDJixpYwh6/AoDaOvRSCha
	 fXMdS35YpHkoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/21] RISC-V: Add Ssccfg/Smcdeleg ISA extension
 definition and parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260608-counter_delegation-v6-8-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-8-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:14:04 +0000
Message-Id: <20260609061405.1943F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Supervisor extension Ssccfg incorrectly depends on Machine extensi=
on Smcdeleg, breaking virtualization.
- [Medium] The Smcdeleg extension validation incorrectly checks for the Sup=
ervisor-level CSR indirection extension (SSCSRIND) instead of the Machine-l=
evel one (SMCSRIND).
--

commit 53e139b078ec8b41f58b09bfd3d37e7132a15d45
Author: Atish Patra <atishp@rivosinc.com>

    RISC-V: Add Ssccfg/Smcdeleg ISA extension definition and parsing

This commit adds definitions and parsing logic for the RISC-V Ssccfg
and Smcdeleg ISA extensions. It introduces validation functions for
both extensions and adds them to the riscv_isa_ext array.

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
                                                        ^^^^^^^^^^^^^^^^^^^=
^^^
[Severity: Medium]
Since Smcdeleg is a Machine-mode extension, shouldn't its validation depend=
 on
the Machine-level CSR indirect access extension (SMCSRIND) rather than the
Supervisor-level extension (SSCSRIND)?

If the kernel runs in M-mode, or on hardware that implements SMCSRIND but n=
ot
SSCSRIND, this validation might incorrectly fail.

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
Does this break supervisor counter delegation in virtualized environments?

Smcdeleg is a Machine-mode extension, and hypervisors typically do not expo=
se
M-mode extensions to guest VMs. A guest kernel running in VS-mode won't see
Smcdeleg in its ISA string, causing this validation to unconditionally fail
and return -EPROBE_DEFER.

Should Ssccfg validation only depend on S-mode visible extensions?

> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D8
