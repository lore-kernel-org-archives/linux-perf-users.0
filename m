Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601537;
	b=aFvolYargqDfGE0p3y3CsA5rUI2MFCOidHgfpy27NAuOQ79DZjle4oPlWnovZy4ihNyj
	 qJIhgQ5+j0IKi/BwYVBaVsgy6PnqmZpDQBejnnL/V0E228QGav+rFdcljhGKKyPOXQXwP
	 pHmOySNBZCobsnZzr7f2HAGICSlc+Q2XswAHFD+kt5yVyLcubPjs4Ya5XcA6DjM6ZZp3u
	 vmhdpMgfeKla9xMv/466+hGgY4ZyTgK53XTrD6/ypV2CkBO4N+c5nSmanq8piyijuR+B6
	 voEZKUESkcszQOvBFnT8YW/errCf/5xqHEj7KYInaK2ylQMC8xG+ROyojs2rkItQMow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601537;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K30Y0G3RcW1SyASq8zfm+B61mDRNAjYuR+5GTVmrYuo=;
	b=qHd0kiZG1iOWxaK1E0R85fugNHDcXzivU3QpOC1u1ph3SvR4Jmh2Il0sO86HL7iFh40m
	 7T+hai3aUYKy2TcMmIfPCeBXIQR5kQuvjyE6TRssgubRH+yWGhCECBosG8iI1+EB9HE7V
	 rQ2hzxZOJ/0DN7ek7CHPU+Ou+hfv5hQgST6Qx7qZekeiAlUjqzxrzFfxpSlY8zNhViwXC
	 biGT78lh0sUvUgxZwOE/zPyIvS5mxnNFxQHztS+ZDBJNwhesvlcLWChnpfYnTz2Ou/QgL
	 ch4QMCWRHUOILiwsVKLD1wsTJQ9kFYLc8hDYZQ16YNOrPj5ozXQMHe6tfYgociz4W/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxRdAsvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F4606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MxRdAsvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014CC1F000C5;
	Fri, 13 Nov 2026 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601537;
	bh=K30Y0G3RcW1SyASq8zfm+B61mDRNAjYuR+5GTVmrYuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MxRdAsvOXqyNexnF/8Z0fldUD+PivskJCWWHPqGyRIxbgZapuv0e64h/3SzxxO3Qj
	 0PG6mfplwv6Jt/5fZYLRYou+k9nN6coBO/8YFwm70n+aEA6eDsYHgCGU1YNuKTbmDc
	 lfPHI9v6WUgx7Fh+mf/Jh/yTIoq6lf3Z6aL7ns96AYzPg3HDKxu2yOualelg/cgrVE
	 nhpDar+P3YXKLycwIBuR6qUPSaTKxMP7TA8EEJCI86W+g692T/3qFQa2zxi78xYERM
	 SFnFTz7pHNbu8w7wenJL1aM1tMhiC7WkbrayPgtTI9tqYJzc/uc7vBV+MwzJzUMrZ4
	 vmfptAzK/Rlzw==
Message-ID: <sashiko-outbox-213635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] perf tests: Exercise the flexible array member
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-4-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:25:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> No test covered find_flex_array() and get_flex_array_member().  Add one
> that keeps a struct with a trailing data[] behind a global pointer and
> checks that accesses past the struct size are resolved and named after
> the flexible array member.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D3

