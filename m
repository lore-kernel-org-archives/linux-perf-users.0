Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7D23C8A0;
	Fri, 15 Aug 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275703; cv=none; b=IiN1FzW6dKnujLAKHS9vydOjDcGKgMKB0KmEfZPdztLJXjJwTd5ep0ep4VTBYcJK7LxHUrD60WtHp68TdbQIHXxmi2VZVgmn0oLxM0xiVMz1Z/iclVf5x7wQwXoK1/hIcWwIM7r1U5KP03Z3NK1dloifI7v7ih0sOQXV5qQqM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275703; c=relaxed/simple;
	bh=c6AnaVW0ZV2bZhNVW8y09FERUFZfx/4V3uxv731vMxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzft2AxZC2fM3+c51SuznWkvQoFGb3r9+GYR27LZ97XdtDvqeBUynNVMf7NwPyJFQk1TDnUnbBr7z3STypvO8X91g2G0swIukZPYv6nO91FitsyH0O5nC5RUgUuG1WA+CEIVHjo5M3nIaHy1OgIEJzSCvope5CQZOjWHjsO4fL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZNTpYrC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZNTpYrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A871CC4CEEB;
	Fri, 15 Aug 2025 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755275702;
	bh=c6AnaVW0ZV2bZhNVW8y09FERUFZfx/4V3uxv731vMxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZNTpYrC7uzJh4JhWIB25/N0THV592WApA7/xXznh7slnR59Co2/zY7/8b6kCpJNS
	 MlrEZvJHoCuVKG0dxOCkt/hunVvc0E0BJvdlurcuX7vx4Zgv3wlgVIL/UQdnTSLB7g
	 /qeO+9lFZW/8aaXVYzgAkU/sK68tppao0BRif1IB/zyKQDqezz1a5cFnYkMWQQxv84
	 zAMIq2DhtU8Duc4x60N0tAzsORG856wiaMSmQVs5rbnMTdNEfaupAHTG822+A9fuSm
	 X8ZRuSmnf6u9M0RsYu8uJK2FrvK2iq9r5dKhqWIhDDa0IduC5p58a5d36HzsQwofJ4
	 36JxKZTfKtGdA==
Date: Fri, 15 Aug 2025 17:34:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/5] dt-bindings: perf: fsl-imx-ddr: Add i.MX94 compatible
Message-ID: <20250815-eclair-expansion-1a680769045f@spud>
References: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
 <20250815-imx94-ddr-pmu-v1-1-edb22be0b997@nxp.com>
 <aJ9ftYVhcuUsKoa3@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cGjM10/Wt+uqqu9p"
Content-Disposition: inline
In-Reply-To: <aJ9ftYVhcuUsKoa3@lizhi-Precision-Tower-5810>


--cGjM10/Wt+uqqu9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 12:26:29PM -0400, Frank Li wrote:
> On Fri, Aug 15, 2025 at 05:36:27PM +0800, Xu Yang wrote:
> > i.MX94 has a DDR Performance Monitor Unit which is compatible with i.MX=
93.
> > This will add a compatible for i.MX94.
>=20
> Add a compatible string fsl,imx94-ddr-pmu for i.MX94
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--cGjM10/Wt+uqqu9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJ9hrQAKCRB4tDGHoIJi
0vTQAQDnyoEjdwJ/vnNuGgwM/Xitf2HIbielj3wLvSJIhkhZAQD6AzPZ25JuX0Pn
MFuj5SHSUlrVhHFslCuT1dCkiPp2vwU=
=ewOy
-----END PGP SIGNATURE-----

--cGjM10/Wt+uqqu9p--
