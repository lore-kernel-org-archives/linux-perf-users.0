Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBC359A90
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539755; cv=none; b=l/xr/RPZBZKBmcAMZIcPTXv2JgZszoJY+YKMSBrdM249+IASJQII/IGq25ahBs+/geOfn13Z6TYiIRoB4qmiInPvowUxqFzz+U3z6jw9XhCY2wqh/EDbBYj0D91zAfE/gMXk42X/tfvbS6Gb2gh2aUD8PP7k+SJIR7dAN27F+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539755; c=relaxed/simple;
	bh=S47/rof0GqNoQb9c9/jxCSgYW0TxCZUBkvzUQohn1l8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DuqWFXGKycPWDiJF2AC6MAiVvfCdfVBHce06N8k1zTufuib5o47B9DhkY2ZwjN9P/4hjbBXr7HbOj5G3jfR0B7wfFkJTQJ2OTZu9r6xdMWyw0LC6vdYg/vkyvC9Lvi8/ADlONT5ScKwLhixYkcILnS+VOQS4zUOpeELJ8Gz3J10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knOoCBi2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knOoCBi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86651F00899;
	Wed, 16 Sep 2026 06:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539753;
	bh=hMwHcxo/KieukQeE+2fT6nvRdSNsE/iNXnJdFdm96B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knOoCBi2vPHV4xzZzy4NRCG9V4Zgir9ztoaF7UbycGsTuLnSEMP1yrrPhIoyB14Fa
	 PWZxqIJtASnEU+IbSA1SdsZYQQh18tZp3p2rSwY2jl4sa6eTMkVebyQ5l7EKuto99R
	 DnX3LNqRlwnXxxYwngfrmJiiEYGJM2FkENp3wvucQo1pKJWgS4xrV9BxKqRG021W0O
	 Xorw4SEnt53syf4KJ8UmKd39a9LP5la5QGhZNMQuYTPI4+M4G8eMOgPrb52hDrO3w1
	 tAdI6EYtJriL0kGbFvAWZElvwtFfe0kxmwZbK8O3oX1tb78tb9mpNhimlj3SrapqpR
	 zr2QCqy9xp0Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] perf test: Add build tests for clang and libbfd
 demangling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061218.3061216-10-irogers@google.com>
References: <20260916061218.3061216-1-irogers@google.com>
 <20260916061218.3061216-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:22:33 +0000
Message-Id: <20260916062233.B86651F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Three build configurations broke recently without the build test suite
> noticing, as none of them were covered:
>=20
>   - "CC=3Dclang" on its own. CXX is only set to clang++ by "make LLVM=3D1=
",
>     so CXX stays as g++ and used to be passed clang's flags.
>   - "CC=3Dclang BUILD_NONDISTRO=3D1", where libbfd.c failed clang's
>     -Wthread-safety analysis.
>   - "BUILD_NONDISTRO=3D1 NO_DEMANGLE=3D1", the only combination that
>     compiles the libbfd demangling in symbol.c, which referred to
>     identifiers nothing declared.
>=20
> Add the three. The clang ones need clang installed, and the libbfd ones
> reuse the existing binutils check.
>=20
> Testing that perf was built isn't enough for the first one. Feature
> [ ... ]
>=20
> For the same reason the clang tests must not reuse a feature dump made
> with the default compiler, so exclude them from REUSE_FEATURES_DUMP.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061218.3061=
216-1-irogers@google.com?part=3D9

