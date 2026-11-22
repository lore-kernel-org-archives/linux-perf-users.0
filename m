Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384485;
	b=g9k3Ls6+uq0bKU0pgHkqRHTkJXv2JFY6db8iPu6rB9yQV0y0nAfFdF3YDOtySiHesYzz
	 64WOXIQNZmTMXeA72CxhXir9cskZSm9JIiIUux45T1/wa+D1ZTa105OHiC08UCJEH2WqT
	 toVAcrvooriaz9U16zpntAtOcenn0T3JTl6thuGRw911Tf1rk7w+5rBp4K0ZRixPWF6jZ
	 4tnLleAljSeE5mSb8yDvQDHNdnTsKdoO8D08+9t4xQyqVCOSHdyZC2k33Bgh41FZsP8P+
	 7e9rUulh8Psl5GSjcWIj8ajaJKCcDFwx+GXLXW5Ic3eRSeKdMHTwiV6L2em417n379w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4ATG0yMueQBNISjSNvfTY4FRqMIE0QOL2FEVWwyGuzI=;
	b=1AlwhE+RdqPj1DvXZjzDHlxNlYuaqCcebwuDvynjikwVc7bswNu1hFYLE+0C1YKZWXUp
	 bYaUix9Ju7hvhg5j5IXRPl+LtXnE/wGsEYXe5kv7Mlw8XFmj3QzRWohpYVT3bm9mVUG5P
	 DGumlmWiQfhkdKEAFGPS12kAVa5CNLveJodr6OCzHom8SDJ4uDZwRR0BRobSuExHXMA2r
	 rOvqTIvduwZbghi6xUPAFIm9X2+aTDTHpqmNvX/GKgzN3wbsxzSMamaCLc2byKiWdkNMG
	 /4zZfy0ELhH939ErDAkncVFVBcF0Ze9KvFqMBk3Crk4e/D00CeodIq8ly7WvkYZt9xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VO6mbv3G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7C606A31E
	for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VO6mbv3G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031F51F000C0;
	Sun, 22 Nov 2026 21:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795384485;
	bh=4ATG0yMueQBNISjSNvfTY4FRqMIE0QOL2FEVWwyGuzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VO6mbv3GW9dhCdLkgt5bwF/FLJDSVLxJiFV5HyqUpUh9bRcBET5minXZiQkVOSE5k
	 xYGGlXuLFNbs0GeTE95bu76JMC4b93N3OekGT6ilg7NcQICeoOCaA6KtyblMEMrit4
	 7n7aa8Sw1umpPFW3ws6oxhvXhnqNKLcbmJUiSsKc9kximoua8YkiL3m79KvFKp+YeT
	 ikOOomppXWkWBI0nxOHY5PdKrKRVaKSOXJl6gnxfiEGPdt3fqYIFVJQaBE/VSVxjJt
	 eq9QWENfgWvfgeekOsRWIez1MGaI5ds3dtWxKrY68aYFDya0NzgD055yF7ENpnRSom
	 SP6aeCAOyO3Dw==
Message-ID: <sashiko-outbox-228397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 18/19] perf scripts: Add a coverage harness for perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261122214025.16769-19-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
 <20261122214025.16769-19-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 21:54:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf scripts: coverage.sh deletes python/perf*.so breaking
  root reruns
--

commit 9ed4bdc97ad1f9cf11d58cc735ab649590f18481
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add a coverage harness for perf

This commit adds scripts/coverage.sh and the coverage and coverage-prep
make targets to build perf with clang source-based coverage, run the perf
test suite, and report line and function coverage.

> diff --git a/tools/perf/scripts/coverage.sh b/tools/perf/scripts/coverage=
.sh
> new file mode 100755
> index 0000000000000..90845f94ac930
> --- /dev/null
> +++ b/tools/perf/scripts/coverage.sh

[ ... ]

> +# Root does not rebuild a prepared build: use the perf already in
> +# BUILD_DIR, or build when there is none.
> +if [ "$ROOT" =3D 1 ] && [ "$PREP" =3D 0 ]; then
> +	if [ -x "$BUILD_DIR/perf" ]; then
> +		SKIP_BUILD=3D1
> +		say "Running as root, using the coverage build in $BUILD_DIR"
> +	else
> +		say "Running as root, building perf in $BUILD_DIR"
> +	fi
> +fi
> +
> +if [ "$SKIP_BUILD" =3D 0 ]; then
> +	command -v clang > /dev/null ||
> +		die "clang not found, it is the only compiler with -fcoverage-mapping"
> +	command -v clang++ > /dev/null ||
> +		die "clang++ not found, it instruments the C++ sources"
> +fi
> +
> +test_status=3D0
> +
> +if [ "$PREP" =3D 1 ]; then
> +	build_perf
> +	say "Coverage build ready: $BUILD_DIR/perf"
> +	make_hint=3D"make -C $PERF_DIR coverage"
> +	[ "$BUILD_DIR" =3D "$PERF_DIR" ] || make_hint+=3D" O=3D$BUILD_DIR"
> +	printf "As root: %s\n" "$make_hint"
> +	exit 0
> +fi
> +
> +build_perf
> +run_tests
> +merge_profiles
> +
> +[ -f "$PROFDATA" ] || die "no $PROFDATA, the merge did not run"
> +
> +export LC_ALL=3DC
> +render_report
> +print_summary
> +update_baseline
> +
> +printf "\nReport:  %s\n" "$REPORT"
> +# The python extension rule can't see the compiler flags change, so drop
> +# what this run built for the next build.
> +rm -f "$BUILD_DIR"/python/perf*.so
> +rm -rf "$BUILD_DIR"/python_ext_build

[Severity: Medium]
Does deleting $BUILD_DIR/python/perf*.so at the end of the run break a
subsequent root coverage run in the same $BUILD_DIR?

Because $BUILD_DIR/perf is left in place, a later root run (for example aft=
er
an unprivileged coverage run, or a second root run after coverage-prep) sees
-x "$BUILD_DIR/perf" and sets SKIP_BUILD=3D1 without rebuilding
python/perf*.so.  Python tests such as tests/shell/python-use.sh then fail =
to
import the perf module, and llvm_cov_objects() silently omits python/perf*.=
so
from the coverage report.

Also, because rm -rf "$BUILD_DIR"/python_ext_build sits after the PREP=3D1
early exit, running coverage-prep without a subsequent coverage run leaves
the instrumented python_ext_build cache behind; removing python_ext_build in
build_perf() right after make (while keeping python/perf*.so, which already
depends on $(PERFLIBS_PY) in Makefile.perf) would avoid both problems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122214025.1676=
9-1-acme@kernel.org?part=3D18
