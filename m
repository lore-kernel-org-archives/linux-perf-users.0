Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B822FDC20
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820505; cv=none; b=tKi9ka5Emcg097tdjE04R/qK9utSLrGrN5aZEJ4mSo+cASJwBCv282VKwI/IltOBj2sQe+sF8AjlapUelq+Wc/npkUNEBsZ32oTc8qsQkj0V7ffONPbP6mOlxq5shZY00mHGLzJEC6t61DUALV8SFQVp/D49kBQSRmw6WSxEh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820505; c=relaxed/simple;
	bh=+feGHpwzm7zkh1wzrpHbjw+qX9yHCytTmCwvsTv3amE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GeSwcHS8aiPMllvxS6DfNelQfbtluPNEGsas/NSMxzR1EsOWrysDcOYrGrZk9H48j7Fld/ecbQk8dfblrGNxbZm+IwOPzPdhpZiCCwWeNPVsTVdHG/YuOXv5vHhC9/5DzQTrJH1QzYiISGqPorCBCps3F93P8dPXucpnW8Z3CXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLdQEnjN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLdQEnjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839EBC19421;
	Fri, 10 Apr 2026 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775820504;
	bh=+feGHpwzm7zkh1wzrpHbjw+qX9yHCytTmCwvsTv3amE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kLdQEnjNos+0j96r0wP5+VFkl/qiO4P7ejnOX79138lEddFsf5/RPcpHISHPFO/no
	 Fdc6Gph5wBocBgREOfNeszzCTajUmVOkVVi8+GeK6KAHQuJ6iasydAJkaB6npC1ruJ
	 UkmhWt/03uwBcOJBpcplSR25j533csewtWxMhzVfkZ7v9HmRYJkGjD3kB+JXn7/e30
	 ZSrAXncZXeuYeYu9LsFNZqfPr7qgmUSD36JbGfxz4FpDLhiFvpEFhQFIB0VU/0ZoHG
	 O0Msr9IHEUX5b14ORdypGSFiGmNj4r6SqWcDnzOQpSURav7y4oSdx6khI5/AWOni/o
	 7m6fJjv/fw7FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf pmu: Skip test on Arm64 when #slots is zero
Reply-To: sashiko@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
References: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 11:28:23 +0000
Message-Id: <20260410112824.839EBC19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Bypass of `fake_pmu` testing abstraction and masking of genuine =
syntax errors in metric validation tests.
--

commit a6c8a008b016717763a4f877bfefc1ddfed146b3
Author: Leo Yan <leo.yan@arm.com>

perf pmu: Skip test on Arm64 when #slots is zero

This commit modifies the PMU metric testing infrastructure to skip metrics
containing "#slots" on Arm64 systems where the CPU does not implement slot
counts. It introduces a function to identify these scenarios and mask the
resulting parsing errors to prevent the test suite from failing.

> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -817,6 +818,26 @@ struct metric {
>  	struct metric_ref metric_ref;
>  };
> =20
> +static bool is_expected_broken_metric(const struct pmu_metric *pm)
> +{
> +	if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
> +	    !strcmp(pm->metric_name, "M3"))
> +		return true;
> +
> +#if defined(__aarch64__)
> +	/*
> +	 * Arm64 platforms may return "#slots =3D=3D 0", which is treated as a
> +	 * syntax error by the parser. Don't test these metrics when running
> +	 * on such platforms.
> +	 */
> +	if (strstr(pm->metric_expr, "#slots") &&
> +	    !tool_pmu__cpu_slots_per_cycle())

Does reading host capabilities via tool_pmu__cpu_slots_per_cycle() bypass
the fake PMU abstraction used by these tests?

The fake PMU tests are intended to validate the metric parser across all
architectures without requiring the actual referenced PMUs or hardware
capabilities to exist on the host machine.

Because tool_pmu__cpu_slots_per_cycle() checks the host's
/sys/bus/event_source/devices/ caps/slots, does this break the test's
hardware-independent validation?

> +		return true;
> +#endif
> +
> +	return false;
> +}
> +

[ ... ]

> @@ -852,8 +873,7 @@ static int test__parsing_callback(const struct pmu_me=
tric *pm,
> =20
>  	err =3D metricgroup__parse_groups_test(evlist, table, pm->metric_name);
>  	if (err) {
> -		if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
> -		    !strcmp(pm->metric_name, "M3")) {
> +		if (is_expected_broken_metric(pm)) {
>  			(*failures)--;
>  			pr_debug("Expected broken metric %s skipping\n", pm->metric_name);
>  			err =3D 0;

Does unconditionally clearing the error here create a testing blind spot
for genuine syntax errors?

If a metric expression contains "#slots" on an Arm64 host without slot
support, the failure is ignored entirely. Could this silently hide other
issues, like typos in other events or malformed operators within the same
metric expression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410-perf_fix_p=
mu_metrics_test-v2-1-61826ab3ca8b@arm.com?part=3D1
