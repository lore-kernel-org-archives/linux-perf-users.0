Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330913B71D2
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539414; cv=none; b=tq4nUd4VxPvCH4MdBV1r1aTm60QXm6rjnV7kcGaD+ZufvDFLpzoUCa5bQn8o0rkBxDE0DU31031ZjwdcwxANNJfIVZz9DpIa1lfuhieTHOOUYxC676y/Ldf/aARS6533Q9PcFr50VVImAkbUHUTOg/XoqTvVyFRKVE5IMk6JAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539414; c=relaxed/simple;
	bh=C/d1Vu6WaOT/4dDAQVSgx6n15mYaJD0wPoJHsUbaRZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SLP4s6i5GgOFv98bmrya4L+x1rmsI0QY/jvFZo7URw4+tbsd/NXmY5B/PH232feaURTcrhbgIBO84qOPli61ScbOa7tqbFCi3EicNKm865fY9VQ3l08GQ+YYOBDw8ML2BIxEZut9Tn9OIr7MhakeF2Iq8LzGYYPXvEchhfElKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4otK4Ue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4otK4Ue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D121F0089A;
	Wed, 16 Sep 2026 06:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539412;
	bh=0mcIP0sLcopaZQevef+SIxq/XRWuGtw9xwryiCTTbDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4otK4Ue9/2HRN9f+hoMObrMsU6kqR84fnItyqAJGKmxw0yfLSa/hEZN2utWmE2Bd
	 rUcE0l4nxyZZgWjXfbvMLHWH0NJEzXZ8omG0uzz36YJvFEVgpqsaClyFB1wHk24gvN
	 xBL58BgLe2A7YwxUMyKcR1clDmAmus61O44uQifHxQa8F0OpdepqdE0rr3v6O66c/C
	 c7B0lT1uedfFjCKPZKyxKWJlTsewVAqSq1itjz3JtE1jYQ90Ntfll3BABTKN1hX2xb
	 XpIioQGkVTVWTuYJeyII+/596cEIa2LGFDj8BUesQt6u+t87omDVzREwfyNf+pBG+7
	 RLZrjLfW/7sLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] perf build: Check the version of the compiler that
 is used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061218.3061216-8-irogers@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:16:52 +0000
Message-Id: <20260916061652.B1D121F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The flex and bison flags are adjusted for clang older than 13.0.0, which
> doesn't grok -Wno-unused-but-set-variable. The test is reached because
> CC_NO_CLANG says CC is clang, but the version comes from $(CLANG), which
> defaults to plain "clang" and needn't be the compiler in use:
>=20
>   $ make CC=3Dclang-19 CLANG=3Dclang-12
>   version from $(CLANG) -> 12.0.0, flag stripped
>   version from $(CC)    -> 19.1.7, flag kept
>=20
> Dropping the flag lets the warnings it suppresses in the generated flex
> and bison code through, and those are errors under -Werror.
>=20
> Ask $(CC) instead, as that is what compiles the code.
>=20
> Fixes: 878460e8d0ff ("perf build: Remove -Wno-unused-but-set-variable fro=
m the flex flags when building with clang < 13.0.0")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.3061=
216-1-irogers@google.com?part=3D7

