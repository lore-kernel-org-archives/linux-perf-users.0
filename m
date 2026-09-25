Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDD3DA7C4
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341736; cv=none; b=G00bIONy1AOISZ/UgLGDPuebQNKjay3AkkduG0silOJwIy1w4RJV5cf9ULnLd4f5DW4BezWgDMJfU0bf7hSq21+AWAEm0JUj49daNY4hs6dg6paYKy5ZA/NkE1YNekEXyQrwtFO8dga+bfloFdc8WcTgTUnkHUgSDh/V9CYs2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341736; c=relaxed/simple;
	bh=1L/5h9WL+nHpSpd0OYkSNnnXnhxySo/u7eYlWaaWp9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YP/F2RgL6BRiuoNF+yVIw165f8Kxzp1S8GJSAm3q/DFz2TZK3+8fwK+SvPs7ZLyac9/PjymXejffdQ2fXNXwYpgh+Y9Ud5cC8Q+g62l/CTj/865eEm41GwxVD77aydRlfIh6vDIpcPkTSkhnMpeyzqGMFrpcS1JD04/2r2zXL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt3KQqYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt3KQqYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4966A1F000FF;
	Fri, 25 Sep 2026 13:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341732;
	bh=JVyyb/a5CNQ2qHcdfVxD2EYVylDuLIciyjVWRvGKybw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bt3KQqYjMXrZn2aXrRz+HSKpyfJnhNoku6YeQUNSUKzjj8FvtH4VFK6CMTTfhFmcO
	 7J2WHmaJmd7JdQJn5u7+7mXW/DOxh+BOnFZXvU/Em1bVyBgtBffPXyKMCqQeGd+grb
	 mGQrigGYxgc3Ha8VBlbjqd7trT2iFkN4FaD4zNuCjc0MAXlfN8R7sU4DQAAXWJE+BT
	 p4HHfM0gH0c4WPCt7Ll0UfzM9g1bxzQWRkSkOGwtFife8q4xmLkHhX830fdMeSODCz
	 ajt1Kdmrh0MFME90dvDD9pBurz2aqVtMwPxrlwIm19c8ahlCwAM6lLeq4z5NRf8wns
	 7SN3CP2Yr2sUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: marvell: avoid large stack variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925130440.4107512-1-arnd@kernel.org>
References: <20260925130440.4107512-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 13:08:51 +0000
Message-Id: <20260925130852.4966A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The probe function in this driver constructs multiple large structures
> on the stack, which ends up causing a size warning:
>=20
> drivers/perf/marvell_cn10k_ddr_pmu.c:1168:12: error: stack frame size (12=
96) exceeds limit (1280) in 'cn10k_ddr_perf_probe' [-Werror,-Wframe-larger-=
than]
>  1168 | static int cn10k_ddr_perf_probe(struct platform_device *pdev)
>       |            ^
>=20
> Avoid this warning and simplify the code by turning these into static
> const structures and directly assigning them without the extra copy.
>=20
> Fixes: 9b551a2446b2 ("perf: marvell: Add CN20K DDR PMU support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925130440.4107=
512-1-arnd@kernel.org?part=3D1

