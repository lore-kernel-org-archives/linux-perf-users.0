Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B84D489C
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562244; cv=none; b=Wh5WzcC8Q229aTCp2reLSyghkeBSwXRsDC0+y4Js44SD0piIdEbYVvZhhZap0lTLK3rPhi08KTYUVvy4LB2au4zhd+lKxA3K9+9bi3PFYTK6dLfp66XYrSzJfAwDuAFW6KiOn/L3rC8OWv+XC/WURqI7VnQL83gf9vyEo/ecN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562244; c=relaxed/simple;
	bh=hZsGrxQdmbjOYXxNFIkkZwizN1iQj9lRbiP/C/xHSjg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uDSnVVXCWUtcsnsyFX7h+OR2DHajueGv/re8yBhreMIR2OHGCkolJS/razPlvFJayE1G+xcTXN1p54YQQeLTWNta1lAwKJWi/F/gJ8K3SWXaskDLBiy6PiyIaekM5kSjJmbsE/1KaPPC/kjpp8a+8/VM7FaZFPHf4jLPujji8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ1P5m3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ1P5m3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52821F000FF;
	Fri,  9 Oct 2026 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791562242;
	bh=pTXMXR6wJkWDs0mjY1MGFCj235IAZpOx+bMBFhewcVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQ1P5m3pajhw2/7VQLBO9p+lXszFk1ijx5buSDgD0OxkhgtLlJ+KINzTmeNEeZQvc
	 u0zLDqpjCGoCRU+tiEZtZ8z1Jd4an+flYVIUWgRY59vfC+1+3nNmlvmejY3+4P0O9H
	 3JDS/dZv6oOzgImIfkdyxADO/N5fr8s/q5oUebq2qaVzYvqWSyANpQ+0AT5K20n7bk
	 riOPlcaMWpVuREDcyIFhBwsYA/d8Sp0JXBp9yCvx2x/sNnofODyibul4fw2pH6a3JJ
	 fv1gTWo4fS5QlFFtDYW41jAPaYcBWIZWl0JyEL3pzfF02vU5j9AdklQPZAdd8jJ3Qt
	 Bw5MLdffOpQDg==
Message-ID: <sashiko-outbox-165815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] selftests/perf_events: add userspace AUX
 regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261009160010.1829642-5-kunwu.chan@gmail.com>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
 <20261009160010.1829642-5-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 16:10:42 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/perf_events: truncation of 64-bit aux_head to 32-bit u=
nsigned long and missing -latomic
- [Low] selftests/perf_events: manual printf bypasses SKIP() macro and corr=
upts skipped test accounting
--

commit 82dfe095e07a5fe7f9ac97c522ea08913124277f
Author: Lian Wang <lianux.mm@gmail.com>

    selftests/perf_events: add userspace AUX regression test
   =20
    Add a standalone C program that opens a perf event, mmaps the metadata
    and data ring, sets up the AUX area via a second mmap, enables tracing,
    reads aux_head from the mmap page, and tears down the mapping.  This
    verifies the kernel-side aux_kernel_count changes do not break the
    existing userspace AUX mmap protocol.

> diff --git a/tools/testing/selftests/perf_events/aux_kernel_usermode.c b/=
tools/testing/selftests/perf_events/aux_kernel_usermode.c
> new file mode 100644
> index 0000000000000..2c8f4baf0825f
> --- /dev/null
> +++ b/tools/testing/selftests/perf_events/aux_kernel_usermode.c

[ ... ]

> +	/*
> +	 * Step 3: mmap the AUX area at aux_offset.
> +	 * The kernel reads aux_offset from the metadata page, verifies
> +	 * the mmap offset matches, and allocates the AUX buffer.
> +	 */
> +	aux_base =3D mmap(NULL, aux_size, PROT_READ, MAP_SHARED, fd,
> +			aux_offset);
> +	if (aux_base =3D=3D MAP_FAILED) {
> +		printf("  [SKIP] AUX mmap: AUX area mmap failed (%s)\n",
> +		       strerror(errno));

[Severity: Low]
Is this manual printf() bypassing the SKIP() macro?

The test suite relies on the SKIP() macro to update the global skipped flag=
. By
using printf() directly here in test_aux_mmap(), the flag isn't updated and=
 the
final note "=3D=3D=3D Note: some tests were SKIPped (environment)" might be
incorrectly omitted if this is the only skipped test.

> +		munmap(mp, mmap_size);
> +		close(fd);
> +		return 0;
> +	}
> +	PASS("AUX mmap: metadata mmap OK, AUX area mmap OK");

[ ... ]

> +static int test_aux_head_monotonic(int pmu_type)
> +{
> +	struct perf_event_attr attr =3D {};
> +	struct perf_event_mmap_page *mp;
> +	unsigned long aux_size, mmap_size, head_before, head_after;

[Severity: Medium]
Will this truncate the 64-bit hardware trace cursors on 32-bit architecture=
s?

The aux_head field in struct perf_event_mmap_page is defined as a 64-bit __=
u64.
Since head_before and head_after are declared as unsigned long, they will be
32-bit on 32-bit architectures, causing the upper 32 bits to be silently
discarded when reading aux_head.

> +	void *aux_base;
> +	int fd, ret;

[ ... ]

> +	/* Read initial head */
> +	head_before =3D __atomic_load_n(&mp->aux_head, __ATOMIC_RELAXED);

[Severity: Medium]
Can this atomic load of a 64-bit value cause a build failure on 32-bit
architectures?

Using __atomic_load_n() on a 64-bit integer on 32-bit platforms often requi=
res
linking against libatomic. The Makefile modifications in this patch do not =
add
-latomic to LDFLAGS, which might lead to link failures on those architectur=
es.

> +
> +	usleep(100000); /* 100ms */

[ ... ]

> +	/* Find an AUX-capable PMU: explicit name from argv, or auto-detect. */
> +	if (argc > 1)
> +		pmu_type =3D find_aux_pmu_type_by_name(argv[1]);
> +	else
> +		pmu_type =3D find_aux_pmu_type();
> +	if (pmu_type < 0) {
> +		printf("--- 2-5. AUX Tests ---\n");
> +		printf("  [SKIP] No AUX-capable PMU found\n");

[Severity: Low]
Does this manual printf() also bypass the SKIP() macro?

Similar to the issue in test_aux_mmap(), bypassing the SKIP() macro here
in main() prevents the skipped flag from being updated, which corrupts the
skipped test accounting at the end of the run.

> +	} else {
> +		/* Test 2: AUX mmap lifecycle */
> +		printf("\n--- 2. AUX Mmap Lifecycle ---\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009160010.1829=
642-1-kunwu.chan@gmail.com?part=3D4
