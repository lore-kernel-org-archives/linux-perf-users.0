Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536A3ED11F
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186032; cv=none; b=mSA4iQ15g1VChovVMvufiorvTn1HRWwRCAdLU4e+rfUlFsL4OoCByzHNRsaJvi5dG9UtZgYqE8HA6e/t/NPeV1f58EXr2NA0MX4ZoDaDD4l/Onzhx3jYDNjKjiS3VVQsnPWzvTRwQVWbn6pMx7fZhz8strSfWB2jzrvbwuQ+j4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186032; c=relaxed/simple;
	bh=L+u12UzQrU3uZs9xsKzmodwxpiZjUncAf9E+T6tTGAc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gDNlKIoGAOrcm3h/mVTO8C8Wf0w4La/uIny/kHMg27dr9PrvAABcAmNnfzWykOGwhyxlUxwR/WVcSs785X3LbZ9NDl8anErDfOtKsVUi5FL+ZTlyjciMBnqGeii41cptx71JdvtSn6nD6MWNNlBcUoFquPurCebpTY61/TH9iO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWAK8goY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWAK8goY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A571F000C4;
	Fri, 16 Oct 2026 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792186030;
	bh=cffWk1nyZMrD9MV4r8uQhoLVSUB+BSDVrPMXeDVUE64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JWAK8goYlnB9fYSaVYZg8t59JdUIwiLrb3kAJ40L7wpwJxRMsNHDWBHX6V13aiz2P
	 acklTxrpKFiX2aZomby9HBLjd1trRg/Z6gYY/vPiTm7rrOjXA4fcW2QUG/kCzLldjH
	 u8s5RneBavl75IE7Qa/M7hHmf5nZg/nICGPGhqab51XHZF9n/0XpzItvJLE0QvJn4H
	 3CrVq0JFUuMt9LOvdwx0WmwCqzkNwVY9JBhqE8STyymomu94D6qGsCMxvZTcu4BMFa
	 4EwF83iv9SW3EBycnDaU66x7bksvANN4YAkhYWhd8eqCqRSjDn1bZmWclJRX0Z+8aX
	 CvrE56AIcDpcQ==
Message-ID: <sashiko-outbox-174970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/21] perf tests: Introduce a 'needs_mlock' suite
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-18-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-18-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:27:10 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Each perf instance maps one ring buffer per CPU, all charged to the same
> per user budget set in kernel.perf_event_mlock_kb, so suites that map
> them need to be told apart from the ones that don't, to later have them
> take turns using that budget while the other tests keep running in
> parallel.
>=20
> Add the flag to 'struct test_suite' and a DEFINE_SUITE_NEEDS_MLOCK()
> variant for the suites using the DEFINE_SUITE() form.
>=20
> Shell tests run perf, that maps ring buffers, so they are taken to need
> room in that budget by default; the requisites, a comma separated list in
> the parens ending their description line, name what a test needs and take
> a "no_" prefix to waive it, e.g.:
>=20
>   # perf stat tests (no_mlock)
>=20
> "mlock" is room in that budget, so stating it only spells the default
> out, "no_mlock" waives it, and "exclusive" is the catch-all that keeps a
> test from running alongside any other, so it runs alone, in sequence, and
> implies every other requisite, which is why it can't be waived either.
> More requisites are to come, each stating what a test needs, till the
> catch-all isn't needed anymore.
>=20
> 'perf test requisites' lists what each test needs, reusing the listing
> routine and taking the same test name fragments and numbers as 'list'.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D17

