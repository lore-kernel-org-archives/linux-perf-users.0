Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859614F7E;
	Mon, 23 Oct 2023 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfba+b57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA831C433C7;
	Mon, 23 Oct 2023 13:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698066932;
	bh=CdJMUFikVJCii5mXprW48PiT+muGUJ/z75ryr8dOT9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gfba+b579X1512dlnYUOz7QOqNdJEPRvyAvHLUmZannabB5KUp/Vd3Nm/wSp8w2Ri
	 waWiz3yGxmNns+bcqhNmTx3yAj8DjeWrGgYG+cILorB5OlTJMUMuZfwBM5P6K2opLI
	 UY4ZUWoLhQYb5c8kuo2Rqj2ltbtYQCYqcShndvP7eJQcrpkDGEqkBKUqewciqhtL4z
	 ZRHbdg0S9NouQGLv9TERVzEhsg491DHa+Nb3tYAsbl/ShQKjEBrY/bAm6jfQFNhnKg
	 n6QRiR+y6WdYy+q4hnLsqr0vNva4ufLMvhzGRqdzZQR30/A4Yj82LcIoT3QECEOCGO
	 RTAdBEBM+aIrg==
Date: Mon, 23 Oct 2023 14:15:21 +0100
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
Subject: Re: [PATCH v3 RESEND 04/13] dt-bindings: riscv: Add Andes interrupt
 controller compatible string
Message-ID: <20231023-contented-passcode-2e8d082afed4@spud>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-5-peterlin@andestech.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="57Aul/yfSew6m9cD"
Content-Disposition: inline
In-Reply-To: <20231023004100.2663486-5-peterlin@andestech.com>


--57Aul/yfSew6m9cD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 08:40:51AM +0800, Yu Chien Peter Lin wrote:
> Add "andestech,cpu-intc" compatible string which indicates that
> Andes specific local interrupt is supported on the core,
> e.g. AX45MP cores have 3 types of non-standard local interrupt
> can be handled in supervisor mode:
>=20
> - Slave port ECC error interrupt
> - Bus write transaction error interrupt
> - Performance monitor overflow interrupt
>=20
> These interrupts are enabled/disabled via a custom register
> SLIE instead of the standard interrupt enable register SIE.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v1 -> v2:
>   - New patch
> Changes v2 -> v3:
>   - Updated commit message
>   - Fixed possible compatibles for Andes INTC
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 97e8441eda1c..4c1bbcf07406 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -99,7 +99,12 @@ properties:
>          const: 1
> =20
>        compatible:
> -        const: riscv,cpu-intc
> +        oneOf:
> +          - items:
> +              - enum:
> +                  - andestech,cpu-intc

Why is this an enum rather than const? What other entries are we going
to add here in the near future?

> +              - const: riscv,cpu-intc

My follow-up question, if my original question on the v2 series had been
answered was going to be about how generic the "andestech,cpu-intc"
compatible is.

Having a cpu-specific compatible in addition to "andestech,cpu-intc"
one makes sense to me, so that we can differentiate between
implementations/integrations of this intc, especially if Andes have no
plans to move to the standard implementation.

Cheers,
Conor.

> +          - const: riscv,cpu-intc
> =20
>        interrupt-controller: true
> =20
> --=20
> 2.34.1
>=20

--57Aul/yfSew6m9cD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTZx6QAKCRB4tDGHoIJi
0lxjAP9yZzi/BFekfjYM8fNDu6y5img3GQ6JfxNOt5mf+VPcSQD/U7Y4IGJ8P8Uy
b+1kEyPrf/GAimbqTmYZqLzmAO9cNgw=
=3GJA
-----END PGP SIGNATURE-----

--57Aul/yfSew6m9cD--
