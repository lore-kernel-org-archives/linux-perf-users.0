Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958036CE02;
	Wed, 20 Aug 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703553; cv=none; b=dvpcwFBpy4r3V3CkcXcvB5UMibqRV1wuTu76XK5n96JMgvoJuggx0IQVjDbtK1iYzQWxiwZtiknIkxPsdASnsW9PFCXEXvYKmsnqkOUpkYNuqwuqdrfZ/9ygNU7F2nzGObJaDSCra8NB/vv8CqSiZzObKrMTcmQfXTyfCR5YfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703553; c=relaxed/simple;
	bh=P4Yet0T9nXdDf0TzNjDPSNwIP8HqdY1hreVkpB5uhwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl3HQUN9L1WzB6XIQnc4ZRqAG7hKIy9oTecYd43j3fw0bBOWOQZffu8JJHdZcEzPXwb7araRrILRUdtAGWLo4Q2lZxqy7/y0g5XPhRL2BjRRkyEaH0dah8GCgXSv8h+Bj9e68IvpzVHyZWPScqkjWG2tdXY2KRQ9iOz1KPIgdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3Z2VO6w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3Z2VO6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2EFC4CEE7;
	Wed, 20 Aug 2025 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755703552;
	bh=P4Yet0T9nXdDf0TzNjDPSNwIP8HqdY1hreVkpB5uhwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3Z2VO6wmW//9zhhtUXtoi55A2/d+Bo/ZKRDlRbz2cEkQ/dL0t2w/ErA5ehi4jZwS
	 6kACZ2+ZW2lii9qfgDZoo5hJhCtdhAK7VkdW5WYr1V9HJ/SVKPWQlgYI+JsL//l6En
	 xChUjX7is6N1KUjZC9BA3KW5d52XDA1UJMFw7xRotrNTM2i/VYqdyNN1Vv97uosL/u
	 aON+Fmkdpq+z+bmLM+R2nAi3swworY2XJlP57A9TUv7CnMMCZ4mg4DWuw86KlzepU1
	 Jtpq6j2ecy5AR+LTg8n+Su28bOsXAgVhvgJWJwwxjelg87FOm1cbGln71C2kY9fItM
	 TW4C/44bDSTTg==
Date: Wed, 20 Aug 2025 16:25:45 +0100
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
Subject: Re: [PATCH v6 2/7] arm64: uaccess: Move existing GCS accessors
 definitions to gcs.h
Message-ID: <a1a7631a-066e-48e5-b8c8-d90b9cf4455d@sirena.org.uk>
References: <20250818213452.50439-1-jeremy.linton@arm.com>
 <20250818213452.50439-3-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UokGFqJlJ5Wl2ADc"
Content-Disposition: inline
In-Reply-To: <20250818213452.50439-3-jeremy.linton@arm.com>
X-Cookie: Semper Fi, dude.


--UokGFqJlJ5Wl2ADc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2025 at 04:34:47PM -0500, Jeremy Linton wrote:

> We are going to add some additional GCS access helpers to gcs.h in
> order to avoid some forward reference problems with uaccess.

> +	/* GCSSTTR x1, x0 */

Should really be [x0], but not super important since it's clear.
Otherwise

Reviewed-by: Mark Brown <broonie@kernel.org>

--UokGFqJlJ5Wl2ADc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmil6PgACgkQJNaLcl1U
h9Cs1wf/euB1pOQe9ocxRSjAjirM7narDyKReS0sLCltciEqP2/zyi7/GsIAJoAy
wdlwoBGhMOJ4KcLCNo8AYzddvotkuApfsrNI3aqPD8fMWIW4kWJOH3csggWeyXw3
aXQzwU0NqiX5NyeBiBApZDHFzbRy5qN9uUsfroKxKbmtCd41GSbhQvXqZKfSMlZ8
rpdR9cPqQLz8o2EZcYGLurOq9144T9/jFOqANYePa/J8Wr4TrpNP5fQIKDlxQefQ
/wQB0DyMg/tV9LYDN4fvVRsdmX2TsQ7/gsLKAkM+2ZcTfI1cplnkBX7Jl/NFpnyO
J80JCwW8IFpm6Bx33Z5i9z33n2ZW0Q==
=58Ws
-----END PGP SIGNATURE-----

--UokGFqJlJ5Wl2ADc--
