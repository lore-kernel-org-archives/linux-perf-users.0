Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E70A17A2FB
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574740; cv=none; b=UtQLtB7946xM4PBq5fp9EwlJALKUdDYRb4TXJxVc2hIsBlfw+0lkvqGm8g623UyB5bm2spBLW2+DqutJy9TD8NVLgSGgG9TsHrVrms7lWVqq4gndiE8P7nafZV1SsFT03rJpgY47bDC09nTPJL12OLuOWnzTgVJ47RD1gDsQ/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574740; c=relaxed/simple;
	bh=Nj9I1gDEr1hgG357yYIZNvMsx7nNOPJ38xv73q4iTtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A8IuJtNLnYeT82Dis/TSH3vml8gJGzBOMuQRLcs8cbDdVAGV8EQgmprOh7eS6HDHeFUKLRDSX2Eifo+Dh2Rb+2Pejy05QdJO70OF3j+eFws9Fm7YMrKwEr4nKyD1Zsxde9OY1FHqhRQajI8oJzXc47RygIi+f+31jP4DpAp+1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1n4WEGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1n4WEGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCC51F000E9;
	Tue, 16 Jun 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574739;
	bh=3O47j1rif6VTBoOdUt7KaJ541gHk/Zkhi6YjXU2QcTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1n4WEGgEaDHkh/3QbJe59w+c7V4GWh+0E/dcm8PxN0myGTr2BFwpCPbkfQQhQuO4
	 GNCfQoN4kO6y0Sz/5Ocl1gW4XUA90RVjRID8I3eH3AvHz700kCAe27ZQmzbeDOR7Nj
	 sghLseT30jqWzy9bPGxmdPlUNqBSzSpB7nwiZV9YHMxfzzpwB6twR0oyT7ovEgAaNR
	 IEv86zpDO9TzkS8C1mj0UhSioVIK4DC4AJ8980lhX1oNhp7KY37qiOKYgPNr6UJiHZ
	 g9VKv4WNiNLY/sxEqqLvIt9hOBJ15p/Mhh1PJuhQhxxGAcd7RMSP1t8x4jjlCPOtok
	 Bm/JlORgn4/Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 08/21] perf python: Use evsel in sample in
 pyrf_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616011543.4037138-9-irogers@google.com>
References: <20260616011543.4037138-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:52:16 +0000
Message-Id: <20260616015219.0BCC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing NULL check before calling evsel__get() on the result of ev=
list__id2evsel() leads to a potential crash.
- [Medium] Missing perf_sample__exit() on the error path of guest_session__=
fetch() leaks the evsel reference.
- [Medium] Missing perf_sample__exit() on the error path out of perf_mmap__=
read_event() loop in test__perf_time_to_tsc leaks the evsel reference.
--

commit c23db56d8fc8d40b59596916ce6b0537514263aa
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event
   =20
Avoid a duplicated evsel by using the one in sample. Add
evsel__get/put to the evsel in perf_sample.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ec759a11f7588..d79112cebb716 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3365,7 +3365,7 @@ int __evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
>  	union u64_swap u;
> =20
>  	perf_sample__init(data, /*all=3D*/true);
> -	data->evsel =3D evsel;
> +	data->evsel =3D evsel__get(evsel);

[Severity: Medium]
Does this new reference acquisition cause memory leaks in existing callers
that do not expect sample.evsel to hold a reference on early errors?=20

For example, in tools/perf/builtin-inject.c:guest_session__inject_events(),
if guest_session__fetch() fails, it returns an error but the cleanup block
checking if (ret && gs->fetched) prevents perf_sample__exit() from running,
leaking the evsel reference.

Similarly, in tools/perf/tests/perf-time-to-tsc.c:test__perf_time_to_tsc(),
the CHECK__(evsel__parse_sample(...)) macro jumps to out_err on failure,
bypassing perf_sample__exit(&sample) and permanently leaking the newly
acquired evsel.

>  	data->cpu =3D data->pid =3D data->tid =3D -1;
>  	data->stream_id =3D data->id =3D data->time =3D -1ULL;
>  	data->period =3D evsel->core.attr.sample_period;

[ ... ]

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 89d0f4cec6c7f..18af70488e07a 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1874,7 +1875,11 @@ static int evlist__deliver_deferred_callchain(stru=
ct evlist *evlist,
>  		else
>  			orig_sample.deferred_callchain =3D false;
> =20
> -		orig_sample.evsel =3D evlist__id2evsel(evlist, orig_sample.id);
> +		new_evsel =3D evlist__id2evsel(evlist, orig_sample.id);
> +		if (new_evsel !=3D orig_sample.evsel) {
> +			evsel__put(orig_sample.evsel);
> +			orig_sample.evsel =3D evsel__get(new_evsel);
> +		}

[Severity: High]
Can this cause a segmentation fault if the sample ID is unknown or corrupte=
d?

The evlist__id2evsel() function can return NULL for malformed perf.data fil=
es.
If new_evsel is NULL, passing it directly to evsel__get(new_evsel) will
dereference the NULL pointer when trying to increment its reference count.

Could we add a NULL check here before calling evsel__get()?

>  		ret =3D evlist__deliver_sample(evlist, tool, de->event,
>  					     &orig_sample, machine);
> =20
> @@ -1913,7 +1919,11 @@ static int session__flush_deferred_samples(struct =
perf_session *session,
>  		}
>  		sample.file_offset =3D de->file_offset;
> =20
> -		sample.evsel =3D evlist__id2evsel(evlist, sample.id);
> +		new_evsel =3D evlist__id2evsel(evlist, sample.id);
> +		if (new_evsel !=3D sample.evsel) {
> +			evsel__put(sample.evsel);
> +			sample.evsel =3D evsel__get(new_evsel);
> +		}

[Severity: High]
Similarly, could evlist__id2evsel() return NULL here and cause a crash when
passed to evsel__get()?

>  		ret =3D evlist__deliver_sample(evlist, tool, de->event,
>  					     &sample, machine);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616011543.4037=
138-1-irogers@google.com?part=3D8
