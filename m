Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B532750E6
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061754; cv=none; b=QooTvLHUeZHepCG7SDQ/+VzGlT6Fhiu6BAwXEgI+aBEfYzBGbjG2cykC+Xd3sBOJfiIK/5w7/O/wJlQS8o5Jdw5zbW/FZkjuCao6YhUOM+K+67yhTTSrYTaL6QWXTVOtT40KG0w0JjQn2g+8LVh3Kh5iIByeR8NyTrQWYnaGtV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061754; c=relaxed/simple;
	bh=AQiymgpzpBz2egBXUUrlLmvS4l9aQfaoprSq2gmuvRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pzKYgxQRDYl9frf/PGqp8mArADSN2lQzOAGPZYh132l/Lnx7hNdK8j3UkkVfjioQ3f7Ez51aEUEtbM1gbUqL8YCnKfh6VZ8GM0ckSGnv8etsmNpawLUi/O3RV+Q6+D9ASqLuPCOEg0JoTLIGYXa8PB7r1OgntHfeYDMbYSn1y84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6twdPJa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6twdPJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82BFC2BCB0;
	Sun, 17 May 2026 23:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779061754;
	bh=AQiymgpzpBz2egBXUUrlLmvS4l9aQfaoprSq2gmuvRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=l6twdPJa3+GoN52BCdhrkNolEXenPHbtNmRJ4mHjemqq/+dOOXWoqohhYRlyrdUrW
	 AC+U2AOr3FJ/kYqD67Qw0OlYGFndcdXfwVJi6RdR9lvvOhl26hJaoWXvsGQBZiUeaY
	 fBVxRvEdR/UxG1lQER2Xsf9qEXt0NvdgnUWDEqwYlzHwoEfrnYcX4ILH6Se191DyLR
	 ONgMYt7KOdfFjqA/noXTP3unZumsIXdkFyg13BhWL115irBcc905XZIL39HewqiJUp
	 YFJpXoNYiMbm7Maj12LvjAsfBfNv7Bkj8rEUf8fNLM3F/+6Mg/5h9wp2Ph/fiG634M
	 8yH+KYSToRrxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] perf tests: Add test for uncore event sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260517232849.2391357-2-irogers@google.com>
References: <20260517232849.2391357-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 23:49:13 +0000
Message-Id: <20260517234913.D82BFC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The test fails to verify that events from multiple PMUs were actual=
ly parsed, allowing it to silently pass without exercising the multi-PMU so=
rting logic.
--

commit 7547d1b7750e7305c495d31d775f2a8e3af0325a
Author: Ian Rogers <irogers@google.com>

perf tests: Add test for uncore event sorting

This commit adds a test to verify that uncore events with a common PMU pref=
ix
are properly resorted when parsed. It sets up a scenario matching multiple
sibling PMUs and checks that the resulting event list correctly groups the
events by PMU.

> diff --git a/tools/perf/tests/uncore-event-sorting.c b/tools/perf/tests/u=
ncore-event-sorting.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/tests/uncore-event-sorting.c
[ ... ]
> +	parse_events_error__init(&err);
> +	ret =3D parse_events(evlist, buf, &err);
> +	if (ret) {
> +		pr_debug("parse_events failed\n");
> +		ret =3D TEST_FAIL;
> +		goto out_err;
> +	}
> +
> +	TEST_ASSERT_VAL("Number of events is > 0", evlist->core.nr_entries > 0);
> +	TEST_ASSERT_EQUAL("Number of events is a multiple of 2", evlist->core.n=
r_entries % 2, 0);

If parse_events() encounters a regression and only matches a single PMU ins=
tead
of expanding to all siblings, evlist->core.nr_entries would evaluate to 2.

Since 2 is greater than 0 and a multiple of 2, wouldn't the test silently p=
ass
without actually exercising the multi-PMU sorting logic it was designed for?

Should this test assert that evlist->core.nr_entries >=3D 4 to guarantee th=
at
the mixed PMU resorting scenario is genuinely validated?

> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		struct evsel *next;
> +
> +		if (!evsel__is_group_leader(evsel))
> +			continue;
> +
> +		next =3D evsel__next(evsel);
> +		TEST_ASSERT_EQUAL("Group size is 2", evsel->core.nr_members, 2);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517232849.2391=
357-1-irogers@google.com?part=3D1
