Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE233F5B0
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719555; cv=none; b=DiHLfWJWJ4toEpX+jR65GlWO4O9qaBoAEAw/rbzKJvEHdqYU+EakCtcoGyC8E5ehQRGcE0582ZzFaBimF9cgZG6C5khq1gaHUf7ur2yPUjyg3Rxpv5GfTe3bUum/ESBHqM6l3ATHChM80VEZkMTuxbTZMjN7X/CGRnOO+9ufyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719555; c=relaxed/simple;
	bh=xAO4SbYS4KQCiH1HKiXMMSBTs0FWOrQUtIRhNNkWDJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hkNRyRVojyhc/H+7QaPDvLpRcHdBFgG+Ja12N66K0OHlksprOETHugA6PNcfH6rDkgLziB6s8ZLfQ947e997YH4K6C+IgjlD+nsfeLGGPcC24T3LzBrGgQFB58NuNK4PeyfJUq0gJNwjmQyixY0jd+1RegXDUV2x/cc+Au211jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqYZdFG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqYZdFG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E16D1F000E9;
	Fri, 14 Aug 2026 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719553;
	bh=5TDd7pD2uMU8D3CEARXDfHgsyHtzm17r0BIOswPW3oE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fqYZdFG2GpZieaxl7S9zURCGSN0/1iFNf2LC0hJgMQ3eJ5iInbe6QE6R/JL+HKadK
	 5LdEBK1ShOWvO10dfwEAgijyWT4dOfN/9wBccOtpCBOIgDe0YvwYSanbHwhsHUGCiu
	 G9dXDNCoSz8+cvswFxmen1HuFePW5G8F9VWaW6sfOune9Gd/jJcQu35dlk4eStJdUK
	 Gh7NepmkAsSq5BZCqLthBYtgQ6tfSlNsXn8cST3DpfIPAbONzY0+pFJ19Flj1dD/65
	 he0z+e3wujXBVkkwJtLsErhJut3ygCUztSHt3UGfkUa8OWK9s0m1vSZJ5RJywTUyOs
	 CvTJjp8nMuJkw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/5] selftests/perf_events: add userspace AUX
 regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260814144927.489172-5-kunwu.chan@linux.dev>
References: <20260814144927.489172-1-kunwu.chan@linux.dev>
 <20260814144927.489172-5-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:59:13 +0000
Message-Id: <20260814145913.7E16D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Multiple test functions have fundamental logic flaws that cause =
them to vacuously pass or unconditionally skip, failing to validate the AUX=
 buffer behavior they are intended to test.
--

--- Patch [4]: [RFC PATCH 4/5] selftests/perf_events: add userspace AUX reg=
ression test ---
commit d0e63b73f16bd8ebf0771524fc82ef084c85ea92
Author: Lian Wang <lianux.mm@gmail.com>

selftests/perf_events: add userspace AUX regression test
   =20
This commit adds a standalone C program to test the perf event AUX userspace
mmap protocol. It opens a perf event, mmaps the metadata/data rings, and se=
ts
up the AUX area to ensure kernel-side changes do not break existing behavio=
r.

> diff --git a/tools/testing/selftests/perf_events/aux_kernel_usermode.c b/=
tools/testing/selftests/perf_events/aux_kernel_usermode.c
> new file mode 100644
> index 0000000000000..c3d2323d08797
> --- /dev/null
> +++ b/tools/testing/selftests/perf_events/aux_kernel_usermode.c

[ ... ]

> @@ -267,23 +267,23 @@ static int test_aux_mmap_independence(int pmu_type)
>  	mp1 =3D mmap(NULL, aux_size + getpagesize(), PROT_READ | PROT_WRITE,
>  		   MAP_SHARED, fd1, 0);
>  	if (mp1 =3D=3D MAP_FAILED) {
>  		FAIL("AUX independence: first mmap failed (%s)", strerror(errno));
>  		close(fd1);
>  		return 1;
>  	}
>  	PASS("AUX independence: first event mmap OK");
> =20
>  	/* Open a second event for the same PMU */
>  	fd2 =3D perf_event_open(&attr, 0, -1, -1, 0);

