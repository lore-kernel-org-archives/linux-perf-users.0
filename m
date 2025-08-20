Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E78256C70;
	Wed, 20 Aug 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710672; cv=none; b=C//Wy0Bz+Hua1h/nCnELLJf00oLOlBDlifF2/GA0smjzKc/spdryA6DVP49ygGg2T31okpuYZj5Ca060gNTwqz6+6Lnav447E4qzwjZ5BYfyCLmJewV2mc2zy1kozS8d0JaRGDH8zULJZwdcpIZlIkbBNlh84bwbsLyONUu/CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710672; c=relaxed/simple;
	bh=zK2/t7pB5uRi95w0k0HULqrZQXZoKb6HKfmiVR24b+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdjIzD7dnBOmqZC86hWHao62J7KYg9zB0EHB0Zs7KJm718SZajqrGHKNPazPrY8e4dUgBhkI3QKtHbWH4jFdMtaEZ+i1S9rQ+6zAv8QrlH0JNPJ6zkdDXLibIdxDFfh6XdGnL4+giPVlvSDznvVBTEwkzptccxww76zytQgp+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt7gdEqT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt7gdEqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CE3C4CEE7;
	Wed, 20 Aug 2025 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755710671;
	bh=zK2/t7pB5uRi95w0k0HULqrZQXZoKb6HKfmiVR24b+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dt7gdEqTTlWr9uPsmbh5dC5JHyQ4ajY1BeBLVEaA84XW568wCEGwP59iZSsYbHZIa
	 Fg2vygO7X8vp2m0Cm8YNFm4BhJ0cPlOHCvQXCj08/3tNm8Sxc4iKm6wZCiDOLd0f+Q
	 1mUo6JG+1d3EvgEjhlPdbZq2YQeh51uVV/NZel0Mz4AGEFZ9gSJf71pS09llaBr1tY
	 ErI0mCisKCney0RRErNlxuIam2AH6ODhP72wMuuXXpqF4K2jA3yjtOQ+NBoc/Vodlh
	 Q7h/cj0WBupi6f8SVmwzot9Vv7r6LhQ6Jk/BHLy4+BjC4dpexOyvP8xLGC9M1B1MRY
	 J5/PE82VmYVaA==
Date: Wed, 20 Aug 2025 18:24:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	yury.khrustalev@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] arm64: uaccess: Add additional userspace GCS
 accessors
Message-ID: <7bc27e3d-7667-4366-89bc-93a084808ace@sirena.org.uk>
References: <20250818213452.50439-1-jeremy.linton@arm.com>
 <20250818213452.50439-4-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CxxZay3cgRaUrHlW"
Content-Disposition: inline
In-Reply-To: <20250818213452.50439-4-jeremy.linton@arm.com>
X-Cookie: Whoever dies with the most toys wins.


--CxxZay3cgRaUrHlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2025 at 04:34:48PM -0500, Jeremy Linton wrote:

> Its important to note that GCS pages can be read by normal
> instructions, but the hardware validates that pages used by GCS
> specific operations, have a GCS privilege set. We aren't validating this
> in load_user_gcs because it requires stabilizing the VMA over the read
> which may fault.

I think in the context of uprobes this is reasonable.  We can always go
back later and tighten things up.

Reviewed-by: Mark Brown <broonie@kernel.org>

> +/*
> + * Unlike put/push_user_gcs() above, get/pop_user_gsc() doesn't
> + * validate the GCS permission is set on the page being read.  This
> + * differs from how the hardware works when it consumes data stored at
> + * GCSPR. Callers should assure this is acceptable.

s/assure/ensure/

--CxxZay3cgRaUrHlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmimBMcACgkQJNaLcl1U
h9DStgf6A0dCzGu8uuMoynkApBSWEG4f5HAlmVPAHWXzCcGU2w83eDn+Q9HoQHoV
JY8tRaql2Xt08gBFi2xdoJIsgVGy5vSpAqXC0gA62YDv9sjsyKAsklb8D0bv+9kw
2Omq5CiJDjBCH0eREe52xvExTcCazZeiXpI18GXPU9/D5t8cWNwIqCaQojQoEqFV
pJN+543otg+v8NN9fFgwkGlQ1vfdnIHa8ERKEYykCdx1oQ98dXonsbWnwhH1WYyw
Om6XvXeDLfnRajhgFM7gSSp1jK900upFFXeOQRPwaNgRnCcwQOeVCC+1zfIp6P1v
IfNStDtyZvXvoMdlMY7QrIB/yBbLVg==
=igX0
-----END PGP SIGNATURE-----

--CxxZay3cgRaUrHlW--
