Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A110370ACE
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574262; cv=none; b=BK3j7Kw0Z8pw7cp23nhR5xL443RuvPHj032na3zrD1jGqYy7jofBC2WhUg3PErzsYfEd0JJK3/2YXjxxMWZ90zn6YVOMb2i67MWqdSy/t/XO5NJecvMW4CLAM0HEI8KwktOrBbKWr+DmXddbKqbfVo87FMhd5n1iXBpH7ZkCRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574262; c=relaxed/simple;
	bh=Jn0ppqHnuXIn4rGDsyGgb5X6c5FBwDcIsPyKHmi7Z4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iuSqdolhAkOIf4eD3vf9Qhtt+KSOF61B/RkS4GFSvWwuC7m4rg+W7GMmu7Z9fDC9rgtkiElpVDz1PTAqZqAForbeZN7Q2vXYVr9ca8rnbe7psJHW1W0uMbsuJ4GwHr2Vtg4iGVaM/8ZSgB9ipYogJSDEefWAc/H7JTmJdjOMhpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC24AU6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC24AU6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FCD1F000E9;
	Tue, 16 Jun 2026 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574261;
	bh=eMehpB15GrenlKIuujQNKVNW7iX1TRxC/AGVSgbXzaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LC24AU6oH2JB+S5EinviR/bUV7HT/VJpAURGfe3Ur6NHlkCUZYsZiSFb7PG39UNwt
	 4AQGwBHLHFbDU2XrPZOvm8sByJ/E1Rp5praC+HXNTpfGzIX7M5gpI+WTdQ6AjHwHz7
	 doZcKbjkORaJBFJBgPrmjhwGhFawmnSeQ3NUoTNvZKByTuApBvtQ7gQWaFQqca+uTs
	 2DJ8q6UHg2ChGAT/v9PZjrO8oUyYPCONJhIHFWzNDyfWPOb0k8VFU7OcpPpAT5gxMr
	 fQR2T55TaJgAO0It8v5wLSjIh7wIDN9z/+ccLXXLPAmcWNpJ2GCJlq+TwESJrMciFE
	 L9HxJwdvYsYLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/12] perf parse-events: Restrict core PMU bypass to
 --cputype option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616012744.4049193-2-irogers@google.com>
References: <20260616012744.4049193-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:44:20 +0000
Message-Id: <20260616014421.07FCD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch fails to correctly distinguish between `--cputype` and=
 `--pmu-filter` when parsing metrics, causing uncore PMU events to incorrec=
tly bypass the PMU filter.
--

commit 4dcfee88ee0f6425d471a5e115dd295cc67baf7d
Author: Ian Rogers <irogers@google.com>

perf parse-events: Restrict core PMU bypass to --cputype option

This commit introduces a cputype_filter flag to distinguish filtering
initiated by --cputype from --pmu-filter. This restricts the uncore
PMU bypass during event parsing to only apply when using --cputype.

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
[ ... ]
> @@ -1317,7 +1317,9 @@ static int parse_ids(bool metric_no_merge, bool fak=
e_pmu,
>  	pr_debug("Parsing metric events '%s'\n", events.buf);
>  	parse_events_error__init(&parse_error);
>  	ret =3D __parse_events(parsed_evlist, events.buf, filter_pmu,
> -			     &parse_error, fake_pmu, /*warn_if_reordered=3D*/false,
> +			     /*cputype_filter=3D*/filter_pmu !=3D NULL,

[Severity: Medium]
Does hardcoding this argument to filter_pmu !=3D NULL cause metric parsing =
to
lose the distinction between --cputype and --pmu-filter?

If metric parsing is initiated and a --pmu-filter was provided, this will
cause cputype_filter to be evaluated as true in __parse_events().

This will then trigger the new bypass logic in parse_events__filter_pmu(),
preventing uncore PMUs from being filtered out. As a result, users specifyi=
ng
--pmu-filter with uncore metrics might silently aggregate events from all
identical uncore PMUs instead of the single requested one.

> +			     &parse_error, fake_pmu,
> +			     /*warn_if_reordered=3D*/false,
>  			     /*fake_tp=3D*/false);
>  	if (ret) {
>  		parse_events_error__print(&parse_error, events.buf);
[ ... ]
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
[ ... ]
> @@ -429,6 +429,9 @@ bool parse_events__filter_pmu(const struct parse_even=
ts_state *parse_state,
>  	if (parse_state->pmu_filter =3D=3D NULL)
>  		return false;
> =20
> +	if (parse_state->cputype_filter && !pmu->is_core)
> +		return false;
> +

[Severity: Medium]
Is it possible for this block to be incorrectly reached during metric
evaluation if cputype_filter was erroneously set to true by parse_ids()?

>  	return perf_pmu__wildcard_match(pmu, parse_state->pmu_filter) =3D=3D 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616012744.4049=
193-1-irogers@google.com?part=3D1
