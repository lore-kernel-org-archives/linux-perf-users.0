Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8A340260
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833646; cv=none; b=mIJRcbFrnu3ZMxc/SXYAaP941w/yflIV2g3yys4HVWwmQO89vbtbPZW9Ss0t9g9ZngkBqLNaV6X9Y7USI+xab2lxCswQoJqZdnr7EJuEiZ5Z9cWC49fAAx2jmyHkce40+4Re1/dcA64aYH3IKdFBtsEeF+U2H0q/XO8rcwELOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833646; c=relaxed/simple;
	bh=PqEzonX4nl1Ki+ICouLZ5HiC6uiKLGXOPxkYW3jsW9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lc1cpgAVD2aus1ouLYOQlTNBpwkkChPz9dMNy2TGExbLCFvBi3B0O19oKElUJ8TiI+31xv1Ox4CDRR1axrjFHj3vCIDfLwsT/ohno6wb9vgcu87yvD1n31oTTHFa8aZVQESv4yOZNVtf7FPKjTHb705lC0d7gU+lX0ihgJoGEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkZIdfUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkZIdfUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91281F000FF;
	Thu,  1 Oct 2026 05:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790833645;
	bh=BpsaV8RzCyFxhRtgXSh/ydNGD8eNqbNs9Gb53JCxqnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkZIdfUcqZYdevMlPYcKq7beOpcAghUbptbxNiNgybzGw6psIqWXkSgMwx6ma7gag
	 eONUSP/9ZoAcgnVdSwHNaAXvwZuO3lDPs50GhkTS/+/fVZmMM6Wgkk15/revsMj+fT
	 RzFIhXoY1bqPTjllRNEikU44GcbBE9/2h13oSPDswQKsY6R38EfXwzb9j2C0eQHVeq
	 ZAHHiHdfMZch+YPT0Bm/Ckgfk+x74Gow5pXUvsbua3jo1nAiedyyST8qmNOIAS6pYt
	 Tzd4x0ihVR1CF7utksAVQklqo/WdSe9c1zffUcKDHwq1CJP1hgwZtsRANHUrzZxScz
	 Njjkad21hhLVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf build: Fix clean and install target
 dependencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001054120.1570943-5-irogers@google.com>
References: <20261001023423.1225713-1-irogers@google.com>
 <20261001054120.1570943-1-irogers@google.com>
 <20261001054120.1570943-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 05:47:24 +0000
Message-Id: <20261001054724.D91281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Fix several missing dependencies and ordering issues for clean and
> install targets:
>=20
> 1. In tools/perf/Makefile, order 'install*' goals (excluding
>    'install-build-deps', which is ordered before build/install goals)
>    after 'all' when both are passed on the command line (e.g.
>    'make -j clean all install') so two concurrent Makefile.perf
>    sub-makes do not race in the same build directory, and mark 'all' and
>    'clean' as .PHONY.
>=20
> 2. In tools/perf/Makefile.perf, when 'clean' is passed alongside build
>    or install goals (e.g. 'make -f Makefile.perf clean install'), run
>    'clean' sequentially before 'fixdep' and 'sub-make' rather than
>    running 'clean' in parallel with the build inside 'sub-make'.
>=20
> [ ... ]
>    '$(OUTPUT)' so '$(OUTPUT)doc.dep' matches out-of-tree documentation
>    targets when 'O=3D' is specified.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001054120.1570=
943-1-irogers@google.com?part=3D4

