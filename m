Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174CB3ACA45
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818774; cv=none; b=RxTlC5nIfySPZQGdBzq264qBlsDtRyd65cNnoJ3bjGtO7X5X+dnR8DCwDVyZD7Q3IM0zPJNYja7KTWmqr1lj/cFuWwN25QtWa7mXWZ9Auas9qVL+08TLlhUD3XxAf7qIVOe9OTP6aZVpRb3HxcaVL2pngOHwsltS9oXu7YzO+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818774; c=relaxed/simple;
	bh=nsZacXqH9IdHVaqS2MSs2k9/toUil8uFlrkbcs9VHJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N4yFpT3SDknUukzMYkQhguqSYSgmXocFYtZTooRDfPcMXn77ex+FwI0nJE/Dzc5VPo1kGfB0Lz6IQHx0r3N3yFbvYC2iB/UjR5iAc6rw3Z7nb5URnwisTTeGm5ZLvAn17T2hjX4o1JJNHzrmzuWBnCxBIKvhRBNdlqTND1m/a10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyD5tuos; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyD5tuos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D24C19421;
	Fri, 10 Apr 2026 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775818773;
	bh=nsZacXqH9IdHVaqS2MSs2k9/toUil8uFlrkbcs9VHJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UyD5tuostpSjQ/koqfm6a9RoUM7SNSTfTxqh1aqnmdeVrlRRmXcJVGwq+9qGfyX1+
	 hw64EzwBnV6LkSReYMZK+TiWZW/XMmrHNIBfQljNMOfGRzVf6MmyXkc1XbpewShbD4
	 6k0s0jySidsWbSZXI9N4UpRYPoXqVzkfMR+2k6DmODoXxdaslY0yZ3AcLr2kA2CTjj
	 Y3qO3THlsz+3EIT98CWCGw8GG3jBh9e5SiPpeY5rm2xn5qr+5jEcyJthwI4xd0wu+A
	 IPqQntTGTgQE7VZS20gBEPs86/MHLCL4b0Fukm1o0Rm/qII5W2c2+Ync4u/uKvpxl1
	 eoP9SJ36mUayA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf pmu: Skip test on Arm64 when #slots is zero
Reply-To: sashiko@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410-perf_fix_pmu_metrics_test-v1-1-18a5d80f71b6@arm.com>
References: <20260410-perf_fix_pmu_metrics_test-v1-1-18a5d80f71b6@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 10:59:32 +0000
Message-Id: <20260410105933.90D24C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Incorrect field check and negated logic in `is_expected_broken_m=
etric()` masks legitimate test failures.
--

commit 06b8acc454fc829193782764d8f5906526599677
Author: Leo Yan <leo.yan@arm.com>

perf pmu: Skip test on Arm64 when #slots is zero

This commit introduces a check to skip metric tests on Arm64 platforms when
the slot count is zero, preventing syntax errors from failing the PMU metric
tests.

> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c

[ ... ]

> +static bool is_expected_broken_metric(const struct pmu_metric *pm)
> +{
> +	if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
> +	    !strcmp(pm->metric_name, "M3"))
> +		return true;
> +
> +#if defined(__aarch64__)
> +	/*
> +	 * Arm64 platforms may return =E2=80=9C#slots =3D=3D 0=E2=80=9D, which =
is treated as a
> +	 * syntax error by the parser. Don't test these metrics when running
> +	 * on such platforms.
> +	 */
> +	if (!strstr(pm->metric_name, "#slots") &&
> +	    !tool_pmu__cpu_slots_per_cycle())
> +		return true;

Should this check pm->metric_expr instead of pm->metric_name, and should
the negation be removed?

The string "#slots" appears to be part of the metric expression rather than
the metric name. Additionally, the !strstr() condition evaluates to true
when the string is not found.

Because most metric names do not contain "#slots", this condition seems to
evaluate to true for almost all metrics. On Arm64 platforms where
tool_pmu__cpu_slots_per_cycle() returns 0, could this cause any metric
parsing failure to be falsely identified as an expected broken metric and
silently skipped?

> +#endif
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410-perf_fix_p=
mu_metrics_test-v1-1-18a5d80f71b6@arm.com?part=3D1
