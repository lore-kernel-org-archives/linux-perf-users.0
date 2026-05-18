Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE012D5A01
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137721; cv=none; b=Gjl8LXtpEe9f5SXo5zjbI9lW7VPNEL4sqRu6KCpcGeF9aZAb0LMgYDAvEtPlIvcAFCuPTO+Pu0W7NAm583CGJAiDU71V1b8CBh7ieXpzSzsqYIT+EYYzHc6Ful8wD1SkZvhcfs3BH5X/jQWJb1YgLOF2nbyBPj6K7WLVY+tBHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137721; c=relaxed/simple;
	bh=AOSdmyzPG+QRFRF+5DKfJ3NxGRcl58VE/EHNY7Tj+vA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J3hh7o4TrrMigjczQg/VzyUcYLScz9n2/6Y/nfAAH/yViVuV7zB3EUsN0dsdQ/wSEwnuDDR66ApPIyOMmOUjZupuB8zGBTPPwFxrY8ynRmRg8EgY+Q77TX09futqQvv/P7nimDfz8nMA/qJUxCsxPJu4iuyByovmpmmZKZHeqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/zzY3lY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/zzY3lY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFACC2BCB7;
	Mon, 18 May 2026 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779137721;
	bh=AOSdmyzPG+QRFRF+5DKfJ3NxGRcl58VE/EHNY7Tj+vA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=K/zzY3lYeun4Pdu10Oq6GYdiG939dSutabUhfkGa0loMGK1ppxZrGyJKemtInt6K7
	 2sHjibrOXfbrAgmEzmUCuIjfGvLRINze9IsAsd6FtewLML1mVT8/EalZqJH2M8nTaa
	 nWIOZkWbfpKhp03mzw49zHBsmX/AfdkajLtlTp7S/o8GmizFU+AQ3we5YuRbEDGgSP
	 IdhLbXO6o4Xja8oxNtPEXAtgfC3m8wh+nq7O+T0I+DcWWJGqZAPUbJqvklsIRwnFMv
	 /vN5wJdJmoEoIzDvpsXuYEAU+BfhjMd7wXDdsPvymGjoURVwOEJg/rRqV4WAph4XKQ
	 ShT5YK8U/9/wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf tests: Add test for stat delay option with
 duration_time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518201419.2943132-3-irogers@google.com>
References: <20260518201419.2943132-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 20:55:20 +0000
Message-Id: <20260518205521.0BFACC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `test_stat_delay` test lacks an upper bound check, failing t=
o verify that the delay is excluded from `duration_time`.
--

commit b57a62c916c7df08ef099bd333919c50a5312b13
Author: Ian Rogers <irogers@google.com>

perf tests: Add test for stat delay option with duration_time

This commit adds a test case test_stat_delay to stat.sh to verify that
duration_time correctly excludes the delay period when using the delay
option (-D). It runs a perf stat command with a 1000ms delay and a 2 second
sleep, and checks the resulting duration_time.

> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat=
.sh
> index 4edb04039036e..a9eadd57e1644 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
[ ... ]
> @@ -483,6 +483,53 @@ test_stat_pid() {
>    wait $pid 2>/dev/null || true
>  }
> =20
> +test_stat_delay() {
> +  echo "stat -D test"
> +  if ! env LC_ALL=3DC perf stat -D 1000 -e duration_time sleep 2 > "${st=
at_output}" 2>&1
> +  then
> +    echo "stat -D test [Failed - command failed]"
> +    cat "${stat_output}"
> +    err=3D1
> +    return
> +  fi
> +
> +  duration=3D$(grep "duration_time" "${stat_output}" | awk '{print $1}' =
| tr -d ',')
> +  elapsed=3D$(grep "seconds time elapsed" "${stat_output}" | awk '{print=
 $1}')
> +
> +  if [ -z "$duration" ] || [ -z "$elapsed" ]
> +  then
> +    echo "stat -D test [Failed - failed to find duration_time or time el=
apsed in output]"
> +    cat "${stat_output}"
> +    err=3D1
> +    return
> +  fi
> +
> +  # Compare duration (ns) and elapsed (s) using awk to handle float and =
allow tolerance.
> +  if ! awk -v d=3D"$duration" -v e=3D"$elapsed" '
> +    BEGIN {
> +      diff =3D d - (e * 1e9);
> +      if (diff < 0) diff =3D -diff;
> +      # Allow 200ms tolerance (200,000,000 ns) for loaded CI machines.
> +      if (diff > 200000000) {
> +        printf "Fail: duration (%d ns) and elapsed (%f s) mismatch (diff=
 %d ns)\n", d, e, diff;
> +        exit 1;
> +      }
> +      # Lower bound check: must be at least 0.5s.
> +      if (d < 500000000) {
> +        printf "Fail: duration (%d ns) is abnormally small\n", d;
> +        exit 1;
> +      }

Is there a missing upper bound check here to verify the delay was actually
excluded from duration_time?

The commit message states the test verifies duration_time is ~1s and not ~2=
s.
However, if a regression caused the -D option to be ignored, both duration
and elapsed would measure the full 2 seconds of the sleep command.

In that scenario, the difference between them would be near 0 (passing the
mismatch check), and duration would be ~2s which is > 0.5s (passing the low=
er
bound check). The test would silently pass, failing to detect the issue.

Could an upper bound check be added to ensure duration_time is strictly less
than 2 seconds?

> +      exit 0;
> +    }'

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518201419.2943=
132-1-irogers@google.com?part=3D2
