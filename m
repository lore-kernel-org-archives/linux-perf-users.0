Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EB3542F6
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780693537; cv=none; b=l5veCGHiq6YFCACmRlzCu8PqGGhV3F4MWTVZjT2Pr488Y/m5uzkr0CYzB3MvpI1lnAqKDw+MYrSUoqfT0NH/Mc+bg2XoUbXEri8UCtMpiGGD5m2BO4+CN483/Vz0PvzQyzR8vThI8HkUIDUIanHLPOPtFn+wTVE5vGa6rxX4oOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780693537; c=relaxed/simple;
	bh=mBK5MuzFQwp/2zV1ZfnDQxgcMA87d/wy7qm9TgukkCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cq4Lx/kw6L78fR833rw0ZMBr0CYjbwWGjOOc/5uWiMhVX19GdGY5T7sWDL18tPHnltoTWmmab6ZdkkXhe58iSu5gWRXK10YAdKckLLW1gghWg2a1PlJOBQF+7uYWiOGUHzq0jHaeW1tz2LK//lLukCbDw8dTKaHymgeEyhtMf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW8T4w3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW8T4w3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEA51F00893;
	Fri,  5 Jun 2026 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780693535;
	bh=mBK5MuzFQwp/2zV1ZfnDQxgcMA87d/wy7qm9TgukkCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JW8T4w3LGA63E1vOJtI4emBZwr7w8WYuLd0PGCTMLiS7IY7rrch7bNuTpbpIK0ub7
	 Ud2uf5/gU5MsOcb3qy1g0JWOF3nmgAoSjVEXzzFiqS8/fvN++i5h6szJkAUYzUTaG+
	 T/KTa9eOV+uwBj5vuZea6g0QjYfGazN8gCN08elP4CJj1SY/rMoiAl2O5xlCbGYG+q
	 Rc68kZtamJJ/frUOTKEnDK6XYMekVCYyolwIYQWck6XpBbBAj+BKHEUXncPlgfh6kA
	 lZiRaOLBIcu/F2uN0AJOdZ4EO+DJCsi1JBbuwIHOUMocNXj5ipZukvJfusbyXIOs4n
	 Q+B92Sp3JoeQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 4/5] perf test: Add inject ASLR test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605205649.2566948-5-irogers@google.com>
References: <20260605205649.2566948-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 21:05:35 +0000
Message-Id: <20260605210535.8AEA51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The kernel workload for sampling (`dd if=3D/dev/zero of=3D/dev/n=
ull bs=3D1M count=3D500`) executes too quickly on modern systems, risking 0=
 kernel samples and causing flaky test failures.
--

commit d9af52a5de1d8869d352d74aa99a8ba4f6d3011b
Author: Ian Rogers <irogers@google.com>

perf test: Add inject ASLR test

This commit adds a new shell test inject_aslr.sh to verify ASLR address
remapping. The test validates sample generation and address remapping
across basic operations, pipe modes, callchains, and kernel sampling.

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> new file mode 100755
> index 0000000000000..d8ded16ba9052
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh
> @@ -0,0 +1,464 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# perf inject --aslr test
> +
> +set -e
> +set -o pipefail
> +
> +shelldir=3D$(dirname "$0")
> +# shellcheck source=3Dlib/perf_has_symbol.sh
> +. "${shelldir}"/lib/perf_has_symbol.sh
> +
> +sym=3D"noploop"
> +
> +skip_test_missing_symbol ${sym}
> +
> +# Create global temp directory
> +temp_dir=3D$(mktemp -d /tmp/perf-test-aslr.XXXXXXXXXX)
> +
> +prog=3D"perf test -w noploop"
> +[ "$(uname -m)" =3D "s390x" ] && prog=3D"$prog 3"
> +err=3D0
> +kprog=3D"dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=3D500"

[Severity: Medium]
Will this workload execute too quickly on modern systems?

The command transfers 500MB in 1MB chunks, resulting in only 1000 syscalls
which could complete in just a few milliseconds.

With perf record defaulting to a ~4000Hz sampling rate, a workload completi=
ng
this fast might generate very few or exactly 0 task-clock:k samples,
potentially causing flaky test failures.

Could we replace this with a syscall-bound workload, like using the default
512B block size with a larger count, to ensure consistent kernel execution
time irrespective of memory bandwidth?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605205649.2566=
948-1-irogers@google.com?part=3D4
