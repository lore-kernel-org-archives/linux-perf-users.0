Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635055;
	b=Z93KTut1ddK8K35fgtZzTQZgiKdhdyV+wgAruv5xW1dpInzWVWEAjp7k7eVeBQzLYziE
	 FNTx5s43RaEbRRo8wwWKZiOk0609uJUKnKJt6bb4M2rqb5p03hjl92G/PZQOyK+rwcz/e
	 ZE8rr6UmuhY4vsrHsP47i+LWYq+/uykgv7bWUKeA9oXLRAMACTWmw79BOxeNZV4GpMcgo
	 hwZYeiMvD+YXKh/5qtG/iu95I2K8UKkWw1UI2a63oUM+WYEPydoC6D8TFHGxJnm0tGv01
	 +Dd99tL78RVs/rV04Fbh7ZkkjrbzStISGa2pc9m0sBvzgb7Fp7HpkNiVJHdnlSy0Y1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635055;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W6BWfsJKKbZc4AgOHX3577EDrG/C46AQp9NylRfvsXE=;
	b=nYl4fiO6qZimUAxy5lt/1XYlo7oDjr6zCtQo+bivXlZ2HvH7xDlpi0C3mylR3vxmxTgs
	 5eJPz2Bqj2GNlxwqcKmx8ZkwfELg0p2LC8Px55RlDpYgmDmMfLSMzR5hRSF5yvqPRSWvz
	 pERWNoI3NU5MGjCZVqgU7KDqQkgoqhBp8s+HHiKt3c/+pchxp6LijpEAAwoJPkqh/qOaD
	 HXpPQoZjuRcfItAwTJ3iJT7JgYnFs6KAMpPPK4WqzDCfsQlJEC0OgeSOiynlPgeA1YBH8
	 f5p3L/yGpf6+xnp/p4hYw5PYrB0oahfOYJc6nQkkRiF44hyqgB2ncEWVi0FZBEEouVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh+yOnxJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD0606A319;
	Thu, 22 Oct 2026 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh+yOnxJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC291F000C1;
	Thu, 22 Oct 2026 02:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635054;
	bh=W6BWfsJKKbZc4AgOHX3577EDrG/C46AQp9NylRfvsXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oh+yOnxJpqvgV/lk5Tacr1zrgvaauG5fP+KLuSvGtGQ14XSqCsTK9Rd4laENNjuJk
	 nGpGDIA1DwI0ALQcP0OXMhiPk3iSNFc08IGNUO/XgonthO9UwRohX27uC2/YPZrfM9
	 DZjMPlPmyj7+zt/d56wg4KaOU5WYeM4bEZ41jzcp+T0Wa/aEnttp4uWwNOQwPZZHOJ
	 GS+VyoffycoEu1NwRb1SXYS9xK2x21111VL+H6l4+t1Zpu5tWc3DEBer6lliG+Gns4
	 3mDUEUsLIm9m/aZ4QZOvkVQLnVtDOenQSh2ZZWlLUxPP7pnfO/I0kThRZ8nrqjvdcv
	 t871p40SLvAyQ==
Message-ID: <sashiko-outbox-180860@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 9/9] selftests/bpf: Test uprobes and fork()
 with busy mmap_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, vbabka@kernel.org, jannh@google.com, hughd@google.com, kees@kernel.org, mingo@redhat.com, tglx@kernel.org, x86@kernel.org, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261022015712.1297331-10-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:10:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: integer overflow of AREA_MAX on 32-bit in hold_mm=
ap_lock()
--

commit 27a041a03328fba58bd21d5e62e3d149445f0523
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test uprobes and fork() with busy mmap_lock

This commit adds a BPF selftest that exercises uprobe attach and detach
concurrently with fork() while a process holds its mmap_lock via
MADV_POPULATE_READ.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c
> new file mode 100644
> index 0000000000000..30614e8b92cd5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c
> @@ -0,0 +1,447 @@

[ ... ]

> +#define AREA_MAX	(64UL << 30)
> +#define AREA_MIN	(64UL << 20)

[ ... ]

> +/*
> + * MADV_POPULATE_READ holds mmap_lock for reading while it maps zero page
> + * all over the area. It costs page tables only.
> + */
> +static void *hold_mmap_lock(void *arg)
> +{
> +	size_t size =3D AREA_MIN;
> +	void *area;
> +	__u64 t;
> +
> +	area =3D mmap(NULL, AREA_MAX, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS | =
MAP_NORESERVE, -1, 0);
> +	if (area =3D=3D MAP_FAILED)
> +		goto err;

[Severity: Medium]
In tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c, does AREA_MAX
overflow on 32-bit architectures when passed to mmap() in hold_mmap_lock()?

When serial_test_uprobe_busy_mm() runs on a 32-bit system via:

  serial_test_uprobe_busy_mm()
    -> start_busy_process()
      -> busy_process()
        -> hold_mmap_lock()

unsigned long and size_t are 32 bits wide, so (64UL << 30) overflows to 0
(and a 64 GiB area exceeds the 32-bit virtual address space). Passing 0 as
the length to mmap() causes it to return MAP_FAILED with EINVAL, jumping to
err and failing the test.

Should AREA_MAX be sized appropriately for 32-bit architectures as well?

> +	/* EINVAL without CONFIG_TRANSPARENT_HUGEPAGE */
> +	madvise(area, AREA_MAX, MADV_NOHUGEPAGE);
> +
> +	t =3D now_ns();
> +	if (madvise(area, size, MADV_POPULATE_READ))
> +		goto err;
> +	t =3D now_ns() - t;
> +	size *=3D sh->hold_ms * 1000000ULL / t + 1;
> +	if (size > AREA_MAX)
> +		size =3D AREA_MAX;
> +
> +	while (!LOAD(sh->stop)) {
> +		STORE(sh->in_hold, 1);
> +		t =3D now_ns();
> +		madvise(area, size, MADV_POPULATE_READ);
> +		/* before anything that can fault and wait for fork() */
> +		INC(sh->hold_seq);
> +		STORE(sh->hold_ns, now_ns() - t);
> +		STORE(sh->in_hold, 0);
> +		madvise(area, size, MADV_DONTNEED);
> +		STORE(sh->ready, 1);
> +	}
> +	return NULL;
> +err:
> +	INC(sh->errors);
> +	STORE(sh->ready, 1);
> +	return NULL;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015712.1297=
331-1-alexei.starovoitov@gmail.com?part=3D9
