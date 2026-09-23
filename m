Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B2443C37
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148255; cv=none; b=n+f1pBq9Zd9NnIT6S7hpGT6kKlaPtXQn3Dc5H6xmhwzkzgzQd/FKrL8Ofgojaah5lG6yTQOOGJ6b5B1eQwCM66BvR5qEgKj+XGJ61SSrXYoxPA+Nktj6XIXb1eXB1hlRyBb305elmli0JmSYdsMjuB0vzytbsKxegUeLsS7zkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148255; c=relaxed/simple;
	bh=zPVzVbhP1FxBf6kTZ8JWEF+FgVt0F7vlR4MO7aHe3vw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WyQn7yCMOzY02ZPYlvycCYlsqd0UwJTWqnMLW8fKwvXLwrIqrg8f+C4u+Q56Bsu078KgF9jEMrlOs2MQPDhazJfsUqTchq7/AI8pOjMb03oelKe7cvmYmHNG6+X9yJ6wGTM5etiGkBNZ6t0xfBQwknjRACjMw641MElssyfKG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQNxNxb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQNxNxb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C611F00893;
	Wed, 23 Sep 2026 07:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148254;
	bh=zPVzVbhP1FxBf6kTZ8JWEF+FgVt0F7vlR4MO7aHe3vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQNxNxb0sGJeyObx4iOG4vlFCGq1e/EigPgVJd5uhTExGdk1osxAt7+nifyyZuFQI
	 igsX74ukr6bO5Aul88aZJnnhwXyTZeZuPyp5FI+5juuhOhUtyG48zEAEjcvKSonpzl
	 Y4kuFE9epi7RUszepu85o6tV5q2pWadTT5+zfcIgI9vwq90DF3loTPKyEL3ST0lHJi
	 AdAcjYDZQHJZep0UaZwNc2JtqjcFny0aiGZP+shLEZs0M2nuu9lOn5u7lizr2T4TxB
	 V72ymluZaY2nEkt/lOfDeVlTrx3LaTlQxOQvSWDL1vD4t+uZPpvJeWENzO4PN7auIl
	 shDzfaoTOmYGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/23] perf test test_task_analyzer: Isolate in
 temporary directory and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d3f26f77e5aabb9776c9a4775ca650f6d90b0136.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <d3f26f77e5aabb9776c9a4775ca650f6d90b0136.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:24:13 +0000
Message-Id: <20260923072414.31C611F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> test_task_analyzer.sh writes perf.data and temporary files directly into
> the current working directory, causing collisions when running tests in
> parallel.
>=20
> As a temporary measure until `perf script report` supports an input file
> option, resolve perfdir to an absolute path, change directory into $tmpdir
> for the test duration, and clean up in the exit trap. Remove the
> (exclusive) tag so the test runs in parallel.
>=20
> perfdir is derived from $0, which may be relative, so it has to be
> resolved before the cd into $tmpdir, otherwise both PERF_EXEC_PATH and
> the cleanup trap point at paths that no longer exist.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D16

