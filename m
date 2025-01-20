Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263016130C;
	Mon, 20 Jan 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399003; cv=none; b=lnL+KMXnWIPVBIAloXr70Hv7joJci+qkJzfS2QX3s7zNiO4AKpF89vUtEDW51x0B9F0PIYs77wbIL7hYD86CWFCKWcIMr02qTXWwJkaRbNbW3SCg5YSWIy1JQvpTlV6ZbSkRkAgkOMZVNpVK1h2k9OjXgvomljP8XfUZpkE95fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399003; c=relaxed/simple;
	bh=keQ4qpXup8ODEZvZQDL7I6+dJQgVZs+X5f48QgI9A9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDh0ujeUQ+u9zRwl3L4FQjjIf2gfEm24R+vxA2z+ZXkGNCmbsP7c3mjF9FPHJ2Pbn5FIAgkXBvzZ237RhZRsiY4WhxatcAeYhYUYSKI+DlkgSqjDFxwokkr0k42HLAYmPyVztf50yCGny7ncgtFsvAB1s6I/GrX8Y48gHMctx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWaoDoSC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWaoDoSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD7AC4CEE0;
	Mon, 20 Jan 2025 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399003;
	bh=keQ4qpXup8ODEZvZQDL7I6+dJQgVZs+X5f48QgI9A9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWaoDoSCrm7ialgf0hjFKpRmwL51vstfVgmob4KF/lVjA1N28AQHIIpq8ncoPdzUt
	 MwQxqcr6Sl7ap0g8CpA//mGugUgsRLQlYwpsuulewNwuUWR1clN3sGI5+lZdDZNjBY
	 nsqjjB6pKlwiS1J25TR/cMyNmxBMAIU3KwMQO6VZydTM8ubMkp7plz2LDKxzx8/Qs9
	 FXkXaofXFdWuOBq4vb4lnxoz3Qx8ozBo3N/PmILjQ3E4slzGIFRvjQw0MJ7zsPTEI2
	 WjWva/Gd/RaCm9eeGgoGE7szv1ddC5aYM/qfHU7eYEkBM7TFSxnxMcXKPrVMBLLVD4
	 g7lvpuM8UpvrA==
Date: Mon, 20 Jan 2025 18:49:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, ajones@ventanamicro.com,
	anup@brainfault.org, acme@kernel.org, atishp@rivosinc.com,
	beeman@rivosinc.com, brauner@kernel.org, heiko@sntech.de,
	irogers@google.com, mingo@redhat.com, james.clark@arm.com,
	renyu.zj@linux.alibaba.com, jolsa@kernel.org,
	jisheng.teoh@starfivetech.com, palmer@dabbelt.com, will@kernel.org,
	kaiwenxue1@gmail.com, vincent.chen@sifive.com
Subject: Re: [PATCH v2 4/7] dt-bindings: riscv: add Sxctr ISA extension
 description
Message-ID: <20250120-twisted-reward-b3b620c80368@spud>
References: <20250116230955.867152-1-rkanwal@rivosinc.com>
 <20250116230955.867152-5-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sM0OwTrQXpmguZwj"
Content-Disposition: inline
In-Reply-To: <20250116230955.867152-5-rkanwal@rivosinc.com>


--sM0OwTrQXpmguZwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:09:52PM +0000, Rajnesh Kanwal wrote:
> Add the S[m|s]ctr ISA extension description.
>=20
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 848354e3048f..8322503f0773 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -167,6 +167,13 @@ properties:
>  	    extension allows other ISA extension to use indirect CSR access
>  	    mechanism in M-mode.
> =20
> +        - const: smctr
> +          description: |
> +            The standard Smctr supervisor-level extension for the machin=
e mode
> +            to enable recording limited branch history in a register-acc=
essible
> +            internal core storage. Smctr depend on both the implementati=
on of
> +            S-mode and the Sscsrind extension.

Please, like the other extensions, cite the commit (and repo) where the
extension was frozen or ratified.

> +
>  	- const: sscsrind
>            description: |
>              The standard Sscsrind supervisor-level extension extends the
> @@ -193,6 +200,13 @@ properties:
>              and mode-based filtering as ratified at commit 01d1df0 ("Add=
 ability
>              to manually trigger workflow. (#2)") of riscv-count-overflow.
> =20
> +        - const: ssctr
> +          description: |
> +            The standard Ssctr supervisor-level extension enables record=
ing of
> +            limited branch history in a register-accessible internal core
> +            storage. Ssctr depend on both the implementation of S-mode a=
nd the
> +            Sscsrind extension.
> +
>          - const: ssnpm
>            description: |
>              The standard Ssnpm extension for next-mode pointer masking as
> --=20
> 2.34.1
>=20

--sM0OwTrQXpmguZwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ46a1AAKCRB4tDGHoIJi
0uceAQCeRb1R/n532c4D/yxFavhS7J4RaH2P2lS4hTeORUDMxwD/bwxHJoeYil2Q
1ihodOZfON2tgzlq45m6l5hCvoAuhQA=
=AF6L
-----END PGP SIGNATURE-----

--sM0OwTrQXpmguZwj--
