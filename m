Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616409;
	b=lCehlbm0UggSSyhZ+hi1C7lrWRqrzGqpbjaI3clk5xYJXWtxha4a8u3pkBT5NRLbqhFX
	 u/p7kskHoJBKD2DS5w4fGRi3jfJtp1Sl4tKPNJ8i+9pc9g60a4KeLu52M5fM4LwDXbdWR
	 faELJufEgcNcZc4mTzq64slYHLZjfrx2L3SH14LHkvCLuHXE9S1qM2oH5cOxEeavqmqfq
	 IPv59SPacjWcN0NN1oR6M+DvsoXgUi+HQ8ZTivgkdzg5ju15Xc8bWqk2D2Mo4beuYa60S
	 EcKTgl0vhNszo8jRLst32iFVoPNGRPrVfiVsSLSkH0m6RCtn6ozN6mP3YcZlCGh1gWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616409;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nRftuFTVF5vUMTLc+AQ2ii+qTWpjF589VYzkXKSCFdk=;
	b=fRDbDg1mY8YGHN0Vs1A+uwz4/DApF8fjY6mpr845EfnuefzFrvHiDs70h1gxJPvqlHkm
	 bz97kqXKJSJldQWZr7OMNa1g9TsEK0B2sXNRWkpVXeOLFYMn0HsRclzLQZ7mnvL0HjtjV
	 fuu2gmpAtwq+SSwzG2CPwCbYt1FA59UzT94YQ2aUyw8wiGHdD4UWSO4cZLxVux25DNF2E
	 eJ76wdeDPii8bV0OdvtHSPgCeLZ/R9s5IEHTyzRCk44ZftHKzmgJ0kekqpdWy867d+/M6
	 Agt57F8+c3/fBL0pEsxWPbxAglnV/w7qVotenogLXO5xJlhPtO4sLrPwPYZJu+OKHvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nY0SHZBN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EC606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nY0SHZBN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B951F000C1;
	Wed, 21 Oct 2026 21:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616409;
	bh=nRftuFTVF5vUMTLc+AQ2ii+qTWpjF589VYzkXKSCFdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nY0SHZBNxgaK+hjVBtRsPw2g+rLRSUG9zLcUZ7KqqcuODOsihoOoGcZ7iZy/AF7lT
	 7nweEvI8zB3K3wVfajaZwEbk4kleSCnx115I5Vh7xLrA8KRWTPbMEqX9q0bDomORH/
	 6w19Er0LzNGajJQXvAtFyrQL4Du+kPxqjpLR1SIDqYNqHAlu8/SrbPZG61j1NLMSZS
	 iH3DdpmPuiljeC8860r+VxOCbntUsyuit3ziq/wzDII0vBRkuZZuBUM4ARMwa6cZY9
	 LyjnlVWhmAjkEnsuIOv7BQ4XWByi39uPQHVyXkeLvEFWsz7ApVOMe2UWeTBKdoi7WG
	 ucqdeOJYjypbw==
Message-ID: <sashiko-outbox-180678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/2] perf/tests: convert check_*.pl helpers to
 Python
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021205506.26736-3-breno3011alves@gmail.com>
References: <20261018134322.26445-1-breno3011alves@gmail.com>
 <20261021205506.26736-1-breno3011alves@gmail.com>
 <20261021205506.26736-3-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:00:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Faithful re-implementations of the four Perl test helpers in
> tools/perf/tests/shell/common/:
>   - check_all_patterns_found.pl
>   - check_no_patterns_found.pl
>   - check_all_lines_matched.pl
>   - check_errors_whitelisted.pl
>=20
> Same CLI, same output, same exit codes. All use only the Python
> standard library. TESTLOG_VERBOSITY and TESTLOG_ERR_MSG_MAX_LINES
> environment handling is preserved.
>=20
> Update all 37 call sites across base_probe/ and base_report/ to
> invoke the .py versions. Update Makefile.perf's install-tests
> target to install *.py files (in addition to *.sh) from
> tests/shell/common/. Remove the four old .pl files.
>=20
> All four were verified byte-for-byte identical to their Perl
> counterparts on synthetic inputs.
>=20
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021205506.2673=
6-1-breno3011alves@gmail.com?part=3D2

