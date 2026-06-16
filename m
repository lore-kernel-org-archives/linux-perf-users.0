Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EE3DE429
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591520; cv=none; b=ZXEsltoDxuNXhyQZ2g8u6HQYGAV5P01D3Urx46smu4rM8ANb2UgTdnZNqBKCD3aAw9zfcKZqYo1SCAJejzeNh5XC3l8xKnkwYrIEY6jEmA0+BAbPHrKshR1fj3jD8qHSqMYl1JwxpppEXcZESnOBmQ9AYPbiUe+6sV6Dwnp8xQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591520; c=relaxed/simple;
	bh=6W71g2sNFduBOr+Pfbsv/tQ6wkob4nVuTkcc/kOEDOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NyInFirFANVIHiwWsPW4VkiPxqW7YAoQSya+tEsIiKYZ/MS5Nzs3DFrbT4+Yr1mCU4qDyEuMmpk3wDvELAjmg+XqLBXMSYN2Lh6xEkpAML5fqW4OXOYWcHlSe3xAgpRReorOgrovTwiKVawawlp5/DBnE67v9IQj/PdaiwV+Hi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL0tsjSV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL0tsjSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945531F000E9;
	Tue, 16 Jun 2026 06:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781591517;
	bh=rzlUOAj+kWgZbVwsqREGAsezWHSxEXg8cMvm8199U0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VL0tsjSVx7/XValLmMHtXbO7qSuVboqnPYmC0KcLQ6eVxdV2tior/S6j5HV32y0GR
	 NC6qNYwGD5ypuvs60u2L30Nody3WoX9/Y3ACPhgjd6LYiRZD14mFR4w4LvVyywkdlr
	 Mn3Z+1aFwYS4HSCvV06s0byIc8v8gL1yDxAITjsaB118xGG2txqsEheOyCHaQ0o3J3
	 wAsp4wjZg8pPwrEBqXaiCK2zBBLHY0lOlaEXv4out/LpxVQZQBjxnlPuieizRI1MAQ
	 pwPe8rSsCQFjoBbcrRjbIhslfvsJIdC4Wvb3pdgC0VTnq7U59AME00YDQ3Eq8MnELl
	 UtKP4DKOZ9NGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] perf parse-events: Restrict core PMU bypass to
 --cputype option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616061404.41929-2-irogers@google.com>
References: <20260616061404.41929-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 06:31:57 +0000
Message-Id: <20260616063157.945531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Hardcoded `false` for `cputype_filter` in `add_default_events()` b=
reaks parsing of default metrics when `--cputype` is used.

Pre-existing issues:
- [High] In `__parse_events()`, an error during group sorting leads to a me=
mory leak and incorrect success return code.
- [High] In `parse_groups()`, `combined_evlist` is leaked on error paths.
--

commit b77824e04893a569eb872e4ec5bd9c15848d74b6
Author: Ian Rogers <irogers@google.com>

perf parse-events: Restrict core PMU bypass to --cputype option