[Severity: Medium]
Does test_aux_mmap_independence() actually allocate an AUX buffer? This code
only mmaps the standard perf metadata/data ring. It appears to omit the set=
up
and second mmap() calls required to actually allocate an AUX buffer for eit=
her
file descriptor.

[ ... ]

> @@ -359,20 +359,20 @@ static int test_mmap_page_fields(int pmu_type)
>  	if (mp->compat_version !=3D 0) {
>  		FAIL("mmap fields: compat_version=3D%u (expected 0)",
>  		     mp->compat_version);
>  		munmap(mp, total_size + getpagesize());
>  		close(fd);
>  		return 1;
>  	}
>  	PASS("mmap fields: compat_version=3D%u", mp->compat_version);
> =20
>  	if (mp->aux_offset =3D=3D 0) {
>  		printf("  [SKIP] mmap fields: aux_offset is 0 (no AUX area)\n");
>  		munmap(mp, total_size + getpagesize());
>  		close(fd);
>  		return 0;
>  	}

[Severity: Medium]
Does this cause test_mmap_page_fields() to unconditionally skip? The aux_of=
fset
is a user-space defined field, but this checks it immediately after the pri=
mary
mmap() when the kernel has zero-initialized the page.

[ ... ]

> @@ -411,20 +411,20 @@ static int test_aux_head_monotonic(int pmu_type)
> =20
>  	attr.type =3D pmu_type;
>  	attr.size =3D sizeof(attr);
>  	attr.disabled =3D 1;
>  	attr.sample_period =3D 256;
>  	attr.freq =3D 0;
> =20
>  	fd =3D perf_event_open(&attr, 0, -1, -1, 0);
>  	if (fd < 0) {
>  		/* Some PMUs may reject the default config */
>  		PASS("AUX head monotonic: skipped (PMU rejected config)");
>  		return 0;
>  	}

[Severity: Medium]
Should this use a skip or fail mechanism instead? Returning PASS on a failu=
re to
open the event could mask regressions and inflate the pass rate.

[ ... ]

> @@ -443,20 +443,20 @@ static int test_aux_head_monotonic(int pmu_type)
>  	if (aux_base =3D=3D MAP_FAILED) {
>  		printf("  [SKIP] AUX head monotonic: AUX area mmap failed (%s)\n",
>  		       strerror(errno));
>  		munmap(mp, mmap_size);
>  		close(fd);
>  		return 0;
>  	}
> =20
>  	ret =3D ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
>  	if (ret < 0) {
>  		PASS("AUX head monotonic: skipped (enable failed)");
>  		munmap(aux_base, aux_size);
>  		munmap(mp, mmap_size);
>  		close(fd);
>  		return 0;
>  	}

[Severity: Medium]
Similarly, should this report a skip or failure instead of PASS when the ev=
ent
fails to enable?

[ ... ]

> @@ -453,20 +453,20 @@ static int test_aux_head_monotonic(int pmu_type)
>  	}
> =20
>  	/* Read initial head */
>  	head_before =3D __atomic_load_n(&mp->aux_head, __ATOMIC_RELAXED);
> =20
>  	usleep(100000); /* 100ms */
> =20
>  	head_after =3D __atomic_load_n(&mp->aux_head, __ATOMIC_RELAXED);
> =20
>  	ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
> =20
>  	if (head_after >=3D head_before) {
>  		PASS("AUX head monotonic: before=3D%lu after=3D%lu (OK)",
>  		     head_before, head_after);
>  	} else {
>  		/* Wrapping is OK for very long runs */
>  		PASS("AUX head monotonic: before=3D%lu after=3D%lu (wrapped)",
>  		     head_before, head_after);
>  	}

[Severity: Medium]
How does this verify that the head was monotonically increasing? Since both
branches result in PASS, the test doesn't seem to assert any failure condit=
ion
or ensure that AUX data was actually generated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144927.4891=
72-1-kunwu.chan@linux.dev?part=3D4
