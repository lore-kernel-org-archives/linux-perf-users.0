Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481974E50BE
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616306; cv=none; b=QrKYesy1XOC20bp+gPYevcdHt/YHMFf4bKAOCNH0qm2sCXa7dFpm8S6ugqdYSXUTsicpRFZOtfkigEIu2Fiut8sIdx9gZd/G8U3+bIG0m1BV82AQr/ayewAEPzVUYyUS/XWwSXtX/PyAQQ2GRTdBFhUQCMMktoIGmfK7nXZ0fDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616306; c=relaxed/simple;
	bh=efnqiGVFnE4gaQKynVVLuYSRrMyavCOGNOkt8hjgk5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YHqS+42Jxu8Qi9PQeV41W1H3tclR3Zoo7P4ECmVE9qbr/1IujhYoD4V6qvM2ZzwTxm501d0D2oF3gylxWcaBGeQT2ZRKgr/5CU4wDYfGAq091Jh8BehKaueU0LfhIqL7p5ZzYrOet+t0vjd+bheKVhr7KggMA0Tp3ziFFMiLg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjpgmkDq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjpgmkDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D671F000FF;
	Mon, 28 Sep 2026 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616304;
	bh=GZNySjAHeU4dFXLHgbXnxBKOhwvp9JFNS3tHRJVl1x8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fjpgmkDqiLAboBdKfPk161EaHoVgY71MZSUUir72VR1Jlu84vFy6SXYx8y7HQEEo3
	 Q6JLJUaFzgK6fT98MbMv+56rDhfc+heG1Gq0DjZeureW8TWsWKKmZf2S+kHA6skZlA
	 gbYAcdGJWMxNhIOMBUo7JflhyANtmJJCJEiRcrJCwk7Df5x4OS1FLL2U+vXUyYwxX8
	 6La3JN5CCz0geeypfq4NaFobWU4iVfO6Qp6FswozSQuSCOzZMOmQqhHLxmCsNiIRB3
	 39W8OaGirDc+PR2L7T4p545iyDO48xjQlofeKl8PGuTm7N84M0fD4Z4/YZGXr5IxOZ
	 fa/aeI8Nh/hiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf config: Move perf_config__set_variable() to
 util/config.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928171244.2437283-2-acme@kernel.org>
References: <20260928171244.2437283-1-acme@kernel.org>
 <20260928171244.2437283-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:25:04 +0000
Message-Id: <20260928172504.C0D671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: strcmp crash on OOM via perf_etc_perfconfig()
--

commit fa97c6103dec622e75b990c48525b0269551b0aa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf config: Move perf_config__set_variable() to util/config.c

This commit moves perf_config__set_variable() out of the perf config builtin
so that opt-in features can persist their choice from outside it. It also
serializes parsing and rewriting of config files using a mutex to support
concurrent access from multiple threads.

> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
[ ... ]
> +int perf_config__set_variable(const char *var, const char *value)
> +{
> +	char path[PATH_MAX];
> +	char *user_config =3D mkpath(path, sizeof(path), "%s/.perfconfig", gete=
nv("HOME"));
> +	const char *config_filename =3D config_exclusive_filename ?: user_confi=
g;
> +		/*
> +	 * When rewriting the system wide file all entries are marked as coming
> +	 * from it and must be kept, or it would be truncated down to its
> +	 * header.
> +	 */
> +	bool system_config =3D strcmp(config_filename, perf_etc_perfconfig()) =
=3D=3D 0;

[Severity: Medium]
Can this cause a segmentation fault under memory pressure?

In perf_config__set_variable(), if ETC_PERFCONFIG is an absolute path and
system_path() fails to allocate memory via strdup(), it returns NULL.=20

This NULL propagates through perf_etc_perfconfig() and is passed directly
as the second argument to strcmp(), which will crash when dereferencing it.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928171244.2437=
283-1-acme@kernel.org?part=3D1
