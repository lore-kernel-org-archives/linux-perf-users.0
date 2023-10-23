Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41720F6;
	Mon, 23 Oct 2023 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jADyhn3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCAEC433C8;
	Mon, 23 Oct 2023 12:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698063930;
	bh=pPk74+A5jkmqRdGnbaBEtM5+7L3q3Pdzznl2EygyWmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jADyhn3KDxsVw0aQWNmTregKnwEQBXXcSO49wnCXUkat73pY1hI6KtDnDFQm34yNX
	 7MvHRIx6WL0/cr0s+SK8wS+umGybz2ywN6GuGJC+h5cwD6EifeF5Yk9iUAbDHVrZiZ
	 M9PM0A47pVnRQOKjDrbDLohtInrVJPP7UBLYPglWs/N3lKwNjGeI9gTbM1/uFN1TVs
	 1hIkOP53y97pl2AyOOlYg6AqlBMutyS5PsKih/qqjwfPluxI3+/TVLtL85yMRfmOQD
	 5YTDUdsWTh2M5gRS7LH1ewaNVErSW7f16kdbtGU1DJ2meXbo2aUH1AJFHtx5XHAOAw
	 Mp0AjZVVBiRIw==
Date: Mon, 23 Oct 2023 13:25:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
	anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
	conor+dt@kernel.org, conor.dooley@microchip.com,
	devicetree@vger.kernel.org, dminus@andestech.com, evan@rivosinc.com,
	geert+renesas@glider.be, guoren@kernel.org, heiko@sntech.de,
	irogers@google.com, jernej.skrabec@gmail.com, jolsa@kernel.org,
	jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	locus84@andestech.com, magnus.damm@gmail.com, mark.rutland@arm.com,
	mingo@redhat.com, n.shubin@yadro.com, namhyung@kernel.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
	robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
	tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
	wens@csie.org, will@kernel.org, ycliang@andestech.com
Subject: Re: [RFC PATCH v3 RESEND 09/13] dt-bindings: riscv: Add T-Head PMU
 extension description
Message-ID: <20231023-facility-phonebook-1be493346bf1@spud>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-10-peterlin@andestech.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qxXWr68G1YeFpESf"
Content-Disposition: inline
In-Reply-To: <20231023004100.2663486-10-peterlin@andestech.com>


--qxXWr68G1YeFpESf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 08:40:56AM +0800, Yu Chien Peter Lin wrote:
> Document the ISA string for T-Head performance monitor extension
> which provides counter overflow interrupt mechanism.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v2 -> v3:
>   - New patch
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index cc1f546fdbdc..5e9291d258d5 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -246,5 +246,11 @@ properties:
>              in commit 2e5236 ("Ztso is now ratified.") of the
>              riscv-isa-manual.
> =20
> +        - const: xtheadpmu
> +          description:
> +            The T-Head performance monitor extension for counter overflo=
w. For more
> +            details, see the chapter 12 in the Xuantie C906 user manual.
> +            https://github.com/T-head-Semi/openc906/tree/main/doc

This really needs to be linked off to a specific version of the document,
lest there be revisions that remove the document from the repository and
to one that is in English.

Cheers,
Conor.


> +
>  additionalProperties: true
>  ...
> --=20
> 2.34.1
>=20

--qxXWr68G1YeFpESf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTZmLwAKCRB4tDGHoIJi
0mvTAP9Q91MnqFwF0cSPMA8pl6M5OOys/V88dfOQPFy4pUXhywEA/H8ZjdArLD56
bf3grpubAS0ckkD2IOWbV6DHx3P86AQ=
=TH1A
-----END PGP SIGNATURE-----

--qxXWr68G1YeFpESf--
