Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C025776
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630086; cv=none; b=ki45npbTtpdHvn+I+KMUwdb3j1vajYfFUnMd7z542yasBaTzpTrPtGDBf6VkDkf+ItKwMOHpAfdMAhBJ8x02Q4wuV2Iv1fs87tCdBv26+pjMSBuMbX8Ene/jyjT/zcRQx4UH52d7luloHfKTzJaSsG1O8SKotFoMJ8TKbWHj4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630086; c=relaxed/simple;
	bh=kvjeO07J9no+S192Uow+2/8xDrYWUoHWgtAqidJBxKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D82DhBy6OLY0DZWK+SyYPS4ywKZqmFfZCGeyjmTy/usZMnwLm+CMh2EL1xRe8E5DKcmLeu+pgU9b1wZIU1h3GTQOyr7JhvZuQZPxubb0PiCSjFYZANJSuMCqqmf+z3odm75KWmyXl/VkW3nTBzTXlvQPj78cdmkEx31lDoGSBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtt1m05A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtt1m05A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C0CC19424;
	Wed,  8 Apr 2026 06:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775630085;
	bh=kvjeO07J9no+S192Uow+2/8xDrYWUoHWgtAqidJBxKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Vtt1m05A9USE4lir06bNmHGzZ0mAIFYm3OtDwZPsCAcqu+C4PqwiuYshxpjUwfBFN
	 PvfCdNclDmKVQbt8QvMPv3X4Ggw4PDtrpYZsoz8Bp3uCc5xWst6hXzjN1KFoH++Tp7
	 qZTexDEhKasOkegnKXGgl43aclgBtg1QBNW3o+qdFW4YTtsHEMwIp/sWWnfRmss24p
	 DOj/8C+cuGE5feT8oWjaHtNVH8KGRsmCPX7WCFBIJtENxLhVAW7d+TK3by+UtGjkaA
	 eafwsTKmGyqSKejW+bIOsXk2OXrgNSTw0IikLIA5cYfkgiS1D3jpSyyCR37opZZk3T
	 4KqNmvuVh/gXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf test: Fixes for check branch stack sampling
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408062048.61252-1-irogers@google.com>
References: <20260408062048.61252-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 06:34:45 +0000
Message-Id: <20260408063445.91C0CC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Outdated comments and output messages in `test_kernel_branches` =
explicitly contradict the new test logic and the commit message.
- [Medium] Missing `perf record` output redirection in `test_trap_eret_bran=
ches`.
--

commit 123631eaa14de0c5e9e90fa3e9a1064ed9d669af
Author: Ian Rogers <irogers@google.com>

perf test: Fixes for check branch stack sampling

This commit updates branch stack sampling tests to handle user/kernel
boundary crossings. It also increases the duration of the system call
sampling test for reliability, and redirects unneeded perf record output
to a temporary file.

> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/sh=
ell/test_brstack.sh
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh

[ ... ]

>  test_trap_eret_branches() {
>  	echo "Testing trap & eret branches"
> +
>  	if ! is_arm64; then
> -		echo "skip: not arm64"
> +		echo "Testing trap & eret branches [Skipped not arm64]"
> +		return
> +	fi
> +	start_err=3D$err
> +	err=3D0
> +	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
> +		perf test -w traploop 1000

The commit message states that unneeded perf record output is put into a
temporary file to avoid cluttering the test output. Was the redirection
intentionally omitted for this specific test?

> +	perf script -i $TMPDIR/perf.data --fields brstacksym | \
> +		tr ' ' '\n' > $TMPDIR/perf.script

[ ... ]

>  test_kernel_branches() {
>  	echo "Testing that k option only includes kernel source addresses"

Does this output message still reflect the test's intent? The commit message
states that the test now allows the source to be in user land, but this
message says it "only includes kernel source addresses".

> =20
> -	if ! perf record --branch-filter any,k -o- -- true > /dev/null; then
> -		echo "skip: not enough privileges"
> +	if ! perf record --branch-filter any,k -o- -- true > "$TMPDIR/record.tx=
t" 2>&1; then
> +		echo "Testing that k option [Skipped not enough privileges]"
> +		return
> +	fi
> +	start_err=3D$err
> +	err=3D0
> +	perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
> +		perf bench syscall basic --loop 1000 > "$TMPDIR/record.txt" 2>&1
> +	perf script -i $TMPDIR/perf.data --fields brstack | \
> +		tr ' ' '\n' > $TMPDIR/perf.script
> +
> +	# Example of branch entries:
> +	#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
> +	# Source addresses come first and target address can be either
> +	# userspace or kernel even with k option, as long as the source
> +	# is in kernel.

This isn't a bug, but this comment appears to contradict the new test logic.
The new test logic below correctly checks that the target address is in the
kernel rather than the source address. Should this comment be updated?

> +
> +	# Look for source addresses with top bit set
> +	if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> +		echo "Testing that k option [Failed kernel branches missing]"
> +		err=3D1
> +	fi
> +	# Look for no target addresses without top bit set
> +	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{0,15}/" $TMPDIR/pe=
rf.script; then
> +		echo "Testing that k option [Failed user branches found with kernel fi=
lter]"
> +		err=3D1
> +	fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408062048.6125=
2-1-irogers@google.com?part=3D1
