Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CE35970C;
	Tue, 10 Feb 2026 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731827; cv=none; b=fAqhJB9hHXRYwVSHKGSa5Ji0Cs5lmk4Pz9wx9/FuB5OJcOfrV4UBgtw6zGPorVKf4xKs9sE6kgWRMtdjihakchPPwjTde4rm9iwpXp/3S7huD2ufvu6wxBkZ6ARWhS0w+Fn+DsavXAIhTxz8kESs7Dcdnp8pCjLiGD83WaHXum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731827; c=relaxed/simple;
	bh=55wFZL+uzbFxr4PiPUySADAPP012r1vAk43VLTCLL7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItV4esbn/IV+QUece3ldSvzVvXi97bVc3JTmQ2kLuGhqFIS3goqEsbcVsCUFdVmUnBgBfMHF8YHSAcjdlQ3kLUns7D4zoOyjm5KnAOiFfW2BEAj0R87uRd8TXKymBomzeoqCQjLoUUsrVhebbH3ANExL0K4xlJs+9HaT813aP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfuHjZ1E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfuHjZ1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ED3C19423;
	Tue, 10 Feb 2026 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770731827;
	bh=55wFZL+uzbFxr4PiPUySADAPP012r1vAk43VLTCLL7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfuHjZ1Ezn6ob3R4U/9vzfaFlqE3OXJvGBp2ImOYg3Hry2B2rW/DQ2ww0YSI2ogmh
	 cUT0Wa+mhNUj+X9B02G/cL6rBu2ydq1UbWspGTs7ycyzsd9ANOsl+mdqmC81zxsAnn
	 ockFIRk2qAbzO8VpGlFghTvyDvapnte8vzUqIS3rxeHCI7DSYD+JVDil5/QFzVqwI6
	 hkKhryuyhPMoBqbRSFAJ3rd3DpY87+loNPAv4DlA2EqwaMoK9FLrjVKimJPPfu+F+/
	 54NwhMxxg7ZkOtEheGdCxAwcT5h6FLzXSJeFw1PBH8scQMJYpasTw6+KiIXG9JvPbz
	 c3BYvQP51eKhw==
Date: Tue, 10 Feb 2026 13:57:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernel test robot <lkp@intel.com>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v1] perf tests workload: Formatting for code_with_type.rs
Message-ID: <13747e01-e7f2-405a-bd0c-5b8bac7f328a@sirena.org.uk>
References: <20260209140533.194251-1-9erthalion6@gmail.com>
 <CANiq72mW=hcvUGt=WENRiYVeVbb2bnYzizE00Eo-MW3b_MwRrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9tgDTr7Bo8VPpa+b"
Content-Disposition: inline
In-Reply-To: <CANiq72mW=hcvUGt=WENRiYVeVbb2bnYzizE00Eo-MW3b_MwRrg@mail.gmail.com>
X-Cookie: Spelling is a lossed art.


--9tgDTr7Bo8VPpa+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 10, 2026 at 09:56:36AM +0100, Miguel Ojeda wrote:

> Cc'ing Mark since I think the plan is to check in linux-next.

Yes, I was going to revisit this after the merge window - hopefully all
the fixes will have landed by then (clippy was the main thing IIRC).

--9tgDTr7Bo8VPpa+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmLOS0ACgkQJNaLcl1U
h9BRDAgAhebdp1Uo8be7088KdqdBbyjw7nwCwf/QZ+7RpVViHnpzlGqPljJKGeXl
Tc0EH4R3Y056CxkFd7YSY3I2vIQl7Aj+bElkocrZ+ipx3lWa9ZN6UfU8zSTnGADF
N0lBtLzF/m1GWbtHqZ7gXEoftZGzgYyB9SnjK/Vne9fnEhpu4uA+/W6MnRNk2uSQ
D7tP/7MlOr1alyOIOKcUbZeojdIIx8g5Fx0Zd5jLAF8eHmjJ1ZJYDQsc1dLlxJCf
dfJyr9AZS/Ly5SGQFKk5ka4EeAeXQtFcU7gyhf/ITxdqEIfQZgG10u+AmvgnwTTM
h+Pe64M1fQxAGeB/3voFw8cPg5JPpA==
=inpM
-----END PGP SIGNATURE-----

--9tgDTr7Bo8VPpa+b--
