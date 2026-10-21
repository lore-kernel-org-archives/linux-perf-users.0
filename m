Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588836;
	b=LY/jvXaL3Kjz8T8GgPf2FymUtgNUKdt6FAaVTworYcOqDaD1Vi/ZD1xNY5ISfxHDw1lo
	 iv1s6ho1ORrGleOLJqODUhJs+JatSELaGRfyAJD2RHiFE7pbzVU9Ek0xx5k+bTmWBBFmr
	 P/AchnJxC5naT+dhdFxQn5SPKGvx5emkDWUgzR/eeMUIveFSqFsq+ulVOVBJ/EYpzOXUv
	 GVJPSMYIdPkVhuU3tdCa+UDZ3SkN7f7g13UEJdIXakyCgQJOe3X5OccldyjZZzz2nYQZh
	 aJ7T5DkIhJEOEnqg/1upbLlDe+Vd+kuaEBRT3p4Gzz68gaKuC+FfAkhk+qBApvM7JXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588836;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jg/4pMO/YUczPE9J+LvM5Xd7ZfED7WVu4yhz4+9IkJ8=;
	b=PnWVGWiXYZRIBfwXMuFShjjXmMPaU/cPG+i/JRC59oc87Xd4Jxw3AsxAepSuv+aMIY64
	 P6HySmC26JkfSbgRHSRiJ0bCo43WvDbmz6/JHu9SSNAaIrnrfXqaers1YQs8pg7Y8XVhz
	 XJIMsaPqpaXN2q3U2357rF6r4MjPP7Lf/98HoqnIFuqAamys+OvZFwHJGb/fTXdJj3S3A
	 4Z3LZTdMPpVqKC5Bv2UnqLLToS0u4FAFe15xwhpq5AUcQkiHER0qCDyxoIS4oaN5FYRpx
	 pJRwVMDT6R0etTT2xxvcrtJGkKCC/rpDdA6CuuVqf6X94mXU8zVw5Nxm1oHIhzzDgnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmmBlzs5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2038606A31B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmmBlzs5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6F11F000C4;
	Wed, 21 Oct 2026 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588835;
	bh=jg/4pMO/YUczPE9J+LvM5Xd7ZfED7WVu4yhz4+9IkJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AmmBlzs5DarIsqO67IiquMbABQfPXH1fqGZtolF19QhMDa/8WQM2yAlkreMCCyu2e
	 GWLA1VPamgPtp7+YF89ulQ7uUHsKSfAe4PistkQQ3ov1/RvO/iK0VS+1V2q6bvVFtV
	 EBwwURtY3gURu5+QHkmkULBwRZl8Ij0m2p+K+CsgvsAXet2E7lylRpFti+B+uHwORW
	 V1n16QZtjyRVT6/68uSEvdXu3i3Mw/yAw5kJEY72xrDjzR0Tshf37xkI+g+KTqZGwZ
	 5IMrOO3Q6q0j7dWx/liNKorSw24wMoAB7HQjmFhkhIaBfL7DTz0oWl+Lmgh5q3vccg
	 EzAIneM2Cb9qw==
Message-ID: <sashiko-outbox-180295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Add test for events re-armed with
 PERF_EVENT_IOC_REFRESH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Nigro" <nigro.fra@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021131006.2101248-1-nigro.fra@gmail.com>
References: <20261021131006.2101248-1-nigro.fra@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:20:34 +0000
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
- [Medium] perf test: missing MADV_NOHUGEPAGE in test__event_refresh_sw() f=
ails on THP
--

commit f4e87f46b616d4e4e30869fe7bd06aad9b7c96f9
Author: Francesco Nigro <nigro.fra@gmail.com>

perf test: Add test for events re-armed with PERF_EVENT_IOC_REFRESH

This commit adds a perf test suite that opens a sampling event with
sample_period 1, re-arms it via PERF_EVENT_IOC_REFRESH from a SIGIO
handler, and verifies that 1000 software page-fault and tracepoint events
each deliver an overflow signal.

Link: https://github.com/async-profiler/async-profiler/issues/1813

> diff --git a/tools/perf/tests/event_refresh.c b/tools/perf/tests/event_re=
fresh.c
> new file mode 100644
> index 0000000000000..480f738de9076
> --- /dev/null
> +++ b/tools/perf/tests/event_refresh.c
> @@ -0,0 +1,136 @@

[ ... ]

> +	pr_debug("%d events, %d overflows\n", NR_EVENTS, overflows);
> +	if (overflows =3D=3D NR_EVENTS)
> +		err =3D TEST_OK;
> +
> +	sigaction(SIGIO, &old_sa, NULL);
> +out_close:
> +	close(fd);
> +	return err;
> +}
> +
> +static char *pages;
> +
> +static void touch_page(int i)
> +{
> +	pages[(long)i * page_size] =3D 1;
> +}
> +
> +static int test__event_refresh_sw(struct test_suite *test __maybe_unused,
> +				  int subtest __maybe_unused)
> +{
> +	struct perf_event_attr attr =3D {
> +		.type =3D PERF_TYPE_SOFTWARE,
> +		.config =3D PERF_COUNT_SW_PAGE_FAULTS,
> +	};
> +	int err;
> +
> +	pages =3D mmap(NULL, (long)NR_EVENTS * page_size, PROT_READ | PROT_WRIT=
E,
> +		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (pages =3D=3D MAP_FAILED)
> +		return TEST_FAIL;
> +
> +	err =3D count_overflows(&attr, touch_page);

[Severity: Medium]
In tools/perf/tests/event_refresh.c, test__event_refresh_sw() maps
NR_EVENTS * page_size bytes (~4 MiB with 4 KiB base pages) as a private
anonymous mapping and relies on each touch_page() write at page_size
stride to trigger a distinct PERF_COUNT_SW_PAGE_FAULTS event.

On systems with Transparent Huge Pages (THP) or multi-size THP (mTHP) set
to "always" (such as when CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy or
/sys/kernel/mm/transparent_hugepage/enabled is set to "always"), the
first write in touch_page(0) can be satisfied by __handle_mm_fault() ->
create_huge_pmd() with a 2 MiB huge page (or a multi-page folio).

That maps up to 512 base pages in a single page fault, so subsequent
touch_page() calls within that huge page hit already-present PTEs/PMDs
without faulting. As a result, overflows only reaches 489 (or fewer)
instead of NR_EVENTS (1000), and count_overflows() returns TEST_FAIL.

Should test__event_refresh_sw() call madvise(pages, (long)NR_EVENTS *
page_size, MADV_NOHUGEPAGE) before count_overflows() so that each
touch_page() write faults in a single base page?

> +	munmap(pages, (long)NR_EVENTS * page_size);
> +	return err;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021131006.2101=
248-1-nigro.fra@gmail.com?part=3D1
