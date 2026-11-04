Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765431;
	b=GQmGPQVgTB5SIwt4JBIh3/puaBKBd4jXqsWm6mrgOMfAhTYqyWhbEu03keA+DgesnGcQ
	 c8IQBNCe/e1ZJ08ZRNlEuQUkkpIfHH9Cs0TW5wkYV45xYXkM1wg+3QlncLW+08zvTc/Ad
	 h2iDWzNuvoE6n6yiLqVKUubGPiWtL+oBwQcrxtKXGxqqbWwGUTHycXV8n+lpR85gqDEiO
	 2z853zFli+Al7BMR6kg7yTL87/fTMA3lJ59sBuKX1UOXY09b+szXJLBxAXNLQP+oQ+wd7
	 zMNQL99zbHLniKeanWEPcm1KhOAQWQx2y38UTBfOusJg+KWoBDfBio0QYac1A7V2Naw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DG7AK1Z+yNfxHscKrIXRZRlR8pSP5YLtVwz71Q0D/pc=;
	b=z+DszdK1G7oGm04hcLFpQqeaTn9XSvQs2ksBqQxZMMWnhts2i2h/bcsSnCotb4YFv/1e
	 Fx62+v6hYTTVjYtWh+THVeOFJEEFKq+umljdbFTlRrl8oHZQHj03eqIZ+c6IFHJ+paFPV
	 xBceV/+n/UYjS2IpdqPslwBl+B+XGhVCch7EkcIo5X+d7gg8muqrrXAHRCwX2Fh/gwwv+
	 xKjja/W9PznJNE3O+s/h2McoZ7OgEHHkjpdqp5/OQ7djjBBravnonOPkRSq1EfpeX7w0J
	 F/4HNRL2iiRbip+yL1KpSYfYvfXhIey8lkQE+YwyXUIm5Iaa17BMzWvjR88WfOGC2sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYbu0T9A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08767606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYbu0T9A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ED81F000C1;
	Wed,  4 Nov 2026 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793765430;
	bh=DG7AK1Z+yNfxHscKrIXRZRlR8pSP5YLtVwz71Q0D/pc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CYbu0T9AlJ3fmVXhSGB+/nAglDBaWj+DA8YztDIksXzE+GDVjywZE3XIZjgyPyy8S
	 EVjIfl1/zH4shl1ybt1yPEQT7MEt9+irhTIFxWtXJfqaD5t8q80TGGRSTifR9UpIzv
	 nTJnjXIW+Ab2hcmlxMZN12aU3Qf56q7VzdpWeSECn59kQ8+D1Kf9wfVIyrRDwUQgjW
	 0kaD5bl99JbiJc6K5psjwS9q7ZCAeqHCFO+jrOsUOjLlfmtATMGGxeAxJS/4DTdUSU
	 aidpguE/8iKv2ZryE07O2TYPE2ctH4qDkr31bwdbIx1VsaNu4bMEUzcCuVP8SP3odC
	 IuAZyMTCtZmtg==
Message-ID: <sashiko-outbox-196644@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 20/41] perf metricgroup: Add
 metricgroup__add_recorded_metrics()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-21-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:10:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf metricgroup: metricgroup__add_recorded_metrics() hides unma=
tched events
- [Low] perf metricgroup: inaccurate kernel-doc for metricgroup__has_metric=
_or_groups()
--

commit 45c4bebdd16b2b622cdd8dcc5c1f189c3de98cfa
Author: Ian Rogers <irogers@google.com>

perf metricgroup: Add metricgroup__add_recorded_metrics()

This commit adds metricgroup__add_matching_metric_groups() and
metricgroup__add_recorded_metrics() to parse metrics or metricgroups from a
recorded perf stat command line (or Default metricgroups) and match them
against the recorded events in the evlist.

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 90d22c67bfaeb..668106d3e08fe 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c

[ ... ]

