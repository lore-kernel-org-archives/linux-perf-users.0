Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B992C029D
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386785; cv=none; b=LMs/u8qmgPvOktk4UIZXxKPODeLQY3E+15ipISBDK5uudfjbF1NiQVB8SBIo3lMOUGVEfKL9EiaDekifMaiYfsdtSbIAZFC1Rc6qsBS1akCwcVtaVy5Cp1ZLXLcH+U188GiJVesECFT7oy+wNSkbaMtFtyS7vmcO2GRwhMIOjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386785; c=relaxed/simple;
	bh=TESG3tj0A8Xjk/55lg48gcwlNePhykEDv+f0trOb1gQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TrVSErmXHrB4wTxHcwi88zRlXzqNOFCwbLbREywIThP938vuOtGqv2sXShAT1+swfV/zvgf09z+je44nAzYH3WbE+rQrHVpxAvSLFI3LMni4ehFxGz3WJW9EhAjK/pi4NZ3No2o5Nmgu3B+zOgnMp2wOzz3tTUXIRiwk72OVX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlSVok2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlSVok2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BF61F00893;
	Tue,  2 Jun 2026 07:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386783;
	bh=9yUYddTDyBwP8p6YM2bVg5QrHKYxcAPRjGxokKEJiUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RlSVok2jOnmZs+7gwvsABHpAoo95S6lPqp4XfKj3SZvakN/b7ySLhiNLDFK+S/PWV
	 LntVL6/yER0/kDiLM54ZZig5ESWdOBJrZAnV7ofwZ20D8esQM22qjc8i6tkHYM6mkA
	 QwD+pZUcyu/m5sd8LZw28o005FMAsTuFM4+CFh8AQlreL0J04h+qNyk5Ycrr6NQvif
	 EldAuLVIXrx2f1u7j4acvICOG/aG3WG3dEOjmkP4H9KAqpqj8Htjj53jkFdAM/8i4b
	 LLQ1bfS+V1UGkyIneinApgJh0Xn04HB7ihDrjhERMeuDwZDd1tC001dOZMZ6zyZK/5
	 nrqvOMsJevL+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf test pmu-events: A sub-test per metric table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602073132.2653307-7-irogers@google.com>
References: <20260602073132.2653307-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 07:53:03 +0000
Message-Id: <20260602075303.C0BF61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch relies on undefined struct fields and missing functions, =
causing immediate build failures. It appears to depend on prerequisite fram=
ework changes that are not present in the tree.
--

commit bc7fcf30945d5b7552eacba5428c9cebfc153def
Author: Ian Rogers <irogers@google.com>

perf test pmu-events: A sub-test per metric table

This commit breaks apart the "Parsing of PMU event table metrics" tests into
individual tests per metric table. It implements setup_pmu_events_suite() to
dynamically allocate and populate these test cases. The parsing tests are
updated to retrieve the specific table and test only that table.

> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index a997168621688..0752f0eba085b 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -903,13 +903,20 @@ static int test__parsing_callback(const struct pmu_=
metric *pm,
>  	return err;
>  }
> =20
> -static int test__parsing(struct test_suite *test __maybe_unused,
> -			 int subtest __maybe_unused)
> +static int test__parsing(struct test_suite *test, int subtest)
>  {
>  	int failures =3D 0;
> +	const struct pmu_metrics_table *table =3D NULL;
> =20
> -	pmu_for_each_core_metric(test__parsing_callback, &failures);
> -	pmu_for_each_sys_metric(test__parsing_callback, &failures);
> +	if (test->test_cases)
> +		table =3D test->test_cases[subtest].priv;

[Severity: Low]
Does struct test_case have a priv member? Looking at tools/perf/tests/tests=
.h,
it appears priv is a member of struct test_suite but not struct test_case,
which may cause a build failure here. Are we missing a prerequisite patch?

[ ... ]

> +static int populate_metrics_tables_cb(const struct pmu_metrics_table *ta=
ble, void *data)
> +{
> +	struct populate_cb_data *cb_data =3D data;
> +	const char *table_name =3D pmu_metrics_table__name(table);
> +	char *desc_real, *desc_fake;
> +
> +	if (!table_name)
> +		table_name =3D "unknown";
> +
> +	if (asprintf(&desc_real, "PMU metric parsing: %s", table_name) < 0)
> +		return -ENOMEM;
> +	if (asprintf(&desc_fake, "PMU metric parsing with fake PMU: %s", table_=
name) < 0) {
> +		free(desc_real);
> +		return -ENOMEM;
> +	}
> +
> +	cb_data->test_cases[cb_data->curr++] =3D (struct test_case){
> +		.name =3D "parsing",
> +		.desc =3D desc_real,
> +		.run_case =3D test__parsing,
> +		.priv =3D (void *)table,

[Severity: Low]
Similar to the above, does the priv member exist in struct test_case?

[ ... ]

> +static int setup_pmu_events_suite(struct test_suite *suite)
> +{
> +	size_t num_tables =3D 0;
> +	size_t num_fixed_tests =3D 4;
> +	size_t tests_per_table =3D 2;
> +	size_t total_tests;
> +	struct test_case *test_cases;
> +	size_t curr =3D 0;
> +	struct populate_cb_data cb_data;
> +	int ret;
> +
> +	if (suite->test_cases !=3D pmu_events_tests)
> +		return 0;
> +
> +	ret =3D pmu_metrics_table__iterate_tables(count_metrics_tables_cb, &num=
_tables);

[Severity: Low]
Is pmu_metrics_table__iterate_tables() defined in the tree at this commit?
It looks like the patch might depend on another series that introduces this
function and pmu_metrics_table__name() above.

[ ... ]

>  struct test_suite suite__pmu_events =3D {
>  	.desc =3D "PMU JSON event tests",
>  	.test_cases =3D pmu_events_tests,
> +	.setup =3D setup_pmu_events_suite,

[Severity: Low]
Does struct test_suite have a .setup member? Looking at its definition in
tools/perf/tests/tests.h, there only seems to be desc, test_cases, and priv.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602073132.2653=
307-7-irogers@google.com?part=3D1
