Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D19EAC7
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775693747; cv=none; b=Hj1H+kUW6JJRejm3kGrr1Dnyz696MAGNqkS6x0iEzjQNU1mwA8Wx37M74zQRl3GPfO0MGXX14hO7BpPn75VgDQej5VahHqExr2qzumMMt0rlkQySjBPVTNIGJlC+xBYvtHAGsZzqahcJr7++hq5N6tRyZijgsWWzrjors+ZJpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775693747; c=relaxed/simple;
	bh=glGhpTN6aIMMp+sK7qgQ+ZlFnRhBrjUGFwLphqFtcfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j+HNkll9FaSl2I2KKWXtLqOtEaJyt7TGMJ/+jEFENG7+X96biMEf2deVr8om1b/jU8htJK3se+s6fuUONFZRK4cXk3IR+3SE8SNxIuP+cbtLVnKQhRr/WEnbP+uALv8bZoRn6vX/qwItTPMVfy/4TIgGiC9m7LWTjd3EyoXO4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGrQwcJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGrQwcJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3A7C19421;
	Thu,  9 Apr 2026 00:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775693747;
	bh=glGhpTN6aIMMp+sK7qgQ+ZlFnRhBrjUGFwLphqFtcfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hGrQwcJWDAYuyhkF1Lel9lwTSx9DzuuQrFkmMfjcm05z/Q55iJ9d0Qw4AKhgjizji
	 iDNjnyrbSdY87+xVD74Rzozb6VZAd4vZ0MybamU7FIL434Jn5lywKvQgDU044h4PwB
	 fMp1GCqV+UUW4fXq2ITsOte+kX/pIEBA+wEOXHCdnRBIRM/uWsUgqykDdG04wYSGXn
	 Zxvxj4OQhDkJ9CH30MAQyNb9gRSn1Vaa2qzrT2mcYq5FRxt666HVZH8Vor4Tt77d+K
	 FzkIFaIoLrtKwC0sSaXW+AhC3UiXBjyQS7CQDHnpUgExA6rN4zejYj+ec2I2Y1F9qQ
	 iHoN9LGugkj0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] perf test: Fixes for check branch stack sampling
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260409000216.196083-1-irogers@google.com>
References: <20260409000216.196083-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2026 00:15:46 +0000
Message-Id: <20260409001547.0C3A7C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The regular expression to check for user-space target addresses =
incorrectly uses `{1,15}`, which excludes single-digit hex addresses like `=
0x0`.
--

commit e332f30c098056428ef830d84c8207d356af6ea2
Author: Ian Rogers <irogers@google.com>

perf test: Fixes for check branch stack sampling

This commit modifies the branch stack sampling tests to be more permissive
regarding kernel addresses in user branches and user addresses in kernel
branches. It also adjusts the system call sampling test parameters and
redirects unnecessary output to a temporary file.

> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/sh=
ell/test_brstack.sh
> index 85233d435be63..eb5837f82e390 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -73,59 +79,88 @@ test_user_branches() {
[ ... ]
>  test_kernel_branches() {
[ ... ]
> -		# Look for no source addresses without top bit set
> -		if grep -E -m1 "^0x[0-7][0-9a-f]{0,15}" $TMPDIR/perf.script; then
> -			echo "ERROR: User branches found with kernel filter"
> -			err=3D1
> -		fi
> +	# Look for no target addresses without top bit set
> +	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{1,15}/" $TMPDIR/pe=
rf.script; then

Does the regex "{1,15}" incorrectly exclude single-digit hex addresses like
"0x0"?

Since the commit message notes that Aarch64 may zero out user land
addresses to prevent leaks, a zeroed address would be output as "0x0" by pe=
rf
script.

The previous regex used "{0,15}", which would match "0x0", but the
updated regex requires at least two hex digits when starting with 0-7.

Could this cause the test to silently miss zeroed addresses and produce a f=
alse
negative?

> +		echo "Testing kernel branch sampling [Failed user branches found]"
> +		err=3D1
> +	fi
> +	if [ $err -eq 0 ]; then
> +		echo "Testing kernel branch sampling [Passed]"
> +		err=3D$start_err
>  	else
> -		perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
> -			perf bench syscall basic --loop 1000
> -		perf script -i $TMPDIR/perf.data --fields brstack | \
> -			tr ' ' '\n' > $TMPDIR/perf.script
> -
> -		# Example of branch entries:
> -		#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
> -		# Source addresses come first and target address can be either
> -		# userspace or kernel even with k option, as long as the source
> -		# is in kernel.
> -
> -		#Look for source addresses with top bit set
> -		if ! grep -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> -			echo "ERROR: Kernel branches missing"
> -			err=3D1
> -		fi
> -		# Look for no source addresses without top bit set
> -		if grep -E -m1 "^0x[0-7][0-9a-f]{0,15}" $TMPDIR/perf.script; then
> -			echo "ERROR: User branches found with kernel filter"
> -			err=3D1
> -		fi
> +		echo "Testing kernel branch sampling [Failed]"
>  	fi
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260409000216.1960=
83-1-irogers@google.com?part=3D1
