Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996A33086;
	Fri, 21 Nov 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763728262; cv=none; b=b82Srv1ua1t0A97b8sBVvQ1BOIJbg+GxlmhHEAmliJ+/UsAkbckzhUQuQzookQxD1Ftlkzf5NS/qRy8iJSsFcl6w76OKHbXy0YQ7iMGBcFNbQ8MNR0IEfpgnL2dOBhXthvYNlCT+B0EVr6WJlVkSrMRZn0Usmi/uydwt+FnaVmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763728262; c=relaxed/simple;
	bh=OH0u7+tI6QWmQtYbiS0/gq2DQX5L0kFhHUjyOoR1DMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSEFrdBln2s5A4R705bwU4w/eAdI0fY3CmSE5qC0yW4wMh+zGbvsGQfu9kdZaE60LPLnI8rF53zGP/DR3RqKl+YPkgdWaC7k3Yl8zK5cwDywF9D6jsk7L9Q60TzIvYEjXltV+Iz1fRRe4VGVV3HOLoDEhtvIjWVQ/YP0nS0q1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/0RdieV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/0RdieV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59183C4CEF1;
	Fri, 21 Nov 2025 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763728261;
	bh=OH0u7+tI6QWmQtYbiS0/gq2DQX5L0kFhHUjyOoR1DMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/0RdieVVIs1gqDFGjE2SyaCPzGfGYbECcNhkLpBNGRiUhyd4qvdGpuLDa2jhq+9s
	 1aDCen2kNVK6Gs6a1bxM9U+tgHdNhiphm0wgvwfjQyRJ4a59dpZWu9/xQ+EYyOJasM
	 jPDY+RiMW80V39iM8+4RomLl+7e4nNLy6nfpbkKrUp87d4eo/sUTz00CNCwKyfYCvr
	 Mt7PxNF1NvbB/OsvsSDCWajwFjpCdWFaihxQrSlJKcs3fls89qq/6ngc7YQ5S8034m
	 82hh/lDISLNq91DI6PzZo/S+6JFS4I9HXVJewkiz+78lh4Bv3paECtiwZehR/X6LlU
	 g8nFyTWDXDLqw==
Date: Fri, 21 Nov 2025 12:30:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: cp0613@linux.alibaba.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	guoren@kernel.org, devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add prefix for
 XuanTie
Message-ID: <20251121-shortlist-coroner-b29e19293b40@spud>
References: <20251121063439.2545-1-cp0613@linux.alibaba.com>
 <20251121063439.2545-2-cp0613@linux.alibaba.com>
 <20251121-able-terrestrial-spaniel-90c3cf@kuoka>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m+h7vgyI7UsGxnd7"
Content-Disposition: inline
In-Reply-To: <20251121-able-terrestrial-spaniel-90c3cf@kuoka>


--m+h7vgyI7UsGxnd7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 10:01:07AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Nov 21, 2025 at 02:34:36PM +0800, cp0613@linux.alibaba.com wrote:
> > From: Chen Pei <cp0613@linux.alibaba.com>
> >=20
> > Add new vendor strings to dt bindings for RISC-V vendor XuanTie.
> >=20
> > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/D=
ocumentation/devicetree/bindings/vendor-prefixes.yaml
> > index f1d1882009ba..5d28b2da94cd 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1829,6 +1829,8 @@ patternProperties:
> >      description: Xilinx
> >    "^xnano,.*":
> >      description: Xnano
> > +  "^xuantie,.*":
> > +    description: C-SKY Microsystems Co., Ltd. (XuanTie)
>=20
> We do not create new prefixes for existing entries. You have already
> csky, alibaba and thead and probably many more. Choose some appropriate.

When the vendor literally says "C-SKY", it's hard to buy why csky
shouldn't be used here. Xuantie is described as being a brand, where at
least t-head was a company. This seems akin to having
"snapdragon,msm8660" instead of "qcom,msm8660", for example.

>=20
> Your commit msg should also explain anything unusual here, like above.
>=20
> Best regards,
> Krzysztof
>=20

--m+h7vgyI7UsGxnd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSBbfgAKCRB4tDGHoIJi
0pu2AP9IUCgDAdGT2KEcgsOZxlFERNEUosFAKBFr2j6gKisKYAEAgrHYwqrbt1od
YK5FuRlMYfflubjQjT4wGFsKjrKaHQI=
=o97f
-----END PGP SIGNATURE-----

--m+h7vgyI7UsGxnd7--
