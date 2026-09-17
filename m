Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF73E4112
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621186; cv=none; b=DSls1B7K/LfwzTDSsjuccTNMajJKD9C2tuFWtLVJuviRSxZCZi0gueZMi0gZn6t64cxf/eO6QJhvITiMoklW0k+OKYXg2RWJdVSN91ymwsJ5J1TEBvMt23n2lazdaAFe+LNMZSf0FfUz/v0hWeSwxlBiwa24imoGY7O16ifuydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621186; c=relaxed/simple;
	bh=P0l5cbQeSulc/dr1ByUXD5SFKRF0i5oC9GtUhiPr938=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sLrbrO6f6Sf5f02Ox0ylsVH7g10QmutcxoNxY84L9KA9dJs/7XnnAPo6/LKwskAdwuqMl1wNKCcqhrFtvL/EXR0liUK0/o/mBEYmw+gouVjUg5NTkRSIG7n1cEaXn2mTIhUiG0pNEKqcZ/gsugw/zxCllzIGvSnFhckJrsX8U/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7Vf2oKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7Vf2oKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFFB1F000FF;
	Thu, 17 Sep 2026 04:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789621185;
	bh=cZfovjXaAjmS+2eSxP9UUPmkgQmz7lhf9lNjdy0LXH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7Vf2oKf9W3GygpbBAcj4eycjTAN+SNdxSdc6ECgVi7cMcw3+WVXkGGgxxzATVBcF
	 ptmEJkAepEvwRONace81Qjo0q0pKTL49mVDv/CzQoXvX6suSoAeJ1WtM3JuikmOKgM
	 D4ull2IywH9eGx7Tz4qlvqa8yu9oXioOs3UCGxaoCS99BkoY5jKrxJaX1rCeiEXmax
	 prdemwlkPCP6LPhAxN5Dagd89/XMZYzRWqVoVod5PH/+FcjJmZMLD/Uads08FB89sL
	 gScQRNnz+nnSPQ3CP1lgW8DxaEJ6ANMtn1aa/zXRA3yFOjtDagEm4K/5lweJTEXSJG
	 b6p1tDIX4qfFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/11] perf bench messaging: Add missing includes and
 sort headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917045326.63601-2-irogers@google.com>
References: <20260917045326.63601-1-irogers@google.com>
 <20260917045326.63601-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:59:44 +0000
Message-Id: <20260917045944.CFFFB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko reported:
>=20
>   When building the perf tool on systems using musl libc, compilation
>   of tools/perf/bench/sched-messaging.c fails due to missing
>   signal-related header declarations.
>=20
>   The POSIX signal API and associated constants (SIGKILL, SIGINT,
>   SIGTERM) are referenced in sig_handler() and bench_sched_messaging()
>   but require an explicit inclusion of <signal.h>. While builds on
>   glibc succeed because the header is implicitly pulled in via other
>   includes, strict libc environments like musl do not provide this
>   implicit namespace pollution.  This results in undeclared identifier
>   errors for kill() and signal() during the build process.
>=20
> Add the header files and use git clang-format to sort.
>=20
> Reported-by: sashiko-bot@kernel.org
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917045326.6360=
1-1-irogers@google.com?part=3D2

