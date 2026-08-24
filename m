Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596A3EAC74
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554557; cv=none; b=PyOJp+KZ+MwUpjnax3HPjntL6g/aJXEDZlgz/17Poe8i5y1HqPI2x0LLH+XqdUwC7rqMPSpPJEItSCB/XsAVreY+nvyiPlvX9O6/MRnXSh3BrOxHzxkVQ6vNH8LRjMFqYfOZ6PVPxHMzBqb07mEVjWP2GrXqhn7lglDlbIsO2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554557; c=relaxed/simple;
	bh=LdYh2FxK7oXBu3lcqN/VCnEShxkuFky1vUiks+mnCr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V8CtiS4/QNjdlkSuQcD3iMi1JjOlXwA6bvG1onI7g1ATokYU6k9l7pYRCphvKd9HGw4mVWZf60XneT7MPrNbrBye/a2vpjr1pBPyfzUdo/aOE1/D3H9DHoNGazoDTKzGUNG9bUfVNBED/BdaYCauuRm0jfU8jLPzdodcxq2lciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0/PG1P0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0/PG1P0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F721F000E9;
	Mon, 24 Aug 2026 06:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787554556;
	bh=sEV6Gz6048ydraqy8+yW5HW6yvgwpPUsd0szfRU6xtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P0/PG1P0j9pF/mSa40qZndnRZx0wHMi9QJPg0I7fG8FHtf1sbHaEGqoIdGSccDExs
	 UJpIiiwFeWfBUt3EQm0CxsBBcIqXQPyoZeMi8xIS+uqR3PfCW7zc4LbkG26Mp8ff7O
	 MId07tW/A0wlf4s3KK4GP5XOO1xxbjVZbX2CKJZk1KaTyaQyCJcg1h1F1Qd2fVDAbH
	 4fSe//v6uIM5Ie0YLxuESVJoM/GSFysP5aN8fr0NpgGgZke3K7jDoalbEKXINdiQww
	 CbkqowRr7ZBYsltBD/ZZJZqeS9qXG9AzbCsVaYZ/nK7GUdg+1Gof2jqCXydB9fEr9q
	 sXSwRWGSQOkPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/7] perf test: Expand top tests for --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824063744.1533837-8-irogers@google.com>
References: <20260813132519.4099508-1-andi@firstfloor.org>
 <20260824063744.1533837-1-irogers@google.com>
 <20260824063744.1533837-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:55:55 +0000
Message-Id: <20260824065555.D8F721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The hybrid merge test explicitly requests the `cpu-clock` event,=
 contradicting its design to test `--hybrid-merge` on hardware events.
- [Medium] Unnecessary system-wide `sync` commands are used to wait for loc=
al file data, causing potential CI performance degradation.
- [Medium] The global `retval` variable is conditionally assigned but not i=
nitialized before use, leaking state between consecutive tests.
--

--- Patch [7]: [PATCH v1 7/7] perf test: Expand top tests for --hybrid-merg=
e ---
commit 83b4f9c7a4d40ea456ef8050c21d34919fb655e1
Author: Ian Rogers <irogers@google.com>
perf test: Expand top tests for --hybrid-merge

This commit adds shell test coverage for the top --hybrid-merge flag to
verify correct behavior on topologies featuring hybrid events. It relies
on fallback logic inside perf top.

> diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
> index ad7fccd09025d..49820bb2d6b25 100755
> --- a/tools/perf/tests/shell/top.sh
> +++ b/tools/perf/tests/shell/top.sh
[ ... ]
> @@ -35,26 +35,27 @@ test_basic_perf_top() {
[ ... ]
> +	sleep 10 | timeout 5s perf top --stdio -d 1 -e cpu-clock \
> +		-p $PID > "${log_file}" 2>&1 || retval=3D$?
> +	if [ "${retval:-0}" -ne 124 ] && [ "${retval:-0}" -ne 0 ]; then

[Severity: Medium]
Is it possible for retval to leak state between consecutive tests?

Since retval is conditionally assigned here but not initialized before use,=
 a
successful command execution might leave retval with a value from a previous
test. If test_basic_perf_top fails and leaves a non-zero retval, a subseque=
nt
success in test_hybrid_merge_perf_top could falsely inherit the non-zero
value and incorrectly report a failure.

[ ... ]
>  	kill $PID
>  	wait $PID 2>/dev/null || true
> =20
> +	sync
> +

[Severity: Medium]
Does this sync command introduce an unnecessary system-wide delay?

Once the process writes to a file descriptor and exits, the data is
immediately available in the VFS page cache for grep. The sync command
commits all dirty pages system-wide to physical storage rather than just
flushing the process buffers.

[ ... ]
> +test_hybrid_merge_perf_top() {
[ ... ]
> +	# Run without explicitly requesting -e cycles so heavily virtualized
> +	# environments can seamlessly fall back to cpu-clock while real
> +	# hybrid hardware will naturally cover the merge logic.
> +	sleep 10 | timeout 5s perf top -e cpu-clock \
> +			--stdio --hybrid-merge -d 1 -p $PID > "${log_file}" 2>&1 || retval=3D=
$?

[Severity: Medium]
Could the explicit -e cpu-clock argument here bypass the hybrid PMU logic
that this function is intended to test?

The inline comment suggests the test runs without requesting cycles to allow
natural hardware merge logic to trigger, yet the command hardcodes cpu-cloc=
k,
which is a software event. Software events do not utilize hardware PMUs,
meaning the --hybrid-merge code path for merging hybrid hardware events
might never be exercised.

[ ... ]
> +	kill $PID
> +	wait $PID 2>/dev/null || true
> +
> +	# Wait a tiny bit for the file system to catch up on the logs
> +	sync
> +

[Severity: Medium]
Is this sync command needed to wait for the file system to catch up?

Similar to the basic test, the data written to the log file should already
be available in the page cache once the process exits. Forcing a system-wide
sync might stall the CI environment unnecessarily.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824063744.1533=
837-1-irogers@google.com?part=3D7
