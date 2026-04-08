Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3E3624A4
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775628739; cv=none; b=lEMklrGY472gLb4NpTn2MLlv5lilyjoA4jUHp/AJwaXJ/CN/pZsMt9iKgS/N/P0UGD11NTg3yUjbo/9cul3bEg6sKOb7gOaWJWh48N4ZU0gQPRoK4LiwC/veQuOFQh1tLqwRevRJKJkSESnCMUmNry2g0SSvuqzp0HnG8JrIvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775628739; c=relaxed/simple;
	bh=nr/YrN1Cm24BGuLta4FYP1ullhNnn1/KLd1B436dkg8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n/m3utsh8W28wE46RKUDTFx7+ss5yZthr4ootqcIh66xqC55SA3foRdW7COtfltke987I/1VwV2c19tQVE1vC4UhOruEbJ+jjRDo75KS5IPCkjW//dxxzuDul+sBQsATYBEdBgoZ1qJduDmlGSmuGqTGS+k6NBLSg+xcSdkxG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCaZhR34; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCaZhR34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFAEC19424;
	Wed,  8 Apr 2026 06:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775628738;
	bh=nr/YrN1Cm24BGuLta4FYP1ullhNnn1/KLd1B436dkg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LCaZhR34VW5IdA6r3SnMwjCMFrocH5qCwhFjA+XzcvwaySTSt5BHSTQOTuuA6Dglk
	 VSnmsZdeYJ9cYs0zZnVPWJPr7GeO2grDf+m+mtCY3rZLGAo0acGzcn62PrmmVm0oe5
	 Z3jXl9KUD9RI37X2QF/AiLk+QnXuT/pUmZwxab9yk8XvINZFfC3278yWqZoEsOXMFT
	 LnUH/QJAQHcKNVrRkAEnoNdnvZdCeQ5ONEzREE9i35D0KWxIj7f2zoEpmEf3XycQBw
	 hychbE8DvvTYOb8s7jNE2pRPD8eAKu86gQh9uI0vLSLzo8ie4ECTH6rqMKYUBeRsy7
	 WfxlTZBQas6fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf test: Fixes for check branch stack sampling
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408060303.51231-1-irogers@google.com>
References: <20260408060303.51231-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 06:12:18 +0000
Message-Id: <20260408061218.9FFAEC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Incorrect regex in `test_user_branches()` renders the test a fal=
se negative for leaked kernel addresses.
- [Low] Contradictory test output in `test_syscall()` when skipped.
- [Low] Missing closing bracket in the failure log output of `test_kernel_b=
ranches()`.
--

commit 5cc9b2c1d3de6813cdf5dae014b695e4edf82d5d
Author: Ian Rogers <irogers@google.com>

perf test: Fixes for check branch stack sampling

This commit updates the branch stack sampling tests to filter cross-boundary
branches properly and increases the sampling duration to make syscall
sampling more reliable. It also redirects unnecessary test output to
temporary files to unclutter the logs and improves the pass/fail reporting.

> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/sh=
ell/test_brstack.sh
> index 85233d435be63..d317ed0e063ef 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
[ ... ]
> @@ -73,59 +75,81 @@ test_user_branches() {
>  	perf script -i "$TMPDIR/perf.data" --fields brstack | \
>  		tr ' ' '\n' > "$TMPDIR/perf.script"
> =20
> -	# There should be no kernel addresses with the u option, in either
> -	# source or target addresses.
> -	if grep -E -m1 "0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> -		echo "ERROR: Kernel address found in user mode"
> +	# There should be no kernel addresses in the target with the u option.
> +	if grep -q -E -m1 "^0x[0-9a-f]{16}/[89a-f][0-9a-f]{15}/" $TMPDIR/perf.s=
cript; then

The perf script output normally prefixes addresses with 0x, but this regex
appears to expect the target address immediately after the slash to lack a
0x prefix.

It also requires the source address to be exactly 16 hex digits, but user
space addresses often lack zero-padding and look like 0x400000.

Does this regex fail to match these output formats, preventing it from
detecting leaked kernel addresses in the test?

> +		echo "Testing user branch stack sampling [Failed kernel address found =
in user mode]"
>  		err=3D1
>  	fi
[ ... ]
>  test_kernel_branches() {
>  	echo "Testing that k option only includes kernel source addresses"
> =20
[ ... ]
> +	# Look for no target addresses without top bit set
> +	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{0,15}/" $TMPDIR/pe=
rf.script; then
> +		echo "Testing that k option [Failed user branches found with kernel fi=
lter"

This isn't a bug, but there is a missing closing ] bracket at the end of the
failure string.

> +		err=3D1
> +	fi
[ ... ]
>  test_syscall() {
>  	echo "Testing syscalls"
> +	start_err=3D$err
> +	err=3D0
>  	# skip if perf doesn't have enough privileges
> -	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
> -		echo "skip: not enough privileges"
> +	if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/record.tx=
t" 2>&1; then
> +		echo "Testing syscalls [Skipped: not enough privileges]"
>  	else
>  		perf record -o $TMPDIR/perf.data --branch-filter \
> -			any_call,save_type,u,k -c 10000 -- \
> -			perf bench syscall basic --loop 1000
> +			any_call,save_type,u,k -c 10007 -- \
> +			perf bench syscall basic --loop 8000  > "$TMPDIR/record.txt" 2>&1
>  		perf script -i $TMPDIR/perf.data --fields brstacksym | \
>  			tr ' ' '\n' > $TMPDIR/perf.script
> =20
>  		check_branches "getppid[^ ]*/SYSCALL/"
>  	fi
> +	if [ $err -eq 0 ]; then
> +		echo "Testing syscalls [Passed]"

Unlike test_kernel_branches(), there is no early return after the skip
message.

If perf record lacks privileges, will the test execution fall through to he=
re
and incorrectly print that the test passed immediately after printing that
it was skipped?

> +		err=3D$start_err
> +	else
> +		echo "Testing syscalls [Failed]"
> +	fi
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408060303.5123=
1-1-irogers@google.com?part=3D1
