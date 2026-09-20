Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DD23D6664
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882554; cv=none; b=DPdQQ6o4/yI5KgEX1Do1nWhWUhVRWjBkOVjTI0iCUyZawWf2h3EX/cQ1qCmr7HKHKZ+tk8zE8co010cvLHi1WUUqHzbT8eQ4YyQrJIqmPor+n5sJOrYI4NbjNQ7peWeBpbgrnul3bsyKw+h6MHtKmLvwmQaNBTOPGG37PSezops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882554; c=relaxed/simple;
	bh=225uCDaYUW+DnMJiMX8uMV6e3Wax9pl4C+FvB0901kQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vDZ2RdamFGdGO88+uwEmlXqG16yWlg28VtRSowYo+pDZxHw60KhtYatScK6wUC1zz6Cta5l0vRZ5iLZv/Mh5MIpxaDj383lBBxOY87GjFPgfH5Z3WdP9HKgqDIUPONSosUC4bwdMtLwYQJnMpZunAB49WpSF0+AgR9TrL5ZHozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS7nsJrS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS7nsJrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582B91F000FF;
	Sun, 20 Sep 2026 05:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882553;
	bh=9pGhCjlFrGa8ijwYajGYf6ac2V+6l/Wsj3RjrGy+ljc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fS7nsJrS6wvRXQ+4xblbmLfgsML5gKj1S3eRqtBB6ohCJdRdAoJ8BzMJzj8DOwzkp
	 yjPDvHQW8AiKV3FwUkN6cSgxKw9GDbfnOVpT+FNx9wkmyZa+q5GXPOAGKRseETx/UD
	 uIjJfRRUZuYxknCX6/9FZ/C4Go5KNqTnOZdnr0zqlAGfbwCp0SgCF0iUi/ImSXiQkZ
	 mT2sxMnwx7cBi3Ol81xdRjpTUrLgEti17bNLpBIlUt/pCxPVis+tR+jFw3A30IZ0oT
	 teIfWD6IUUoEcwbfKkB2xjhFAI6F6yTKnbyaU2351+NTM9DALiqTPa2rCUPbeZWak3
	 sCDTtIi44GT9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 29/49] perf python: Port rwtop from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d3441510cb4fe4ddd442f2ea17d96b775f24f35f.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <d3441510cb4fe4ddd442f2ea17d96b775f24f35f.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:35:52 +0000
Message-Id: <20260920053553.582B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rwtop.pl with a standalone Python script
> in tools/perf/python/rwtop.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Support both offline perf.data files (via perf.session) and live
>   recording (via LiveSession with --live), driving periodic interval
>   summaries from event timestamps rather than wall-clock SIGALRM timers
>   so both live and offline runs produce deterministic output.
> - Use session.is_64_bit (falling back to host bitness in live mode) when
>   checking for negative syscall return values so 64-bit byte counts in
>   0xfffff000..0xffffffff are not misclassified as 32-bit errors.
> - Sanitize non-printable characters in /proc/<pid>/comm to prevent
>   terminal control sequence injection.
>=20
> Add a shell test
> (test_rwtop_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D29

