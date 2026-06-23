Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E553C1405
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252042; cv=none; b=tsbCmelAeCsCnj+KBymTipZdNHdbRsHkZlBfXJ8at5d+4ZoFlUpI5jXJ5+Y2YcQr+oFOmeItgukvgxPax49d1XB3sEuNE6F0deAwz5q4avF4SY+Z3vfLdeI2qqanr7Uj0hz6cFPIPq/fEFZsj3ssi6IsI4ubcgoSZLn0yWvt/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252042; c=relaxed/simple;
	bh=VNaZXx4m2qoCWcVPCnZrZ+cXyWMwD20eEBabvSQoncQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mDUnZ3Onad0Tk+qs/8MOojXOhe2SJs/xOgy6frW0pj7VPAOlidsmiEL0UQZLHXhmd2Wz4KPVHSzWb2rLcqVuy1Tt4bybRhpMdAj0+mlUepMEqzOEd2GRK28DEXnwcLgIlqF09f1CbnnTrAIFJcWaoRSBHlea4n57rJKIzFW7og4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnAUgZTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnAUgZTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D291F000E9;
	Tue, 23 Jun 2026 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782252041;
	bh=JBqm4jmkoGRU0JkNDk6DxRqOLatSxsL97g2hw/C9rsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnAUgZTrt7NEKF4GrnC6N81gMDpgex15+OcuacEcq4qpD5ajuWGhLGpptc7A6dbGa
	 RkJ8dZfHxwlY5ENfhTZ1UCN35o/PZG0/BnKpRNUrV3umbC3Dtv2T75zps6nIgD1Efp
	 pW6+eB8ZfIBMCqu8jpM5sM8uzkVamxDjJE/dEYhfKVNep/Qrdold0HdLTBoMpdtF9H
	 XbcxYH+1T1fOfwyL5FtpCL6iAo/PoPKaagt9dCsnEL/q6uND3ggqFGkNKbnqFMi9xL
	 yveI7IhkLX8y8yilZNWrdiBvA+14npXDQ44CWB8+NXRFWSDe2NkxKxhi2K/EbMC3P5
	 plzSdaKGnYygQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/13] perf tests: Fix flakiness in branch stack
 sampling tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623012758.2291858-10-irogers@google.com>
References: <20260616164819.370939-1-irogers@google.com>
 <20260623012758.2291858-1-irogers@google.com>
 <20260623012758.2291858-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:00:40 +0000
Message-Id: <20260623220041.06D291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced retry loop logic causes false-positive log =
pollution for some tests on intermediate failures, while completely strippi=
ng necessary failure diagnostics from others.
--

commit d113a5c1702fc8bb852d96d6b5faea6997163754
Author: Ian Rogers <irogers@google.com>

perf tests: Fix flakiness in branch stack sampling tests

This commit increases the workload loop counts to 100,000 across three test
sections to guarantee robust branch stack capture during brief benchmark
execution. The iterations were introduced in a retry loop to prevent false
negatives.

> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/sh=
ell/test_brstack.sh
> index eb5837f82e390..71550e0b37baa 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -110,20 +110,29 @@ test_trap_eret_branches() {

[ ... ]

> -	err=3D0
> -	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
> -		perf test -w traploop 1000 > "$TMPDIR/record.txt" 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstacksym | \
> -		tr ' ' '\n' > $TMPDIR/perf.script
> -
> -	# BRBINF<n>.TYPE =3D=3D TRAP are mapped to PERF_BR_IRQ by the BRBE driv=
er
> -	check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
> -	check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"
> -	if [ $err -eq 0 ]; then
> +	local ret=3D1
> +	for loops in 1000 10000 100000; do
> +		err=3D0
> +		perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u,k -- \
> +			perf test -w traploop $loops > "$TMPDIR/record.txt" 2>&1
> +		perf script -i $TMPDIR/perf.data --fields brstacksym | \
> +			tr ' ' '\n' > $TMPDIR/perf.script
> +
> +		# BRBINF<n>.TYPE =3D=3D TRAP are mapped to PERF_BR_IRQ by the BRBE dri=
ver
> +		check_branches "^trap_bench\+[^ ]+/[^ ]/IRQ/"
> +		check_branches "^[^ ]+/trap_bench\+[^ ]+/ERET/"

[Severity: Medium]
Will these check_branches() calls pollute the test logs with false-positive
errors during intermediate loop iterations?=20

The shared check_branches() helper unconditionally prints "ERROR: Branches
missing" when it fails to find samples. This might trigger automated CI log
parser failures when an initial retryable loop iteration fails, even if a
subsequent iteration succeeds. This also applies to the similar loop added
to test_syscall().

> +		if [ $err -eq 0 ]; then
> +			ret=3D0
> +			break
> +		fi
> +	done

[ ... ]

> @@ -135,32 +144,40 @@ test_kernel_branches() {

[ ... ]

> -	# Look for source addresses with top bit set
> -	if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> -		echo "Testing kernel branch sampling [Failed kernel branches missing]"
> -		err=3D1
> -	fi
> -	# Look for no target addresses without top bit set
> -	if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{1,15}/" $TMPDIR/pe=
rf.script; then
> -		echo "Testing kernel branch sampling [Failed user branches found]"
> -		err=3D1
> -	fi
> -	if [ $err -eq 0 ]; then
> +	local ret=3D1
> +	for loops in 1000 10000 100000; do
> +		err=3D0
> +		perf record -o $TMPDIR/perf.data --branch-filter any,k -- \
> +			perf bench syscall basic --loop $loops > "$TMPDIR/record.txt" 2>&1
> +		perf script -i $TMPDIR/perf.data --fields brstack | \
> +			tr ' ' '\n' > $TMPDIR/perf.script
> +
> +		# Example of branch entries:
> +		#       "0xffffffff93bda241/0xffffffff93bda20f/M/-/-/..."
> +		# Source addresses come first in user or kernel code. Next is the targ=
et
> +		# address that must be in the kernel.
> +
> +		# Look for source addresses with top bit set
> +		if ! grep -q -E -m1 "^0x[89a-f][0-9a-f]{15}" $TMPDIR/perf.script; then
> +			err=3D1
> +		fi
> +		# Look for no target addresses without top bit set
> +		if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{1,15}/" \
> +			$TMPDIR/perf.script; then
> +			err=3D1
> +		fi

[Severity: Medium]
Does removing these diagnostic echo statements strip necessary failure
diagnostics?=20

If the test definitively fails after all retry iterations are exhausted, it
appears we will no longer know whether the failure was due to missing kernel
branches or unexpected user branches since the specific echo outputs have
been removed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623012758.2291=
858-1-irogers@google.com?part=3D9
