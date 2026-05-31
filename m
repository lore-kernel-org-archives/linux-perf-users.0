Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2226299
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206497; cv=none; b=LoCzOzrXMBGfHW4M637Y6AeFfhw8WZ/Y81qet/RGfhkYS8t1ti5qSdploXryPvaJcGVdmJ/TYWurmIyBYsxDEaBZkztKrhUVZhJG6iCe5WlyO9dH74LSp7fzfRTzSNNBkvk/aeQcm47ayr8h7lq0Qa2J8ljsS05QUdOHPvy0jso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206497; c=relaxed/simple;
	bh=hSTzQwqv1tOnBOUg/PduagzZ2mWaFDIu4GrZ0f4JuBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OqcfqLlQpFw87abD1DwKXJLFXN8+1eYHeOB+1lITvBplXqJPJBEQEvH5HDPWaLiLI/6HAXKGo2BaR92RIxK/Fi7aQE2XoU9KPoKI6GncsuH2l8zelknpmperw1dqi3I0hpkEwEJrA35OwwCJqB5ldKqPqh76bsD584SveI5axwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BByvmS4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BByvmS4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC301F00893;
	Sun, 31 May 2026 05:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780206496;
	bh=GqIGxvqZIb7o3p1vFTqSrIe0bZlMwBLhVLOoO9Ww+mY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BByvmS4ozQt6Sk8VaovKLBRC1rso2m9NQeRQR4mbLujOoVXoSHwqkE1rMSDhXu+P4
	 BnQzE49Ad5+7WCcYA6kESTO4SUKFG12v8derdCXimIFLIQsbee9iiuI6tG3k1DHjnH
	 F1vaKbkS9awIIXLwZKY6j8IxlCrjLwyOqGfkI72FS6JdE4O1hPABWcols0cxtZ/P6B
	 1TF8bAeUNKps3h247RaVFQjBavlkT69UzR9yU/fpZM0Cd1PqGRTHf4T9JiS6eQpaOR
	 csaE8GAjc+j5N2g3TBHdHA/KySzfKvq/41ahPoQ5VwIOZzujouY6H70pKyZTOmsaQO
	 D14GqAN/FaJdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] perf test: Split monolithic 'util' test suite
 into sub-tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-12-irogers@google.com>
References: <20260531052740.796087-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:48:15 +0000
Message-Id: <20260531054815.DEC301F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The fallback logic in check_if_command_finished() deadlocks on zom=
bie processes when /proc/pid/status fails to open.
- [High] Raw characters from test output are passed to the tolower() macro =
without being cast to unsigned char, causing undefined behavior and potenti=
al out-of-bounds reads.
--

commit f640a118d91b710c58b64dc0322749367a37d9e9
Author: Ian Rogers <irogers@google.com>

perf test: Split monolithic 'util' test suite into sub-tests

This commit refactors the monolithic 'util' test suite into distinct 'String
replacement' and 'BLAKE2s hash' sub-tests using the struct test_case framew=
ork.
This improves test reporting granularity for subsequent JUnit XML reporting.

> diff --git a/tools/perf/tests/util.c b/tools/perf/tests/util.c
> index bf2c5b1338844..f9abd9911e6ca 100644
> --- a/tools/perf/tests/util.c
> +++ b/tools/perf/tests/util.c
[ ... ]

While reviewing this series, I noticed a couple of regressions introduced by
earlier patches in the series.

tools/lib/subcmd/run-command.c:check_if_command_finished() {
...
	status_file =3D fopen(filename, "r");
	if (status_file =3D=3D NULL) {
...
		if (errno =3D=3D ENOENT)
			return 1;
		if (kill(cmd->pid, 0) =3D=3D -1 && errno =3D=3D ESRCH)
			return 1;
		return 0;
	}
...
}

[Severity: High]
This isn't a bug introduced by this patch, but by a previous patch in the
series ('perf test: Refactor parallel poll loop to drain all pipes
simultaneously'). Does this fallback logic deadlock on zombie processes when
/proc/pid/status fails to open?

When running tests in parallel, file descriptors can be exhausted, causing
fopen() to fail with EMFILE.

The code falls back to kill(cmd->pid, 0), which succeeds (returns 0) for
zombie processes. Since check_if_command_finished() returns 0, the test
runner never calls finish_command() to reap the zombie via waitpid().

Will the zombie remain in the process table forever, causing the parent
finish_tests_parallel() loop to spin indefinitely in a deadlock?


tools/perf/tests/builtin-test.c:find_next_keyword() {
...
			for (i =3D 0; i < len; i++) {
				if (tolower(s[i]) !=3D fail_keywords[k][i])
					break;
			}
...
}

[Severity: High]
This is a pre-existing issue, but it was introduced by a previous patch in
the series ('perf test: Show snippet failure output for verbose=3D1'). Are =
raw
characters from test output being passed to the tolower() macro without
being cast to unsigned char?

Characters from the raw stderr output buffer are passed directly to
tolower(s[i]).

On architectures where char is signed, characters with the high bit set (>=
=3D 128)
are sign-extended to negative integers. In glibc, tolower() uses the integer
directly as an index into a lookup array.

Can these negative values cause out-of-bounds memory reads, potentially cra=
shing
the test runner when it attempts to parse arbitrary or localized child test
output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D11
