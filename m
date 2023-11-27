Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465A31735;
	Mon, 27 Nov 2023 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHInnaUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BE6C433C7;
	Mon, 27 Nov 2023 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701106570;
	bh=T9aHRJVjeoKb38nUJtTSE5Hb5iAydevh3MV0AnOO2os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHInnaUbk8vPpP53zjdtj8Uzs9Nj2hN9z9T4PL+6pq/auYsgwB4tIt8jrFjnH7/e6
	 yGT4VMvW0ZvVplmn8pTjhXkZQC5zyGqNvCAEAn3mHHedVD4bX4vTtNz9OoztTQBZTd
	 l0N6XynSXKhibqrR8mNyTJjATa+j7oUNS3VI4bltfnO2h1AYZYW2xW5Gk5bWPzMciq
	 zKH8qpySZHFB1F0+3YhcXwwqwlD98Mli5wgEyN0a06VDyRE5DOXrf0c1x/68bG7hHK
	 AsA7xIDb+DHfO4E1+oHTv+HCJjIq5664X4tjpNAEPuxMLQE6tPKokppCvyPrIM+mJ8
	 MfgUH1PFK8wig==
Date: Mon, 27 Nov 2023 17:36:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, irogers@google.com,
	namhyung@kernel.org, acme@kernel.org, john.g.garry@oracle.com,
	james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
	peterz@infradead.org, mingo@redhat.com,
	alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Message-ID: <20231127-whoever-magical-5a7cf2b142e1@spud>
References: <20231127073208.1055466-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bqCvTtn/vn49SB7T"
Content-Disposition: inline
In-Reply-To: <20231127073208.1055466-1-xu.yang_2@nxp.com>


--bqCvTtn/vn49SB7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 03:32:06PM +0800, Xu Yang wrote:
> i.MX95 has a more precise counting capability than i.MX93. This will add
> a compatible for it.

It is hard to tell from this comment, but I figure this "more precise
capability" is not an option you can enable, but instead makes the
programming model of this device different to that of the imx93?

Thanks,
Conor.

>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Do=
cumentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> index e9fad4b3de68..1bc7bf1c8368 100644
> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> @@ -20,6 +20,7 @@ properties:
>            - fsl,imx8mn-ddr-pmu
>            - fsl,imx8mp-ddr-pmu
>            - fsl,imx93-ddr-pmu
> +          - fsl,imx95-ddr-pmu
>        - items:
>            - enum:
>                - fsl,imx8mm-ddr-pmu
> --=20
> 2.34.1
>=20

--bqCvTtn/vn49SB7T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWTTgwAKCRB4tDGHoIJi
0ikLAP9tu0wxGmk25cjdbqeGdZvGn4NbjVTL5qsfZz4bjeAA/wEAvvoBXvC9fdQH
KSTCMB62c3ddeFfzxxsMDT4xgMAv8AI=
=dSz3
-----END PGP SIGNATURE-----

--bqCvTtn/vn49SB7T--
