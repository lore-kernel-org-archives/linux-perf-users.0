Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598093;
	b=v0iG4C0dfF1FqO7mRPoSH/j8yp2daxa3nCT8rPuoOa8QhKMimQxZ0JJPcAKkrjSLiQrg
	 rM4D3Kl3M8ndA2OIYPFGZmBeHvl2tLECIw0E9rc4VbFjOhmwmqDthbaZnnzRvPmqtP/px
	 JGLP0z/XKTj22+Ax327/OLqj2LD1ziR9/CuRMzCnjC1PbmJvcAP8jE1xw5EJUsPLKCiC6
	 DeyXJ3z59/AV7mZw7lGFo5QfBgQ7E9inpyayFB66+g2nOaobVVbhuCUxtzhXUutRkcjy8
	 kyDTTcrkL+Jhb5L25hkuAQBtIH8OBSNnWS2fBcgKYcKiR0CCVKtg53deD7e83jSD+6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598093;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zcmMf7CdjWjEOEGi6f5urh5nlcuJLov2fndk46rGEyU=;
	b=FsP81AE/+Z0MPojkgWFOHUofEC0+ZefsH3+VJU/eI+xuJMwzHaYSzA2pY4lnyvL+P5SI
	 NBWayXnfPGn/ODgynVqV4HnhIyZvXkISrDFc0OhseiG1MMpEHaaJgUs0MVEV0FfYSaYvP
	 LHv246FL4DgmkkcdZCCtYf+bSXf+FRes5E6NvqiXqcKUpUZekoD4Ch2nX+zmRSHdHhago
	 a6G2gcfK9hnVevcxy2/5E1SgW/vA3ElejnsuigW1DV4r9Brpx+R9TT2AlE0pZPnP1xZfe
	 f5/0k/8La+lFRSX3jipUGOnA96tdmMluXCwsjOS8YmgXFxW5CNJCvtRkKctkVEv6B7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCHyn3Kg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B106606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCHyn3Kg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E11F000C4;
	Fri, 13 Nov 2026 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598092;
	bh=zcmMf7CdjWjEOEGi6f5urh5nlcuJLov2fndk46rGEyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iCHyn3KgB7EDsvkdD9BpTDt5lvYJaasvg2OuhAKHoeTJXHdZyBLs+XQP3DHe+VhvV
	 5y7lLGC5ptOCBmo4D9m8MWXnvqWUsAEELbcpJtYW5pT3aalWcdizl/jwpxEWCzdiHG
	 HdQY060FtlsLd9eJ93jpG2t0mbEb4vxps7B+vafwXW3K4wveLn/t1nwIoHCUk/mw4N
	 3PZiXdHoLGsi3qhujf0u1G6dAHckw6mx0ptpNhWqmXxhjmPgTImaY0sZs+/c4y1pxK
	 hidvOnp+6U7WwVAiZF7TT9TwpWSfQIt69OUcUMEJbw9gR9Tmme3Dje7P1sck3UFxry
	 77kloN2lEjPZA==
Message-ID: <sashiko-outbox-213550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] perf tests: Add NVMe PMU event parsing test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20261113191234.2509964-4-irogers@google.com>
References: <20261113191234.2509964-1-irogers@google.com>
 <20261113191234.2509964-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:28:11 +0000
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
- [Low] perf tests: suite__nvme_pmu has NULL test_cases when libnvme is
  disabled
--

commit 606f3f12b454f7dd2fdaeea08ae54a0e801abbdb
Author: Ian Rogers <irogers@google.com>

perf tests: Add NVMe PMU event parsing test

This commit adds a unit test suite for the NVMe tool PMU event parser and
registers a helper to create a test NVMe PMU.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 0b8897fd42cac..fbcdcbf92aded 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -110,6 +110,7 @@ static struct test_suite *generic_tests[] =3D {
>  	&suite__pmu,
>  	&suite__pmu_events,
>  	&suite__hwmon_pmu,
> +	&suite__nvme_pmu,
>  	&suite__tool_pmu,
>  	&suite__dso_data,
>  	&suite__perf_evsel__roundtrip_name_test,
> diff --git a/tools/perf/tests/nvme_pmu.c b/tools/perf/tests/nvme_pmu.c
> new file mode 100644
> index 0000000000000..c3c17ccc9ea0b
> --- /dev/null
> +++ b/tools/perf/tests/nvme_pmu.c

[ ... ]

> +#else
> +
> +struct test_suite suite__nvme_pmu =3D {
> +	.desc =3D "NVMe PMU",
> +	.test_cases =3D NULL,
> +};
> +
> +#endif

[Severity: Low]
When HAVE_LIBNVME_SUPPORT is not defined, does setting
suite__nvme_pmu.test_cases to NULL cause __cmd_test() to silently drop the
suite during execution?

generic_tests[] registers suite__nvme_pmu unconditionally, so perf test
list assigns it a suite number, but __cmd_test() only invokes start_test()
and print_test_result() inside test_suite__for_each_test_case(), which
runs zero iterations when test_cases is NULL.  On builds without libnvme,
perf test skips over that suite number without printing a Skip line,
counting it in the skipped summary, or emitting it in JUnit output.
Providing a stub test case that returns TEST_SKIP with a TEST_CASE_REASON
of "not compiled in" (like tools/perf/tests/pfm.c), or guarding
&suite__nvme_pmu in generic_tests[] with HAVE_LIBNVME_SUPPORT, would keep
the suite list and test runner in sync.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113191234.2509=
964-1-irogers@google.com?part=3D3
