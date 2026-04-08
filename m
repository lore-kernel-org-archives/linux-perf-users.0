Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133B376BDE
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632608; cv=none; b=I+FwrCxjStt7XJyMqbPRkk6QXheimMy3yRe80ohsCUlAVsDVWIzjT4XVT0t50rkAAFo0pBfqnsol5/E1Pk+tpMTzEORtBkvDpbl2fs5xle4otqlL3X1rrNnD++qGKabk/l5gWympAsSnbclAPCgYfzMSX2C9OJ3rbA+R/PrPN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632608; c=relaxed/simple;
	bh=H+VQZU1284xl2udoZN/470JV3j6iqbA1OAxO+AiU46Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B6FgA6MjMOFol3yNdweKYIxuil9uyaSRcg5fkFfdMqXZxZ08RBy2bzvxgoftIr2rmEhU+kiZKy1VSyiyvJ1ZZAtRygPgOxcaqpnHVnn3DihkTXpO7FAt7G5iBqmAjZMyY0D1gU909Sb4DgJqw/4jsu4lTz3D0NLmkjGp/QNWB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYyEIMq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYyEIMq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389A6C19424;
	Wed,  8 Apr 2026 07:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775632608;
	bh=H+VQZU1284xl2udoZN/470JV3j6iqbA1OAxO+AiU46Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gYyEIMq2jKV/MvF9knzHZpWe7McMLOj5e1BERmUEbbKgnmRTcNhYFiltfitreYmfP
	 /KaZVtO+aoURsz8Jfny0e5T85Lu5tFVSA5hAY+dsXq8DneQCcW7tROOGyZIFNl4+zh
	 zr9G2PMhh4OlQT2TxJ39uSMHOk+bfDGZzlxQr0ckIHHnWMn4TEp+lE1Z8v3Pyc7uBV
	 iyhQqnNXBRE+KbOu6fYtgObMEMu5ta6+PmnYpwlh99sxXTR1W8OovlaZXiOOHyAt4W
	 vIDO9t8MGBBxNEZjim0amh32x+gJwPHaTwkR80DM5tNu78VEEbtKE+5llCiUbYwRE/
	 Igq1/bu5AWDRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf test: Fixes for check branch stack sampling
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408065841.165393-1-irogers@google.com>
References: <20260408065841.165393-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 07:16:47 +0000
Message-Id: <20260408071648.389A6C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Incomplete regex in `test_kernel_branches` misses user branch ta=
rget addresses that don't start with 0-7, causing false negatives.
--

commit 81a20991ebd7cf4f6e494b9b81ee11052acea653
Author: Ian Rogers <irogers@google.com>

perf test: Fixes for check branch stack sampling

This commit fixes and expands the branch stack sampling tests in perf.
It updates user and kernel branch filters to properly check source and targ=
et
addresses, increases system call sampling duration for reliability, and cle=
ans
up test output.

> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/sh=
ell/test_brstack.sh
> index 85233d435be63..025ed9d3d1105 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
[ ... ]
> @@ -73,59 +75,80 @@ test_user_branches() {
[ ... ]
>  test_kernel_branches() {
[ ... ]
> +	# Look for no target addresses without top bit set
> +	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{0,15}/" $TMPDIR/pe=
rf.script; then

Does this regex reliably match all user space target addresses?

Because perf script prints brstack addresses without zero-padding, a valid
32-bit user address like 0x8048000 begins with 8 but is much shorter than
16 characters.

Since the regex strictly requires the first character after the prefix to be
between 0 and 7, it seems like it might silently miss shorter user addresses
that start with 8 through f, potentially causing the test to pass when it
should fail.

> +		echo "Testing kernel branch sampling [Failed user branches found]"
> +		err=3D1
> +	fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408065841.1653=
93-1-irogers@google.com?part=3D1
