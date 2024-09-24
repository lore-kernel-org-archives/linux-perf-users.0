Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981AA1ABEBA;
	Tue, 24 Sep 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195252; cv=none; b=SYlNyYo0DBm3TsBlRd+Df5hex2i1Ncj3e91IT05EqTGEaNo4yDCzJOQjj86+cUcjN2etfs6inQgnvP8Gv9GDRF8OKYY2VKJDTwuNodNIoH8sDGDG46xRkrT6prc8zKhg2Zud2POHDmGsgMqe/0H0AkCXKC6GM8hzqZwWau46sXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195252; c=relaxed/simple;
	bh=ViMnVk42J1l5tNuKJ0A+i1JOlDLYVFAqPaiFCBC/1F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b14gpgP+rPL3jrzSFwXXmP/dA/ZIsABhwFDCW2IFw7XSpaiOtVjnprNkrW2GHdnEYZpATnQF3AIoq10A17KGeOGT0LKS/U64jYpby51ZZzvhTCY/tNhFfjD7acqe9ygAgYx8BSH6JnziozZit3P+wcdZfCmuFxyiSwVQhtbJYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0cFLyHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0cFLyHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C4CC4CEC4;
	Tue, 24 Sep 2024 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727195251;
	bh=ViMnVk42J1l5tNuKJ0A+i1JOlDLYVFAqPaiFCBC/1F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0cFLyHcyjbi8i2zT5OsGQVPp6yggzrZB4IOhcKQU8knkw9PY/rJo03IcqAz9trQM
	 6nhwNx8ETc5F3DOTgGUHevyVmu5qrSqYWnNbioHXiJcyd0GeOW4x21n3MhPtyAiXtC
	 MOJ7LGbm/okyXZCnWruScGVO7Irm/UHFZXeDG2VYh8dLVvsEz2BRs2ehQhdSJ+tXG7
	 tglTVjZeUBJStQyulRt9jOlZOjwGd4yXPR+Y7ofCto7apzbyurZPKovcGeJ7JLYZzZ
	 Ca/nw8IWj0ztYzIf+ORNPvicdLRhfYs9WBtbKXIdaOoJOSkJQr7jadlLlrdtCY4mI7
	 6Qn/Eqkcz4jMQ==
Date: Tue, 24 Sep 2024 17:27:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX91 compatible
Message-ID: <20240924-large-tasty-d9c45a3fe969@spud>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="auDiD+K406aHQcwI"
Content-Disposition: inline
In-Reply-To: <20240924061251.3387850-1-xu.yang_2@nxp.com>


--auDiD+K406aHQcwI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 02:12:49PM +0800, Xu Yang wrote:
> i.MX91 has a DDR Performance Monitor Unit which is compatible with i.MX93.
> This will add a compatible for i.MX91.
>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--auDiD+K406aHQcwI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLoawAKCRB4tDGHoIJi
0kN/APwL2z8F5Tglfl9QjopUlQVFIaJX5TWhJRyfpV2Aze7x9gEApES3/5oXAq4s
g/l+ZBP3l+HStihwldteR7YFVuUsuw8=
=S2xu
-----END PGP SIGNATURE-----

--auDiD+K406aHQcwI--