> @@ -1060,6 +1062,315 @@ int metricgroup__add_matching_metrics(struct evli=
st *evlist, bool system_wide)
>  	return ret;
>  }
> =20
> +int metricgroup__add_matching_metric_groups(struct evlist *evlist,

[ ... ]

> +void metricgroup__add_recorded_metrics(struct evlist *evlist,
> +				       const char *metrics,
> +				       const char *pmu_filter,
> +				       bool cputype_filter,
> +				       bool metric_no_group,
> +				       bool metric_no_merge,
> +				       bool metric_no_threshold,
> +				       bool all_metrics,
> +				       bool system_wide,
> +				       bool default_metricgroup,
> +				       bool *metric_only)
> +{

[ ... ]

> +	} else if (!has_events && !had_rec_metrics && !rec_null) {
> +		static const char * const default_names[] =3D {
> +			"Default", "Default2", "Default3", "Default4",
> +		};
> +		struct evsel *evsel;
> +
> +		if (default_metricgroup) {
> +			evlist__for_each_entry(evlist, evsel) {
> +				if (!evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
> +					evsel->skippable =3D true;
> +				if (!all_metrics)
> +					evsel->default_metricgroup =3D true;
> +			}
> +		}
> +		for (size_t i =3D 0; !all_metrics && i < ARRAY_SIZE(default_names); i+=
+) {
> +			if ((int)i > rec_detailed)
> +				break;
> +			if (!metricgroup__has_metric_or_groups(pmus, pmu_filter ?: "all",
> +							       default_names[i]))
> +				continue;
> +			metricgroup__add_matching_metric_groups(evlist, pmu_filter,
> +								cputype_filter,
> +								default_names[i],
> +								/*metric_no_group=3D*/false,
> +								/*metric_no_merge=3D*/false,
> +								/*metric_no_threshold=3D*/true,
> +								system_wide,
> +								default_metricgroup);
> +		}
> +	}

[Severity: Medium]
When default_metricgroup is true and !all_metrics, setting
evsel->default_metricgroup =3D true on every evsel in evlist upfront before
matching the Default metricgroups appears to cause unmatched or unsupported
events to be hidden during reporting.

During reporting, print_counter_aggrdata() checks
perf_stat__skip_metric_event() before should_skip_zero_counter():

tools/perf/util/stat-shadow.c:perf_stat__skip_metric_event() {
	if (!evsel->default_metricgroup)
		return false;

	return !metricgroup__lookup(evlist__metric_events(evsel->evlist), evsel, f=
alse);
}

Because map_metric_evsel_to_evlist() skips any evsel with
!data_evsel->supported, no unsupported evsel ever gets an entry in
evlist->metric_events. With evsel->default_metricgroup set to true on all
evsels, perf_stat__skip_metric_event() returns true for every unsupported
counter before should_skip_zero_counter() is reached, which makes the
!evsel__match(evsel, HARDWARE, HW_CPU_CYCLES) non-skippable exception and
verbose reporting of unsupported counters unreachable when !all_metrics.

Similarly, if a supported recorded event in evlist does not have a matched
Default metric attached to it (for instance, task-clock when duration_time
was not recorded so CPUs_utilized fails to match, instructions when
cpu-cycles was unsupported, or when the recorded CPUID has no matching
Default metrics), won't perf_stat__skip_metric_event() suppress those
recorded events as well?

Conversely, metricgroup__add_matching_metric_groups() documents that
default_metricgroup marks matched events with Default metricgroup display
flags, but add_matching_metric_evlist() only sets
data_evsel->default_show_events =3D true and data_me->is_default =3D true w=
ithout
setting default_metricgroup =3D true on the matched evsels. Should
default_metricgroup be set only on the matched events inside
add_matching_metric_evlist(), or only when a Default metricgroup actually
matches?

> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 25398eafd6e28..7b371171d315f 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -112,6 +112,67 @@ int metricgroup__for_each_metric(struct perf_pmus *p=
mus, const struct pmu_metric

[ ... ]

> +/**
> + * metricgroup__has_metric_or_groups() - Check if any metric or metricgr=
oup in
> + *                                       @metric_or_groups exists for @p=
mus.
> + * @pmus: The PMUs to search.
> + * @pmu: PMU filter name or "all".
> + * @metric_or_groups: Comma-separated list of metric or metricgroup name=
s.
> + *
> + * Return: true if all names in @metric_or_groups match a metric or grou=
p.
> + */
>  bool metricgroup__has_metric_or_groups(struct perf_pmus *pmus, const cha=
r *pmu,
>  				       const char *metric_or_groups);

[Severity: Low]
This isn't a bug in the code, but is this kernel-doc description for
metricgroup__has_metric_or_groups() accurate?

The summary line says "if any metric or metricgroup in @metric_or_groups
exists" while the Return section says "true if all names in @metric_or_grou=
ps
match", and @metric_or_groups is described as a comma-separated list.

Looking at metricgroup__has_metric_or_groups() -> match_pm_metric_or_groups=
()
-> match_metric_or_groups() in tools/perf/util/metricgroup.c:

	len =3D strlen(sought);
	if (!strncasecmp(metric_or_groups, sought, len) &&
	    (metric_or_groups[len] =3D=3D 0 || metric_or_groups[len] =3D=3D ';'))
		return true;
	m =3D strchr(metric_or_groups, ';');
	return m && match_metric_or_groups(m + 1, sought);

match_metric_or_groups() splits the metric's semicolon-separated
pm->metric_group list on ';' and compares sought (@metric_or_groups) as a
single metric or metricgroup name rather than a comma-separated list. Could
the comment be updated to reflect that @metric_or_groups is a single metric
or metricgroup name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D20
