Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1604339FCCC;
	Wed,  1 Jul 2026 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897088; cv=none; b=l5hM6MtyhO1E6B9e9J2yLXrQyCgDc+Z/fv83YIClLjHIWwRzFbuX2HnKSaiAXT+h98y0fU2GUcYXWmcMH23H1X9g0iomvhQ5gw8zFJuGe1yCqkj+HUGkytGj9X7RqSn9XsflSaah9A7NGZ9Eh4xy23ufJ28Sq2/7Lj8wMzYrjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897088; c=relaxed/simple;
	bh=0qwRH0VpthamnGatXs3UZ5lbAY9w8bFYaMwIvglhzHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t9JhhnZYfkh5S/+tYHbDgCfJhH+Ccl8xUJWZYn6so/NRCoxJyIu4FWWyXgc5/3ibfhCncaoxxNNb6H8DgNMhxL5wqMl8ydV9mYn5XgxIJBdR+fgRjhUhqBKxSV6+WU72sn30I6lqZ+gbOgWOVdSzx+JIVUZK0QUTkUbnVmyifsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQs/i7KM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQs/i7KM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F191F000E9;
	Wed,  1 Jul 2026 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782897086;
	bh=jvTFl5vL211K5skStsWaWiAI6JmtKkjQ0Ig2NpqnZWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQs/i7KMSkvh+ekY2x0/OAXsSuNhJ9YIfOx6oto+gsH2rHsaAjMuNjOM86kasakSe
	 G8cXZKinJe6n0Qp1OUC7LklGf+sWRYRfE7ddndvEXChi+5JOlkxIJpvshEMALuHlQs
	 /avWHwncqbKgj7MpAkekAphFv0O6//shwbNVt6U2H/C7FmZLD3JOtvSj3RdtS4V0bm
	 6wuaX0geLAmRy3h6FJRXho6hBJPsnYt8rg4X/+Sadgz9TbHcHey/kzu3mq3QJlnzAB
	 vn7MZYPAunW0JSCbjdiF2J+iM1XdvnuwyJlPOQT8zV8go1ONaKH3tnapyxFOwdCx0g
	 cXYDKcNJw+T6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/22] RISC-V: Add Ssccfg/Smcdeleg ISA extension
 definition and parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260701-counter_delegation-v8-9-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-9-7909f863a645@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:11:25 +0000
Message-Id: <20260701091125.C8F191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The Supervisor-level `Ssccfg` extension validation strictly requir=
es the Machine-level `Smcdeleg` extension, breaking S-mode guest VMs.
- [Medium] riscv_ext_ssccfg_validate passes the wrong context pointer to ri=
scv_ext_smcdeleg_validate and performs a logically redundant check.
--

commit 6cf182c3b2cfda28c919d7041cfd7b6c8a237b86
Author: Atish Patra <atishp@rivosinc.com>

RISC-V: Add Ssccfg/Smcdeleg ISA extension definition and parsing

This commit introduces definitions and parsing for the Smcdeleg and Ssccfg
ISA extensions on RISC-V. It adds validation logic to ensure that required
dependencies are present before enabling these extensions.

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
Does this code inadvertently break Ssccfg support in S-mode guest VMs?

When Linux runs as a guest VM under a hypervisor, M-mode extensions like
Smcdeleg are hidden from the guest OS. Since this validation strictly requi=
res
RISCV_ISA_EXT_SMCDELEG to be present in the ISA string, Ssccfg will always
return -EPROBE_DEFER and be disabled.

Should a Supervisor-level extension depend on the presence of a Machine-lev=
el
extension?

[Severity: Medium]
Is it intentional to pass the SSCCFG data pointer to a function expecting
SMCDELEG's context?

While it currently doesn't crash because riscv_ext_smcdeleg_validate() igno=
res
the data pointer, this seems to violate the validation callback API contrac=
t.

Additionally, is it necessary to call riscv_ext_smcdeleg_validate() directly
here? If RISCV_ISA_EXT_SMCDELEG is present in the resolved isa_bitmap, it
should already be guaranteed to have passed its own validation function dur=
ing
a previous loop iteration.

> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-counter_de=
legation-v8-0-7909f863a645@meta.com?part=3D9
