Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196274E325C
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661036; cv=none; b=lCQFe2ZONA9gcILJm8IYjF6rIaqPk4hC9CTXKsWb4kKWeQEez5x2cCez/pSvnQ/4CTUuECNsS531OkMhaGbT6H/xR5XHCkvIUPzEM/sY0p1gaqCb6anB/nF8au33uphz8X0xjISOikmMqJQpPuNpaUEoSyt8EKmcR1rjoNR1aFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661036; c=relaxed/simple;
	bh=4EYTiC4ZEJF3qAw+pOpPsj6G3CwPghUhFHKaqvmCKm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfqISMEnaf6Hy9MRkRabmYEf5bRPkO6A8FW4mxkdmhnKeXd5Bs+b9KMhK2mhIeONyoNc6krJsOnYIuS0gOy3AgohBJAea4bMrqUpib9Zp7oliaGJ10fP/Hqml3stBIDRTy+78PB5uIK5yqiW3LLAG1x2cIplfxOpxsyzUH2LC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuUeEABL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuUeEABL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B247E1F000FF;
	Thu, 17 Sep 2026 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661034;
	bh=Xf9p8XyUKBXOjKn510SDlz2sAUfrkc7RINjjThcgnQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DuUeEABLzHl+JvMEZdOKHizqzYsBcQMR2HF9CPpHjLQlEecPHjsyiD1L+uusqDvCW
	 sYdmxDpVNqiJadsg81ztQxXGYYK5yDKZQeW0f0USM7J7MepFpfaFgaAxtcaRUwJwQF
	 022UO/p38PhOLqz/VU5RE73+Dqr8ct1hZgpr1Z9cCem0c8EzahmFGT7thyAUQ2AEJa
	 k1u/0B3O6mgoax2y9tiehLo8Uvl2Bf4jp5LUnXOEjk8ElPHf4xrYct83+qGH3bOIsZ
	 2DkxPme526wQwlq30yVCydwSmq8cv9NQGwvIX+T0vhbwFgn31QnNLeMePbhb9tv8jQ
	 we1dxpfHKvgFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-2-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:03:54 +0000
Message-Id: <20260917160354.B247E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Add debuginfo__find_build_id(), which uses the debuginfod client to
> locate a debuginfo file keyed by the build ID - checking its local cache
> first and then the servers in DEBUGINFOD_URLS - and
> debuginfo__new_build_id(), which opens the DWARF in the file it finds.
> dso__debuginfo() falls back to it for DSOs whose debuginfo is not
> installed locally, e.g. the vmlinux of a kernel profiled on another
> machine or upgraded since, doing the fetch outside dso__lock.
>=20
> Querying servers, possibly third party ones, sends the build IDs of the
> binaries being analysed off-box, and a fetch can take a while, so this
> is opt-out: --no-debuginfod, core.debuginfod=3Dfalse,
> report.debuginfod/top.debuginfod, and off also when the build-id cache
> is disabled.  Fetches are serialized and misses are remembered, as both
> the lookup state and the fetch interaction are process global.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D1

