Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0992D3731;
	Wed, 23 Jul 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269207; cv=none; b=W0gISWEdmwEI6vM7EPis8ZgtPb2D98TEgmrddM5Bl1Zr0mWqM8eZOkvb3xrGmtiVM1MCT2aqUNBSUwVAttAq78EVB2EcIkpk+W4fdtHgtsnzZGbjLpj0D1B8XeZLGXq60F7g92XREJgd6SuP9iviQ9doeGdW8696MlN9XjBDY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269207; c=relaxed/simple;
	bh=QS54HACGbgdMRs0EaSON+Zv0IttzLgk3Dxvba53hmEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6wtHKltfcrQl6Je2yggkGsDmVUKIPD4awkGmPfNswLYlDqd5dC/2+b0nHR/VkkGkRajXXzHVJtUQXcw0GcTWCMivWuN5XzjSglUnET6gMgxW2hPams+gVPM4pm/brYeo6o+zGoyYZ+T3Lsi3H5PJzL6P8lOGghoCd2gCTiTYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VveC0p42; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VveC0p42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D80DC4CEE7;
	Wed, 23 Jul 2025 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753269207;
	bh=QS54HACGbgdMRs0EaSON+Zv0IttzLgk3Dxvba53hmEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VveC0p42ztQD01MnFfZlI0VMLsO/8qZp7VAoH72GvyCT1o3tfOA0XyRIjPFW5lYAi
	 k/cIVCxaOvcMxuF8JK4oly+Gb+x9y18pTR8ZJEjd8EVkpIBuCRWDBWQUpbwfP4Q2eq
	 +lPnxlk9lnVBTy4tpisJi/Tfy/ztJCXogsJqF913H6al3HBi7BHxRzVLX1pvKOUDSD
	 u4nKNy3+XCK+OZZ12lH1OFoU2zW/+/VApEeCOQFhw2tJeQc8mtur2z1ClR3ALgloY8
	 Ux9hfdhPXUvJYr0p5pe8eLDh/7We5RJ84askLuSNAHurpDXmcxDapbMFTnS9hOs+mi
	 r4bOPw4jHoiAw==
Date: Wed, 23 Jul 2025 12:13:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org,
	oleg@redhat.com, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	yury.khrustalev@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] arm64: probes: Add GCS support to bl/blr/ret
Message-ID: <75faf0ec-79ee-4631-91d0-535c81c1bc85@sirena.org.uk>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-6-jeremy.linton@arm.com>
 <aICywZ55EKfSYSIY@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LlK8+g0AOOO1HzK1"
Content-Disposition: inline
In-Reply-To: <aICywZ55EKfSYSIY@arm.com>
X-Cookie: List was current at time of printing.


--LlK8+g0AOOO1HzK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:00:33AM +0100, Catalin Marinas wrote:
> On Fri, Jul 18, 2025 at 11:37:37PM -0500, Jeremy Linton wrote:

> > @@ -133,17 +147,26 @@ simulate_br_blr(u32 opcode, long addr, struct pt_=
regs *regs)
> >  	/* update pc first in case we're doing a "blr lr" */
> >  	instruction_pointer_set(regs, get_x_reg(regs, xn));
> > =20
> > -	/* Link register is x30 */
> >  	if (((opcode >> 21) & 0x3) =3D=3D 1)
> > -		set_x_reg(regs, 30, addr + 4);
> > +		update_lr(regs, addr);
> >  }

> I can see why this function was originally updating PC (in case of a blr
> lr) but updating the LR was not supposed to fail. With GCS, I think we
> should follow similar logic to simulate_b_bl() and skip updating PC/LR
> if the write to the GCS failed (assuming that's what the hardware does,
> I haven't checked the spec).

Yes, the pseudocode does the GCS validation before it starts updating
BTYPE or any of the registers.

--LlK8+g0AOOO1HzK1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiAw88ACgkQJNaLcl1U
h9DmBQf+NT0Xig5/CJmpAvlNNkwAL72NZQH1v7bPz2tbKiHVjN1NwtBf/kvxhpEJ
RMMUpmeXdnzJLb5ivMwiO+8bgLYvs+ac79pa1VQYELxVclezQ/cjk4wH0S4PH+gN
neW8Elmceqi2i9Qdf5Bsk1bBwytFluoTnYxoivJsYUCkOR+Fd4ERBYdixoqjJ0iK
+aORZ60biBcK47nd+hg41RbXRPovvPqiaSlwQFZaG+xaujmlKiFVA9raaxu6s/J8
4etrlu666ZIaJpv0Dt559+M04Qi3MOld4/oJZcDMPUWyTxCpHV8Di6eEOAKTnRSn
W8tJ7fswvUHErMIkOyCePEMdE1dAHw==
=mw2L
-----END PGP SIGNATURE-----

--LlK8+g0AOOO1HzK1--
