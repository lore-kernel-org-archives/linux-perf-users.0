Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344003E49FE
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539283; cv=none; b=FZtgY1V4h9kbbKM+ipj/svi45ZQL8suTyWBGSeSMRw+btDY4m86VqngR7JBeOdeRXv60mMSUv01DTh7VvuosQ+cNFdrDNLnQ6uoC+Rul04FdoCR2kk31+RhsvAMuz+DAghFjBeZDC/oPLpbETyPvIbRfrbpYwlGFZhgpAGToAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539283; c=relaxed/simple;
	bh=h7gqFdAgOMFyCwWqxTSygHjjki21E9R9yHm43CIekws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NCYFPQOsoZ2bsKhQmvRTwW2An5HS0GIlrI8oTgU4M75vIA8vfDwndr6QEofdn2p3pIMOqFGkSFT0MbEhdGQTBns7a+F+8NK6L1Z1t+36zP2ayrRsIPg/nk5Ec0dC3ucpOZB9un8viLSw/yORGXL6Pu+SPQEDIMAKV/yxfcrYqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUCosLNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUCosLNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A271F000FF;
	Wed, 16 Sep 2026 06:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539282;
	bh=h7gqFdAgOMFyCwWqxTSygHjjki21E9R9yHm43CIekws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QUCosLNhiHRxiCjow9hNT3+yAbYD1aCpEjOUzolQElX5pkgQiZiP3Y/5SJCmtU8tw
	 dWZ65YmhYKZpOEUjuzWP9gDYOEp+asOsio5Y47IxaQr+B0RgFc2xNBF+AXouTjPnZN
	 gogtA+fuycybsUDU73/cz4oue7sE5I2rzUNpvquCW0pBVz9uWYNbkJkU/ccrdzH7ER
	 AIv105dmJJe7LISroLuM9ShgqBV9QSwmWK28KEnt7AOpG+wWKfevVKoBIK+ttYJBRZ
	 x8jLcMH05Hh2xpbWsHz66j3ilyyosaW9aBTjERH3rBfqyEFnD3ypmYwoDuPUsTVzE2
	 6XqA9/b61nfqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] perf pmu: Include the headers that are used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061218.3061216-5-irogers@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:14:41 +0000
Message-Id: <20260916061441.E9A271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> pmu.c uses errno, free() and the str*() functions but declares none of
> them directly. <string.h> arrives by way of <linux/string.h>, and
> <errno.h> and <stdlib.h> come from whatever the other headers happen to
> drag in, which is fragile and breaks on C libraries that don't nest
> their headers the same way.
>=20
> Include the three directly.
>=20
> <ctype.h> is deliberately not added. The isdigit(), tolower() and
> toupper() used here are the macros from <linux/ctype.h>, which is
> included on purpose and documents that it doesn't handle EOF the way the
> standard C library does, so pulling in <ctype.h> would change which
> implementation is used.
>=20
> size_t is left alone too, as <stdio.h> is already included directly and
> declares it.
>=20
> No functional change.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.3061=
216-1-irogers@google.com?part=3D4

