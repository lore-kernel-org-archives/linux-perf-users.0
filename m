Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5622D7B9;
	Mon, 22 Jun 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116319; cv=none; b=ll2NAOp9LfUY3+bLbq+6s9KsCoLWdPOo4vJecuBhGd+CCLW6X8iuoCg5zDNucKaG8YxsPFWZ8JpxBsafOMhGdvlgUzgBEWQQtzT4M23wUgdAlYClYmp1x44qq02yI9IklpxAZAg082LD1x4qEyoD5e2jHk/0uELH8ApvHYXzi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116319; c=relaxed/simple;
	bh=wQs1eiQkBCLi6GJwxmTq9D3ptFh+DBtYOwqUNCoE9zA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f2oaOS8a39L2OSJ5oknnVEBlPmU193e5bJXAhj7hFS8j4HFz2IkSxQiLhH/PkFpgBJm6sqJB7DCAyfiijVlUW6DbxZnmkPtOPkByyH2opBaIDzBesqHBEBkXh3Gbn2fj0FkzqZmGVDeQ7z7fO1shWa6qZu+s62YrHpnwv7+64iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKt6aSs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKt6aSs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8706D1F000E9;
	Mon, 22 Jun 2026 08:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782116317;
	bh=MRk94mH+GplLOMfOMvLR5jtaHaIv8X6sl6S5mu/QjTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iKt6aSs6LDPb1fJcOhpWfMCE5ElerrI5ALQjRTTVI8Fwk9UuM9ZaZqyP3A3iNm+D+
	 fFRWQlAMLHXEwPTHc9I817TDV147eKABH617bVcndjwEviMoWHQy36ZN/MceZHzmEP
	 ds42iWjhSPo4iI6a8sQjJgh5vES4YxZ9U4NmOVqQexQHgxsNvB1QjhPQfBh+sGdQQk
	 BUfj0BMefTNlzO7DprC7ytCzhSMEV2eoY7g6PIhkLeXWWIIU4EgZmQIamBSz4hfJ0l
	 ty5Pc+QgZnTNcF0uWVkJipIfQxfX2jEBlq1vqN+INphj2n7AQ3mbL1Npw2NXxasHSX
	 cCIbCqPQ9QwHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/22] RISC-V: Add Ssccfg/Smcdeleg ISA extension
 definition and parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260622-counter_delegation-v7-9-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
 <20260622-counter_delegation-v7-9-0ba2fd34614e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:18:36 +0000
Message-Id: <20260622081837.8706D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `riscv_ext_smcdeleg_validate` incorrectly checks for the Superviso=
r-level extension `SSCSRIND` instead of the Machine-level extension `SMCSRI=
ND`.
- [High] The supervisor-level extension `Ssccfg` improperly mandates the pr=
esence of the Machine-level `Smcdeleg` extension and relies on flawed depen=
dency logic, breaking `Ssccfg` in S-mode guests.
--

commit ad250a6901a4cd821647231579298f446a592807
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: Add Ssccfg/Smcdeleg ISA extension definition and parsing

Smcdeleg extension allows the M-mode to delegate selected counters
to S-mode so that it can access those counters and correpsonding
hpmevent CSRs without M-mode. Ssccfg provides access to delegated
counters and new supervisor-level state.

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

[Severity: High]
Should this validate against the Machine-level extension SMCSRIND instead of
the Supervisor-level SSCSRIND?

Since Smcdeleg is a Machine-mode extension, checking the S-mode equivalent
might cause Smcdeleg to incorrectly fail validation on hardware that exposes
SMCSRIND but not SSCSRIND. It could also erroneously pass if SMCSRIND is
missing.

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
Does enforcing a Machine-mode extension dependency (SMCDELEG) here break
Ssccfg in virtualized environments?

In a guest OS, the hypervisor typically exposes S-mode extensions like Sscc=
fg
but filters out M-mode extensions like Smcdeleg. Enforcing the presence of
SMCDELEG means the guest kernel will silently fail to enable Ssccfg.

Also, is it necessary to call riscv_ext_smcdeleg_validate() directly here?
Reusing the Machine-mode validation logic prevents Ssccfg from independently
checking its own software-visible S-mode dependencies (SSCSRIND, ZIHPM,
and ZICNTR).

> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-counter_de=
legation-v7-0-0ba2fd34614e@meta.com?part=3D9
