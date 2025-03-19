Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCC1DEFD0;
	Wed, 19 Mar 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396597; cv=none; b=LorPyHPVtID4bjtjOrJ7YuMc+eA8bl1ApDZGIOxcyzYLWVd1euehncv26ibGlawuSjTGp2kZSmlrRJOuR+1FIzEVtuzx/r3cDgGFRFhZlRg7VuQtpSl9i6z6t0dXKy41sJqDAVoEOupdA6lLwHER6o8Yw1Gwyuaf47eimxH/oNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396597; c=relaxed/simple;
	bh=HclihVpXgk0jrr62do8J69IkyByKRZp2wtFVZiiJRQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et/68692jGPRClRHYJwm0v2VX/IhXc5Yn+i2aDqpPY+FImCx8LVJrEdqCIfXI0wOlVU0qLqT2e/JqBRMMXZ6H3IkUN4/WKhx3bPo0fsIybzBFFa9v1/lv+89IESXzuf3jZfF8dq97eEKz6NOOgKKDQt6j8Nb3/CptIX/Kxxp/+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp6K4Gh+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp6K4Gh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64FEC4CEE4;
	Wed, 19 Mar 2025 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742396596;
	bh=HclihVpXgk0jrr62do8J69IkyByKRZp2wtFVZiiJRQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cp6K4Gh+NZkMbIyjiZ0GvBEXE7Qd5VdMfO/4RAKaAvRnS34WkEUJPYL4W8RUoQmBJ
	 caQS2OFuULUtauywOOT3OxuGAsH75qMhrI/08ojMIkOwmtP6ZlybfEonHmAxJHl9kK
	 9iJ2BZXiOCNJYdj/mk5zmCwpg+gnDTWluUx2olgTDag7EBwdvR/1bRFacDmJ/n0eYF
	 DiLmOk5Usx50bxTVD1zakUWSc2j6PE4JS/TwjkkvVHBna6lq+VHxV0gInIFW7V5QjG
	 ScJRDfhbzPi47A5Fsmjp3b9BMirZALrxkRzCGOxCG11qZPBWjyUOEHIt1UpO74GCD0
	 PM8p7ODboWErg==
Date: Wed, 19 Mar 2025 15:03:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org,
	oleg@redhat.com, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	yury.khrustalev@arm.com, kristina.martsenko@arm.com,
	liaochang1@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64/gcs: task_gcs_el0_enable() should use passed
 task
Message-ID: <ad1408f2-8a6d-4299-b986-0bacc58ad388@sirena.org.uk>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-2-jeremy.linton@arm.com>
 <Z9rUEtZtNXhVnarO@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NGfq55A8VzV+mIR7"
Content-Disposition: inline
In-Reply-To: <Z9rUEtZtNXhVnarO@J2N7QTR9R3>
X-Cookie: Chairman of the Bored.


--NGfq55A8VzV+mIR7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2025 at 02:26:26PM +0000, Mark Rutland wrote:
> On Tue, Mar 18, 2025 at 03:48:35PM -0500, Jeremy Linton wrote:

> 		if (!task_gcs_el0_enabled(p))
> 			return 0;

> 	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;

> Either that later assignment is redundant, or copy_thread_gcs() was
> accidentally relying upon task_gcs_el0_enabled() reading from 'current'
> rather than 'p', and this change opens up another bug...

copy_thread_gcs() looks buggy here - we should move the allocation of
the new stack to the bottom of the function after the assignments.  Like
you say it does currently work due to the check of the source thread.
The other users are the prctl and signal code which always work with
current and the check to see if we should do a GCSB DSYNC in
gcs_thread_switch() which currently misses a sync if switching from a
non-GCS to GCS task.

--NGfq55A8VzV+mIR7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfa3KkACgkQJNaLcl1U
h9AbQQf9GI5AtUO//K/8Gy4mhIDfDlvWsjZdKRMBiiIHubVULhGZnR9v1l5okpF2
HM45GQmkuSrKsUdEdJV/2YYmImOSWFfNQ7JtRnaLuzCLVwUOwapORITO66qcBKWh
ZKVZa8sIgDulT/x6Cq+6icfzYt48OBXwEL1+BjVO4p4LhI49aSKN6EAUQgtjKhyG
NCRfC23CZxMN+Kb33saQHUzM3puEvqUofm39LdGfTGnX45t6aHobfOYFOcvhtcTD
zK6Pvv+EeQqkGIyx2fghHjd/MqHLSWc0xSMtmEZ6uNaQQqaNJPWpLRFgPThdZ+R+
HN4ExJenZxFQCTmRnKxGC2nTiYKkWQ==
=Avuv
-----END PGP SIGNATURE-----

--NGfq55A8VzV+mIR7--
