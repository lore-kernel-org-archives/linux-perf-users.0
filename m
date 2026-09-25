Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6A4D0A16
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350501; cv=none; b=UGIvxjiVWc57kYK8JtfYvYs6tyWT27sfiHidY1mH/VJR8lprb4fLHfSIMUEb1hYboo6ch8SEZQ56AqSXDiRRh8emScZtSx1PVKRh2OnWf5kkHPc92OXosKaujaZMXwNJ3o0RYiSTRW+SuvS4AyBhWT86mh68rsgtPY8IYnLJzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350501; c=relaxed/simple;
	bh=E11CgE+U2AxRb1NjmJSSj2eMoeQX8AP9bDKqdD1ghaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gwd+ThFRRVJaIka5kcc9+cecWxudJVN4DTveQ6PuMakiUn7QQHF+pBFow2Xfv2ciNIaDFQH6spMyjxj/aHV3Qmbl3c+4RnAhcKG4jQiM6+mzpo6YQCmdPoXYpzaptWSD+hkgWTuOvk2CSy9+d06kiQZEndPBiJHYsvrRR1AUgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPGgAW91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPGgAW91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B851F000FF;
	Fri, 25 Sep 2026 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350499;
	bh=Cn5NgEE6wY4raFpdNBH0GSBLNPLkEJPJWKwZy3WNrh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MPGgAW91zJovFYvYiVLkCzPTkpKElT7QCfPNnlBwpXqrnM3dEbs8yCmpHCotg/PRl
	 N0AP5ETW05rrydaSypwMEuWIH6AtvC/ulPyepTc17gjeSJsH8IQY4fBauzWJP4I/S4
	 fexpnFMhJYkSjOtAh8RyoP3OH9dTVbIqkswb9/a8q4vLIveFPhi8UOqI3ZDVFoOBJY
	 hZJj42teapQJ5/6g6yxPssTVLprB8ZDXGaWvyqvQysPdLsZgDWYMafasAyqJKvsKTR
	 AXzR7XDBXaqhRc0q6K0FF87jCigHamVm+flzi2RYdxvmGOS+xiF7yHYFx5fESHh4Cj
	 WSWWWQ85eHQOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] perf test workload: Use unsigned int in
 code_with_type instead of uint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <araUAt-S6YM_bbAf@x2>
References: <araUAt-S6YM_bbAf@x2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 15:34:58 +0000
Message-Id: <20260925153459.08B851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The declaration of the Rust helper test_rs() uses "uint", a BSD-ism
> that lives in <sys/types.h>, so on glibc it is only visible by
> accident: glibc's <stdlib.h> includes <sys/types.h>, where uint is
> exposed under __USE_MISC, which is on by default.
>=20
> musl does none of that: its <stdlib.h> doesn't include <sys/types.h>
> and it typedefs uint there only when _GNU_SOURCE/_BSD_SOURCE is
> defined, while nothing else in this translation unit includes
> <sys/types.h>. Building it on Alpine therefore fails with:
>=20
>   tests/workloads/code_with_type.c:9:21: error: unknown type name 'uint';=
 did you mean 'int'?
>   tests/workloads/code_with_type.c:39:17: error: implicit declaration of =
function 'test_rs' [-Wimplicit-function-declaration]
>=20
> The second error is a consequence of the first one: with the
> declaration at line 9 rejected, the call at line 39 has no prototype,
> which is an error since gcc 14.
>=20
> The breakage is only visible when rustc is present, because
> tests/workloads/Build adds code_with_type.o when CONFIG_RUST_SUPPORT
> is detected, and tools/build/feature only checks for "rustc
> --version". That is why alpine:3.23 and alpine:3.24 fail while
> alpine:3.22 and alpine:edge, lacking rustc, build fine and hide it.
>=20
> Use unsigned int, which needs no header at all.
>=20
> Fixes: 2e05bb52a12d3 ("perf test workload: Add code_with_type test worklo=
ad")
> Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/araUAt-S6YM_bbAf@x2=
?part=3D1

