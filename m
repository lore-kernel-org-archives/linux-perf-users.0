Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F334DCF3
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882434; cv=none; b=HBwOlZF2jkdnBmol9/DL4Nx3x1TO6qGw6aGOAkCKn+4CuxDzAuuSXg+K0U+nBwoFoNe8L4lPvqrTpyyYi7/pB080g+P7GF/MZW9uzhPlTbaCQogL0+x3+cYjb4M+gOI/OLZOOAv2QVMDKo+zTI1XgojIWSQzPsIp6/MpdnPfJWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882434; c=relaxed/simple;
	bh=ph2riAupGAeSq1uRwjbnUl6X8GorHZuNWVQs0DvZTeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xb0zi7K5TdN2A6sNYr5fQ6oOs0BPGa/k5aUa+qExVahbP3CMbWOTV5E+yzK+TC8ijqlpDjwqSolHNWuxwGNaUo5XFcoOztFz2ZQrkkpDDsEIA2L3bQx5M9xwxOA4I/KHrp4BAOg2qzD3Wt7Ysk3aH0hbIm8HdeIizNP2ch9+nSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV3GUxe5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV3GUxe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3191F000FF;
	Sun, 20 Sep 2026 05:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882433;
	bh=JbX7MejOj98ncs+zqZp9YNIpbSIn041giAkGHvcebgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BV3GUxe5fTsVVvYdP8jzrSF+ku9cETtGDkvpyKiKjoUsXR5ODm8vvpWEZ7TN3eed1
	 fCNKi31vLhyoiCh1hOhTFmhmwCdC/0/0pMoTSNdOAZ5CaF3taa1Rpmr4bIka7UUInf
	 OrXDsl3G2zLUhG2F7mF7nfX02qfBa7wz18Dks4GmGbaRpQ4m0YHK/5Eq0WFRfgZLrJ
	 xmtRNMqPXmCXxTX/CgCBQOXNwzUECa0H1fpJjs49ga60OqOuLnyIyliWXORHYwjMgy
	 ZrdkiD65DJSCAvWPWJDFntJi6Yl1z2nBUkbBomxV4tLboczNSW3OmroI5xdGSdR5lO
	 HumQlUpukBPHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 25/49] perf python: Port failed-syscalls from Perl to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5bf86935636daa6939a43ceeca772ec8f053381a.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <5bf86935636daa6939a43ceeca772ec8f053381a.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:33:52 +0000
Message-Id: <20260920053353.0F3191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script failed-syscalls.pl with a standalone
> Python script in tools/perf/python/failed-syscalls.py using the perf
> Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Support both syscalls:sys_exit_* and raw_syscalls:sys_exit events (the
>   legacy script only handled raw_syscalls::sys_exit).
> - Use session.is_64_bit to distinguish 32-bit vs 64-bit unsigned error
>   return ranges (0xfffff000..0xffffffff vs >=3D 0xfffffffffffff000) so
>   valid 64-bit syscalls returning ~4GB values are not misclassified as
>   32-bit negative errors.
> - Add argparse CLI support (-i/--input and optional comm filter) and
>   full type annotations.
>=20
> Add a shell test
> (test_failed_syscalls_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D25