This commit introduces a cputype_filter flag to distinguish PMU filtering
initiated by --cputype from --pmu-filter, restricting the core-only PMU
bypass to the former.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a04466ea3b0a0..2505bc604e532 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
[ ... ]
> @@ -1999,7 +2001,7 @@ static int add_default_events(void)
>  			ret =3D -1;
>  			goto out;
>  		}
> -		ret =3D metricgroup__parse_groups(evlist, pmu, "transaction",
> +		ret =3D metricgroup__parse_groups(evlist, pmu, false, "transaction",

[Severity: High]
Should parse_events_option_args.cputype_filter be passed here instead of
hardcoding false?

If the --cputype option is active, hardcoding false causes
parse_events__filter_pmu() to filter out software and uncore PMU events
required by default metrics (like duration_time). This causes default metric
parsing to fail and can abort perf stat entirely.

[ ... ]
> @@ -2036,7 +2038,7 @@ static int add_default_events(void)
>  		if (!force_metric_only)
>  			stat_config.metric_only =3D true;
> =20
> -		ret =3D metricgroup__parse_groups(evlist, pmu, "smi",
> +		ret =3D metricgroup__parse_groups(evlist, pmu, false, "smi",

[Severity: High]
Similarly here, does this hardcoded false break the smi metric when using
the --cputype option?

[ ... ]
> @@ -2073,7 +2075,7 @@ static int add_default_events(void)
>  		}
>  		str[8] =3D stat_config.topdown_level + '0';
>  		if (metricgroup__parse_groups(evlist,
> -						pmu, str,
> +					      pmu, false, str,

[Severity: High]
Does this hardcoded false break the Topdown metric group parsing when using
the --cputype option?

[ ... ]
> @@ -2112,7 +2114,7 @@ static int add_default_events(void)
>  				ret =3D -ENOMEM;
>  				break;
>  			}
> -			if (metricgroup__parse_groups(metric_evlist, pmu, default_metricgroup=
_names[i],
> +			if (metricgroup__parse_groups(metric_evlist, pmu, false, default_metr=
icgroup_names[i],

[Severity: High]
Does this hardcoded false break the standard default metrics when using
the --cputype option?

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index c2ce3e53aaee7..9c9b048838411 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
[ ... ]
> @@ -1476,7 +1480,8 @@ static int parse_groups(struct evlist *perf_evlist,
>  		if (!metric_evlist) {
>  			ret =3D parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
>  					m->group_events, tool_events, &m->evlist,
> -					(pmu && strcmp(pmu, "all") =3D=3D 0) ? NULL : pmu);
> +					(pmu && strcmp(pmu, "all") =3D=3D 0) ? NULL : pmu,
> +					cputype_filter);
>  			if (ret)
>  				goto out;

[Severity: High]
This is a pre-existing issue, but does this error path leak combined_evlist?

If a subsequent operation in the metric_list loop fails, the function jumps
to the out: label:

tools/perf/util/metricgroup.c:parse_groups() {
    ...
    if (combined_evlist) {
        evlist__splice_list_tail(perf_evlist, &combined_evlist->core.entrie=
s);
        evlist__delete(combined_evlist);
    }
    ...
out:
    metricgroup__free_metrics(&metric_list);
    return ret;
}

Since the cleanup for combined_evlist is located above the out: label, it g=
ets
completely skipped, leaking the list and its events.

> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 943569e82b82f..9f64d5197b8a8 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
[ ... ]
> @@ -2288,18 +2291,20 @@ static int parse_events__sort_events_and_fix_grou=
ps(struct list_head *list)
>  	return (idx_changed || num_leaders !=3D orig_num_leaders) ? 1 : 0;
>  }
> =20
> -int __parse_events(struct evlist *evlist, const char *str, const char *p=
mu_filter,
> +int __parse_events(struct evlist *evlist, const char *str,
> +		   const char *pmu_filter, bool cputype_filter,
>  		   struct parse_events_error *err, bool fake_pmu,
>  		   bool warn_if_reordered, bool fake_tp)
>  {
>  	struct parse_events_state parse_state =3D {

[Severity: High]
This is a pre-existing issue, but does __parse_events() leak memory and
falsely report success if group sorting fails?

If parse_events__sort_events_and_fix_groups() returns a negative error code
(e.g., due to ENOMEM), the function returns the successful ret instead of
the error code ret2:

tools/perf/util/parse-events.c:__parse_events() {
    ...
    ret =3D parse_events__scanner(str, &parse_state);
    ...
    ret2 =3D parse_events__sort_events_and_fix_groups(&parse_state.list);
    if (ret2 < 0)
        return ret;
    ...
}

Returning here also bypasses the call to evlist__splice_list_tail(), which
causes all dynamically allocated evsel elements in parse_state.list to be
lost and leaked when the list goes out of scope.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616061404.4192=
9-1-irogers@google.com?part=3D1
