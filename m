Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EC363C6C;
	Mon, 22 Jun 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127130; cv=none; b=XJoYnayifZ5SYvbVDRx+RCzQnvFjN7TT/6BZTtpG6u8ECOpzQzTYCZdcRE39c0WQHEBWdw5qLuBLA97GFQYbyqIA/H3XZg+HSzOQvVx8HrJbemnLbXp+EX0sIlPeHmXmECSHJCRBQQLu3fwnoeBrwnWM056H11axb521VuSKeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127130; c=relaxed/simple;
	bh=+tRbklp4JyVHoRJa0C03ZnQWszBvWY01Wq7DwFQYmI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8svfCd60RbL/GScliT182LRD0jxYugTFHRuCEsQSdZIxAk7U45rggKmNUUqQMcyPmKXKdm4Oyo8JKiukk7R/e3I/Ko+IS4tCuTCwtLZkadYxbU9OuoA6UYa20If8/3I3thqGCVVC4WSvMLZ5jfp3sgdgoUz/Yz4MrCkbB2NCzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmgusW4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmgusW4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8787E1F000E9;
	Mon, 22 Jun 2026 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782127129;
	bh=+tRbklp4JyVHoRJa0C03ZnQWszBvWY01Wq7DwFQYmI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LmgusW4jDrmBUT/eAFkXAvwfJMyBz+vLFVpuVqYb3HtNF1Mj6htEtV4TkaDBBe9wY
	 5hrXYzIiKqXTDLbvvJ799z7retUQCMB9SzQ25jUwo1cuSLt/OAS413Mcs2WLJiAEJB
	 s6nNvEWIsPAZS8mHuiXsINf+xb/Esbz1Rkxjd9VHufUxSQ9O5lligX5r2MOOfzFj+w
	 lBijp3tBqIf28mQWmGT4Oi6u/8Puya3NWb8qHrUM+vj+4PRkPEE4MC5aRYWrg6sJ7T
	 DIjnrt9VtvADiWUULrt5MxirrDsJ72Y88bfRc8JWndTDBsEgm9lm6QjnTZV4UiY9QB
	 IPJguB/PCSnGA==
Date: Mon, 22 Jun 2026 12:18:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnaldo Melo <arnaldo.melo@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, peterz@infradead.org,
	acme@kernel.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH perf] perf: Fix btf_vlen() signedness errors
Message-ID: <ab95c312-061f-47ae-9202-432aa48afa70@sirena.org.uk>
References: <20260622103418.579115-1-alan.maguire@oracle.com>
 <ffdbf003-5f08-4db8-b633-7ed053a738f1@sirena.org.uk>
 <A52F0C17-9617-4F5F-9537-C9643F5EF347@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oq/IkiI7LiR5Mfx6"
Content-Disposition: inline
In-Reply-To: <A52F0C17-9617-4F5F-9537-C9643F5EF347@gmail.com>
X-Cookie: Now I am depressed ...


--oq/IkiI7LiR5Mfx6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2026 at 08:09:33AM -0300, Arnaldo Melo wrote:
> On June 22, 2026 7:53:40 AM GMT-03:00, Mark Brown <broonie@kernel.org> wrote:

> >which I have been using as a fixup since I originally reported the issue
> >since Linus' tree is broken, Arnaldo said he'd applied it to the
> >perf-tools-next branch but it has not yet appeared in Linus' tree (and
> >it looks like he forgot to push it so his copy isn't getting picked up
> >in the merge either, the last update was on the 15th).

> Its here:

> <https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=776bd9ac834556ab6ff6b7ef74b71ac53d37855e>

Ah, so it is - I missed it because Ian's series was applied on top of it
and doesn't look at all like fixes so I stopped reading the log (should
it be in -next given the merge window?).

--oq/IkiI7LiR5Mfx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo5GhMACgkQJNaLcl1U
h9AFigf/XgJRcsNoFgPtFedtsEkd51aXQDYp6s3Z0dlgtnILwLt4/10BJuc9fa+U
RDo6VWSUJyX5ySqhcmzximoBHMaiIhv2cviDvHg5HggTiCvn8ge5ZP4nEKIYqsme
ce9IlKiufyEmH1VW9NPH4l/PWWccvgLPmycxrtzfZhQ5lIneyhYsVPcnafVu8Ur6
T741PjpHBYEpBmvqb9RvPs7ncTxi3uoTIGXubuUl5iD6dt82x/+T8iKtyL+Yc58B
9/JY5gX+yvQsaclcty9KkqfhETbR7s3OVhDrT7JUA3TfyN4EgPHm63epat9EJOIZ
igFdLTqaZfkjOSb19p/CHck+zaEGNw==
=gmzP
-----END PGP SIGNATURE-----

--oq/IkiI7LiR5Mfx6--
