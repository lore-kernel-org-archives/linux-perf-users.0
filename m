Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C3EEC3
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573757; cv=none; b=qxh2vVGxsnQVnIR4rOexhphZ3mg++PON3pIk8V7PsDTobi1gZyEdEsvizKgFjyX/p7G75UWCqncjREHw0MNktuXPXNa+hppbLoChyZ2oiByGv/JzLLo1sKXTk4nexYnwNNUhullhMZPC/vK+bgKSJ5BnZuQGz450kejlXuMgkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573757; c=relaxed/simple;
	bh=Z0D+rD3RDahadHbDKFdhNsTzIe7QK0B9u07KarQioXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R9PieiQsl8L5p3TlwZPNFwfXIIiZxSahX8LatbzUWHqjn7z8k+1eHg+EdomdHqO3jUOzeCTEnXQKwfW8pOqluCY/aB2hW7EYGULzInmEjGrB70Syx2I7oD3IL6qYvunboYTutkt+S7CtDbF1AfviwsIR7XkmcMjdeqlg7RFqThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2xmQQMX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2xmQQMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323CF1F000E9;
	Tue, 16 Jun 2026 01:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573756;
	bh=+S/iE6HUCfdS6yJiCdduq00wImGKSsdSFQEsYbbyTI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i2xmQQMXrVtZZbV8lsnulzQz4gv7KMgMrgzc0DcXU6GXd8aZ3JnC6naWzpzFbwMiY
	 F1WR7PiVThhd1VEA6GdqsHsEWIt4tIAF+CZdqo6DpE9FaMqIdu8uXenZEcNncCJwdf
	 Wuem+4N7kW0064+rMD2ALk6P+8KlHPlEFxijMPr1buO5bl8pWSOPQtfF3d1yKO+Dzk
	 4UWSD1oanR5miUOxj6uApE3o2rwHceMu3o1wfsG8eHXYtn23NOwhu7JfIc3+pWCUL/
	 vDwYcpdaPmAymmabJE1w6JLWXZpKyJdd61pBxDd9Ia8+HtZ++mrexPNucNcj/jsukZ
	 4enuFUfr+GS2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 08/12] perf tests: Fix flakiness in BPF counters test
 on hybrid systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616012744.4049193-9-irogers@google.com>
References: <20260616012744.4049193-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:35:55 +0000
Message-Id: <20260616013556.323CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The script incorrectly uses `nproc` to pick a random CPU ID, whi=
ch causes `taskset` to fail unconditionally on systems with restricted cpus=
ets.
- [Medium] The percentage calculation using `expr $first_num \* 3 / 20` is =
vulnerable to a 32-bit signed integer overflow, causing false test failures=
 on minimalist environments.
--

commit 3c1a23e10cc0581a3aebcf4bbcfca207d9638689
Author: Ian Rogers <irogers@google.com>
Subject: perf tests: Fix flakiness in BPF counters test on hybrid systems

This commit fixes flakiness in the BPF counters test by switching to a
deterministic `awk` workload pinned to a random CPU and restricted to
user-space instructions. It also tightens the comparison tolerance.

> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tes=
ts/shell/stat_bpf_counters.sh
> index 35463358b273c..2f01608c95e37 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -4,21 +4,25 @@
> =20
>  set -e
> =20
> -workload=3D"perf test -w sqrtloop"
> +CPU=3D0
> +if command -v shuf >/dev/null 2>&1; then
> +	CPU=3D$(shuf -i 0-$(($(nproc) - 1)) -n 1 2>/dev/null || echo 0)
> +fi
> +workload=3D(taskset -c "$CPU" awk 'BEGIN { for (i=3D0; i<10000000; i++) =
sum+=3Di }')

[Severity: Medium]
On systems where the process is restricted to a subset of CPUs (e.g., CPUs 4
and 5 via cpusets), `nproc` will return 2. Will this select a CPU ID of 0 o=
r 1,
causing `taskset -c "$CPU"` to fail unconditionally with an 'Invalid argume=
nt'
error?

If taskset fails immediately, it seems `perf stat` will only measure the br=
ief
execution of the failed taskset command instead of the intended workload.

> =20
> -# check whether $2 is within +/- 20% of $1
> +# check whether $2 is within +/- 15% of $1
>  compare_number()
>  {
>  	first_num=3D$1
>  	second_num=3D$2
> =20
> -	# upper bound is first_num * 120%
> -	upper=3D$(expr $first_num + $first_num / 5 )
> -	# lower bound is first_num * 80%
> -	lower=3D$(expr $first_num - $first_num / 5 )
> +	# upper bound is first_num * 115%
> +	upper=3D$(expr $first_num + $first_num \* 3 / 20 )
> +	# lower bound is first_num * 85%
> +	lower=3D$(expr $first_num - $first_num \* 3 / 20 )

[Severity: Medium]
Will this percentage calculation cause an integer overflow on systems with
32-bit `expr` implementations (such as some BusyBox configurations)?

The newly introduced `awk` workload runs for 10 million iterations, executi=
ng
roughly 1.5 to 3 billion instructions. Since multiplication is performed be=
fore
division, `$first_num \* 3` will produce a value over 4.5 billion, overflow=
ing
the 32-bit signed `INT_MAX` (2,147,483,647) and resulting in a negative bou=
nd.

Prior to this patch, division occurred first (`first_num / 5`), avoiding th=
is
intermediate overflow.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616012744.4049=
193-1-irogers@google.com?part=3D8
