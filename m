Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7A1FDB;
	Mon, 23 Oct 2023 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsdUSetC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A67AC433C7;
	Mon, 23 Oct 2023 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698053001;
	bh=aZBFa7fN1EH0urSii1LHTdENO3pg0U4aosD5CcywGOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsdUSetCYsPxlm2mEo2erqrcSSEMIbJPN+mwquIMS5v0zBB/zF6vOthd+ohrOuVAZ
	 UVU8ksImL8gz4CcLRlhjrMCeI/Vf2dsFqgU83vgk4pNmOc7UqFNyYyTW7pKzoOdp9i
	 Y4vY6QJg0LyHMsDiraZt8HDlO2JNBvvene6Uegl9FK0uUL/hhd1/WzE5DRS6joh6Iv
	 47DDn0lyl6SBWknnaeb4p/6fbIygzeyZrThucG0QudR/UeulSJsOBp2llQllpS5aTl
	 Pp6NYW3mNjD0amOF2TrdevqGyAWAf6SDvINhvZGhQ6VW5Mtr1w5Djz0iJqMDQmohMQ
	 uv3sSew7XVDkQ==
Date: Mon, 23 Oct 2023 10:23:10 +0100
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
Subject: Re: [PATCH v3 RESEND 01/13] riscv: errata: Rename defines for Andes
Message-ID: <20231023-splashing-dandy-1effebb9ec30@spud>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-2-peterlin@andestech.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dr6k7xdk2Nj78Rm8"
Content-Disposition: inline
In-Reply-To: <20231023004100.2663486-2-peterlin@andestech.com>


--Dr6k7xdk2Nj78Rm8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 08:40:48AM +0800, Yu Chien Peter Lin wrote:
> Using "ANDES" rather than "ANDESTECH" to unify the naming
> convention with directory, file names, Kconfig options
> and other definitions.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Dr6k7xdk2Nj78Rm8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTY7fgAKCRB4tDGHoIJi
0szrAQDpbVZqytSdG3WsXMLtVH5Uqmw9YxPlcM5oJY5NdKbzngEAsaz52IDy3Sk5
0HxrIcXgEJ5z+J2YeJShi5+5WFBDYQc=
=HAN/
-----END PGP SIGNATURE-----

--Dr6k7xdk2Nj78Rm8--
