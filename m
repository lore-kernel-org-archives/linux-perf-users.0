Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114943A9629
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742208; cv=none; b=koLcvx+gU4wyP19N18tp4yCB+pIcjrnv9wpg33rSB9UuFAV+s5LeNG3I3OLb79kOpc4z/Ygp9FmY+vyHZugUxfW0ezFGQ7N3QE9QggdlQwIj5ZOrT/U4wJSGhSmxayFwIbU+madHfXNV4tpUFyScnnLrJdlfQBEMsfsEd2Dssik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742208; c=relaxed/simple;
	bh=oYjn/k7ZO5+5ixL/xUHyyImgPlMlqzGxE9svquH2YT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XaQ3i3/6lPzz14B1ONnI3QmlMUDD9qtIvfDKJi1nYPlQ2P08DpMA9ZZ31w39aL8mA4HNmwhip/Wb8cUmOcveBDFWlgJphXqDYzHL5SkGov8XcTzFzQ7KPVWc2pTdDzn3/dwXF9lfNzvoWvou41PTAFhDXo54b+hOAp1EB1nzjpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgPNaGsB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgPNaGsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899991F000FF;
	Fri, 18 Sep 2026 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742206;
	bh=oYjn/k7ZO5+5ixL/xUHyyImgPlMlqzGxE9svquH2YT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mgPNaGsBHp6DrLaElpu90IWxAz4h7UTa9Br1a1XJoy7bvsCy4jOUeZ0F3jaLCqgUv
	 sFyNnSucTv+tMW222ZbtrIU4zBYJEm8gW2QwFysG18XabBmvWzBwCb7oFA1Uw98i4y
	 cKVLpXBpuBBI0DHiKz2jmPwMKamWSjT453VWJAUVW8pXn3JewucQfntmiSzpvbv/7S
	 /b5m0U8YZ6etirTQJEspH1pq+3waXYuS4qiqLjiziCOvY9jUkShn5PIplX/fpZw68J
	 Hsm1GfHbsUfr+VtX7auiOuV46GfmZa+rzOwDQXbFv3Lr5LZCE2mCIgkMne+E7OayrM
	 hGQjXcDxMJLmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/16] perf test test_task_analyzer: Isolate in
 temporary directory and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-10-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:36:46 +0000
Message-Id: <20260918143646.899991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> test_task_analyzer.sh writes perf.data and temporary files directly into
> the current working directory, causing collisions when running tests in
> parallel.
>=20
> As a temporary measure until `perf script report` supports an input file
> option, resolve perfdir to an absolute path, change directory into $tmpdir
> for the test duration, and clean up in the exit trap. Remove the
> (exclusive) tag so the test runs in parallel.
>=20
> perfdir is derived from $0, which may be relative, so it has to be
> resolved before the cd into $tmpdir, otherwise both PERF_EXEC_PATH and
> the cleanup trap point at paths that no longer exist.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D9

