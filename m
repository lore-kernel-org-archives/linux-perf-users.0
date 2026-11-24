Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546651;
	b=s4aCSV3x52bTRxvs5YQMMujl0iGv4lsFuzj4wVTXsxpC622Xe6xIsJiIg85WtlsP1Vau
	 zsFI+2yPDvL558rJBt7ft0G3Hh4TxW2T5SsSUfSMH0Ew4byd1PRVnNChADw18AxNDx+3L
	 LEAxnFYAI2nUF4R8O+4JHmi7XuoddUNkF5XDQYrJwQRHKzme6gW/zAP9OrKPqAWO55vuH
	 4wPAXeMrmYETxybfpRQjI5sibyo33d3Oz9Z13y3SfLbXV8cpVuOu9HeTnXUj8x5VEbz7X
	 14qsjFvEj+sIEjvqfMLVrl/DCLROWYiBXfqo3Ii8BR0sxqoxq7l+by22Q/FT9MKKHRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UzCvt8N0bP1j/5ZuU/z2GS4k0yM0FbGc1I3WRxdp70s=;
	b=mZSUrjwBppmkqYmPhjOmmSqnaIHd7cSCugSdfh+NOC2G7iu54q2yjHCXsILsI5zsqdJC
	 JJbQOScRVq0AmDQ0IuJzBX13/3EVOAVTVEEI2QGrMSiD55xnzVXIzNlwrktTIZ2xYqBEJ
	 SyOIfoM3ajDBDcQ8OLbMVl6Ln0NesGknwHPXW311Q17TDkZffkrzZxJFpPKcHLqChrjV1
	 uyfkVQfmJ/TWFpip5uaLY7A+rMDa5xO7yq4Vy+FVjSLJCI11EugxmXa8ozCQa3mKCpzTX
	 xvjBPc1V3vnYBbWCmuplvM4cZmTzzRBGtegMrS1L6RW8CbBjmYRhdG5YmGOtKMpBpeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBuydNyr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A4606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBuydNyr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A431F000D4;
	Tue, 24 Nov 2026 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546650;
	bh=UzCvt8N0bP1j/5ZuU/z2GS4k0yM0FbGc1I3WRxdp70s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZBuydNyrqdApqo0aU6D32Pdz7mC9CXSeojAzPF0/OwjgdG25o7mV20N1cVna1/Qy2
	 IMakMzdFN+mqBPsanhN9VEzKfiEQ5cF1kKo+BXp8ro3/9EzhrvduQ2TNoFQSXrKQLF
	 h6wY+qQOOtKRrKmOWTVdGnZEcK1K1ZM8CFEH8My98QDZzClQuxrIo3FZDWEuit6ZMC
	 QcvKzmcyf6k92xaSgcU3ySt/mt1gw1Zl7XmsJVJ1ccerBbk+dmOU4yC3J2ygmeBM1k
	 UmgWnqjQz8DPg0LMGblUe6JvxioXeQIsChcO/BijsDtXzYeNfWiaqbGoIUItjI/7No
	 YExX5ggb47soQ==
Message-ID: <sashiko-outbox-231866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/17] perf tests diff: Exercise the output options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-8-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:57:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] perf tests diff: unchecked perf diff exit status and u64
  overflow in --time
- [Low] perf tests diff: mktemp files leaked when
  skip_test_missing_symbol() exits
- [Low] perf tests diff: test_three_files() overwrites err and
  test_options() runs
--

commit c0af815c226f5a563d83e161e3f9885c8829c0ce
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests diff: Exercise the output options

This commit extends the perf diff shell test to record a second workload
for the third data file and adds test_options() to verify output and
filtering options.

> diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/diff=
.sh
> index 88f37b8ef8936..d2fbc8a8c2c36 100755
> --- a/tools/perf/tests/shell/diff.sh
> +++ b/tools/perf/tests/shell/diff.sh
> @@ -8,14 +8,18 @@ err=3D0
>  perfdata1=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  perfdata2=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  perfdata3=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +diffout=3D$(mktemp /tmp/__perf_test.perf.diff.out.XXXXX)
>  testprog=3D"perf test -w thloop"
> +testprog2=3D"perf test -w noploop"
> =20
>  shelldir=3D$(dirname "$0")
>  . "${shelldir}"/lib/perf_has_symbol.sh
> =20
>  testsym=3D"test_loop"
> +testsym2=3D"noploop"
> =20
>  skip_test_missing_symbol ${testsym}
> +skip_test_missing_symbol ${testsym2}

[Severity: Low]
Does skip_test_missing_symbol leak perfdata1, perfdata2, perfdata3, and
diffout in /tmp when either symbol is missing?  skip_test_missing_symbol
calls exit 2 before trap_cleanup is installed on EXIT.

[ ... ]

> @@ -100,8 +110,175 @@ test_three_files() {
>    echo "Basic three file diff test [Success]"
>  }
> =20
> +test_options() {
> +  echo "Diff options test"

[ ... ]

> +  # A window starting at the beginning of the data shows it all, a
> +  # window starting after the last sample shows nothing
> +  if ! perf diff --time 0, "${perfdata1}" "${perfdata2}" | grep -q "${te=
stsym}"
> +  then
> +    echo "Diff options test [Failed: --time]"
> +    err=3D1
> +    return
> +  fi
> +  if perf diff --time 9000000000000000000, "${perfdata1}" "${perfdata2}"=
 | \
> +      grep -q "${testsym}"
> +  then
> +    echo "Diff options test [Failed: --time shows samples outside the wi=
ndow]"
> +    err=3D1
> +    return
> +  fi

[Severity: Medium]
Can this negative --time check pass even if perf diff fails, and does
9000000000000000000 overflow u64 in parse_nsec_time()?

Because the pipeline runs inside a positive if condition without pipefail,
any error exit from perf diff produces no stdout, causing grep -q to return
1 and the check to succeed silently (unlike the --baseline-only check
above, which writes to ${diffout} and checks perf diff's status first).

In addition, parse_nsec_time() treats the number before the decimal point
as seconds and multiplies by NSEC_PER_SEC in u64 arithmetic:

tools/perf/util/time-utils.c:parse_nsec_time() {
	...
	time_sec =3D strtoull(str, &end, 10);
	...
	*ptime =3D time_sec * NSEC_PER_SEC + time_nsec;
	return 0;
}

9000000000000000000 overflows u64 when multiplied by 10^9 and wraps to
~5.3e18 ns.

[ ... ]

>  test_two_files
>  test_three_files
> +test_options
> =20
>  cleanup
>  exit $err

[Severity: Low]
If test_two_files fails (setting err=3D1), or if make_data fails partway
through test_three_files, should the subsequent test functions still run?
test_three_files overwrites global err with 0 when make_data succeeds,
masking an earlier failure in test_two_files, and an early return from
test_three_files leaves test_options running against unrecorded mktemp
files.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D7
