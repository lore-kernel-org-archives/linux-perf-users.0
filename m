Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41F2E3F5;
	Thu, 26 Oct 2023 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6xjc64F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FC4C433C7;
	Thu, 26 Oct 2023 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698329381;
	bh=o+qCmd2p2pNBcodf0yPjWJ37AbBRRvl8Nu1y76ub5Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6xjc64FizKqY/UFZYzRexqwanb6HD1mvGz5Mjl2Oe/EWUThAH391tDMEG60AtLAF
	 n/69z9xHH1rbXwDaQM/Ng+Z9f+CnRVd2alD7vxO1Be1OIyvzcNfMYkybzD55tObSPw
	 vkGW/4TFkvQwrwqJh5hZcGo9Sslw/YHNXh17Ez6jyDxXZBN3zRYl2mumQGfSY7+NIc
	 LeGuyM20Yphheryl8vCIlwO9SnpaYfHeN99qsy+4WKt7z06ZpbKBkVK209nQIetQVV
	 M/RuSLZ0PdIi5fBoJ0XxCaiEcuN/QFzogBlfwpcDK0cPOVYC5wjRS05wcUD0j26hH1
	 u+Gy7TnP/udVQ==
Date: Thu, 26 Oct 2023 15:09:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Yu-Chien Peter Lin <peterlin@andestech.com>
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
Subject: Re: [PATCH v3 RESEND 10/13] dt-bindings: riscv: Add Andes PMU
 extension description
Message-ID: <20231026-concierge-perfume-6c327fc5282f@spud>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-11-peterlin@andestech.com>
 <20231023-spectacle-module-0516fb35995a@spud>
 <ZTohvi7TPyVoO-Sl@APC323>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BzI6JdR1d6DrVYK+"
Content-Disposition: inline
In-Reply-To: <ZTohvi7TPyVoO-Sl@APC323>


--BzI6JdR1d6DrVYK+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 04:22:22PM +0800, Yu-Chien Peter Lin wrote:
> Hi Conor,
>=20
> On Mon, Oct 23, 2023 at 01:03:53PM +0100, Conor Dooley wrote:
> > On Mon, Oct 23, 2023 at 08:40:57AM +0800, Yu Chien Peter Lin wrote:
> > > Document the ISA string for Andes Technology performance monitor
> > > extension which provides counter overflow interrupt and mode
> > > filtering mechanisms.
> > >=20
> > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > ---
> > > Changes v2 -> v3:
> > >   - New patch
> > > ---
> > >  Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml =
b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > index 5e9291d258d5..e0694e2adbc2 100644
> > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > @@ -246,6 +246,13 @@ properties:
> > >              in commit 2e5236 ("Ztso is now ratified.") of the
> > >              riscv-isa-manual.
> > > =20
> > > +        - const: xandespmu
> > > +          description:
> > > +            The Andes Technology performance monitor extension for c=
ounter overflow
> > > +            and privilege mode filtering. For more details, see Coun=
ter Related
> > > +            Registers in the AX45MP datasheet.
> > > +            https://www.andestech.com/wp-content/uploads/AX45MP-1C-R=
ev.-5.0.0-Datasheet.pdf
> >=20
> > Does/will this PMU function identically on the other CPUs that support =
it?
>=20
> Yes, I can confirm that.

If there's a more generic document available, that'd be good.
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--BzI6JdR1d6DrVYK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTpzGgAKCRB4tDGHoIJi
0uXdAQCoseBoG7Xs6hmuy7UdTh5kG8f+pMwygEI1z4FoVKXYlAEAttRxz9XXoQKp
UzeNDgGlP1WLp7aj7fbSai8IToBZtgM=
=eR7X
-----END PGP SIGNATURE-----

--BzI6JdR1d6DrVYK+--
