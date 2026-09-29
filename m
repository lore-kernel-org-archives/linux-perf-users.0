Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FD4390CAB
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665456; cv=none; b=sZ5cWiNAyI9y1gUWGNDFYCb/kiWDZsxk+l4L8r4VG7We7Vy7v1utWBj9+Upq5NJimrLzTbD/aywg6Y/QA1I9hACT5GX6P1dXGbanpGR2EoDXvPDPt2LffCGOK0SMKwMtlIY+C20169u8gpPWeUWLbsUH/OwdF37UOn62yxUs4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665456; c=relaxed/simple;
	bh=EA4ext1sITC+ivVibM9EH+h3ux7eAzy8zD7kQChJApA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kl0w1mBVTuef+5+PJ50a2dooNyY3I7l/LYYkPyZEhKmIR2XDilJFxrHNTfEgiYm9syUCNSIuhxTlWfOMbYrte7mBZfHvaqFZfl46PewJVIDXJ1nWCnYWHKsd7ZZnFQRE6qjddfhTG3Owh5vvLBSCYBywKBhZ/1P85GzVcX3hVvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5pES9o8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5pES9o8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579D21F00893;
	Tue, 29 Sep 2026 07:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665455;
	bh=EA4ext1sITC+ivVibM9EH+h3ux7eAzy8zD7kQChJApA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5pES9o8jtlpkOLKb4xudZhPLHv+aQ37HbPy2j7dVioM9TmM7NZCeIVkbzA5VtxMi
	 sz0DUz1VjZ8+N+0GJZOCIt0fB+kDmA4TzlOZy4JGU+50vJTwbQNeILqw3Mi2/G41pz
	 XykGxDN0jZFJbREEEyeKFohjlkPXFAFlYHwAJVNll4L66kg062TaTRLcR5aOEA2EP0
	 yG5z92x2XkUooebrGswe2gHDAQSoQyzqHVDEyvqdZxe6y6QbQqqUqoiRoxBnCjxOlz
	 bMYOnpu3rq97yhBDXyKmSa/Y9Lr1mxxZYOCk4c3lfGKCuik3bM0cCxi+6cz0SbYV5j
	 F5pm4i53EpMYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] perf python stat-cpi: Fix live mode signal races
 and test flakiness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929065839.407062-4-irogers@google.com>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
 <20260929065839.407062-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:04:14 +0000
Message-Id: <20260929070415.579D21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In test_stat_cpi_python.sh, 'perf test -w noploop &' defaults to a
> 1-second duration and can exit under heavy parallel load before
> 'perf stat -p' and 'perf script stat-cpi' finish starting up. In
> addition, the fixed 'sleep 0.5' before sending SIGINT can fire before
> Python finishes importing the perf module, opening the live evlist, and
> flushing the first interval.
>=20
> In stat-cpi.py, register SIGINT and SIGTERM handlers before calling
> _open_live_evlist() and pass flush=3DTrue when printing live output so
> redirected stdout is flushed immediately after each interval.
>=20
> In test_stat_cpi_python.sh, run 'perf test -w noploop 60 &' so the
> target workload stays alive until killed, and poll the output file for
> 'cpi' (up to 5 seconds) before sending SIGINT.
>=20
> Fixes: 4425182d426b ("perf python: Port stat-cpi to perf module")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065839.4070=
62-1-irogers@google.com?part=3D3

