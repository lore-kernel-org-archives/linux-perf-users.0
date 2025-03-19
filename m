Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3F254B1F;
	Wed, 19 Mar 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389950; cv=none; b=TlOOmgyo6v//XA1FbON8MLOssqLkC9jYvOj8yRPciLW8VJof8fumvgaa1xBNFi4eVxjk/cehlr3oZLbO2/QZlr0u5Bjb2yH/xVcfewJX0TPRV9RDuIsNqYL3ttPcAo7LMSYCpAk90s0BFpwdmRcxhp/7lgqH61QfwCxrtbO96zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389950; c=relaxed/simple;
	bh=n8hPagKbPuB7fz3X5Lg3RtNaeLruTBVSj3aHYFgk1NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En+nGQ3Ewk5g+gJ9ENHL6maqj7hVAhmWI+BWDjy6qVQpfmRQRZUbiKfHvONdS4ZlI37W78JcCJfKNjwnUn731OAmGDPwP5PfJY5wqVxKXhslCzPh4/pbyMJfELeyi03DpIaVm2qTF2Ym8Vcrj+U4tLK6Hh/chmrrslceo1YYmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+abxySm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+abxySm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C931C113CF;
	Wed, 19 Mar 2025 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742389949;
	bh=n8hPagKbPuB7fz3X5Lg3RtNaeLruTBVSj3aHYFgk1NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+abxySmgb4KrrYS++Faii+ngdDbuQnepKCNH0eWm/3AxasnpSlOD+o55gBS2ziTp
	 eW3HpEv3Dmi/vb++HC/wq6D761CMKQs3JU6OcyNFoZccZpc5r2HviaakBG+SFNgGPM
	 Tnz0KiW/EOztzT5M+CqG6IFs6w61wAc6IEtboo4isx9K4u4+LWWbokF3hNTfxiWBBW
	 MAAhzwy3Gyxvsm4A61Km6KNR/Og7i6rx9ZO+Zeso2frWa3NwvDdwo+MYfD4qDFpSMi
	 SBtQm7hDwYDe7shG5qVc+AFlwYMAAx5oopYqTrGeOG8kmyo7YPmMU9B9sIgB/jguJZ
	 lqe1+Ilkx0zHg==
Date: Wed, 19 Mar 2025 13:12:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	yury.khrustalev@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64/gcs: task_gcs_el0_enable() should use passed
 task
Message-ID: <979bd797-6f92-4195-989c-9a004d0d018c@sirena.org.uk>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-2-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1WyOTuvindCPGRH2"
Content-Disposition: inline
In-Reply-To: <20250318204841.373116-2-jeremy.linton@arm.com>
X-Cookie: Chairman of the Bored.


--1WyOTuvindCPGRH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2025 at 03:48:35PM -0500, Jeremy Linton wrote:
> Mark Rutland noticed that the task parameter is ignored and
> 'current' is being used instead. Since this is usually
> what its passed, it hasn't yet been causing problems but likely
> will as the code gets more testing.

Reviewed-by: Mark Brown <broonie@kernel.org>

--1WyOTuvindCPGRH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfawrUACgkQJNaLcl1U
h9BglQf/V4W+8RCMCKLae1WNVlW6t1laAXA8fGzyIRqPpHvOyM4r1/FEClh5LLsW
25z4xfwfAm58qvknNwr2f8qh1AltjRq7pTBqxYynX2pr9EVY71ZhX4QtuwAPMz1K
c7kwvxvQjvMBgdhfL4/eS3J2nEVB0P+sesI3eflrcVLoHR7mGX4r2BhErXo6qXyk
gtOemiHpwbzjLm4vV9q7lP4egKPMjSAwv3qe7LaNSTzYXBtUvUYZrTOTI8sMcLn3
hEDf7oukp0WiDeAvVS0hW5UdtMnNAZPTmxaZ+jvp9QCXFQFLYLZ1oJiWfBOaDzpH
QBt0vlj3s7lgFRbcxMqTKiDQCUdWYg==
=oFyA
-----END PGP SIGNATURE-----

--1WyOTuvindCPGRH2--
