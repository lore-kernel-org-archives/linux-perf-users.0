Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265755409E
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083644; cv=none; b=ok2hdKIm4r0X87Zcy8s0Zelh5L887Be98iNGniNAv9UTlt7oqz46cseNUQ4/CFuRA7QB4l2W1U13RofujQnguNNc5AF8P/MGtMv2R0a4rdds/DbVuQBRUa3K5EV1oKBzQqVjx2502kb9O/fUMeM72xY1lYgO03IXQ9s/quKD3uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083644; c=relaxed/simple;
	bh=WYOER2RQxoAGDk2j4jV+4FRLelOtRzIlT0v3SYGU1nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pgL1PIC7/+1wLrqtLpWJCHU1w4E8azqkA+tNPGWjqsry+tPHCLmVxcg1rcBEh4CGn7seBm0F93jCQz6EFovAD5Fy+SQI70jmGYjphw49WaCPnCXNGZkxmAPAc865yHONj+PcG/ry48hbAe+DNsFYqpnQ4/jwXcj33a43InwW71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMCLw6aq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMCLw6aq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA4A1F000FF;
	Tue, 22 Sep 2026 13:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083643;
	bh=v3kpH8xg2hKWIB9XfNq+MVOXpGhToNA4/ZOduCmqYCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gMCLw6aqIeyHSc4X9Pxcu4bCY40Em8KH5KJr9QDiv8+hgZyib8hVkzJie7hTinDnB
	 MpNT9ezEcowzQ2Lh1tl4JQy1EGJmO6JJNzlo0NXTY4P/rSopZBgwmfT3sovhxnfdCl
	 mPxXPOnQuicGgogkN0Z/YETCkfr0hDjzK6afY5BnH5LGLigGpVyySmsi6dUamVCCu2
	 9FqkiIYN6h05qHgCmZZSk6D+mLkxcsnsNpMTIN9f1A+ux+brHC9ebox/e1YLVSastQ
	 cowYPrQGgNxDmxt2Ny9sO8Sqb7beMArcmLNr3jeEl+rtHubLsxSBMsb6P2iTe+SPzm
	 rJS5rp3oYlJYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf symbols: Apply the symfs flat layout to the
 composed filename
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhan Xusheng" <zhanxusheng1024@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922131952.2922816-1-zhanxusheng@xiaomi.com>
References: <20260922131952.2922816-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:27:22 +0000
Message-Id: <20260922132723.0DA4A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> --symfs=3D<dir>,flat documents itself as matching only the base name, so a
> debuginfo lookup for /usr/lib/x86_64-linux-gnu/libc.so.6 should land on
> <dir>/libc.so.6.debug.  It lands on
> <dir>/debug/usr/lib/x86_64-linux-gnu/libc.so.6.debug instead, because the
> layout is applied to a fixed prefix and the file name arrives afterwards:
>=20
> 	len =3D __symbol__join_symfs(filename, size, "/usr/lib/debug");
> 	snprintf(filename + len, size - len, "%s.debug", dso__long_name(dso));
>=20
> perf_basename() only ever sees "/usr/lib/debug", so neither layout comes
> out of it.
>=20
> Compose the path as it would appear on the profiled system and join it
> once, which puts the layout on the whole name.  That covers
> FEDORA_DEBUGINFO, UBUNTU_DEBUGINFO, MIXEDUP_UBUNTU_DEBUGINFO,
> [ ... ]
>=20
> With --symfs /s,flat the lookups are now /s/libc.so.6, /s/libc.so.6.debug,
> /s/sleep and /s/<build id>.debug.  hierarchy is unchanged.
>=20
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922131952.2922=
816-1-zhanxusheng@xiaomi.com?part=3D1

